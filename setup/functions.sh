# Turn on "strict mode." See http://redsymbol.net/articles/unofficial-bash-strict-mode/.
# -e: exit if any command unexpectedly fails.
# -u: exit if we have a variable typo.
# -o pipefail: don't ignore errors in the non-last command in a pipeline 
set -euo pipefail
source setup/chips-api/control.sh
source setup/chips-api/wallet.sh
source setup/chips-api/network.sh
source setup/chips-api/mining.sh
source setup/chips-api/util.sh
source setup/chips-api/rawtransactions.sh

function hide_output {
	# This function hides the output of a command unless the command fails
	# and returns a non-zero exit code.

	# Get a temporary file.
	OUTPUT=$(tempfile)

	# Execute command, redirecting stderr/stdout to the temporary file. Since we
	# check the return code ourselves, disable 'set -e' temporarily.
	set +e
	$@ &> $OUTPUT
	E=$?
	set -e

	# If the command failed, show the output that was captured in the temporary file.
	if [ $E != 0 ]; then
		# Something failed.
		echo
		echo FAILED: $@
		echo -----------------------------------------
		cat $OUTPUT
		echo -----------------------------------------
		exit $E
	fi

	# Remove temporary file.
	rm -f $OUTPUT
}

function apt_get_quiet {
	# Run apt-get in a totally non-interactive mode.
	#
	# Somehow all of these options are needed to get it to not ask the user
	# questions about a) whether to proceed (-y), b) package options (noninteractive),
	# and c) what to do about files changed locally (we don't cause that to happen but
	# some VM providers muck with their images; -o).
	#
	# Although we could pass -qq to apt-get to make output quieter, many packages write to stdout
	# and stderr things that aren't really important. Use our hide_output function to capture
	# all of that and only show it if there is a problem (i.e. if apt_get returns a failure exit status).
	DEBIAN_FRONTEND=noninteractive hide_output sudo apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" "$@"
}

function apt_install {
	# Install a bunch of packages. We used to report which packages were already
	# installed and which needed installing, before just running an 'apt-get
	# install' for all of the packages.  Calling `dpkg` on each package is slow,
	# and doesn't affect what we actually do, except in the messages, so let's
	# not do that anymore.
	PACKAGES=$@
	apt_get_quiet install $PACKAGES
}

function apt_add_repository_to_unattended_upgrades {
	if [ -f /etc/apt/apt.conf.d/50unattended-upgrades ]; then
		if ! grep -q "$1" /etc/apt/apt.conf.d/50unattended-upgrades; then
			sed -i "/Allowed-Origins/a \
	    \"$1\";" /etc/apt/apt.conf.d/50unattended-upgrades
		fi
	fi
}

function get_default_hostname {
	# Guess the machine's hostname. It should be a fully qualified
	# domain name suitable for DNS. None of these calls may provide
	# the right value, but it's the best guess we can make.
	set -- $(hostname --fqdn      2>/dev/null ||
                 hostname --all-fqdns 2>/dev/null ||
                 hostname             2>/dev/null)
	printf '%s\n' "$1" # return this value
}

function get_publicip_from_web_service {
	# This seems to be the most reliable way to determine the
	# machine's public IP address: asking a very nice web API
	# for how they see us. Thanks go out to icanhazip.com.
	# See: https://major.io/icanhazip-com-faq/
	#
	# Pass '4' or '6' as an argument to this function to specify
	# what type of address to get (IPv4, IPv6).
	curl -$1 --fail --silent --max-time 15 icanhazip.com 2>/dev/null || /bin/true
}

function get_default_privateip {
	# Return the IP address of the network interface connected
	# to the Internet.
	#
	# Pass '4' or '6' as an argument to this function to specify
	# what type of address to get (IPv4, IPv6).
	#
	# We used to use `hostname -I` and then filter for either
	# IPv4 or IPv6 addresses. However if there are multiple
	# network interfaces on the machine, not all may be for
	# reaching the Internet.
	#
	# Instead use `ip route get` which asks the kernel to use
	# the system's routes to select which interface would be
	# used to reach a public address. We'll use 8.8.8.8 as
	# the destination. It happens to be Google Public DNS, but
	# no connection is made. We're just seeing how the box
	# would connect to it. There many be multiple IP addresses
	# assigned to an interface. `ip route get` reports the
	# preferred. That's good enough for us. See issue #121.
	#
	# With IPv6, the best route may be via an interface that
	# only has a link-local address (fe80::*). These addresses
	# are only unique to an interface and so need an explicit
	# interface specification in order to use them with bind().
	# In these cases, we append "%interface" to the address.
	# See the Notes section in the man page for getaddrinfo and
	# https://discourse.mailinabox.email/t/update-broke-mailinabox/34/9.
	#
	# Also see ae67409603c49b7fa73c227449264ddd10aae6a9 and
	# issue #3 for why/how we originally added IPv6.

	target=8.8.8.8

	# For the IPv6 route, use the corresponding IPv6 address
	# of Google Public DNS. Again, it doesn't matter so long
	# as it's an address on the public Internet.
	if [ "$1" == "6" ]; then target=2001:4860:4860::8888; fi

	# Get the route information.
	route=$(ip -$1 -o route get $target | grep -v unreachable)

	# Parse the address out of the route information.
	address=$(echo $route | sed "s/.* src \([^ ]*\).*/\1/")

	if [[ "$1" == "6" && $address == fe80:* ]]; then
		# For IPv6 link-local addresses, parse the interface out
		# of the route information and append it with a '%'.
		interface=$(echo $route | sed "s/.* dev \([^ ]*\).*/\1/")
		address=$address%$interface
	fi

	echo $address
}

function ufw_allow {
	if [ -z "${DISABLE_FIREWALL:-}" ]; then
		# ufw has completely unhelpful output
		ufw allow $1 > /dev/null;
	fi
}

function check_ufw_running {
	echo "Checking firewall running..."
	UFWRUNNING=`sudo ufw status | grep inactive | grep -v grep`
	if [ ! -z "$UFWRUNNING" ];then
		echo "Force starting firewall"
		sudo ufw --force enable
	fi
}

function restart_service {
	hide_output service $1 restart
}

## Dialog Functions ##
function message_box {
	dialog --title "$1" --msgbox "$2" 0 0
}

function input_box {
	# input_box "title" "prompt" "defaultvalue" VARIABLE
	# The user's input will be stored in the variable VARIABLE.
	# The exit code from dialog will be stored in VARIABLE_EXITCODE.
	# Temporarily turn off 'set -e' because we need the dialog return code.
	declare -n result=$4
	declare -n result_code=$4_EXITCODE
	set +e
	result=$(dialog --stdout --title "$1" --inputbox "$2" 0 0 "$3")
	result_code=$?
	set -e
}

function input_menu {
	# input_menu "title" "prompt" "tag item tag item" VARIABLE
	# The user's input will be stored in the variable VARIABLE.
	# The exit code from dialog will be stored in VARIABLE_EXITCODE.
	declare -n result=$4
	declare -n result_code=$4_EXITCODE
	local IFS=^$'\n'
	set +e
	result=$(dialog --stdout --title "$1" --menu "$2" 0 0 0 $3)
	result_code=$?
	set -e
}

function wget_verify {
	# Downloads a file from the web and checks that it matches
	# a provided hash. If the comparison fails, exit immediately.
	URL=$1
	HASH=$2
	DEST=$3
	CHECKSUM="$HASH  $DEST"
	rm -f $DEST
	hide_output wget -O $DEST $URL
	if ! echo "$CHECKSUM" | sha1sum --check --strict > /dev/null; then
		echo "------------------------------------------------------------"
		echo "Download of $URL did not match expected checksum."
		echo "Found:"
		sha1sum $DEST
		echo
		echo "Expected:"
		echo "$CHECKSUM"
		rm -f $DEST
		exit 1
	fi
}

function git_clone {
	# Clones a git repository, checks out a particular commit or tag,
	# and moves the repository (or a subdirectory in it) to some path.
	# We use separate clone and checkout because -b only supports tags
	# and branches, but we sometimes want to reference a commit hash
	# directly when the repo doesn't provide a tag.
	REPO=$1
	TREEISH=$2
	SUBDIR=$3
	TARGETPATH=$4
	TMPPATH=/tmp/git-clone-$$
	rm -rf $TMPPATH $TARGETPATH
	git clone -q $REPO $TMPPATH || exit 1
	(cd $TMPPATH; git checkout -q $TREEISH;) || exit 1
	mv $TMPPATH/$SUBDIR $TARGETPATH
	rm -rf $TMPPATH
}

# Store menu options selected by the user
INPUT=/tmp/menu.sh.$$

# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$

#y23y
function start_kmdice {
	CHAIN="KMDICE"
	source ~/.devwallet
	echo "Starting $CHAIN..."
	sleep 2
	if ! ps aux | grep -i "[k]mdice" ; then
		echo "Starting $CHAIN... "
		if [ "$DEVPUBKEY" == "" ]; then
			echo "Starting $CHAIN with no pubkey set"
			hide_output komodod -ac_name=KMDICE -ac_supply=10500000 -ac_reward=2500000000 -ac_halving=210000 -ac_cc=2 -addressindex=1 -spentindex=1 -addnode=144.76.217.232 &
			sleep 3
		else
			echo "Starting $CHAIN with pubkey $DEVPUBKEY"
			hide_output komodod -pubkey=$DEVPUBKEY -ac_name=KMDICE -ac_supply=10500000 -ac_reward=2500000000 -ac_halving=210000 -ac_cc=2 -addressindex=1 -spentindex=1 -addnode=144.76.217.232 &
			sleep 3
		fi
	else
		echo "Not starting $CHAIN - already started"
		sleep 4
	fi
}

function delete_blockchain_data_kmdice {
  CHAIN="KMDICE"
  if ! ps aux | grep -i [k]mdice ; then
    echo "Deleting blockchain data for $CHAIN"
    sleep 2
    cd ~/.komodo/$CHAIN
    echo "in $CHAIN directory"
    sleep 2
#    CONTENTS=$(ls | grep -v "$CHAIN.conf\|wallet.dat") 
#    message_box "Info" "Deleting $CONTENTS"
    ls | grep -v "$CHAIN.conf\|wallet.dat" | xargs rm -Rf
    echo "Done deleting..."
    sleep 2
#    CONTENTS=$(ls) 
#    message_box "Info" "Contents \n $CONTENTS"
    cd $INSTALL_DIR
    echo "Done deleting blockchain data for $CHAIN...."
    sleep 2
  else
    echo "$CHAIN is running.  Stop $CHAIN before doing this..."
    sleep 2
  fi
}

function coingw {
  tokencreate
	sleep 5


}

function setup_dev2wallet {
  echo "Entering DEV2 wallet setup"
  if ! ps aux | grep -i [r]egtest | grep -v dialog | grep -vi cakeshopdevsetup ; then
  echo "Starting DEV2 wallet setup"
  hide_output komodod -regtest -ac_name=CAKESHOPDEVSETUP -ac_supply=500 &
  sleep 7
  source ~/.komodo/CAKESHOPDEVSETUP/CAKESHOPDEVSETUP.conf
  DEVADDRESS=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  DEVWIF=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"dumpprivkey\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  DEVPUBKEY=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"validateaddress\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.pubkey'`
  echo "DEVADDRESS=$DEVADDRESS" > ~/.dev2wallet
  echo "DEVWIF=$DEVWIF" >> ~/.dev2wallet
  echo "DEVPUBKEY=$DEVPUBKEY" >> ~/.dev2wallet
  cat ~/.dev2wallet
  echo "Completed OTHER wallet setup"
  sleep 1
  RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "stop", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  echo "Result: $RESULT"
  cd $INSTALL_DIR
  else
    echo "CAKESHOPSETUP server cannot start because another dev mode (regtest) server is running."
    sleep 1
    echo "Only 1 regtest mode allowed."
    sleep 1
    echo "Please stop the other regtest mode server"
    sleep 2
  fi
  sleep 2
}

function setup_devwallet {
  echo "Entering DEV wallet setup"
  if ! ps aux | grep -i [r]egtest | grep -v dialog | grep -vi cakeshopdevsetup ; then
    echo "Starting DEV wallet setup"
    hide_output komodod -regtest -ac_name=CAKESHOPDEVSETUP -ac_supply=500 &
    sleep 7
    source ~/.komodo/CAKESHOPDEVSETUP/CAKESHOPDEVSETUP.conf
    DEVADDRESS=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    DEVWIF=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"dumpprivkey\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    DEVPUBKEY=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"validateaddress\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.pubkey'`
    echo "DEVADDRESS=$DEVADDRESS" > ~/.devwallet
    echo "DEVWIF=$DEVWIF" >> ~/.devwallet
    echo "DEVPUBKEY=$DEVPUBKEY" >> ~/.devwallet
    cat ~/.devwallet
    echo "Completed DEV wallet setup"
    sleep 1
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "stop", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo "Result: $RESULT"
    cd $INSTALL_DIR
  else
    echo "CAKESHOPSETUP server cannot start because another dev mode (regtest) server is running."
    sleep 1
    echo "Only 1 regtest mode allowed."
    sleep 1
    echo "Please stop the other regtest mode server"
    sleep 2
  fi
  sleep 2
}

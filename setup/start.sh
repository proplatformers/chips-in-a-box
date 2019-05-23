#!/bin/bash
# This is the entry point for configuring the system.
#####################################################
INSTALL_DIR=`pwd`

source setup/functions.sh # load our functions

if [ ! -f /usr/bin/dialog ] || [ ! -f /usr/bin/python3 ] || [ ! -f /usr/bin/pip3 ]; then
	echo Installing packages needed for setup...
	sudo apt-get -q -q update
	apt_get_quiet install dialog python3 python3-pip  || exit 1
fi

mkdir -p ~/bin


SWAP_MOUNTED=$(cat /proc/swaps | tail -n+2)
SWAP_IN_FSTAB=$(grep "swap" /etc/fstab || /bin/true)
ROOT_IS_BTRFS=$(grep "\/ .*btrfs" /proc/mounts || /bin/true)
TOTAL_PHYSICAL_MEM=$(head -n 1 /proc/meminfo | awk '{print $2}' || /bin/true)
AVAILABLE_DISK_SPACE=$(df / --output=avail | tail -n 1)
if
	[ -z "$SWAP_MOUNTED" ] &&
	[ -z "$SWAP_IN_FSTAB" ] &&
	[ ! -e /swapfile ] &&
	[ -z "$ROOT_IS_BTRFS" ] &&
	[ $TOTAL_PHYSICAL_MEM -lt 5900000 ] &&
	[ $AVAILABLE_DISK_SPACE -gt 15242880 ]
then
	echo "Adding a swap file to the system..."

	# Allocate and activate the swap file. Allocate in 1KB chuncks
	# doing it in one go, could fail on low memory systems
	sudo dd if=/dev/zero of=/swapfile bs=2048 count=$[1024*1024] status=none
	if [ -e /swapfile ]; then
		sudo chmod 600 /swapfile
		hide_output sudo mkswap /swapfile
		sudo swapon /swapfile
	fi

	# Check if swap is mounted then activate on boot
	if sudo swapon -s | grep -q "\/swapfile"; then
		echo "/swapfile   none    swap    sw    0   0" | sudo tee -a /etc/fstab > /dev/null
	else
		echo "ERROR: Swap allocation failed"
	fi
fi


# Put a start script in a global location. We tell the user to run 'chipsinabox'
# in the first dialog prompt, so we should do this before that starts.
cat > ~/bin/chipsinabox << EOF;
#!/bin/bash
cd `pwd`
source setup/start.sh
EOF
chmod +x ~/bin/chipsinabox

source setup/console.sh 
echo
echo "-----------------------------------------------"
echo
echo Your chips-in-a-box is running below
echo
ps aux | grep chipsd | grep -v grep 

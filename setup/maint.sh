source setup/chainconfig.sh
source setup/bsk1n.sh
source setup/bsk.sh
source setup/regtest.sh

function submenu_maint {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ M A I N T - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
NEW_DEV_WALLET "Create a new dev wallet to import on blockchains" \
NEW_DEV2_WALLET "Create a second wallet for testing" \
REGTEST "Regtest mode" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW_DEV_WALLET) setup_devwallet;;
	NEW_DEV2_WALLET) setup_dev2wallet;;
	REGTEST) submenu_regtest;;
	Back) echo "Bye"; break;;
esac
done
}

# function setup_dev2wallet {
#   echo "Entering DEV2 wallet setup"
#   if ! ps aux | grep -i [r]egtest | grep -v dialog | grep -vi cakeshopdevsetup ; then
#   echo "Starting DEV2 wallet setup"
#   hide_output komodod -regtest -ac_name=CAKESHOPDEVSETUP -ac_supply=500 &
#   sleep 7
#   source ~/.komodo/CAKESHOPDEVSETUP/CAKESHOPDEVSETUP.conf
#   DEV2ADDRESS=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#   DEV2WIF=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"dumpprivkey\", \"params\": [\"$DEV2ADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#   DEV2PUBKEY=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"validateaddress\", \"params\": [\"$DEV2ADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.pubkey'`
#   echo "DEV2ADDRESS=$DEV2ADDRESS" > ~/.dev2wallet
#   echo "DEV2WIF=$DEV2WIF" >> ~/.dev2wallet
#   echo "DEV2PUBKEY=$DEV2PUBKEY" >> ~/.dev2wallet
#   cat ~/.dev2wallet
#   echo "Completed OTHER wallet setup"
#   sleep 1
#   RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "stop", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#   echo "Result: $RESULT"
#   cd $INSTALL_DIR
#   else
#     echo "CAKESHOPSETUP server cannot start because another dev mode (regtest) server is running."
#     sleep 1
#     echo "Only 1 regtest mode allowed."
#     sleep 1
#     echo "Please stop the other regtest mode server"
#     sleep 2
#   fi
#   sleep 2
# }

# function setup_devwallet {
#   echo "Entering DEV wallet setup"
#   if ! ps aux | grep -i [r]egtest | grep -v dialog | grep -vi cakeshopdevsetup ; then
#     echo "Starting DEV wallet setup"
#     hide_output komodod -regtest -ac_name=CAKESHOPDEVSETUP -ac_supply=500 &
#     sleep 7
#     source ~/.komodo/CAKESHOPDEVSETUP/CAKESHOPDEVSETUP.conf
#     DEVADDRESS=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#     DEVWIF=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"dumpprivkey\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#     DEVPUBKEY=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"validateaddress\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.pubkey'`
#     echo "DEVADDRESS=$DEVADDRESS" > ~/.devwallet
#     echo "DEVWIF=$DEVWIF" >> ~/.devwallet
#     echo "DEVPUBKEY=$DEVPUBKEY" >> ~/.devwallet
#     cat ~/.devwallet
#     echo "Completed DEV wallet setup"
#     sleep 1
#     RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "stop", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#     echo "Result: $RESULT"
#     cd $INSTALL_DIR
#   else
#     echo "CAKESHOPSETUP server cannot start because another dev mode (regtest) server is running."
#     sleep 1
#     echo "Only 1 regtest mode allowed."
#     sleep 1
#     echo "Please stop the other regtest mode server"
#     sleep 2
#   fi
#   sleep 2
# }
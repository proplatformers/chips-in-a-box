
function submenu_wallet {
while true
do
echo "Wallet functions for $CHAIN blockchain:"
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ C A K E S H O P - W A L L E T - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
INFO "getwalletinfo - get wallet info for $CHAIN" \
LIST "listunspent - get unspent outputs for $CHAIN" \
SENDTOADDRESS "sendtoaddress - send some native $CHAIN coins to an address" \
SENDALLSELF "sendtoaddress - send all native $CHAIN coins to yourself" \
SENDALLADDRESS "sendtoaddress - send all native $CHAIN coins to an address" \
TOKENADDRESS "tokenaddress - get address information for tokens on $CHAIN for this pubkey" \
BALANCE "getbalance - get the balance for this node $CHAIN wallet" \
Back "Back" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

# make decsion
case $menuitem in
	LIST) listunspent;;
	INFO) getwalletinfo;;
	SENDTOADDRESS) sendtoaddress;;
    SENDALLSELF) sendalltoself;;
    SENDALLTO) sendallto;;
	TOKENADDRESS) tokenaddress;;
    BALANCE) getbalance;;
	Back) echo "Back"; break;;
esac
done
}
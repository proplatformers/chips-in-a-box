function submenu_pizza {
source ~/.devwallet
while true
do
CHAIN=PIZZA
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ P I Z Z A - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
GETINFO "Get Info - $CHAIN getinfo method" \
LISTUNSPENT "List Unspent UTXO - $CHAIN listunspent" \
SENDTOADDRESS "Send $CHAIN to a transparent address" \
VALIDATEADDRESS "Validate this nodes dev wallet: $DEVADDRESS" \
GETPEERINFO "Get Network Info - $CHAIN getpeerinfo" \
GETMININGINFO "Get Mining Info - $CHAIN getmininginfo" \
PIZZA_DELETE "Experimental - Delete blockchain data" \
PIZZA_START "Start $CHAIN" \
STOP "Stop $CHAIN" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	PIZZA_DELETE) delete_blockchain_data_pizza;;
	PIZZA_START) start_pizza;;
	STOP) stop;;
	GETINFO) getinfo;;
	LISTUNSPENT) listunspent;;
	GETPEERINFO) getpeerinfo;;
	GETMININGINFO) getmininginfo;;
	SENDTOADDRESS) sendtoaddress;;
	Back) echo "Bye"; break;;
esac
done
}

function submenu_beer {
while true
do
CHAIN=BEER
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ B E E R - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
GETINFO "Get Info - $CHAIN getinfo method" \
LISTUNSPENT "List Unspent UTXO - $CHAIN listunspent" \
GETPEERINFO "Get Network Info - $CHAIN getpeerinfo" \
GETMININGINFO "Get Mining Info - $CHAIN getmininginfo" \
BEER_DELETE "Experimental - Delete blockchain data" \
BEER_START "Start $CHAIN" \
STOP "Stop $CHAIN" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	BEER_DELETE) delete_blockchain_data_beer;;
	BEER_START) start_beer;;
	STOP) stop;;
	GETINFO) getinfo;;
	LISTUNSPENT) listunspent;;
	GETPEERINFO) getpeerinfo;;
	GETMININGINFO) getmininginfo;;
	Back) echo "Bye"; break;;
esac
done
}

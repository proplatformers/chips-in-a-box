function submenu_pirate {
while true
do
CHAIN=PIRATE
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ P I R A T E - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
GETINFO "Get Info - $CHAIN getinfo method" \
LISTUNSPENT "List Unspent UTXO - $CHAIN listunspent" \
GETPEERINFO "Get Network Info - $CHAIN getpeerinfo" \
GETMININGINFO "Get Mining Info - $CHAIN getmininginfo" \
PIRATE_DELETE "Experimental - Delete blockchain data" \
PIRATE_START "Start $CHAIN" \
STOP "Stop $CHAIN" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	PIRATE_DELETE) delete_blockchain_data_pirate;;
	PIRATE_START) start_pirate;;
	STOP) stop;;
	GETINFO) getinfo;;
	LISTUNSPENT) listunspent;;
	GETPEERINFO) getpeerinfo;;
	GETMININGINFO) getmininginfo;;
	Back) echo "Bye"; break;;
esac
done
}

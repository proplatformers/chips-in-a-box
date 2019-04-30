function submenu_kmdice {
while true
do
CHAIN=KMDICE

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ K M D I C E - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
GETINFO "Get Info - $CHAIN getinfo method" \
LISTUNSPENT "List Unspent UTXO - $CHAIN listunspent" \
GETPEERINFO "Get Network Info - $CHAIN getpeerinfo" \
KMDICE_GETMININGINFO "Get Mining Info - $CHAIN getmininginfo" \
KMDICE_DELETE "Experimental - Delete blockchain data" \
KMDICE_START "Start $CHAIN" \
STOP "Stop $CHAIN" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	KMDICE_DELETE) delete_blockchain_data_kmdice;;
	KMDICE_START) start_kmdice;;
	STOP) stop;;
	GETINFO) getinfo;;
	LISTUNSPENT) listunspent;;
	GETPEERINFO) getpeerinfo;;	
	GETMININGINFO) getmininginfo;;
	Back) echo "Bye"; break;;
esac
done
}

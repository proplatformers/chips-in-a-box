function submenu_chips {
STAGE="CHIPS control"
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console - ${STAGE}" \
--title "[ C H I P S - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
GETINFO "Get Info - CHIPS getinfo method" \
LISTUNSPENT "List Unspent UTXO - CHIPS listunspent" \
GETPEERINFO "Get Network Info - CHIPS getpeerinfo" \
DELETE "Experimental - Delete blockchain data" \
START "Start CHIPS" \
STARTLN "Start Lightning" \
STOP "Stop CHIPS" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	DELETE) delete_blockchain_data_chips;;
	START) start_chips;;
	STARTLN) start_chips_lightning;;
	STOP) stop_chips;;
	GETINFO) getinfo_chips;;
	LISTUNSPENT) listunspent_chips;;
	GETPEERINFO) getpeerinfo_chips;;
	Back) echo "Bye"; break;;
esac
done
}

function start_chips {
echo "Start chips"
sleep 2
chipsd -daemon
}

function start_chips_lightning {
echo "Start chips lightning"
sleep 2
lightningd --alias friendlyalias --ipaddr=xxx.xxx.xxx.xxx --rgb aabbcc --log-level=debug
}

function stop_chips {
echo "Not Implemented"
echo "Stop chips"
sleep 2
}

function getinfo_chips {
echo "Not Implemented"
echo "getinfo chips"
sleep 2
}

function getpeerinfo_chips {
echo "Not Implemented"
echo "getpeerinfo chips"
sleep 2
}

function listunspent_chips {
echo "Not Implemented"
echo "listunspent chips"
sleep 2
}

function delete_blockchain_data_chips {
echo "Not Implemented"
echo "Delete blockchain data chips"
sleep 2
}


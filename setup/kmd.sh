function submenu_kmd {
while true
do
CHAIN=KMD

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ K M D - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
GETINFO "Get Info - $CHAIN getinfo method" \
WALLET "Wallet function for $CHAIN" \
LISTUNSPENT "List Unspent UTXO - $CHAIN listunspent" \
GETPEERINFO "Get Network Info - $CHAIN getpeerinfo" \
KMD_GETMININGINFO "Get Mining Info - $CHAIN getmininginfo" \
KMD_START "Start $CHAIN" \
KMD_STOP "Stop $CHAIN" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	KMD_START) start_kmd;;
	KMD_STOP) stop;;
	GETINFO) getinfo;;
	WALLET) kmd_wallet;;
	LISTUNSPENT) listunspent;;
	GETPEERINFO) getpeerinfo;;	
	GETMININGINFO) getmininginfo;;
	Back) echo "Bye"; break;;
esac
done
}

function kmd_wallet {
  KIABMETHOD="listunspent"
  if ps aux | grep -i komodod | grep -v "naame\|grep" ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    source $HOME/.devwallet
    submenu_wallet
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}


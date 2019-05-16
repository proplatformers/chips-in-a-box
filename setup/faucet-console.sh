
function submenu_faucet {
while true
do
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console using pubkey $DEVPUBKEY" \
--title "[ C A K E S H O P - F A U C E T - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
INFO "faucetinfo - get info about a faucet on $CHAIN" \
ADDRESS "faucetaddress - get address information on $CHAIN" \
FUNDFAUCET "faucetfund - fund the faucet on $CHAIN" \
GETFUNDS "faucetget - get a small amount from the faucet on $CHAIN" \
Back "Back" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

# make decsion
case $menuitem in
  LIST) faucetlist;;
  INFO) faucetinfo;;
  ADDRESS) faucetaddress;;
  FUNDFAUCET) faucetfund;;
  GETFUNDS) faucetget;;
	Back) echo "Back"; break;;
esac
done
}


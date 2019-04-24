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
BSK_1_HOST "Blockchain Starer Kit - single node seed & mining" \
BSK "Blockchain Starter Kit - (experimental) seed node or mining node" \
NEW_DEV_WALLET "Create a new dev wallet to import on blockchains" \
REGTEST "Regtest mode" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	BSK_1_HOST) bsk1n;;
	BSK) bsk;;
	NEW_DEV_WALLET) setup_devwallet;;
	REGTEST) submenu_regtest;;
	Back) echo "Bye"; break;;
esac
done
}

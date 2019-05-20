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
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW_DEV_WALLET) setup_devwallet;;
	NEW_DEV2_WALLET) setup_dev2wallet;;
	Back) echo "Bye"; break;;
esac
done
}


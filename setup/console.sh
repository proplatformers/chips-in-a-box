cd $INSTALL_DIR
source setup/kmdice.sh
source setup/regtest.sh
source setup/maint.sh

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ C A K E S H O P - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
KMDICE "KMDICE - the mineable provably fair chain" \
HUSH3 "HUSH3 - first sapling only blockchain" \
REGTEST "Give me devmode - start single user dev chain" \
MAINT "Maintenance menu" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	REGTEST) submenu_regtest;;
	KMDICE) submenu_kmdice;;
	HUSH3) submenu_hush3;;
	MAINT) submenu_maint;;
	Exit) echo "Bye"; break;;
esac
done

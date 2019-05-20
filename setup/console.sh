cd $INSTALL_DIR
#if [ ! -f ~/.dev2wallet ]; then
#  setup_dev2wallet
#fi
CHAIN="CHIPS"
source setup/wallet-console.sh
source setup/maint.sh
source setup/chips.sh
source setup/base_install_chips.sh

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "CHIPS Console" \
--title "[ C H I P S - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
PLAY "Play CHIPS Poker" \
INSTALL "Install CHIPS Poker" \
MM2 "(q3 2019) - Marketmaker 2 integration" \
MAINT "Maintenance menu" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	PLAY) submenu_chips;;
	INSTALL) submenu_install_chips;;
	MAINT) submenu_maint;;
	Exit) echo "Bye"; break;;
esac
done

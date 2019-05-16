function submenu_ksb {
while true
do
CHAIN=KSB

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ K S B - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 60 14 \
GETINFO "Get Info - $CHAIN getinfo method" \
KSB_START "Start $CHAIN" \
STOP "Stop $CHAIN" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	KSB_START) start_ksb;;
	STOP) stop;;
	GETINFO) getinfo;;
	Back) echo "Bye"; break;;
esac
done
}

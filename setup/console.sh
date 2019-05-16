cd $INSTALL_DIR
if [ ! -f ~/.devwallet ]; then
  setup_devwallet
fi
if [ ! -f ~/.dev2wallet ]; then
  setup_dev2wallet
fi
source setup/wallet-console.sh
source setup/kmdice.sh
source setup/pirate.sh
source setup/maint.sh
source setup/beer.sh
source setup/pizza.sh
source setup/tokens-console.sh
source setup/oracles-console.sh

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ C A K E S H O P - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
BSK "Blockchain Starter Kit - seed node or mining node" \
BSK_1_HOST "Blockchain Starer Kit - single node seed & mining" \
KMD "(todo) KMD - the Komodo ecosystem currency" \
BTC "(todo) - Bitcoin & other blockchains" \
KMDICE "KMDICE - the mineable provably fair chain" \
MM2 "(q3 2019) - Marketmaker 2 integration" \
PIRATE "(experimental) PIRATE - ARRR an enforced privary chain" \
ZEX "(todo) ZEX - Zaddex Hybrid DEX Exchange" \
KSB "(todo) KSB - Ecosystem stable coin from O-Crypto-Union" \
OUR "(todo) OUR - O-Crypto-Union" \
PGT "(todo) PGT - Pungo Token - the services company paying back to the community" \
OOT "(todo) OOT - Utrum Crypto Review Platform" \
RFOX "(todo) RedFOX Labs - The blockchain startup incubation project" \
PIZZA "PIZZA - the pizza chain" \
BEER "BEER - the beer chain" \
MAINT "Maintenance menu" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	BSK_1_HOST) bsk1n;;
	BSK) bsk;;
	KMDICE) submenu_kmdice;;
	PIZZA) submenu_pizza;;
	BEER) submenu_beer;;
	PIRATE) submenu_pirate;;
	MAINT) submenu_maint;;
	Exit) echo "Bye"; break;;
esac
done

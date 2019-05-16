
function submenu_oracles {
while true
do
echo "Oracles for blockchain:"
echo $CHAIN
echo $DEVPUBKEY
sleep 2
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ C A K E S H O P - O R A C L E S - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
LIST "oracleslist - list oracles created on $CHAIN" \
INFO "oraclesinfo - get info about a oracles on $CHAIN" \
CREATE "oraclescreate - create a oracles on $CHAIN" \
ADDRESS "oraclesaddress - get address information on $CHAIN" \
Back "Back" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

# make decsion
case $menuitem in
  LIST) oracleslist;;
  INFO) submenu_oraclesinfo;;
  CREATE) submenu_oraclescreate;;
  ADDRESS) oraclesaddress;;
  BALANCE) submenu_oraclesbalance;;
  ASK) submenu_oraclesask;;
  BID) submenu_oraclesbid;;
	Back) echo "Back"; break;;
esac
done
}

function submenu_oraclesinfo {
    helper_oracleslist
    # get the array from ~/.kiabresponse
    # [
    #   "be75c48e0168668ef8a6861e51ba8461deb5a923bf50bd7e9a89917dfb066462",
    #   "lkajsdlfjasdlfkjalskdfj"
    # ]
    # turn it into a menu item
    #
    # 1 - "be75....."
    # 2 - "lkaj...."
    #

    echo "Got the list of oracles"
    # TODO
    # add if statement grep for null in ~/.kiabresponse
    # if responds then message box saying no oracles to list
    # get info on or interact with, exit to last menu

    cat $HOME/.kiabresponse | jq -r '.[]' > $HOME/.tmp
    /bin/rm $HOME/.kiabresponse

    cat $HOME/.tmp

    COUNT=0
    #used later during selection
    CHOICES2="("
    #used first for dialog
    CHOICES3=""
    for i in `cat $HOME/.tmp`
    do
      echo "Trying $i"
      ORACLESTXID=$i
      helper_oraclesinfo
      ORACLESNAME=`cat ~/.kiabresponse  | jq -r '. | .name'`
      CHOICES2="$CHOICES2 $i "
      CHOICES3="$CHOICES3 $COUNT $ORACLESNAME"
      echo "$COUNT $i \\">> $HOME/.kiabresponse
      let COUNT=COUNT+1
    done
    CHOICES2="$CHOICES2)"
    # echo $CHOICES3
    # sleep 1

    while true
    do
    echo "Oracles system for blockchain:"
    echo $CHAIN
    ### display main menu ###
    dialog --clear  --help-button --backtitle "Cakeshop Console" \
    --title "[ C A K E S H O P - O R A C L E S - C O N S O L E ]" \
    --menu "These are the funding txid for the oracles creation. \n\
    They follow the marker pattern used for creating contracts. \n\
    The funding tx marks the beginning of this contract and can \n\
    easily be used to track it throughout the blockchain. \n\
    You can use the UP/DOWN arrow keys, the first \n\
    letter of the choice as a hot key, or the \n\
    number keys 1-9 to choose an option.\n\
    Choose the TASK" 25 120 14 \
    $CHOICES3 \
    Back "Back" 2>"${INPUT}"

    menuitem=$(<"${INPUT}")

    # make decsion break or continue with selection of oraclesinfo
    case $menuitem in
        Back) echo "Back"; break;;
    esac

    declare -a CHOICES4=$CHOICES2
    # echo ${CHOICES4[@]:$menuitem:1}
    ORACLESTXID=${CHOICES4[@]:$menuitem:1}
    # echo $menuitem
    # echo $ORACLESTXID
    oraclesinfo
    sleep 1
    done
}

function submenu_oraclescreate {
    echo $DEVPUBKEY
    sleep 2
    input_box "Name Question" "Token name?" "ORACLESA" ORACLESNAME
    input_box "Description of oracles" "Short description of oracles?" "short description" ORACLESDESCRIPTION
    input_box "Format Question" "What format will the oracle be" "s" ORACLESFORMAT
    oraclescreate 
}

function submenu_bsk1n_seed_oraclescreate {
    echo $DEVPUBKEY
    sleep 2
    input_box "Name Question" "Token name?" "ORACLESA" ORACLESNAME
    input_box "Description of oracles" "Short description of oracles?" "short description" ORACLESDESCRIPTION
    input_box "Format Question" "What format will the oracle be" "s" ORACLESFORMAT
    #source ~/.devwallet
    oraclescreate 
}

function submenu_bsk1n_mining_oraclescreate {
    echo $DEVPUBKEY
    sleep 2
    input_box "Name Question" "Token name?" "ORACLESA" ORACLESNAME
    input_box "Description of oracles" "Short description of oracles?" "short description" ORACLESDESCRIPTION
    input_box "Format Question" "What format will the oracle be" "s" ORACLESFORMAT
    #source ~/.dev2wallet
    oraclescreate 
}


function submenu_rewards {
while true
do
### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console using pubkey $DEVPUBKEY" \
--title "[ C A K E S H O P - R E W A R D S - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
LIST "rewardslist - list rewards created on $CHAIN" \
INFO "rewardsinfo - get info about a rewards on $CHAIN" \
CREATE "rewardscreatefunding - create a rewards plan on $CHAIN" \
ADDRESS "rewardsaddress - get address information on $CHAIN" \
Back "Back" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

# make decsion
case $menuitem in
  LIST) rewardslist;;
  INFO) submenu_rewardsinfo;;
  CREATE) submenu_rewardscreatefunding;;
  ADDRESS) rewardsaddress;;
  BALANCE) submenu_rewardsbalance;;
  ASK) submenu_rewardsask;;
  BID) submenu_rewardsbid;;
	Back) echo "Back"; break;;
esac
done
}

function submenu_rewardsinfo {
    helper_rewardslist
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

    echo "Got the list of rewards"
    # TODO
    # add if statement grep for null in ~/.kiabresponse
    # if responds then message box saying no rewards to list
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
      REWARDSTXID=$i
      helper_rewardsinfo
      REWARDSNAME=`cat ~/.kiabresponse  | jq -r '. | .name'`
      CHOICES2="$CHOICES2 $i "
      CHOICES3="$CHOICES3 $COUNT $REWARDSNAME"
      echo "$COUNT $i \\">> $HOME/.kiabresponse
      let COUNT=COUNT+1
    done
    CHOICES2="$CHOICES2)"
    # echo $CHOICES3
    # sleep 1

    while true
    do
    echo "Rewards system for blockchain:"
    echo $CHAIN
    ### display main menu ###
    dialog --clear  --help-button --backtitle "Cakeshop Console" \
    --title "[ C A K E S H O P - R E W A R D S - C O N S O L E ]" \
    --menu "These are the funding txid for the rewards creation. \n\
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

    # make decsion break or continue with selection of rewardsinfo
    case $menuitem in
        Back) echo "Back"; break;;
    esac

    declare -a CHOICES4=$CHOICES2
    # echo ${CHOICES4[@]:$menuitem:1}
    REWARDSTXID=${CHOICES4[@]:$menuitem:1}
    # echo $menuitem
    # echo $REWARDSTXID
    rewardsinfo
    sleep 1
    done
}

function submenu_rewardscreatefunding {
    echo $DEVPUBKEY
    sleep 2
    input_box "Name Question" "Token name?" "REWARDSA" REWARDSNAME
    input_box "Seed funding" "How many funds to seed the rewards plan?" "50" REWARDSSEEDFUNDING
    input_box "APR" "What annual percentage rate will the reward be" "20" REWARDSAPR
    input_box "Days minimum" "How many MINIMUM DAYS will funds need to be locked for the reward" "1" REWARDSMINDAYS
    input_box "Days maximum" "How many MAXIMUM DAYS will funds get rewards for" "7" REWARDSMAXDAYS
    input_box "Minimum Deposit" "How many funds will be the minimum deposit to use this rewards plan" "10" REWARDSMINDEPOSIT
    rewardscreatefunding
}

function submenu_rewardslock {
    helper_rewardslist
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

    echo "Got the list of rewards"
    # TODO
    # add if statement grep for null in ~/.kiabresponse
    # if responds then message box saying no rewards to list
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
      REWARDSTXID=$i
      helper_rewardsinfo
      REWARDSNAME=`cat ~/.kiabresponse  | jq -r '. | .name'`
      CHOICES2="$CHOICES2 $i "
      CHOICES3="$CHOICES3 $COUNT $REWARDSNAME"
      echo "$COUNT $i \\">> $HOME/.kiabresponse
      let COUNT=COUNT+1
    done
    CHOICES2="$CHOICES2)"
    # echo $CHOICES3
    # sleep 1

    while true
    do
    echo "Rewards system for blockchain:"
    echo $CHAIN
    ### display main menu ###
    dialog --clear  --help-button --backtitle "Cakeshop Console" \
    --title "[ C A K E S H O P - R E W A R D S - C O N S O L E ]" \
    --menu "These are the funding txid for the rewards creation. \n\
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

    # make decsion break or continue with selection of rewardsinfo
    case $menuitem in
        Back) echo "Back"; break;;
    esac

    declare -a CHOICES4=$CHOICES2
    # echo ${CHOICES4[@]:$menuitem:1}
    REWARDSTXID=${CHOICES4[@]:$menuitem:1}
    # echo $menuitem
    # echo $REWARDSTXID
    input_box "Lock Amount" "How many funds will be locked?" "10" REWARDSLOCK
    rewardslock
    sleep 1
    done
}
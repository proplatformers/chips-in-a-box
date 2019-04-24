
function bsk1n {

input_box "Blockchain Starter Kit - Step 1" "Ticker for chain?" "HELLOWORLD" TICKER

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - $TICKER ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key. \n\
\n\
Choose the Seed or Mining Menu" 25 120 14 \
SEED-MENU "BSK - Single host - $TICKER seed control" \
MINING-MENU "BSK - Single host -  $TICKER mining control" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	SEED-MENU) bsk1n_seed_menu;;
	MINING-MENU) bsk1n_mining_menu;;
	Back) echo "Bye"; break;;
esac
done
}


function bsk1n_control {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - Control $TICKER ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key. \n\
\n\
Choose the Seed or Mining Menu" 25 120 14 \
SEED-MENU "BSK - Single host - $TICKER seed control" \
MINING-MENU "BSK - Single host -  $TICKER mining control" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	SEED-MENU) bsk1n_seed_menu;;
	MINING-MENU) bsk1n_mining_menu;;
	Back) echo "Bye"; break;;
esac
done
}

function bsk1n_seed_menu {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - $TICKER Seed Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
SEED-GETINFO "BSK-1node $TICKER seed getinfo" \
NEW-NODE-SEED "Create a BSK-1node $TICKER seed node" \
SHUTDOWN-NODE-SEED "Shutdown $TICKER seed node" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW-NODE-SEED) bsk1n_seed_spinup;;
	SEED-GETINFO) bsk1n_seed_getinfo;;
	SHUTDOWN-NODE-SEED) bsk1n_seed_shutdown;;
	Back) echo "Bye"; break;;
esac
done
}

function bsk1n_mining_menu {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - $TICKER Mining Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
MINER-GETINFO "BSK-1node $TICKER mining getinfo" \
MINER-GETMININGINFO "BSK-1node $TICKER mining getmininginfo" \
MINING-START "BSK-1node $TICKER start mining" \
MINING-STOP "BSK-1node $TICKER mining stop" \
IMPORT-DEV-WALLET "BSK-1node $TICKER import the dev wallet of this node" \
NEW-NODE-MINER "Create a BSK-1node $TICKER mining node" \
SHUTDOWN-NODE-MINER "Shutdown $TICKER mining node" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW-NODE-MINER) bsk1n_mining_spinup;;
	MINER-GETINFO) bsk1n_mining_getinfo;;
	MINER-GETMININGINFO) bsk1n_mining_getmininginfo;;
	MINING-START) bsk1n_mining_start;;
	MINING-STOP) bsk1n_mining_stop;;
	IMPORT-DEV-WALLET) bsk1n_mining_importdevwallet;;
	SHUTDOWN-NODE-MINER) bsk1n_mining_shutdown;;
	Back) echo "Bye"; break;;
esac
done
}


function bsk1n_seed_getinfo {
  CHAIN=$TICKER
  METHOD="getinfo"
  if ps aux | grep -i $TICKER | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$METHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.$METHOD
    MSGBOXINFO=`cat ~/.$METHOD`
    message_box "$METHOD" "$MSGBOXINFO"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi

}

function bsk1n_mining_getinfo {
  CHAIN=$TICKER
  METHOD="getinfo"
  if ps aux | grep -i $TICKER | grep coinData ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$METHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.$METHOD
    MSGBOXINFO=`cat ~/.$METHOD`
    message_box "$METHOD" "$MSGBOXINFO"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi

}

function bsk1n_mining_getmininginfo {
  CHAIN=$TICKER
  METHOD="getmininginfo"
  if ps aux | grep -i $TICKER | grep coinData ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$METHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.$METHOD
    MSGBOXINFO=`cat ~/.$METHOD`
    message_box "$METHOD" "$MSGBOXINFO"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi

}

function bsk1n_seed_spinup {
    if ps aux | grep -i $TICKER | grep -iv "coinData\|grep" ; then
	    echo "seed node for name $TICKER running, use different name"
	    sleep 2
    else
      input_box "$TICKER" "How many $TICKER coins?" "1000" SUPPLY
      source ~/.devwallet
      echo $SUPPLY
      sleep 1
      echo $TICKER
      sleep 1
      echo "BSK_$TICKER=-ac_supply=$SUPPLY" >> ~/.komodoinabox.conf
      hide_output komodod -ac_name=$TICKER -ac_supply=$SUPPLY -pubkey=$DEVPUBKEY &>/dev/null &
      sleep 1
      sleep 1
      source ~/.komodo/$TICKER/$TICKER.conf
      echo "Finishing seed node setup"
      sleep 3
      curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
      sleep 1
    fi
}

function bsk1n_mining_spinup {
  if ps aux | grep $TICKER | grep coinData ; then
    echo "Already running a mining node"
    sleep 2
  else
    if [ -d ~/coinData/$TICKER ]; then
	    echo "$TICKER already been a mining node, no need to mkdir"
	    sleep 1
    else
      NEWRPCPORT=$(shuf -i 25000-25500 -n 1)
      TRYAGAIN=1
      while [ $TRYAGAIN -eq 1 ]
      do
	      NEWPORT=$(( NEWRPCPORT - 1 ))
	      echo "Seeing if ports are available for RPC/P2P $NEWPORT / $NEWRPCPORT"
	      sleep 1
	      if netstat -ptan | grep "$NEWRPCPORT\|$NEWPORT" ; then
		      NEWRPCPORT=$(shuf -i 25000-25500 -n 1)
		      echo "Try again...with $NEWRPCPORT"
		      sleep 1
	      else
		      TRYAGAIN=0
	      fi

      done
      mkdir -p ~/coinData/$TICKER
      cp ~/.komodo/$TICKER/$TICKER.conf ~/coinData/$TICKER
      sed -i 's/^\(rpcuser=\).*$/rpcuser=newname/' ~/coinData/$TICKER/$TICKER.conf
      sed -i 's/^\(rpcpassword=\).*$/rpcpassword=newpass/' ~/coinData/$TICKER/$TICKER.conf
      echo "port=$NEWPORT" >> ~/coinData/$TICKER/$TICKER.conf
      sed -i "s/^\(rpcport=\).*$/rpcport=$NEWRPCPORT/" ~/coinData/$TICKER/$TICKER.conf
      echo "Created datadir for single host BSK"
      sleep 2
    fi
    hide_output komodod -ac_name=$TICKER -ac_supply=1000 -datadir=$HOME/coinData/$TICKER -addnode=localhost & #>/dev/null &
    echo "Finished mining node setup"
    echo "Ready to enable mining..."
    cat ~/coinData/$TICKER/$TICKER.conf
    sleep 3
  fi
}

function bsk1n_mining_importdevwallet {
  if ps aux | grep -i $TICKER | grep coinData ; then
    source ~/coinData/$TICKER/$TICKER.conf
    source ~/.devwallet
    echo "Importing $DEVADDRESS"
    sleep 2
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_start {
  if ps aux | grep -i $TICKER | grep coinData ; then
	  echo "Staring mining on $TICKER"
	  sleep 3
    source ~/coinData/$TICKER/$TICKER.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [true,1]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_stop {
  if ps aux | grep -i $TICKER | grep coinData ; then
    source ~/coinData/$TICKER/$TICKER.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [false]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    #echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_shutdown {
  if ps aux | grep -i $TICKER | grep coinData ; then
    source ~/coinData/$TICKER/$TICKER.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_seed_shutdown {
  source ~/.komodo/$TICKER/$TICKER.conf
  RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  echo $RESULT
  sleep 1
}

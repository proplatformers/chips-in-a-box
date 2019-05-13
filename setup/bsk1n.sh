
function bsk1n {

input_box "Blockchain Starter Kit - Step 1" "Name of chain?" "HELLOWORLD" CHAIN

while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - $CHAIN ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key. \n\
\n\
Choose the Seed or Mining Menu" 25 120 14 \
SEED-MENU "BSK - Single host - $CHAIN seed control" \
MINING-MENU "BSK - Single host -  $CHAIN mining control" \
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
--title "[ Blockchain Starter Kit - Control $CHAIN ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key. \n\
\n\
Choose the Seed or Mining Menu" 25 120 14 \
SEED-MENU "BSK - Single host - $CHAIN seed control" \
MINING-MENU "BSK - Single host -  $CHAIN mining control" \
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
--title "[ Blockchain Starter Kit - $CHAIN Seed Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
SEED-GETINFO "BSK-1node $CHAIN seed getinfo" \
NEW-NODE-SEED "Create a BSK-1node $CHAIN seed node" \
SHUTDOWN-NODE-SEED "Shutdown $CHAIN seed node" \
COINGW "Experimental: Coin Gateway" \
TOKENS "Use the tokenization system on this blockchain" \
WALLET "Use this node $CHAIN wallet" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW-NODE-SEED) bsk1n_seed_spinup;;
	SEED-GETINFO) bsk1n_seed_getinfo;;
  COINGW) coingw;;
	SHUTDOWN-NODE-SEED) bsk1n_seed_shutdown;;
  TOKENS) bsk1n_seed_tokens;;
  WALLET) bsk1n_seed_wallet;;
	Back) echo "Bye"; break;;
esac
done
}

function bsk1n_mining_menu {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ Blockchain Starter Kit - $CHAIN Mining Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
MINER-GETINFO "BSK-1node $CHAIN mining getinfo" \
MINER-GETMININGINFO "BSK-1node $CHAIN mining getmininginfo" \
MINING-START "BSK-1node $CHAIN start mining" \
MINING-STOP "BSK-1node $CHAIN mining stop" \
IMPORT-DEV-WALLET "BSK-1node $CHAIN import the dev wallet of this node" \
NEW-NODE-MINER "Create a BSK-1node $CHAIN mining node" \
TOKENS "Use the tokenization system on this blockchain" \
WALLET "Use this node $CHAIN wallet" \
COINGW "Experimental: Coin Gateway" \
SHUTDOWN-NODE-MINER "Shutdown $CHAIN mining node" \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	NEW-NODE-MINER) bsk1n_mining_spinup;;
	MINER-GETINFO) bsk1n_mining_getinfo;;
	MINER-GETMININGINFO) bsk1n_mining_getmininginfo;;
	MINING-START) bsk1n_mining_start;;
	MINING-STOP) bsk1n_mining_stop;;
  COINGW) coingw;;
	IMPORT-DEV-WALLET) bsk1n_mining_importdevwallet;;
	SHUTDOWN-NODE-MINER) bsk1n_mining_shutdown;;
  TOKENS) bsk1n_mining_tokens;;
  WALLET) bsk1n_mining_wallet;;
	Back) echo "Bye"; break;;
esac
done
}


function bsk1n_seed_getinfo {
  CHAIN=$CHAIN
  METHOD="getinfo"
  if ps aux | grep -i $CHAIN | grep -v grep ; then
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
  CHAIN=$CHAIN
  METHOD="getinfo"
  if ps aux | grep -i $CHAIN | grep coinData ; then
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
  CHAIN=$CHAIN
  METHOD="getmininginfo"
  if ps aux | grep -i $CHAIN | grep coinData ; then
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
    if ps aux | grep -i $CHAIN | grep -iv "coinData\|grep" ; then
	    echo "seed node for name $CHAIN running, use different name"
	    sleep 2
    else
      input_box "$CHAIN" "How many $CHAIN coins?" "1000" SUPPLY
      source ~/.devwallet
      echo $SUPPLY
      sleep 1
      echo $CHAIN
      sleep 1
      echo "BSK_$CHAIN=-ac_supply=$SUPPLY" >> ~/.komodoinabox.conf
      hide_output komodod -ac_name=$CHAIN -ac_supply=$SUPPLY -pubkey=$DEVPUBKEY -ac_cc=2 &>/dev/null &
      sleep 1
      sleep 1
      source ~/.komodo/$CHAIN/$CHAIN.conf
      echo "Finishing seed node setup"
      sleep 5
      curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
      sleep 1
    fi
}

function bsk1n_mining_spinup {
  if ps aux | grep $CHAIN | grep coinData ; then
    echo "Already running a mining node"
    sleep 2
  else
    if [ -d ~/coinData/$CHAIN ]; then
	    echo "$CHAIN already been a mining node, no need to mkdir"
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
      mkdir -p ~/coinData/$CHAIN
      cp ~/.komodo/$CHAIN/$CHAIN.conf ~/coinData/$CHAIN
      newrpcuser=$(dd bs=24 count=1 if=/dev/urandom | base64 | tr +/ _.)
      newrpcpassword=$(dd bs=24 count=1 if=/dev/urandom | base64 | tr +/ _.)
      sed -i "s/^\(rpcuser=\).*$/rpcuser=$newrpcuser/" ~/coinData/$CHAIN/$CHAIN.conf
      sed -i "s/^\(rpcpassword=\).*$/rpcpassword=$newrpcpassword/" ~/coinData/$CHAIN/$CHAIN.conf
      echo "port=$NEWPORT" >> ~/coinData/$CHAIN/$CHAIN.conf
      sed -i "s/^\(rpcport=\).*$/rpcport=$NEWRPCPORT/" ~/coinData/$CHAIN/$CHAIN.conf
      echo "Created datadir for single host BSK"
      sleep 2
    fi
    source $HOME/.dev2wallet
    input_box "$CHAIN" "How many $CHAIN coins?\n\nNote: Must be same as seed node" "1000" SUPPLY
    hide_output komodod -ac_name=$CHAIN -ac_supply=$SUPPLY -datadir=$HOME/coinData/$CHAIN -addnode=localhost -pubkey=$DEVPUBKEY -ac_cc=2 & #>/dev/null &
    echo "Finished mining node setup"
    echo "Ready to enable mining..."
    cat ~/coinData/$CHAIN/$CHAIN.conf
    sleep 3
  fi
}

function bsk1n_mining_importdevwallet {
  if ps aux | grep -i $CHAIN | grep coinData ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    source ~/.dev2wallet
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
  if ps aux | grep -i $CHAIN | grep coinData ; then
	  echo "Staring mining on $CHAIN"
	  sleep 3
    source ~/coinData/$CHAIN/$CHAIN.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [true,1]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_stop {
  if ps aux | grep -i $CHAIN | grep coinData ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"setgenerate\", \"params\": [false]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    #echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_mining_shutdown {
  if ps aux | grep -i $CHAIN | grep coinData ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo $RESULT
    sleep 1
  else
    echo "Mining node not running"
    sleep 2
  fi
}

function bsk1n_seed_shutdown {
  source ~/.komodo/$CHAIN/$CHAIN.conf
  RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"stop\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
  echo $RESULT
  sleep 1
}

function bsk1n_seed_wallet {
  KIABMETHOD="listunspent"
  if ps aux | grep -i $CHAIN ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    source $HOME/.devwallet
    submenu_wallet
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function bsk1n_seed_tokens {
  KIABMETHOD="listunspent"
  if ps aux | grep -i $CHAIN ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    source $HOME/.devwallet
    submenu_tokens
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function bsk1n_mining_wallet {
  KIABMETHOD="listunspent"
  if ps aux | grep -i $CHAIN ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    source $HOME/.dev2wallet
    submenu_wallet
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function bsk1n_mining_tokens {
  KIABMETHOD="listunspent"
  if ps aux | grep -i $CHAIN ; then
    source ~/coinData/$CHAIN/$CHAIN.conf
    source $HOME/.dev2wallet
    submenu_tokens
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}


function submenu_regtest {
while true
do

### display main menu ###
dialog --clear  --help-button --backtitle "Cakeshop Console" \
--title "[ R E G T E S T - C O N S O L E ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 25 120 14 \
START "Give me devmode - start single user dev chain" \
STOP "Stop devmode - stops single user dev chain" \
RESTARTDEV1 "(todo) Restart clearing wallet and importing dev1 wallet in single user dev chain" \
RESTARTDEV2 "(todo) Restart clearing wallet and importing dev2 wallet in single user dev chain" \
GETINFO "Get Info - single user dev chain getinfo method" \
GENERATE "Generate - single user dev chain generate blocks" \
GETBALANCE "Get Balance - get balance of all coins in the wallet" \
LISTUNSPENT "List Unspent UTXO - single user dev chain listunspent" \
SENDTODEV1 "Send some coins to the same address" \
SENDALLTODEV1 "Send all coins to the same address" \
SENDTODEV2 "Send some coins to another address"  \
Back "Back a menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion
case $menuitem in
	START) start_regtest;;
	STOP) stop_regtest;;
	GETINFO) getinfo_regtest;;
	GENERATE) generate_regtest;;
	GETBALANCE) getbalance_regtest;;
	LISTUNSPENT) listunspent_regtest;;
	SENDTODEV1) sendtoself_regtest;;
	SENDALLTODEV1) sendalltoself_regtest;;
	SENDTODEV2) sendtoother_regtest;;
	Back) echo "Bye"; break;;
esac
done
}

function listunspent_regtest {
  KIABMETHOD="listunspent"
  if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
    source ~/.komodo/$NAME/$NAME.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"listunspent\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function generate_regtest {
  KIABMETHOD="generate"
  if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
    source ~/.komodo/$NAME/$NAME.conf
    input_box "Generate blocks" "How many blocks to generate?" "1" GENERATE
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"generate\", \"params\": [$GENERATE]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function getinfo_regtest {
  KIABMETHOD="getinfo"
  if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
    source ~/.komodo/$NAME/$NAME.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getinfo", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function getbalance_regtest {
	KIABMETHOD="getbalance"
	if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
    source ~/.komodo/$NAME/$NAME.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function sendtoself_regtest {
	KIABMETHOD="sendtoaddress"
	if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
	source ~/.devwallet
    source ~/.komodo/$NAME/$NAME.conf
	input_box "Send Question" "How many coins to send, must be less than your balance?" "1" SENDAMOUNT
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$DEVADDRESS\", $SENDAMOUNT, \"optional comment\", \"optional comment-to\", true]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function sendalltoself_regtest {
	KIABMETHOD="sendtoaddress"
	if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
	source ~/.devwallet
    source ~/.komodo/$NAME/$NAME.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"getbalance\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
	sleep 1
	SENDAMOUNT=`cat ~/.kiabresponse`
	echo $SENDAMOUNT
	sleep 4
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$DEVADDRESS\", $SENDAMOUNT, \"\", \"\", true]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function sendtoother_regtest {
	KIABMETHOD="sendtoaddress"
	if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
	source ~/.dev2wallet
    source ~/.komodo/$NAME/$NAME.conf
	input_box "Send Question" "How many coins to send, must be less than your balance?" "1" SENDAMOUNT
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$DEV2ADDRESS\", $SENDAMOUNT, \"optional comment\", \"optional comment-to\", true]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function stop_regtest {
	KIABMETHOD="stop"
  if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
    source ~/.komodo/$NAME/$NAME.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to stop..."
    sleep 1
  fi
}

function start_regtest {
  if ps aux | grep -i [r]egtest ; then
    NAME=$(ps aux | grep [r]egtest | cut -d= -f2| cut -d' ' -f1)
    source ~/.komodo/$NAME/$NAME.conf
#    WALLET1=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
#    echo "New wallet address: $WALLET1"
#    input_box "LEG4" "New wallet is" "$WALLET1" WALLET1B
#    sleep 3
    echo "Regtest already running"
    sleep 3
  else
    input_box "Supply Question" "How many coins?" "1000" SUPPLY
    #input_box "LEGS2" "How many wallets?" "5" WALLETS
    input_box "Name Question" "Ticker for chain?" "MYCOIN" NAME
    source ~/.devwallet
    echo $SUPPLY
    sleep 1
#    echo $WALLETS
#    sleep 1
    echo $NAME
    sleep 1
    hide_output komodod -regtest -ac_name=$NAME -ac_supply=$SUPPLY -pubkey=$DEVPUBKEY -ac_cc=2 &
    sleep 1
    sleep 1
    echo "Waiting for 3 more seconds"
    sleep 3
    source ~/.komodo/$NAME/$NAME.conf
    echo "Using $rpcuser & $rpcpassword with wif $DEVWIF"
    sleep 2
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"importprivkey\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'
    sleep 3
  fi
}

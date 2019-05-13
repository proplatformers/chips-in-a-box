function getbalance {
  KIABMETHOD="getbalance"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function getwalletinfo {
  KIABMETHOD="getwalletinfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function listunspent {
  KIABMETHOD="listunspent"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function sendtoaddress {
	KIABMETHOD="sendtoaddress"
	if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
	input_box "Send Question" "How many coins to send, must be less than your balance?" "1" SENDAMOUNT
	input_box "Send Question" "Send to which transparent address?" "1" SENDTOADDRESS
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$SENDTOADDRESS\", $SENDAMOUNT, \"optional comment\", \"optional comment-to\", true]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function importprivkey {
	KIABMETHOD="importprivkey"
	if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    source ~/.devwallet
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$DEVWIF\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function sendalltoself {
	KIABMETHOD="sendtoaddress"
	if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"getbalance\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
	sleep 1
	SENDAMOUNT=`cat ~/.kiabresponse`
	echo $SENDAMOUNT
	sleep 1
  source ~/.devwallet
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$DEVADDRESS\", $SENDAMOUNT, \"\", \"\", true]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}

function sendallto {
	KIABMETHOD="sendtoaddress"
	if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    input_box "Send Question" "Send balance to which transparent address?" "address" SENDTOADDRESS
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"getbalance\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
	sleep 1
	SENDAMOUNT=`cat ~/.kiabresponse`
	echo $SENDAMOUNT
	sleep 1
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$SENDTOADDRESS\", $SENDAMOUNT, \"\", \"\", true]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start devmode..."
    sleep 1
  fi
}
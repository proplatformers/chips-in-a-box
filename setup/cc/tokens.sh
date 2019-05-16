function tokenaddress {
  KIABMETHOD="tokenaddress"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    # echo "curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/"
    # sleep 3
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function tokencreate {
  KIABMETHOD="tokencreate"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    echo "curl -s --user $rpcuser:$rpcpassword --data-binary \"{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENNAME\", \"$TOKENSUPPLY\", \"$TOKENDESCRIPTION\"]}\" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/"
    message_box "Create Token Details" "Name: $TOKENNAME\nSupply: $TOKENSUPPLY\nDescription: $TOKENDESCRIPTION"
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENNAME\", \"$TOKENSUPPLY\", \"$TOKENDESCRIPTION\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function tokenlist {
  KIABMETHOD="tokenlist"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function helper_tokenlist {
  KIABMETHOD="tokenlist"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    # message_box removed
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function tokeninfo {
  KIABMETHOD="tokeninfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function helper_tokeninfo {
  KIABMETHOD="tokeninfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    # message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokenbalance {
  KIABMETHOD="tokenbalance"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokenask {
  KIABMETHOD="tokenask"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$AMOUNT\", \"$TOKENTXID\", \"$PRICE\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
    # message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokenbid {
  KIABMETHOD="tokenbid"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$AMOUNT\", \"$TOKENTXID\", \"$PRICE\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
    # message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}


function tokenorders {
  KIABMETHOD="tokenorders"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function helper_tokenorders {
  KIABMETHOD="tokenorders"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    # KIABRESPONSE=`cat ~/.kiabresponse`
    # message_box "$KIABMETHOD" "$KIABRESPONSE"
    # ~/.kiabresponse is usable for the tokenfillbid/tokenfillask 
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}


function tokencancelask {
  KIABMETHOD="tokencancelask"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # input_box "Token Amount to Fill Trade" "Amount of tokens?" "1" TOKENFILLAMOUNT
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\", \"$TOKENFILLTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokencancelbid {
  KIABMETHOD="tokencancelbid"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # input_box "Token Amount to Fill Trade" "Amount of tokens?" "1" TOKENFILLAMOUNT
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\", \"$TOKENFILLTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokenfillask {
  KIABMETHOD="tokenfillask"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    input_box "Token Amount to Fill Trade" "Amount of tokens?" "1" TOKENFILLAMOUNT
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\", \"$TOKENFILLTXID\", \"$TOKENFILLAMOUNT\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokenfillbid {
  KIABMETHOD="tokenfillbid"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    input_box "Token Amount to Fill Trade" "Amount of tokens?" "1" TOKENFILLAMOUNT
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\", \"$TOKENFILLTXID\", \"$TOKENFILLAMOUNT\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}

function tokentransfer {
  KIABMETHOD="tokentransfer"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    input_box "Token Amount to Transfer" "Amount of tokens?" "1" TOKENTRANSFERAMOUNT
    input_box "Destination" "Pubkey destination?" "1" DESTINATIONPUBKEY
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$TOKENTXID\", \"$DESTINATIONPUBKEY\", \"$TOKENTRANSFERAMOUNT\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    # sleep 1
  fi
}
function faucetinfo {
  KIABMETHOD="faucetinfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function faucetaddress {
  KIABMETHOD="faucetaddress"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}


function faucetfund {
  KIABMETHOD="faucetfund"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    input_box "Fund the faucet" "How many coins to fund faucet?" "101" FAUCETFUNDAMOUNT
    # echo "Using $CHAIN configuration pubkey $DEVPUBKEY"
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$FAUCETFUNDAMOUNT\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function faucetget {
  KIABMETHOD="faucetget"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # echo "Using $CHAIN configuration pubkey $DEVPUBKEY"
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    cp ~/.kiabresponse ~/.faucetget
    # grep for error, but a real programmer will inspect the response if error attribute is set
    if grep error $HOME/.kiabresponse ; then
      echo "Error"
      sleep 1
      message_box "Error" "There was an error.\nEither no funds in faucet or you have to wait until next block"
    else 
    #   message_box "NO Error" "There was NO error.\nEither no funds in faucet or you have to wait until next block"
    #   echo "No error"
    #   sleep 2
      RAWHEX=$KIABRESPONSE
      echo $RAWHEX
      sendrawtransaction
    fi
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}
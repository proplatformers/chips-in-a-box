function rewardslist {
  KIABMETHOD="rewardslist"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function helper_rewardslist {
  KIABMETHOD="rewardslist"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    # message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function rewardsinfo {
  KIABMETHOD="rewardsinfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$REWARDSTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function helper_rewardsinfo {
  KIABMETHOD="rewardsinfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$REWARDSTXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    # message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function rewardscreatefunding {
  KIABMETHOD="rewardscreatefunding"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$REWARDSNAME\", \"$REWARDSSEEDFUNDING\", \"$REWARDSAPR\", \"$REWARDSMINDAYS\", \"$REWARDSMAXDAYS\", \"$REWARDSMINDEPOSIT\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function rewardsaddress {
  KIABMETHOD="rewardsaddress"
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

function rewardslock {
  KIABMETHOD="rewardslock"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$REWARDSNAME\", \"$REWARDSTXID\", \"$REWARDSLOCK\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}
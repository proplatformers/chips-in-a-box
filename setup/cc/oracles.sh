function oracleslist {
  KIABMETHOD="oracleslist"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": []}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function oraclesinfo {
  KIABMETHOD="oraclesinfo"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$ORACLETXID\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function oraclescreate {
  KIABMETHOD="oraclescreate"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$ORACLESNAME\", \"$ORACLESDESCRIPTION\", \"$ORACLESFORMAT\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    RAWHEX=$KIABRESPONSE
    sendrawtransaction
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function oraclesaddress {
  KIABMETHOD="oraclesaddress"
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

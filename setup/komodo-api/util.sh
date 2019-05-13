function validateaddress {
    KIABMETHOD="validateaddress"
    if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    # source ~/.komodo/$CHAIN/$CHAIN.conf
    # source ~/.devwallet
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"$DEVADDRESS\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD response" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

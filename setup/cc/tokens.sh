function tokencreate {
  KIABMETHOD="tokencreate"
  if ps aux | grep komodod | grep $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    curl -s --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\": \"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"GB\", 5, \"created GB token\"]}" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.hex' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
  else
    echo "Nothing to query - start $CHAIN..."
    sleep 1
  fi
}

function getinfo {
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

function stop {
  if ps aux | grep -i $CHAIN | grep -v grep ; then
    source ~/.komodo/$CHAIN/$CHAIN.conf
    RESULT=`curl -s --user $rpcuser:$rpcpassword --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "stop", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result'`
    echo "Result: $RESULT"
    sleep 2
  else
    echo "Nothing to stop..."
    sleep 1
  fi
}
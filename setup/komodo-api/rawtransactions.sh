function sendrawtransaction {
    source ~/.komodo/$CHAIN/$CHAIN.conf
    KIABMETHOD="sendrawtransaction"
    curl --user $rpcuser:$rpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\":\"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [\"\"] }" -H 'content-type: text/plain;' http://127.0.0.1:$rpcport/ | jq -r '.result' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
}


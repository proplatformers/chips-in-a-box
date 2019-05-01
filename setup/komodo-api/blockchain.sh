function getrawmempool {
    source ~/.komodo/$CHAIN/$CHAIN.conf
    KIABMETHOD="getrawmempool"
    curl --user myrpcuser:myrpcpassword --data-binary "{\"jsonrpc\": \"1.0\", \"id\":\"curltest\", \"method\": \"$KIABMETHOD\", \"params\": [true] }" -H 'content-type: text/plain;' http://127.0.0.1:myrpcport/ | jq '.' > ~/.kiabresponse
    KIABRESPONSE=`cat ~/.kiabresponse`
    message_box "$KIABMETHOD" "$KIABRESPONSE"
}
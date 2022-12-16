#!/bin/bash
# Prettifies the cURL json response while showing the header

clear
ID=
PORT=3000
ROUTE=jobs
QUERY=
USERNAME=daniel
TOKEN=$(<curl_scripts/$USERNAME-token.txt)
RES=$(curl -i\
	"localhost:$PORT/api/v1/$ROUTE"\
	-H "content-type:application/json"\
	 -H "Authorization: Bearer $TOKEN")
HEAD=$''
BODY=$''
isJSON=false 
for (( i=0; i<${#RES}; i++)); do
	CH=${RES:$i:1}
	if [ "$CH" = '{' ] || [ "$CH" = '[' ] || [ $isJSON = true ]
	then
		BODY+=$CH
		isJSON=true
	else
		HEAD+=$CH
	fi
done
printf "\n\n$HEAD"
echo "$BODY" | jq '.'
echo "$BODY" | jq '.' > curlresget.txt

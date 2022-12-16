#!/bin/bash
# Prettifies the cURL json response while showing the header

clear
ID=
PORT=3000
QUERY=
USERNAME=
USERID=
TOKEN=$(<curl_scripts/token/$USERNAME$USERID.txt)
URL=localhost
PORT=1024
ROUTE=api/v1/user-accounts
RES=$(curl -i "$URL/$ROUTE/$ID"\
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
echo $BODY | jq '.'

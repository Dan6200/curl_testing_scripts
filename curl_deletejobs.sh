#!/bin/bash
# Prettifies the cURL json response while showing the header

clear
USERNAME=tevon
URL=https://jobs-api-06-dan.herokuapp.com
ROUTE=api/v1/jobs
ID=629b98732e4636c0d704edbc
PORT=3000
QUERY=
TOKEN=$(<curl_scripts/$USERNAME-token.txt)
RES=$(curl -i -X DELETE\
	"$URL/$ROUTE/$ID"\
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

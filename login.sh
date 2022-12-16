#!/bin/bash
# Prettifies the json response while showing the header in the cURL response

clear
PORT=1024

DATA="{
	\"email\"			:\"ebukachibueze5489@gmail.com\",
	\"password\"		:\"EbukaDa1!\"
}"
URL=localhost
ROUTE=api/v1/auth/login
RES=$(curl\
	-i "$URL:$PORT/$ROUTE"\
	-H "content-type:application/json"\
	-d "$DATA")

HEAD=""
BODY=""
isJSON=false 
#TODO: optimize this SHIT!!! Use sed/awk
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
TOKEN=$(jq -r '.token' <<< $BODY)
USERNAME=$(jq -r '.user.name' <<< $BODY)
USERID=$(jq -r '.user.userId' <<< $BODY)
echo $TOKEN > token/$USERNAME$USERID.txt

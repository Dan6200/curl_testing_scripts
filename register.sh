#!/bin/bash
# Prettifies the json response while showing the header in the cURL response

clear
PORT=1024
DATA="{
	\"first_name\"	    :\"Ebuka\",
	\"last_name\"	    :\"Eze\",
	\"initials\"	    :\"EE\",
	\"email\"			:\"ebukachibueze5489@gmail.com\",
	\"phone\"			:\"2349063459623\",
	\"password\"		:\"EbukaDa1!\",
	\"ip_address\"		:\"168.89.91.45\",
	\"country\"			:\"Nigeria\",
	\"dob\"				:\"1999-07-01\"
}"
URL=localhost
ROUTE=api/v1/auth/register
RES=$(curl\
	-i "$URL:$PORT/$ROUTE"\
	-H "content-type:application/json"\
	-d "$DATA")

HEAD=""
BODY=""
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

TOKEN=$(jq -r '.token' <<< $BODY)
USERNAME=$(jq -r '.newUser.first_name' <<< $BODY)
USERID=$(jq -r '.newUser.user_id' <<< $BODY)
echo $TOKEN > token/$USERNAME$USERID.txt

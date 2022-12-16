#!/bin/bash
# Prettifies the json response while showing the header in the cURL response

clear
PORT=3000
USERNAME="kentrell"
ID=
# \"\":\"\"
DATA="{
	\"company\":\"Walmart\",
	\"position\":\"Sales Manager\"
}"
URL=https://jobs-api-06-dan.herokuapp.com
ROUTE=api/v1/jobs
TOKEN=$(<curl_scripts/$USERNAME-token.txt)
RES=$(curl -i "$URL/$ROUTE/$ID"\
	-H "content-type:application/json"\
	 -H "Authorization: Bearer $TOKEN" -d "$DATA")
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

#!/bin/bash
# Prettifies the json response while showing the header in the cURL response

clear
PORT=3000
USERNAME="kentrell"
ID=629cbd2eb67e8c3669df6e02
# \"\":\"\"
DATA="{
	\"company\":\"Tesco\"
}"
URL=https://jobs-api-06-dan.herokuapp.com
ROUTE=api/v1/jobs
TOKEN=$(<curl_scripts/$USERNAME-token.txt)
RES=$(curl -i -X PATCH "$URL/$ROUTE/$ID"\
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
printf "\n$HEAD"
echo "$BODY" | jq '.'

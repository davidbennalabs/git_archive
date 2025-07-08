#!/usr/bin/bash


FILE=$1
STORAGE_CONTAINER=$2
STORAGE_ACCOUNT=$3

FILE=index.html
STORAGE_ACCOUNT=
# echo az storage blob upload-batch -s $FILE -d $STORAGE_CONTAINER --account-name $STORAGE_ACCOUNT
az storage blob upload-batch -s index.html -d '$web' --account-name fclzolhk
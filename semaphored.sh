#!/bin/bash

cookie_hash=$([ -r "/$SNAP_USER_COMMON/cookie_hash.txt" ] && cat "/$SNAP_USER_COMMON/cookie_hash.txt")

if [ -z "$cookie_hash" ]
then
  cookie_hash=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 40 ; echo '')
  echo "$cookie_hash" > "/$SNAP_USER_COMMON/cookie_hash.txt"
fi

cookie_encryption=$([ -r "/$SNAP_USER_COMMON/cookie_encryption.txt" ] && cat "/$SNAP_USER_COMMON/cookie_encryption.txt")

if [ -z "$cookie_encryption" ]
then
  cookie_encryption=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 40 ; echo '')
  echo "$cookie_encryption" > "/$SNAP_USER_COMMON/cookie_encryption.txt"
fi

tee "/$SNAP_USER_COMMON/config.json" <<CONFIG
{
 	"bolt": {
 		"host": "${SNAP_USER_COMMON}/database.boltdb",
 		"user": "",
 		"pass": "",
 		"name": ""
 	},
 	"port": "",
 	"interface": "",
 	"tmp_path": "/tmp/semaphore",
 	"cookie_hash": "${cookie_hash}",
 	"cookie_encryption": "${cookie_encryption}",
 	"email_sender": "",
 	"email_host": "",
 	"email_port": "",
 	"web_host": "",
 	"ldap_binddn": "",
 	"ldap_bindpassword": "",
 	"ldap_server": "",
 	"ldap_searchdn": "",
 	"ldap_searchfilter": "",
 	"ldap_mappings": {
 		"dn": "",
 		"mail": "",
 		"uid": "",
 		"cn": ""
 	},
 	"telegram_chat": "",
 	"telegram_token": "",
 	"concurrency_mode": "",
 	"max_parallel_tasks": 0,
 	"email_alert": false,
 	"telegram_alert": false,
 	"ldap_enable": false,
 	"ldap_needtls": false
}
CONFIG

./sempahore -config "/$SNAP_USER_COMMON/config.json"

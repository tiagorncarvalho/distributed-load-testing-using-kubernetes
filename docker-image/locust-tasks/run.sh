#!/bin/bash

# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCUST="/usr/local/bin/locust"
LOCUS_OPTS="-f /locust-tasks/tasks.py --host=$TARGET_HOST"
LOCUST_MODE=${LOCUST_MODE:-standalone}
sudo apt install jq
ACCESS_TOKEN=$(curl --request POST \
  --url 'https://saldanha.eu.auth0.com/oauth/token' \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=password \
  --data username=miguelsaldanhafernandes@protonmail.com \
  --data 'password=!sedeusquiser1999' \
  --data audience=https://recommendations.sytes.net/api \
  --data 'scope=openid name email nickname read:suggest write:item delete:item write:seen write:like write:username delete:username' \
  --data 'client_id=72wQelC6FubulYS6qlY7ZhSVkyNgoTYF'\
  --data client_secret=UHqFceMIWf0pzpA3CRWggxpGDxByyn_vQuw_90OdhaoascI-t5RBha4z5sRPbNJK | jq -r '.access_token'
)
set TOKEN="$ACCESS_TOKEN"

if [[ "$LOCUST_MODE" = "master" ]]; then
    LOCUS_OPTS="$LOCUS_OPTS --master"
elif [[ "$LOCUST_MODE" = "worker" ]]; then
    LOCUS_OPTS="$LOCUS_OPTS --slave --master-host=$LOCUST_MASTER"
fi

echo "$LOCUST $LOCUS_OPTS"

$LOCUST $LOCUS_OPTS
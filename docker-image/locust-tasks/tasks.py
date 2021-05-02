#!/usr/bin/env python

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


import uuid

from datetime import datetime
from locust import HttpLocust, TaskSet, task


class MetricsTaskSet(TaskSet):
    _deviceid = None

    def on_start(self):
        self._deviceid = str(uuid.uuid4())

    @task(999)
    def getItem(self):
        self.client.get(
            "/item/BOOK/607615b3aeb60e0f26f7c1df")

    @task(999)
    def putLikes(self):
        self.client.put(
        "/item/BOOK/607615b3aeb60e0f26f7c1df/like", auth=("admin", "admin"))
        
    @task(999)
    def putSeen(self):
        self.client.put(
        "/item/BOOK/607615b3aeb60e0f26f7c1df/seen", auth=("admin", "admin"))
        
    @task(999)
    def getPage(self):
        self.client.get(
        "/lib/1")
        
    @task(999)
    def getSuggestion(self):
        self.client.post(
        "/suggest", {"tipos": ["BOOK"]}, auth=("admin", "admin"))
        
    @task(999)
    def changePassword(self):
        self.client.put(
        "/user/search/saldanha", { "password": "saldanha", "username": "saldanha"}, auth=("saldanha", "saldanha"))
        
    @task(999)
    def getLogin(self):
        self.client.get(
        "/user/login", auth=("admin", "admin"))
        
    @task(999)
    def getLogout(self):
        self.client.get(
        "/user/logout", auth=("admin", "admin"))

class MetricsLocust(HttpLocust):
    task_set = MetricsTaskSet

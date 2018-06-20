#!/bin/bash

docker run --name redisserver -d redis redis-server --appendonly yes

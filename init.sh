#!/bin/bash

mkdir -p ./data/rabbitmq
mkdir -p ./data/mysql/{binlog,data,logs,conf}
mkdir -p ./data/redis/data
chown -R 999:999 ./data/mysql/*
chown -R 100:100 ./data/redis
chown -R 100:100 ./data/rabbitmq

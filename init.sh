#!/bin/bash

mkdir -p ./data/mysql/{binlog,data,logs,conf}
chown -R systemd-bus-proxy:input ./data/mysql/*
chown -R 100:100 ./data/redis/*

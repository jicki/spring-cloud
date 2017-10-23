#!/bin/bash

chown -R systemd-bus-proxy:input ./data/mysql/*
chown -R 100:100 ./data/redis/*

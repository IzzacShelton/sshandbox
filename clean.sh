#!/bin/bash
docker rm -f sshandbox && docker build -t sshandbox .
echo "removed and rebuild sshandbox"

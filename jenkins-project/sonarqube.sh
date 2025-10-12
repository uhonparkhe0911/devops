#!/bin/bash

docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube

sqa_6eb266f19eead1881ce2391363b4f28f8054d0b3
#!/bin/bash

yum update -y
yum install java -y
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cd /etc/yum.repos.d
echo "[logstash-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > logstash.repo
yum -y install logstash
 
# Create Logstash config files and pipelines
 
cd /etc/logstash/conf.d
echo "input {
  beats {
    port => 5044
    }
  }
output {
    pipeline {
    send_to => ["\"pipeline2\""]
    }
    file {
    path => "\"/var/log/filebeat/HWC-Raw.log\""
    }
  } " > pipeline1.conf
  
echo "input {
  pipeline {
    address => "\"pipeline2\""
    }
  }
output {
  elasticsearch {
    hosts => [\"http://c59624d7a01a80.lhr.life:80\"]
    index => \"hwc-%{+YYYY.MM.dd}\"
    }
    pipeline {
    send_to => ["\"pipeline3\""]
    }
  } " > pipeline2.conf
 
echo "input {
  pipeline {
    address => "\"pipeline3\""
    }
  }
output { 
   file {
    path => "\"/var/log/filebeat/HWC1.log\""
    }
  } " > pipeline3.conf
 
# Start Logstash
/usr/share/logstash/bin/logstash --path.settings /etc/logstash/
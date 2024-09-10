# HWC-2-2023
Continuation of HWC, looking at Automation and Cloud Services. Originally Created Feb 2023.

# What's in this repo
This repo has been created as part of the Observability onboarding, it allows for the deployment of an ec2 instance within the ACG sandbox via Terraform.
Using user input Access and Secret Access keys from the ACG log in, Terraform will create a single ec2 instance pre-installed with Logstash and 2 security groups allowing for ssh and port 5044/9200 access.
Access to localhost:9200 will be established through running localhost.run.

# Prerequisites’:
* Access to ACG sandbox or AWS environment with Access Key Id's & Secret Access Key's
* Access to previously mention environments GUI portal
* Terraform installed locally
* Elasticsearch, Kibana & Filebeat all installed locally
* Localhost.run key
* Filebeat reading logs from your chosen location

# Instructions for use

1) Spin up Elasticsearch and Kibana servers,
2) Run ssh -R 80:localhost:9200 localhost.run command in CLI,
3) Add localhost.run output URL into InstallLS.sh file within elasticsearch output. Removing "s" from "https" and maintaining :80,
4) Using AWS GUI portal create a keypair under the name "HWC" and store as a .pem file,
5) Run TFRun.sh file,
6) Enter AWS Access key, followed by Secret access key,
7) Review Terraform apply and follow instructions if happy to proceed,
8) Once the ec2 instance has been created copy the public IPv4 address of the instance and add to filebeat.yml under "Logstash Output" - output.logstash: hosts: ["\<ec2 IPv4\>:5044"],
9) Run Filebeat,
10) Your ec2 instance is now ready to receive logs into Logstash on Port:5044 from Filebeat and output them to your local Elasticsearch/ Kibana Dashboard.

# Outline acceptance criteria: 

HWC-Pt2:

Create Virtual Machine via AWS Portal

Create Virtual Machine via Terraform

Install Logstash Manually onto VM

Install Logstash via script

Get Logstash to read logs from one folder and write logs to another in a single pipeline.

Change Logstash pipeline to split it and use pipeline to pipeline communication (Input / Filter / Output)

Incorporate Logstash install script and pipeline into TF code

Modify solution to HWC so that filebeat writes data to Logstash, Logstash should be configured to use 3 pipelines to write the logs to a folder locally. 

Logstash output pipeline should be updated to include an elasticsearch output. 

Amend configuration for elasticsearch so that an ILM policy removes replicas in the index after 1 day.

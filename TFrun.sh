#!/bin/bash
# This script will create an additional EC2 instance
# Main.tf within this repo will create 1 addition t2.micro VM
# Storing user input secrets during creation
# This script is soley for user convinience not required for the HWC
 
echo "Please Enter Access ID:"
read -s varID
 
echo "Now Enter Secret Key:"
read -s varKey
 
export AWS_ACCESS_KEY_ID=$varID
export AWS_SECRET_ACCESS_KEY=$varKey
 
echo "Terraform Installed, initialising Terraform"
terraform init
 
echo "Terraform is ready to use, now validating config"
terraform fmt
terraform validate
 
echo "Config validated, running apply"
 
terraform apply
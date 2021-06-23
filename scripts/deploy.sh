#!/bin/bash

echo "deploy script has run"

# download azure cli
sudo apt-get update
sudo apt-get install curl -y
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# download terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform -y 

# login, az login

# run terraform
cd Terraform/
terraform init
terraform plan -no-color -out=create.tfplan
terraform apply -no-color -auto-approve create.tfplan

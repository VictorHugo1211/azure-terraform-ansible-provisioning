#!/bin/bash

VM_ADM="adminuser"
VM_ADM_PASS="Mudar@1234"
SSH_KEY="$(pwd)/ssh/default_key"
DB_SERVER="wordpress-mysql-server-unique"
DB_USER="dbadmin"
DB_PASS="Mudar@1234"
DB_NAME="wordpress"


echo "Iniciando criação do ambiente"

cd ./terraform

echo "admin_vm = \"$VM_ADM\"
admin_password_vm = \"$VM_ADM_PASS\"
public_key_path = \"$SSH_KEY.pub\"
admin_db = \"$DB_USER\"
admin_password_db = \"$DB_PASS\"
db_name = \"$DB_NAME\"
db_server_name = \"$DB_SERVER\"" > terraform.tfvars 

terraform init

terraform fmt

terraform validate

terraform apply -auto-approve -var-file="terraform.tfvars"

IP=$(terraform output ip | sed 's/"//g')

echo "Infraestrutura criada com sucesso"

cd ..

cd ./ansible

echo "Iniciando configuração do inventário host $IP"

echo "webservers:
  hosts:
    wordpress:
      ansible_host: $IP
      ansible_user: $VM_ADM
      ansible_ssh_private_key_file: $SSH_KEY" > inventory.yaml

echo "db_name: $DB_NAME
db_user: $DB_USER
db_password: $DB_PASS
db_host: $DB_SERVER.mysql.database.azure.com" > group_vars/wordpress.yaml

echo "Inventario de host configurado com sucesso"

echo "Iniciando playbook"

ssh-keyscan -H $IP >> ~/.ssh/known_hosts

ansible-playbook main.yaml -i inventory.yaml

echo "Playbook executado com sucesso"

echo "Você pode acessar o wordpress em http://$IP"
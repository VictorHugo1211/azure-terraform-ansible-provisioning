# Projeto Terraform e Ansible

Este projeto utiliza Terraform para provisionamento de infraestrutura no Azure e Ansible para configuração de servidores.

## Pré-requisitos

1. **Azure CLI**

    Você precisa ter o Azure CLI instalado em sua máquina. Para instalar o Azure CLI, siga as instruções no [site oficial da Microsoft](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli).

    Após instalar, faça login na sua conta do Azure:
    ```sh
    az login
    ```
2. **Ansible**

    O Ansible deve estar instalado na sua máquina. Note que o Ansible funciona melhor em distribuições Linux. Se você estiver usando Debian ou uma distribuição baseada em Debian, há um script install_ansible.sh na pasta ansible para facilitar a instalação.

    Para instalar o Ansible no Debian, execute o script de instalação:
    ```sh
    cd ansible
    ./install_ansible.sh
    ```
## Configuração e Execução

1. **Variáveis do Terraform**

   - Antes de executar o script `create.sh`, revise e ajuste as variáveis no inicio do arquivo, pois serão gravadas no arquivo `terraform.tfvars` conforme a sua configuração específica, ou se preferir, pode deixar os valores default atribuídos.

2. **Executando o Terraform e Ansible**

   - Execute o script `create.sh` na raiz do projeto para iniciar o processo de provisionamento da infraestrutura no Azure e configuração dos servidores com Ansible:
     ```sh
     ./create.sh
     ```

   - O script `create.sh` automatiza o processo de:
     - Inicialização do Terraform
     - Aplicação da configuração do Terraform para provisionamento da infraestrutura no Azure
     - Configuração dos servidores usando Ansible com base nos playbooks e roles definidos na estrutura do projeto.

## Estrutura do Projeto
├── ansible\
│   ├── group_vars\
│   │   └── wordpress.yaml\
│   ├── inventory.yaml\
│   ├── main.yaml\
│   ├── roles\
│   │   ├── mysql\
│   │   │   └── tasks\
│   │   │       └── main.yaml\
│   │   ├── nginx\
│   │   │   ├── tasks\
│   │   │   │   └── main.yaml\
│   │   │   └── templates\
│   │   │       └── nginx.conf.j2\
│   │   └── wordpress\
│   │       ├── tasks\
│   │       │   └── main.yaml\
│   │       └── templates\
│   │           └── wp-config.php.j2\
│   └── install_ansible.sh\
├── README.md\
├── ssh\
│   ├── default_key\
│   └── default_key.pub\
├── terraform\
│   ├── backend.tf\
│   ├── main.tf\
│   ├── mysql_flexible_server.tf\
│   ├── network_interface.tf\
│   ├── network_security_group.tf\
│   ├── output.tf\
│   ├── public_ip.tf\
│   ├── resource_group.tf\
│   ├── subnet.tf\
│   ├── terraform_state\
│   │   └── terraform state file\
│   ├── terraform.tfvars\
│   ├── variables.tf\
│   ├── virtual_machine.tf\
│   └── virtual_network.tf\
└── create.sh

## Observações

Certifique-se de ter as permissões necessárias para executar scripts na sua máquina. Você pode precisar alterar as permissões do script create.sh com o seguinte comando:

```sh
chmod +x create.sh
```
    
Este projeto foi testado em distribuições Linux, especialmente Debian. Se estiver utilizando outra distribuição ou sistema operacional, adapte as instruções conforme necessário.
    
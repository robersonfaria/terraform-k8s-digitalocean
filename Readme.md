# Digital Ocean Kubernetes - Deploy Wordpress

## Configuração e execução do terraform

1) Criar variaveis de ambiente:
```bash
export DIGITALOCEAN_TOKEN=dop_v1_***********************************
export SPACES_SECRET_KEY=*******************************************
```

2) Configurar o [nome do bucket/spaces](https://github.com/robersonfaria/terraform-k8s-digitalocean/blob/e6757d2d88ef16e07ccb1752b4d5ae489bc196b2/main.tf#L12) onde será provisionado o estado do terraform:

```terraform
  backend "s3" {
    ...
    bucket = "nome-unico-do-seu-space"
    ...
  }
```

3) Iniciar a configuração do terraform:

```bash
terraform init -migrate-state -backend-config="access_key=$SPACES_ACCESS_TOKEN" -backend-config="secret_key=$SPACES_SECRET_KEY"
```

4) Rodar o terraform, será necessário informar as senhas desejadas para o banco de dados Mysql ou criar um arquivo.tfvars

```bash
terraform apply
```

## Variáveis de entrada aceitas

| Variável | Descrição | Tipo | Valor Padrão |
|----------|-----------|------|--------------|
| cluster_name | Nome do cluster Kubernetes | string | my-cluster |
| cluster_version | Versão do cluster Kubernetes | string | 1.24.4-do.0 |
| region | Sigla da região onde será implantado o cluster Kubernetes | string | nyc1 |
| namespace | Nome do name space utilizado para implantação das applicações | string | my-app |
| default_node_instances_size | Tamanho das instancias utilizadas para compor o poll de nodes default do cluster | string | s-1vcpu-2gb |
| default_node_instances_quantity | Qauntidade de instancias utilizadas para compor o poll de nodes default do cluste(é recomendado um mínimo de 3) | number | 3 |
| mysql_version | Versão do MySql que será utilizado | string | 8.0.31 |
| mysql_password | Senha do usuário wordpress do banco de dados MySql | string |  |
| mysql_root_password | Senha do usuário root do banco de dados MySql | string |  |
| wordpress_version | Versão do Wordpress que será implantado | string | 6.0.2 |

# Changelog

* 1.0.2<br/>- Alterado para utilizar deployment segundo [recomendação da documentação](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#:~:text=Note%3A%20A%20Deployment%20that%20configures,is%20always%20up%20and%20available)<br/>- Corrigido bug na alteração do mysql hostname


* 1.0.1<br/>- Organização geral do código<br/>- Criação de variáveis<br/>- Criação de private VPC

* 1.0.0<br/>- Primeira versão apenas com a app funcionando para validar a POC
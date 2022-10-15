variable "cluster_name" {
  default     = "my-cluster"
  type        = string
  description = "Nome do cluster Kubernetes"
}

variable "cluster_version" {
  default     = "1.24.4-do.0"
  type        = string
  description = "Versão do cluster Kubernetes"
}

variable "region" {
  default     = "nyc1"
  type        = string
  description = "Sigla da região onde será implantado o cluster Kubernetes"
}

variable "namespace" {
  default     = "my-app"
  type        = string
  description = "Nome do name space utilizado para implantação das applicações"
}

variable "default_node_instances_size" {
  default     = "s-1vcpu-2gb"
  type        = string
  description = "Tamanho das instancias utilizadas para compor o poll de nodes default do cluster"
}

variable "default_node_instances_quantity" {
  default     = 3
  type        = number
  description = "Qauntidade de instancias utilizadas para compor o poll de nodes default do cluste(é recomendado um mínimo de 3)"
}

variable "mysql_version" {
  default     = "8.0.31"
  type        = string
  description = "Versão do MySql que será utilizado"
}

variable "mysql_password" {
  type        = string
  description = "Senha do usuário wordpress do banco de dados MySql"
}

variable "mysql_root_password" {
  type        = string
  description = "Senha do usuário root do banco de dados MySql"
}

variable "mysql_volume_size" {
  default     = "10Gi"
  type        = string
  description = "Tamanho do volume disponível para o container do MySql"
}

variable "wordpress_version" {
  default     = "6.0.2"
  type        = string
  description = "Versão do Wordpress que será implantado"
}

variable "wordpress_volume_size" {
  default     = "10Gi"
  type        = string
  description = "Tamanho do volume disponível para o container do Wordpress"
}

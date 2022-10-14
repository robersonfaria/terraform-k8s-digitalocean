variable "namespace" {
  type = string
}

variable "mysql_version" {
  type    = string
  default = "8.0.31"
}

variable "mysql_password" {
  type = string
}

variable "wordpress_version" {
  type = string
  default = "6.0.2"
}

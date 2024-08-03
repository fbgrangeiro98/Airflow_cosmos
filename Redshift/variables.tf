# Variável para a região da AWS
variable "region" {
  description = "AWS region"
  default     = "us-east-2" # Região padrão
}

# Variável para o nome de usuário do administrador do Redshift
variable "admin_username" {
  description = "Redshift Admin Username"
  default     = "admin" # Nome de usuário padrão
}

# Variável para a senha do administrador do Redshift
variable "admin_password" {
  description = "Redshift Admin Password"
  default     = "YourPassword123!" # Senha padrão
}

# Variável para o nome do banco de dados
variable "db_name" {
  description = "Database name"
  default     = "exampledb" # Nome do banco de dados padrão
}

# Variável para o nome do grupo de trabalho do Redshift
variable "workgroup_name" {
  description = "Workgroup name"
  default     = "example-workgroup" # Nome do grupo de trabalho padrão
}

# Variável para o nome do namespace do Redshift
variable "namespace_name" {
  description = "Namespace name"
  default     = "example-namespace" # Nome do namespace padrão
}

# Define o provedor AWS e a região onde os recursos serão criados
provider "aws" {
  region = var.region # Usa a variável de região definida em variables.tf ou terraform.tfvars
}

# Cria a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example_vpc"
  }
}

# Cria três subnets públicas em diferentes zonas de disponibilidade
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "public_subnet_b"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "public_subnet_c"
  }
}

# Cria um gateway de Internet
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example_igw"
  }
}

# Cria uma tabela de rotas para a VPC
resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }

  tags = {
    Name = "example_route_table"
  }
}

# Associa as subnets à tabela de rotas
resource "aws_route_table_association" "public_subnet_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_route_table_association" "public_subnet_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_route_table_association" "public_subnet_c_association" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.example_route_table.id
}

# Cria um grupo de segurança do VPC para permitir o acesso ao Redshift
resource "aws_security_group" "redshift_sg" {
  name        = "redshift_sg"
  description = "Security group for Redshift cluster"
  vpc_id      = aws_vpc.example_vpc.id

  # Regra de entrada para permitir acesso ao Redshift (porta 5439) de qualquer lugar
  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso de qualquer IP (ajuste conforme necessário)
  }

  # Regra de saída para permitir qualquer tráfego
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redshift_sg"
  }
}

# Cria um namespace serverless do Redshift
resource "aws_redshiftserverless_namespace" "example" {
  namespace_name      = var.namespace_name # Nome do namespace
  admin_username      = var.admin_username # Nome de usuário do administrador
  admin_user_password = var.admin_password # Senha do administrador
  db_name             = var.db_name # Nome do banco de dados padrão
}

# Cria um grupo de trabalho serverless do Redshift, dependendo da criação do namespace
resource "aws_redshiftserverless_workgroup" "example" {
  workgroup_name      = var.workgroup_name # Nome do grupo de trabalho
  namespace_name      = aws_redshiftserverless_namespace.example.namespace_name # Nome do namespace associado
  subnet_ids          = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id,
    aws_subnet.public_subnet_c.id
  ] # Lista de subnets no VPC onde o Redshift será criado
  security_group_ids  = [aws_security_group.redshift_sg.id] # Grupo de segurança do VPC
  publicly_accessible = true



  # Dependência explícita para garantir que o namespace seja criado antes do workgroup
  depends_on = [aws_redshiftserverless_namespace.example]
}


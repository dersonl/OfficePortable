
#=============================
# Variável para o bloco CIDR da VPC
#=============================

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "172.31.0.0/16"
}

#=============================
# Variável para o bloco CIDR da sub-rede
#=============================


variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "172.31.1.0/24"
}

#=============================
# Variável para o nome do grupo de VPC
#=============================

variable "vpc_name" {
  description = "Nome do grupo de VPC"
  default     = "officeportable"
}

#=============================
# Variável para o nome vpc id
#=============================
variable "vpc_id" {
  description = "ID do grupo de VPC"
  default     = "vpc-0a262c5af54856d2a" # Exemplo
}

#=============================
# Variável para o nome do grupo de sub-redes
#=============================

variable "subnet_name" {
  description = "Nome do grupo de sub-redes"
  default     = "officeportable-subnets"
}
#=============================
# Variável para o nome do grupo de internet gateway
#=============================
variable "igw_name" {
  description = "Nome do grupo de internet gateway"
  default     = "officeportable-igw"
}

#=============================
# Variável para a AMI do Ubuntu
#=============================
variable "ami_id" {
  description = "AMI ID for the instance"
  default     = "ami-07a0715df72e58928" # Exemplo para Ubuntu
}

#=============================
# Variável para o tipo de instância
#=============================
variable "instance_type_medium" {
  description = "Instance type"
  default     = "t3.medium"
}

variable "instance_type_micro" {
  description = "Instance type"
  default     = "t3.micro"
}


variable "instance_type_large" {
  description = "Instance type"
  default     = "t3.large"
}
#=============================
# Variável para a região AWS
#=============================
variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

#=============================
# Variável para a região AWS VPC
#=============================
variable "aws_region_vpc" {
  description = "AWS Region"
  default     = "eu-north-1a"
}

#=============================
# Variável para o nome do grupo de segurança
#=============================
variable "security_group_officeportable" {
  description = "Nome do security group"
  default     = "officeportable-sg"
}

#=============================
# Variável para o nome da zona DNS
#=============================
variable "dns_zone_name" {
  description = "The name of the DNS zone"
  default     = "officeportable.org" # Substitua pelo seu domínio
}

#=============================
# Variável para o nome do bucket S3
#=============================
variable "bucket_name" {
  description = "Nome do bucket S3"
  default     = "officeportable-bucket"
}


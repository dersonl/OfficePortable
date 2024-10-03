#=============================
# Cria uma VPC (Virtual Private Cloud) com um bloco CIDR especificado
#=============================
resource "aws_vpc" "officeportable_vpc" {
  cidr_block           = var.vpc_cidr # Bloco CIDR da VPC (utilizando a variável)
  enable_dns_support   = true         # Ativa suporte ao DNS
  enable_dns_hostnames = true         # Ativa suporte ao DNS hostnames
  tags = {
    Name = "officeportable-vpc"
  }
}
#=============================
# Cria uma sub-rede dentro da VPC
#=============================

resource "aws_subnet" "officeportable_subnet" {
  vpc_id                  = aws_vpc.officeportable_vpc.id # Referência à VPC criada
  cidr_block              = var.subnet_cidr               # Bloco CIDR da sub-rede (utilizando a variável)
  availability_zone       = var.aws_region_vpc            # Zona de disponibilidade da sub-rede
  map_public_ip_on_launch = true                          # Não mapeia IPs públicos automaticamente
}
#=============================
# Cria um gateway de internet para permitir acesso à internet
#=============================
resource "aws_internet_gateway" "officeportable_gateway" {
  vpc_id = aws_vpc.officeportable_vpc.id # Associado à VPC criada
}

#=============================
#dns Route 53
#=============================
resource "aws_route53_zone" "officeportable_zone" {
  name    = var.dns_zone_name         # Nome do domínio DNS (utilizando a variável)
  comment = "officeportable DNS Zone" # Comentário sobre a zona DNS (utilizando a variável)
}

#=============================
# Cria uma tabela de rotas para gerenciar o tráfego
#=============================
resource "aws_route_table" "officeportable_route_table" {
  vpc_id = aws_vpc.officeportable_vpc.id # Associado à VPC criada

  route {
    cidr_block = "0.0.0.0/0"                                    # Rota para todo o tráfego
    gateway_id = aws_internet_gateway.officeportable_gateway.id # Rota pelo gateway de internet
  }
}
#=============================
# Associa a tabela de rotas à sub-rede
#=============================
resource "aws_route_table_association" "officeportable_route_table_association" {
  subnet_id      = aws_subnet.officeportable_subnet.id           # Sub-rede associada
  route_table_id = aws_route_table.officeportable_route_table.id # Tabela de rotas associada
}
#=============================
# Cria um Security Group para officeportable
#=============================
resource "aws_security_group" "officeportable_sg" {
  vpc_id = aws_vpc.officeportable_vpc.id
  # Nome do Security Group (utilizando a variável)
  name = var.security_group_officeportable
  #=============================
  # Descrição do Security Group (utilizando a variável)
  # Regras de ingress para as portas especificadas
  #=============================  
   ingress = [
    for port in [22, 80, 81, 443, 3000, 8000, 8080, 8443, 9100, 9090, 9093, 9094, 9095, 9096, 9097, 9443] : {
      description      = "Allow traffic on port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] # Permite acesso de qualquer lugar
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  # Regras de egress para permitir todo o tráfego
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Permite todo o tráfego
    cidr_blocks = ["0.0.0.0/0"] # Permite saída para qualquer lugar
  }

  # Tags para identificação
  tags = {
    Name = "officeportable-sg" # Nome do Security Group
  }
}


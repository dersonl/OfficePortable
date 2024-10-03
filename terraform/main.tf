#=============================
# Define o provedor AWS e a região usando a variável
#=============================
provider "aws" {
  region = var.aws_region # Região da AWS (utilizando a variável)
}

#=============================
# Criação do bucket S3
#=============================
resource "aws_s3_bucket" "officeportable_bucket" {
  bucket = var.bucket_name
  acl    = "private" # Define the private access
  tags = {
    Name = "officeportable-bucket"
  }
}

#=============================
# Cria uma instância EC2 t3.large para o OfficePortable
#=============================
resource "aws_instance" "officeportable" {
  ami                    = var.ami_id                                # AMI do Ubuntu (utilizando a variável)
  instance_type          = var.instance_type_large                   # Tipo da instância (utilizando a variável)
  subnet_id              = aws_subnet.officeportable_subnet.id       # Sub-rede onde a instância será lançada
  vpc_security_group_ids = [aws_security_group.officeportable_sg.id] # Associa o Security Group
  key_name               = "mhl"                                     # Chave pública para acessar a instância (utilizando a variável)

  # Utiliza user_data para executar um script a partir de um arquivo
  user_data = file("../scripts/setup.sh") # Lê o conteúdo do arquivo ../scripts/provision.sh

  # Adiciona tags para identificar as instâncias
  tags = {
    Name = "Office Portable"
  }

  root_block_device {
    volume_size = 25
    volume_type = "gp3" # Utiliza o tipo GP3 (SSD) para o root volume
  }
}
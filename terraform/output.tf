#=============================
# Output para o IP e  da instância EC2 Office Portable
#=============================

output "nextcloud_onlyoffice_instance_id" {
  description = "The IP address of the Nextcloud-Onlyoffice EC2 instance"
  value       = aws_instance.officeportable.public_ip
}

#=============================
# Output para o DNS publico da instância EC2 Office Portable
#=============================

output "prometheus_grafana_dns_public" {
  description = "The DNS public of the Prometheus-Grafana EC2 instance"
  value       = aws_instance.officeportable.public_dns
}

#=============================
# Output do nome do bucket S3
#=============================

output "bucket_name" {
  value = aws_s3_bucket.officeportable_bucket.bucket
}

#=============================
# Output para o ID da VPC
#=============================
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.officeportable_vpc.id
}

#=============================
# Output para o ID da Sub-rede
#=============================
output "subnet_id" {
  description = "The ID of the Subnet"
  value       = aws_subnet.officeportable_subnet.id
}

#=============================
# Output para o ID do Security Group
#=============================
output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.officeportable_sg.id
}


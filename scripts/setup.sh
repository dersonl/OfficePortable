#!/bin/bash

#==========================================
# atualizar pacotes do sistema 
#==========================================

echo "sera inicializado a atualizacao dos pacotes"
echo "#========================================================================="
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y wget curl tar jq
sudo apt-get update
sudo apt-get install -y wget
sudo apt-get install -y make gcc g++

#==========================================
# instalar git
#==========================================

echo "sera instalado o git"
echo "#========================================================================="
sudo apt-get install -y git

#==========================================
# instalar docker e dependencias
#==========================================
echo "sera instalado o docker e dependencias"
echo "#========================================================================="
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker.io
sudo apt-get install -y docker-ce
sudo apt-get install -y docker-compose



#==========================================
# habilitar e iniciar servicos
#==========================================

echo "sera habilitado e iniciado o docker"
echo "#========================================================================="
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker --no-pager

echo "instalacao do docker completa!"

#==========================================
# adicionar o user ubuntu ao group docker
#==========================================

echo "sera adicionado o user ubuntu ao group docker"
echo "#========================================================================="
sudo usermod -aG docker ubuntu
newgrp docker

#==========================================
# criacao da network officeportable-network
#==========================================

echo "sera criada a rede officeportable-network"
echo "#========================================================================="

sudo docker network create officeportable-network

#==========================================
# instalacao e configuracao do nginx
#==========================================

echo "sera instalado o nginx"
echo "#========================================================================="

sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl status nginx --no-pager

# #==========================================
# # instalacao e configuracao do Prometheus Grafana node exporte AlertManager
# #==========================================

# # Cria o usuário Prometheus
# echo "sera criado o user Prometheus"
# echo "#========================================================================="

# sudo useradd --no-create-home --shell /bin/false prometheus


# # Cria os diretórios necessários
# sudo mkdir /etc/prometheus /var/lib/prometheus

# # Baixa e instala a última versão do Prometheus
# echo "sera instalado o Prometheus"
# echo "#========================================================================="
# PROMETHEUS_VERSION=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | jq -r .tag_name)
# cd /tmp
# wget "https://github.com/prometheus/prometheus/releases/download/${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"
# tar -xvf "prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"
# cd "prometheus-${PROMETHEUS_VERSION}.linux-amd64"

# # Move os binários
# sudo mv prometheus /usr/local/bin/
# sudo mv promtool /usr/local/bin/

# # Move os arquivos de configuração
# sudo mv consoles /etc/prometheus
# sudo mv console_libraries /etc/prometheus
# sudo mv prometheus.yml /etc/prometheus/prometheus.yml

# # Define permissões
# sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

# # Cria o serviço systemd para o Prometheus
# echo "sera configurado a fonte de dados Prometheus"
# echo "#========================================================================="
# echo "[Unit]
# Description=Prometheus Monitoring System
# Wants=network-online.target
# After=network-online.target

# [Service]
# User=prometheus
# Group=prometheus
# Type=simple
# ExecStart=/usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/

# [Install]
# WantedBy=multi-user.target" | sudo tee /etc/systemd/system/prometheus.service

# # Inicia e habilita o Prometheus
# echo "sera inicializado e habilitado o Prometheus"
# echo "#========================================================================="

# sudo systemctl daemon-reload
# sudo systemctl start prometheus
# sudo systemctl enable prometheus

# # Instala o Grafana
# echo "sera instalado o Grafana"
# echo "#========================================================================="

# sudo apt-get install -y software-properties-common
# sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
# wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install -y grafana

# # Inicia e habilita o Grafana

# sudo systemctl start grafana-server
# sudo systemctl enable grafana-server

# # Baixa e instala a última versão do Node Exporter
# echo "sera instalado o Node Exporter"
# echo "#========================================================================="

# NODE_EXPORTER_VERSION=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | jq -r .tag_name)
# cd /tmp
# wget "https://github.com/prometheus/node_exporter/releases/download/${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
# tar -xvf "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
# cd "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64"
# sudo mv node_exporter /usr/local/bin/

# # Cria o serviço Node Exporter
# echo "sera configurado de dados Node Exporter"
# echo "#========================================================================="
# echo "[Unit]
# Description=Prometheus Node Exporter
# Wants=network-online.target
# After=network-online.target

# [Service]
# User=prometheus
# Group=prometheus
# Type=simple
# ExecStart=/usr/local/bin/node_exporter

# [Install]
# WantedBy=multi-user.target" | sudo tee /etc/systemd/system/node_exporter.service

# # Inicia e habilita o Node Exporter
# echo "sera cativado o Node exporter"
# echo "#========================================================================="
# sudo systemctl daemon-reload
# sudo systemctl start node_exporter
# sudo systemctl enable node_exporter

# # Baixa e instala a última versão do Alertmanager
# echo "sera instalado o Alertmanager"
# echo "#========================================================================="

# ALERTMANAGER_VERSION=$(curl -s https://api.github.com/repos/prometheus/alertmanager/releases/latest | jq -r .tag_name)
# cd /tmp
# wget "https://github.com/prometheus/alertmanager/releases/download/${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz"
# tar -xvf "alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz"
# cd "alertmanager-${ALERTMANAGER_VERSION}.linux-amd64"
# sudo mv alertmanager /usr/local/bin/
# sudo mv amtool /usr/local/bin/

# # Cria os diretórios e a configuração necessária para o Alertmanager
# echo "sera criado os diretorios AlertManager"
# echo "#========================================================================="
# sudo mkdir /etc/alertmanager
# sudo touch /etc/alertmanager/alertmanager.yml

# # Configura o AlertManager para notificações por e-mail
# echo "sera configurado a fonte a notificacao"
# echo "#========================================================================="
# echo "
# global:
#   smtp_smarthost: 'smtp.mail.me.com:587'
#   smtp_from: 'seunome@icloud.com'
#   smtp_auth_username: 'seunome@icloud.com'
#   smtp_auth_password: 'sua-senha-ou-senha-específica-do-app'

# route:
#   receiver: 'email-notifications'
#   group_wait: 10s
#   group_interval: 10s
#   repeat_interval: 1h

# receivers:
#   - name: 'email-notifications'
#     email_configs:
#       - to: 'destinatario@example.com'
#         from: 'seunome@icloud.com'
#         smarthost: 'smtp.mail.me.com:587'
#         auth_username: 'seunome@icloud.com'
#         auth_identity: 'seunome@icloud.com'
#         auth_password: 'sua-senha-ou-senha-específica-do-app'
# " | sudo tee /etc/alertmanager/alertmanager.yml

# # Cria o serviço systemd para o Alertmanager
# echo "sera configurado a fonte de dados AlertManager"
# echo "#========================================================================="
# Description=Prometheus Alertmanager Service
# Wants=network-online.target
# After=network-online.target

# [Service]
# User=prometheus
# Group=prometheus
# Type=simple
# ExecStart=/usr/local/bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml

# [Install]
# WantedBy=multi-user.target" | sudo tee /etc/systemd/system/alertmanager.service

# # Inicia e habilita o Alertmanager
# echo "sera instalado o Grafana Alert Manager"
# echo "#========================================================================="
# sudo systemctl daemon-reload
# sudo systemctl start alertmanager
# sudo systemctl enable alertmanager

# # Configura o Prometheus como uma fonte de dados no Grafana
# # Cria um arquivo JSON com a configuração da fonte de dados
# echo "sera configurado a fonte de dados Grafan"
# echo "#========================================================================="
#   "name": "Prometheus",
#   "type": "prometheus",
#   "url": "http://localhost:9090",
#   "access": "proxy",
#   "isDefault": true
# }' > prometheus-datasource.json

# # Aguarda o Grafana ficar pronto (aguarda 15 segundos)
# echo "aguardando Grafana..."
# echo "#========================================================================="
# sleep 15

# # Usa a API do Grafana para configurar a fonte de dados Prometheus
# echo "sera configurado a fonte de dados Prometheus"
# echo "#========================================================================="
# curl -X POST -H "Content-Type: application/json" -d @prometheus-datasource.json http://admin:admin@localhost:3000/api/datasources

# echo "Prometheus, Grafana, Node Exporter e Alertmanager instalados e configurados com sucesso!"

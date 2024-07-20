# Airflow_cosmos
Projeto utilizando Airflow + DBT para processamento e orquestração de dados dentro do Redshift na AWS

# Gerando a chave do repositorio
ssh-keygen -t ed25519 -C "seu email"

# Criptografando a chave gerada em base64
base64 id_ed25519 | tr -d "\n"

# criando a secret no kubernetes
kubectl apply -f airflow-ssh-secret_exemplo.yaml -n airflow 
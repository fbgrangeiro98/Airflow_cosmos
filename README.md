# Airflow Cosmos

Projeto utilizando **Airflow** e **DBT** para processamento e orquestração de dados dentro do **Redshift** na **AWS**.

## Passos para Configuração

1. **Gerar a Chave do Repositório**

   Execute o comando abaixo para gerar uma chave SSH:

   ```bash
   ssh-keygen -t ed25519 -C "seu-email@example.com"


2. **Criptografar a Chave Gerada**

    Para criptografar a chave em base64, utilize o comando:

    ```bashbash
    base64 id_ed25519 | tr -d "\n"

3. **Criar Secrets no Kubernetes**

    Crie o Secret para a chave SSH com:
    
    ```bashbash
    kubectl apply -f airflow-ssh-secret_exemplo.yaml -n airflow

4. **Baixar o Chart do Airflow para o Helm**

    Adicione o repositório do Airflow ao Helm:
    
    ```bashbash
    helm repo add apache-airflow https://airflow.apache.org

5. **Criar a Imagem Docker**

    Construa a imagem Docker com as bibliotecas necessárias:
    
    ```bashbash
    docker build -t brunojyh/projeto_airflow_dbt:1.0 .

6. **Enviar a Imagem para o Docker Hub**

    Envie a imagem Docker para o Docker Hub:
    
    ```bashbash
    docker push brunojyh/projeto_airflow_dbt:1.0 .

7. **Instalar o Chart do Airflow**

    Instale o chart no Kubernetes com:
    
    ```bashbash
    helm install airflow apache-airflow/airflow -n airflow -f values.yaml

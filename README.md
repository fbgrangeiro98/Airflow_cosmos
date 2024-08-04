# Airflow Cosmos

Projeto utilizando **Airflow** e **DBT** para processamento e orquestração de dados dentro do **Redshift** na **AWS**.

## Passos para Configuração

1. **instalar o cluster do Kubernetes**

    Execute o comando abaixo para fazer o download do minikube:
    ```bash
    New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
    Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
    ```

    Após o download adicione o arquivo minikube.exe binario na variavel PATH no windows.

2. **Iniciando o cluster do Kubernetes no minikube**
    Execute o comando abaixo para iniciar o cluster minikube:
    ```bash
    minikube start 
    ```

3. **Gerar a Chave do Repositório**

   Execute o comando abaixo para gerar uma chave SSH:

   ```bash
   ssh-keygen -t ed25519 -C "seu-email@example.com"
   ``` 

4. **Criptografar a Chave Gerada**

    Para criptografar a chave em base64, utilize o comando:

    ```bashbash
    base64 id_ed25519 | tr -d "\n"
    ```

5. **Criar Secrets no Kubernetes**

    Crie o Secret para a chave SSH com:
    
    ```bashbash
    kubectl apply -f airflow-ssh-secret_exemplo.yaml -n airflow
    ```

6. **Baixar o Chart do Airflow para o Helm**

    Adicione o repositório do Airflow ao Helm:
    
    ```bashbash
    helm repo add apache-airflow https://airflow.apache.org
    ```

7. **Criar a Imagem Docker**

    Construa a imagem Docker com as bibliotecas necessárias:
    
    ```bashbash
    docker build -t brunojyh/projeto_airflow_dbt:1.0 .
    ```

8. **Enviar a Imagem para o Docker Hub**

    Envie a imagem Docker para o Docker Hub:
    
    ```bashbash
    docker push brunojyh/projeto_airflow_dbt:1.0 .
    ```

9. **Instalar o Chart do Airflow**

    Instale o chart no Kubernetes com:
    
    ```bashbash
    helm install airflow apache-airflow/airflow -n airflow -f values.yaml
    ```

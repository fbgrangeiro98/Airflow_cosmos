# Airflow Cosmos

Projeto utilizando **Airflow** e **DBT** para processamento e orquestração de dados dentro do **Redshift** na **AWS**.

## Passos para Configuração

1. **instalando o cluster do Kubernetes usando minikube e docker**

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
    Lembre-se de deixar o docker desktop aberto

3. **Gerando a Chave do Repositório Privado para o github**

   Execute o comando abaixo para gerar uma chave SSH:

   ```bash
   ssh-keygen -t ed25519 -C "seu-email@example.com"
   ``` 

4. **Criptografando a Chave Gerada**

    Para criptografar a chave em base64, utilize o comando:

    ```bash
    base64 id_ed25519 | tr -d "\n"
    ```
    

5. **Criando a Secret no Kubernetes**

    Com a chave ssh criptografada gerada adicione ela ao arquivo airflow-ssh-secret_exemplo.yaml e execute o comando abaixo para aplicar:
    
    ```bash
    kubectl apply -f airflow-ssh-secret_exemplo.yaml -n airflow
    ```

6. **instalando o Helm**

    Execute o comando abaixo para baixar o binario do helm
    ```bash
    choco install kubernetes-helm
    ```

7. **Baixando o Chart do Airflow para o Helm**

    Adicione o repositório do Airflow ao Helm:
    
    ```bash
    helm repo add apache-airflow https://airflow.apache.org
    ```

8. **Criando a Imagem Docker**

    Construindo a imagem Docker com as bibliotecas necessárias:
    
    ```bash
    docker build -t brunojyh/projeto_airflow_dbt:1.0 .
    ```

9. **Enviaando a Imagem para o Docker Hub**

    Enviando a imagem para o Docker Hub:
    
    ```bash
    docker push brunojyh/projeto_airflow_dbt:1.0 .
    ```

10. **Instalando o Chart do Airflow**

    Instalando o chart no Kubernetes com helm:
    
    ```bash
    helm install airflow apache-airflow/airflow -n airflow -f values.yaml
    ```

11. **Acessando o Airflow**

    ```bash
    kubectl port-forward svc/airflow-webserver 8080:8080 -n airflow
    ```

12. **instalando o terraform**
    ```bash
    choco install terraform
    ```

13. **iniciando o cluster do redshift com terrform**

    Execute o comando abaixo para iniciar o terraform do projeto:
    ```bash
    terraform init
    ```

    Em seguida inicie o cluster com o comando:
    ```bash
    terraform apply
    ```


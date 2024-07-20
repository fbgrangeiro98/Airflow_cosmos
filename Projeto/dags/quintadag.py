from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'example_bash_operator',
    default_args=default_args,
    description='An example DAG to run a Python script with BashOperator',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2023, 1, 1),
    catchup=False,
) as dag:

    run_python_script = BashOperator(
        task_id='run_python_script',
        bash_command='python /opt/airflow/dags/repo/scripts/teste.py',
    )

    run_python_script

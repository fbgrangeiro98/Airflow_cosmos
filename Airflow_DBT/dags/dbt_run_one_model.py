from airflow.decorators import dag
from airflow.operators.dummy_operator import DummyOperator
from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig, RenderConfig, LoadMode
from cosmos.profiles import RedshiftUserPasswordProfileMapping
from cosmos.constants import TestBehavior

from pendulum import datetime
#teste novo

CONNECTION_ID = "redshift"
DB_NAME = "dev"
SCHEMA_NAME = "teste"

ROOT_PATH = '/opt/airflow/dags/repo/Airflow_DBT/dags/dbt'
DBT_PROJECT_PATH = f"{ROOT_PATH}/projeto_red"

profile_config = ProfileConfig(
    profile_name="projeto_red",
    target_name="dev",
    profile_mapping=RedshiftUserPasswordProfileMapping(
        conn_id=CONNECTION_ID,
        profile_args={"schema": SCHEMA_NAME},
    )
)


@dag(
    start_date=datetime(2023, 10, 14),
    schedule=None,
    catchup=False
)
def dbt_run_one_model():

    start_process = DummyOperator(task_id='start_process')

    transform_data = DbtTaskGroup(
        group_id="transform_data",
        project_config=ProjectConfig(DBT_PROJECT_PATH),
        profile_config=profile_config,
        render_config=RenderConfig(
        load_method=LoadMode.AUTOMATIC,
        select=["path:models/modelo_selecionado.sql"])
    )

    start_process >> transform_data


dbt_run_one_model()

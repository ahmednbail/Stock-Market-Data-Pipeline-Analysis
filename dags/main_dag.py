from pathlib import Path
from airflow import DAG
from datetime import datetime
from airflow.providers.papermill.operators.papermill import PapermillOperator


default_args = {
    'owner': 'Ahmed Nabil',
    'retries': 1,
}

notebooks_dir = Path(__file__).parent / 'Notebooks'

with DAG(
    dag_id='stock_market_data_pipeline',
    default_args=default_args,
    description='Stock Market Data Pipeline',
    tags=['stock_market_data_pipeline', 'ETL'],
    max_active_runs=2,
    start_date=datetime(2026, 4, 5),
    schedule='@daily',
    catchup=False,
) as dag:
    extract_stock_data = PapermillOperator(
        task_id='extract_stock_data',
        input_notebook=str(notebooks_dir / 'extract.ipynb'),
        output_notebook=str(notebooks_dir / 'extract_stock_data_output_{{ run_id | replace(":", "_") }}.ipynb'),
    )

from airflow import DAG
from datetime import datetime , timedelta
from airflow.providers.papermill.operators.papermill import PapermillOperator


default_args={
    'owner': 'Ahmed Nabil',
    'start_date': datetime(2026, 4, 5),
    'retries': 1,
    'schedule': '@daily',
    'catchup': False
}


with DAG(
    dag_id='stock_market_data_pipeline',
    default_args=default_args,
    description='Stock Market Data Pipeline',
    tags=['stock_market_data_pipeline','ETL'],
    max_active_runs=2,
    start_date=datetime(2026, 4, 5)
) as dag: 
           
    extract_stock_data = PapermillOperator(
        task_id='extract_stock_data',
        input_notebook='D:\Ahmed\Data engineering - MSC\Stock-Market-Data-Pipeline-Analysis\dags\Notebooks\extract.ipynb',
        output_notebook='D:\Ahmed\Data engineering - MSC\Stock-Market-Data-Pipeline-Analysis\dags\Notebooks\extract_stock_data_output.ipynb',
    )
    extract_stock_data
    
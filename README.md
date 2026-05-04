# Stock Market Data Pipeline & Analysis

An end-to-end data engineering project to ingest, clean, transform, model, and analyze stock market data for financial insights.

## Project Overview

This project simulates a real-world financial analytics workflow where reliable market data is required for decision-making.  
The pipeline collects historical and incremental stock data, applies data quality checks and transformations, stores the results in PostgreSQL, and supports analytical SQL queries.

## Business Objectives

The solution is designed to support data-driven stock analysis by:

- Tracking stock price trends over time
- Comparing performance across multiple companies
- Measuring volatility and risk
- Supporting basic investment insights

## Data Source

- **Provider:** Yahoo Finance
- **Access:** Python using `yfinance`
- **Frequency:** Daily stock market data
- **Example tickers:** `AAPL`, `MSFT`, `AMZN`, `GOOGL`, `META`, `TSLA`, `NVDA` (target: at least 8-10 companies)

### Core Raw Columns

- `date`
- `open`
- `high`
- `low`
- `close`
- `volume`

## Pipeline Architecture

The pipeline follows a standard ETL pattern:

1. **Extract** stock data from Yahoo Finance
2. **Clean** and validate raw records
3. **Transform** records into analytics-ready metrics
4. **Load** data into PostgreSQL tables
5. **Orchestrate** the flow with Apache Airflow
6. **Analyze** output with SQL queries

## Data Ingestion

Ingestion logic should:

- Retrieve historical data for selected companies
- Support incremental updates (load new dates only)
- Be safe to re-run without creating duplicates

## Data Cleaning Rules

Cleaning and quality checks include:

- Standardize dates to `YYYY-MM-DD`
- Remove duplicate records
- Validate numeric fields (`open`, `high`, `low`, `close`, `volume`)
- Handle missing values appropriately

> Note: Missing dates caused by weekends and market holidays are expected and should not be treated as errors.

## Data Transformations

The transformed dataset includes:

- **Daily Return**: percentage change in closing price versus previous day
- **Price Range**: difference between high and low prices
- **Moving Average (7-day)**: rolling average of close price
- **Volatility (7-day)**: rolling standard deviation of daily returns

## Data Modeling (PostgreSQL)

### `fact_stock_prices`

- `date`
- `ticker`
- `open`
- `high`
- `low`
- `close`
- `volume`
- `daily_return`

**Primary Key:** (`date`, `ticker`)

### `dim_company`

- `ticker`
- `company_name`

### Modeling Requirements

- Clear schema design
- Proper primary keys
- No duplicate records

## Incremental Loading Strategy

Incremental loading should enforce:

- Load only records with new dates
- Duplicate prevention on insert
- Idempotent behavior for repeated pipeline runs

## Orchestration with Airflow

The Airflow DAG should include tasks such as:

- `extract_stock_data`
- `transform_data`
- `load_to_database`

With:

- Defined task dependencies
- Basic retry behavior
- Manual or scheduled execution support

## Data Validation

Validation checks should confirm:

- No duplicate `(date, ticker)` records
- No null values in critical fields
- Consistency of calculated transformation columns

## Analytical Questions (SQL)

Example analysis queries should answer:

- Which stock performed best over a selected period?
- Which stock is the most volatile?
- What is the average closing price per company?
- What are the price trends over the last 30 days?

## Expected Deliverables

1. Python ETL pipeline (modular and organized)
2. PostgreSQL database with final tables
3. SQL scripts for table creation and analytics
4. Airflow DAG file
5. This `README.md`
6. GitHub repository containing all project artifacts

## README Scope

This README documents:

- Pipeline architecture
- Data cleaning assumptions and decisions
- Incremental loading logic
- Transformation approach
- Known limitations and implementation challenges (to be expanded during execution)

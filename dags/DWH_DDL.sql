CREATE DATABASE stock;
CREATE SCHEMA dwh;

CREATE TABLE fact_stock_prices(
    date            DATE,
    ticker          VARCHAR(20),
    open            NUMERIC,
    close           NUMERIC,
    high            NUMERIC,
    low             NUMERIC,
    volume          BIGINT,
    daily_return    NUMERIC,
    pct_change      NUMERIC,
    price_range     NUMERIC,
    moving_average NUMERIC,
    volatility     NUMERIC,
    PRIMARY KEY(date,ticker)

);


CREATE  TABLE  dim_company(
    ticker VARCHAR(20) PRIMARY KEY ,
    company_name VARCHAR(100)
);

INSERT INTO dim_company VALUES
    ('AAPL',  'Apple Inc.'),
    ('AMD',   'Advanced Micro Devices'),
    ('AMZN',  'Amazon.com Inc.'),
    ('GOOGL', 'Alphabet Inc.'),
    ('META',  'Meta Platforms Inc.'),
    ('MSFT',  'Microsoft Corporation'),
    ('NFLX',  'Netflix Inc.'),
    ('NVDA',  'NVIDIA Corporation'),
    ('TEAM',  'Atlassian Corporation'),
    ('TSLA',  'Tesla Inc.');


select count(*) from fact_stock_prices



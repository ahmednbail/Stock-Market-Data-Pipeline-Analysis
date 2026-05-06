--1) Which stock performed best over a given period?
SELECT
    ticker,
    SUM(pct_change) AS total_return
FROM fact_stock_prices
WHERE date BETWEEN '2020-01-01' AND '2020-12-31'  -- change period
GROUP BY ticker
ORDER BY total_return DESC
LIMIT 1;


--2) Which stock is the most volatile?
SELECT
    ticker,
    AVG(volatility) AS avg_volatility
FROM fact_stock_prices
GROUP BY ticker
ORDER BY avg_volatility DESC
LIMIT 1;


--3) What is the average closing price per company?
SELECT
    d.company_name,
    f.ticker,
    AVG(f.close) AS avg_closing_price
FROM fact_stock_prices f
JOIN dim_company d
    ON f.ticker = d.ticker
GROUP BY d.company_name, f.ticker
ORDER BY avg_closing_price DESC;

--4) What are the price trends over the last 30 days?

SELECT
    ticker,
    date,
    close,
    AVG(close) OVER (
        PARTITION BY ticker
        ORDER BY date
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS moving_avg_30d
FROM fact_stock_prices
WHERE date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY ticker, date;
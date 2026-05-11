create database Churn_Analysis;
use Churn_Analysis;

CREATE TABLE churn_customers (RowNumber INT, CustomerId BIGINT, Surname VARCHAR(100), CreditScore INT,
    Geography VARCHAR(50), Gender VARCHAR(20), Age INT, Tenure INT, Balance DECIMAL(15,2), NumOfProducts INT,
    HasCrCard INT, IsActiveMember INT, EstimatedSalary DECIMAL(15,2), Exited INT);
drop table churn_customers;
SHOW TABLES;
RENAME TABLE churn_modelling TO churn_customers;
SELECT COUNT(*) 
FROM churn_customers;
-- Total Customers--
SELECT COUNT(*) AS total_customers FROM churn_customers;
-- Total Churned Customers --
SELECT COUNT(*) AS churned_customers
FROM churn_customers WHERE Exited = 1;
-- Churn by geography --
SELECT Geography, COUNT(*) AS total_customers, SUM(Exited) AS churned_customers 
FROM churn_customers GROUP BY Geography;
-- Churn rate by geography --
SELECT Geography, ROUND((SUM(Exited) * 100.0)/COUNT(*),2) AS churn_rate FROM churn_customers
GROUP BY Geography ORDER BY churn_rate DESC;
-- Customer Ranking by Balance--
SELECT 
    CustomerId,
    Geography,
    Balance,
    RANK() OVER(
        PARTITION BY Geography
        ORDER BY Balance DESC
    ) AS balance_rank
FROM churn_customers;

CREATE VIEW churn_summary AS
SELECT 
    Geography,
    Gender,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned_customers,
    ROUND(AVG(Balance),2) AS avg_balance
FROM churn_customers
GROUP BY Geography, Gender;

SELECT * 
FROM churn_summary;  
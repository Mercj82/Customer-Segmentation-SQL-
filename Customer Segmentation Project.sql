CREATE DATABASE IF NOT EXISTS MallAnalyticsDB;
USE MallAnalyticsDB;
-- create data base
SELECT * FROM CD;
-- View Table
ALTER TABLE CD
ADD PRIMARY KEY (CustomerID);
-- Create primary key 
SELECT *
FROM CD
WHERE CustomerID IS NULL OR Gender IS NULL OR Age IS NULL;
-- Identify rows with missing values
DELETE FROM CD
WHERE CustomerID IS NULL OR Gender IS NULL OR Age IS NULL;
-- Delete any rows with missing values
SELECT CustomerID, COUNT(*)
FROM CD
GROUP BY CustomerID
HAVING COUNT(*) > 1;
-- Identify any duplicates columns
SHOW COLUMNS FROM CD;
-- show data types of columns
SELECT *
FROM CD
WHERE Age < 0 OR Age > 100;
-- determine age outliers
SELECT DISTINCT Gender
FROM CD;
-- Identify inconsistency 
SHOW COLUMNS FROM CD;
-- show column names 
SELECT
    AVG(Age) AS AvgAge,
    MIN(Age) AS MinAge,
    MAX(Age) AS MaxAge,
    AVG(`Annual Income (k$)`) AS AvgIncome,
    MIN(`Annual Income (k$)`) AS MinIncome,
    MAX(`Annual Income (k$)`) AS MaxIncome,
    AVG(`Spending Score (1-100)`) AS AvgSpendingScore,
    MIN(`Spending Score (1-100)`) AS MinSpendingScore,
    MAX(`Spending Score (1-100)`) AS MaxSpendingScore
FROM CD;
-- customer demographics 
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS AgeGroup,
    COUNT(*) AS CustomerCount
FROM CD
GROUP BY AgeGroup;
-- Customer segmentation by age group
SELECT
    Gender,
    COUNT(*) AS CustomerCount,
    AVG(Age) AS AvgAge,
    AVG(`Annual Income (k$)`) AS AvgIncome,
    AVG(`Spending Score (1-100)`) AS AvgSpendingScore
FROM CD
GROUP BY Gender;
-- Gender analysis
SELECT
    `Annual Income (k$)` AS AnnualIncome,
    COUNT(*) AS CustomerCount
FROM CD
GROUP BY `Annual Income (k$)`
ORDER BY `Annual Income (k$)`;
-- annual income distribution
SELECT
    CONCAT(FLOOR(`Annual Income (k$)` / 10) * 10, ' - ', (FLOOR(`Annual Income (k$)` / 10) + 1) * 10 - 1) AS IncomeRange,
    COUNT(*) AS CustomerCount
FROM CD
GROUP BY IncomeRange
ORDER BY MIN(`Annual Income (k$)`);
-- Income Range
SELECT
    `Spending Score (1-100)` AS SpendingScore,
    COUNT(*) AS CustomerCount
FROM CD
GROUP BY `Spending Score (1-100)`
ORDER BY `Spending Score (1-100)`;
-- spending score analysis
CREATE VIEW CustomerIncomeView AS
SELECT
    CustomerID,
    Gender,
    Age,
    `Annual Income (k$)`,
    `Spending Score (1-100)`,
    CONCAT(FLOOR(`Annual Income (k$)` / 10) * 10, ' - ', (FLOOR(`Annual Income (k$)` / 10) + 1) * 10 - 1) AS IncomeRange
FROM CD;
-- create view
SELECT * FROM CustomerIncomeView;
-- Create view 
SELECT
    IncomeRange,
    AVG(`Spending Score (1-100)`) AS AvgSpendingScore
FROM CustomerIncomeView
GROUP BY IncomeRange
ORDER BY MIN(`Annual Income (k$)`);
-- avg spending score ny Income range
SELECT
    IncomeRange,
    AVG(`Spending Score (1-100)`) AS AvgSpendingScore,
    COUNT(*) AS CustomerCount
FROM CustomerIncomeView
WHERE `Spending Score (1-100)` > 70 
      AND `Annual Income (k$)` > 40  
GROUP BY IncomeRange
ORDER BY MIN(`Annual Income (k$)`);
-- target customers
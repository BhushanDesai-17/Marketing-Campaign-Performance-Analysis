SELECT *
FROM cleaned_campaigns;

SELECT *
FROM cleaned_customers;

SELECT *
FROM cleaned_performance;

-- Total Spend
SELECT ROUND(SUM(Spend), 2) AS total_spend
FROM cleaned_performance;

-- Total Revenue
SELECT ROUND(SUM(Revenue), 2) AS total_revenue
FROM cleaned_performance;

-- Total Conversions
SELECT SUM(Conversions) AS total_conversions
FROM cleaned_performance;

-- Average CTR 
SELECT ROUND(AVG(CTR_Pct), 2) AS average_CTR
FROM cleaned_performance;

-- Average Conversion Rate
SELECT ROUND(AVG(Conversion_Rate_Pct), 2) AS avg_conversion_rate
FROM cleaned_performance;

-- Overall ROAS
SELECT ROUND(SUM(Revenue) / SUM(Spend), 2) AS overall_ROAS
FROM cleaned_performance;

-- Revenue by Channel
SELECT c.Channel, 
		ROUND(SUM(p.Revenue), 2) AS total_revenue
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Channel
ORDER BY total_revenue DESC;

-- ROAS by Channel
SELECT c.Channel,
		ROUND(SUM(p.ROAS), 2) AS total_ROAS
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Channel
ORDER BY total_ROAS DESC;

-- Conversions by Channel
SELECT c.Channel,
		SUM(p.Conversions) AS total_conversions
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Channel
ORDER BY total_conversions DESC;

-- Spend vs Revenue
SELECT ROUND(SUM(Spend), 2), ROUND(SUM(Revenue), 2) AS spend_vs_revenue
FROM cleaned_performance;

-- Top 5 Campaigns by Revenue
SELECT c.Campaign_Name, 
		ROUND(SUM(p.Revenue), 0) AS total_revenue
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Campaign_Name
ORDER BY total_revenue DESC
LIMIT 5;

-- top 5 Campaigns by ROAS
SELECT c.Campaign_Name,
		ROUND(SUM(p.ROAS), 0) AS total_ROAS
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Campaign_Name
ORDER BY total_ROAS DESC
LIMIT 5;

-- Bottom 5 Campaigns by ROAS 
SELECT c.Campaign_Name,
		ROUND(SUM(p.ROAS), 0) AS total_ROAS
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Campaign_Name
ORDER BY total_ROAS ASC
LIMIT 5;

-- Campaign Conversion Rate
SELECT c.Campaign_Name,
		ROUND(SUM(p.Conversions) / SUM(p.Clicks) * 100, 2) AS conversion_rate
FROM cleaned_campaigns AS c
INNER JOIN cleaned_performance AS p
ON c.Campaign_ID = p.Campaign_ID
GROUP BY c.Campaign_Name
ORDER BY conversion_rate DESC
LIMIT 5;

-- Revenue by Customer Segment
SELECT c.Customer_Segment,
		ROUND(SUM(p.Revenue), 0) AS total_revenue
FROM cleaned_customers AS c
INNER JOIN cleaned_performance AS p
ON c.Customer_ID = p.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY total_revenue DESC;

-- Conversion rate by Customer Segment
SELECT c.Customer_Segment,
		ROUND(SUM(p.Conversions) / SUM(Clicks) * 100, 2) AS conversion_rate
FROM cleaned_customers AS c
INNER JOIN cleaned_performance AS p
ON c.Customer_ID = p.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY conversion_rate DESC;

-- Revenue by City
SELECT c.City,
		ROUND(SUM(p.Revenue), 0) AS total_revenue
FROM cleaned_customers AS c
INNER JOIN cleaned_performance AS p
ON c.Customer_ID = p.Customer_ID
GROUP BY c.City
ORDER BY total_revenue DESC;

-- Conversion Rate by Device
SELECT Device,
		ROUND(SUM(Conversions) / SUM(Clicks) * 100, 2) AS conversion_rate
FROM cleaned_performance
GROUP BY Device
ORDER BY conversion_rate DESC;

-- Revenue by Device
SELECT Device, ROUND(SUM(Revenue), 0) AS total_revenue
FROM cleaned_performance
GROUP BY Device
ORDER BY total_revenue DESC;
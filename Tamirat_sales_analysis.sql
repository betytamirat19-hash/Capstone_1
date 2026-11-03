USE sample_sales;
---Alias ---FROM store_sales ss---JOIN store_locations sl---ON ss.Store_ID = sl.StoreId

--QUESTION 1 
--What is total revenue overall for sales in the assigned territory, plus the start date and end date---------that tell you what period the data covers?
USE sample_sales;
SELECT
    SUM(ss.Sale_Amount)      AS total_revenue, 
    MIN(ss.Transaction_Date) AS start_date,
    MAX(ss.Transaction_Date) AS end_date
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Connecticut';  
-------'2392222.44', '2022-01-01', '2025-12-31'----

QUESTION 2 
-------What is the revenue breakdown by year and month for the sales territory?
USE sample_sales;
SELECT
    YEAR(ss.Transaction_Date)  AS sales_year,
    MONTH(ss.Transaction_Date) AS sales_month,
    SUM(ss.Sale_Amount)        AS monthly_revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State IN ('Connecticut') 
GROUP BY
    YEAR(ss.Transaction_Date),
    MONTH(ss.Transaction_Date)
ORDER BY
    sales_year,
    sales_month;
--2022	1	29958.25             ------
2022	2	25563.98
2022	3	33995.57
2022	4	31587.12
2022	5	37953.48
2022	6	32008.85
2022	7	30656.27
2022	8	42881.99
2022	9	30369.64
2022	10	43646.37
2022	11	25950.41
2022	12	34680.64
2023	1	38351.45
2023	2	53435.37
2023	3	50828.54
2023	4	45747.20
2023	5	39215.78
2023	6	39754.07
2023	7	49592.69
2023	8	48445.34
2023	9	49175.79
2023	10	45347.65
2023	11	42683.73
2023	12	50446.82
2024	1	57974.76
2024	2	49206.33
2024	3	46044.68
2024	4	38918.30
2024	5	41203.81
2024	6	48142.95
2024	7	48445.34
2024	8	49633.16
2024	9	44890.28
2024	10	43061.44
2024	11	50069.11
2024	12	38351.45
2025	1	68601.89
2025	2	55131.75
2025	3	69261.43
2025	4	58288.72
2025	5	66996.15
2025	6	60671.67
2025	7	88590.03
2025	8	77048.51
2025	9	71032.14
2025	10	115828.46
2025	11	59762.07
2025	12	92791.01

    
    
---QUESTION 3 
--Provide a comparison of total revenue for the specific sales territory and the region it belongs to.--

SELECT
    sl.State, 
    m.Region,
    SUM(ss.Sale_Amount) AS state_revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
JOIN management m
    ON sl.State = m.State
WHERE m.Region = 'East'
GROUP BY sl.State
ORDER BY state_revenue DESC;
----# State, Region, state_revenue

----'New York', 'East', '4330817.09'
---'Connecticut', 'East', '2392222.44'

       




  
  
    

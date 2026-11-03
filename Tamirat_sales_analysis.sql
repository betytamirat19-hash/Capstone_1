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




  
  
    

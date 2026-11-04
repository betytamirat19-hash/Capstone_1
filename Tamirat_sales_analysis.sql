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

---QUESTION 4
----What is the number of transactions per month and average transaction amount by product
category for the sales territory?--------
 SELECT
     DATE_FORMAT(ss.Transaction_Date, '%Y-%m') AS Month,
    ic.Category,
    COUNT(*) AS Number_of_Transactions,
    ROUND(AVG(ss.Sale_Amount), 2) AS Average_Transaction_Amount
FROM Store_Sales ss
JOIN Products p
    ON ss.Prod_Num = p.ProdNum
JOIN Inventory_Categories ic
    ON p.Categoryid = ic.Categoryid
JOIN Store_Locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Connecticut'
GROUP BY
    DATE_FORMAT(ss.Transaction_Date, '%Y-%m'),
    ic.Category
ORDER BY
    Month,
    ic.Category;
----# Month, Category, Number_of_Transactions, Average_Transaction_Amount
'2022-01', 'Apparel and Merchandise', '42', '29.13'
'2022-01', 'Art Supplies', '29', '22.52'
'2022-01', 'Books (General)', '19', '25.77'
'2022-01', 'Stationery and Supplies', '36', '9.29'
'2022-01', 'Technology & Accessories', '45', '485.78'
'2022-01', 'Textbooks', '31', '174.12'
       :        :
       :        :
       :        :
       
--QUESTION 5--  
-- Can you provide a ranking of in-store sales performance by each store in the sales territory, or aranking of online sales performance by state within an online sales territory?
SELECT
    sl.StoreId,
    sl.StoreLocation,
    SUM(ss.Sale_Amount) AS Total_Sales,
    COUNT(*) AS Number_of_Transactions,
    RANK() OVER (
        ORDER BY SUM(ss.Sale_Amount) DESC
    ) AS Sales_Rank
FROM Store_Sales ss
JOIN Store_Locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Connecticut'
GROUP BY
    sl.StoreId,
    sl.StoreLocation
ORDER BY
    Total_Sales DESC;

# StoreId, StoreLocation, Total_Sales, Number_of_Transactions, Sales_Rank
'870', 'New London', '331116.76', '2272', '1'
'865', 'Bridgeport', '322100.07', '2231', '2'
'867', 'Hartford', '309592.06', '2133', '3'
'872', 'Waterbury', '295651.17', '2099', '4'
'869', 'New Haven', '286779.43', '2173', '5'
'868', 'Litchfield County', '286217.15', '2127', '6'
'866', 'Darien', '283455.62', '2152', '7'
'871', 'Old Saybrook', '277310.18', '2191', '8'

-QUESTION 6
What is your recommendation for where to focus sales attention in the next quarter?--
  
    

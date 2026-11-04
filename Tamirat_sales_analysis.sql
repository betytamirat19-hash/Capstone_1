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
    MONTH(ss.Transaction_Date);
----# sales_year, sales_month, monthly_revenue
'2022', '1', '29958.25'
'2022', '2', '25563.98'
'2022', '3', '33995.57'
'2022', '4', '31587.12'
'2022', '5', '37953.48'
'2022', '6', '32008.85'
'2022', '7', '30656.27'
'2022', '8', '42881.99'
'2022', '9', '30369.64'
'2022', '10', '43646.37'
'2022', '11', '25950.41'
'2022', '12', '34680.64'
'2023', '1', '38351.45'
'2023', '2', '53435.37'
'2023', '3', '50828.54'
'2023', '4', '45747.20'
'2023', '5', '39215.78'
'2023', '6', '39754.07'
'2023', '7', '49592.69'
'2023', '8', '48445.34'
'2023', '9', '49175.79'
'2023', '10', '45347.65'
'2023', '11', '42683.73'
'2023', '12', '50446.82'
'2024', '1', '57974.76'
'2024', '2', '49206.33'
'2024', '3', '46044.68'
'2024', '4', '38918.30'
'2024', '5', '41203.81'
'2024', '6', '48142.95'
'2024', '7', '48445.34'
'2024', '8', '49633.16'
'2024', '9', '44890.28'
'2024', '10', '43061.44'
'2024', '11', '50069.11'
'2024', '12', '38351.45'
'2025', '1', '68601.89'
'2025', '2', '55131.75'
'2025', '3', '69261.43'
'2025', '4', '58288.72'
'2025', '5', '66996.15'
'2025', '6', '60671.67'
'2025', '7', '88590.03'
'2025', '8', '77048.51'
'2025', '9', '71032.14'
'2025', '10', '115828.46'
'2025', '11', '59762.07'
'2025', '12', '92791.01'


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
'2022- 01', 'Apparel and Merchandise', '42', '29.13'
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
SELECT sl.StoreId,
    sl.StoreLocation,
    SUM(ss.Sale_Amount) AS Total_Sales,
    COUNT(*) AS Number_of_Transactions
FROM Store_Sales ss
JOIN Store_Locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Connecticut'
GROUP BY
    sl.StoreId,
    sl.StoreLocation
ORDER BY
    Total_Sales DESC;

# StoreId, StoreLocation, Total_Sales, Number_of_Transactions
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

-- ============================================================
--  Recommendation for where to focus sales attention
--     in the next quarter
-- ============================================================
-- Finding 1 (Connecticut vs. the East region):
-- In the East region, New York had total revenue of $4,330,817.09,
-- while Connecticut had $2,392,222.44. New York sells almost
-- twice as much as Connecticut.
--
-- Finding 2 (inside Connecticut):
-- Sales are almost equal among the Connecticut stores. No single
-- store is far ahead or far behind the others, so Connecticut
-- performs as one balanced territory.
--
-- Recommendation:
-- Next quarter, focus sales attention on growing Connecticut as a
-- whole state, not on fixing one weak store. Since all stores
-- perform about the same, a state-wide plan will work better, for
-- example: a state-wide promotion, an online and in-store campaign
-- for back-to-school season, and more marketing for the product
-- categories that sell best (see Q4).
-- Because New York is almost double Connecticut, there is room to
-- grow. Connecticut can copy New York's best practices and aim to
-- close part of this gap.
-- ============================================================

  
  
  

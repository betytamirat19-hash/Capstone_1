USE sample_sales;
--Alias --store_sales ss  --store_locations sl-- Management region m.Region--- ic catagory inventory_categories

--QUESTION 1 
--What is total revenue overall for sales in the assigned territory, plus the start date and end date---------that tell you what period the data covers?
SELECT
    CONCAT('$',FORMAT(SUM(ss.Sale_Amount),2 )) AS total_revenue, 
    MIN(ss.Transaction_Date) AS start_date,
    MAX(ss.Transaction_Date) AS end_date
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Connecticut';  
------ANS
---# total_revenue, start_date, end_date
---'$2,392,222.44', '2022-01-01', '2025-12-31'


QUESTION 2 
---What is the revenue breakdown by year and month for the sales territory?
SELECT
    YEAR(ss.Transaction_Date) AS Year,
    MONTH(ss.Transaction_Date) AS Month,
    CONCAT('$',FORMAT(SUM(ss.Sale_Amount),2 )) AS monthly_revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State IN ('Connecticut') 
GROUP BY
    YEAR(ss.Transaction_Date),
    MONTH(ss.Transaction_Date);

----ANS---
----# sales_year, sales_month, monthly_revenue
'2022', '1', '$29,958.25'
'2022', '2', '$25,563.98'
'2022', '3', '$33,995.57'
'2022', '4', '$31,587.12'
'2022', '5', '$37,953.48'
'2022', '6', '$32,008.85'
'2022', '7', '$30,656.27'
'2022', '8', '$42,881.99'
'2022', '9', '$30,369.64'
'2022', '10', '$43,646.37'
'2022', '11', '$25,950.41'
'2022', '12', '$34,680.64'
'2023', '1', '$38,351.45'
'2023', '2', '$53,435.37'
'2023', '3', '$50,828.54'
'2023', '4', '$45,747.20'
'2023', '5', '$39,215.78'
'2023', '6', '$39,754.07'
'2023', '7', '$49,592.69'
'2023', '8', '$48,445.34'
'2023', '9', '$49,175.79'
'2023', '10', '$45,347.65'
'2023', '11', '$42,683.73'
'2023', '12', '$50,446.82'
'2024', '1', '$57,974.76'
'2024', '2', '$49,206.33'
'2024', '3', '$46,044.68'
'2024', '4', '$38,918.30'
'2024', '5', '$41,203.81'
'2024', '6', '$48,142.95'
'2024', '7', '$48,445.34'
'2024', '8', '$49,633.16'
'2024', '9', '$44,890.28'
'2024', '10', '$43,061.44'
'2024', '11', '$50,069.11'
'2024', '12', '$38,351.45'
'2025', '1', '$68,601.89'
'2025', '2', '$55,131.75'
'2025', '3', '$69,261.43'
'2025', '4', '$58,288.72'
'2025', '5', '$66,996.15'
'2025', '6', '$60,671.67'
'2025', '7', '$88,590.03'
'2025', '8', '$77,048.51'
'2025', '9', '$71,032.14'
'2025', '10', '$115,828.46'
'2025', '11', '$59,762.07'
'2025', '12', '$92,791.01'


---QUESTION 3 
--Provide a comparison of total revenue for the specific sales territory and the region it belongs to.--
SELECT
    sl.State, 
    m.Region,
    AS state_revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
JOIN management m
    ON sl.State = m.State
WHERE m.Region = 'East'
GROUP BY sl.State
ORDER BY state_revenue DESC;
----# State, Region, state_revenue
-----ANS---
---'New York', 'East', '4330817.09'
---'Connecticut', 'East', '2392222.44'

---QUESTION 4
----What is the number of transactions per month and average transaction amount by product category for the sales territory?--------
 SELECT
	DATE_FORMAT(ss.Transaction_Date, '%Y-%m') AS Month,
    ic.Category,
    COUNT(*) AS Number_of_Transactions,
    CONCAT('$',FORMAT(AVG(ss.Sale_Amount),2))  AS Average_Transaction_Amount
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
--# Month, Category, Number_of_Transactions, Average_Transaction_Amount
'2022-01', 'Apparel and Merchandise', '42', '$29.13'
'2022-01', 'Art Supplies', '29', '$22.52'
'2022-01', 'Books (General)', '19', '$25.77'
'2022-01', 'Stationery and Supplies', '36', '$9.29'
'2022-01', 'Technology & Accessories', '45', '$485.78'
'2022-01', 'Textbooks', '31', '$174.12'
'2022-02', 'Apparel and Merchandise', '44', '$34.18'
'2022-02', 'Art Supplies', '24', '$30.49'
'2022-02', 'Books (General)', '17', '$25.83'

       :        :
       :        :
       :        :
       
--QUESTION 5--  
- Can you provide a ranking of in-store sales performance by each store in the sales territory, or aranking of online sales performance by state within an online sales territory?
SELECT 
    sl.StoreId,
    sl.StoreLocation,
	CONCAT('$',FORMAT(SUM(ss.Sale_Amount),2 ))  AS Total_Sales,
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
'870', 'New London', '$331,116.76', '2272'
'865', 'Bridgeport', '$322,100.07', '2231'
'867', 'Hartford', '$309,592.06', '2133'
'872', 'Waterbury', '$295,651.17', '2099'
'869', 'New Haven', '$286,779.43', '2173'
'868', 'Litchfield County', '$286,217.15', '2127'
'866', 'Darien', '$283,455.62', '2152'
'871', 'Old Saybrook', '$277,310.18', '2191'


---QUESTION 6
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

  
  
  

-- Capstone 1: Bonus Questions
-- Database: sample_sales
-- Sales Territory: Connecticut
-- Author: Your Name
---o
USE sample_sales;
SELECT
    ss.id,
    ss.Transaction_Date,
    sl.StoreLocation,
    ss.Prod_Num,
    ss.Sale_Amount
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE ss.Transaction_Date = '2024-01-15'
  AND sl.State = 'Connecticut'
ORDER BY ss.Sale_Amount DESC;
-----ANS 
# id, Transaction_Date, StoreLocation, Prod_Num, Sale_Amount
'136376', '2024-01-15', 'Hartford', '105266-IT', '367.08'
'136375', '2024-01-15', 'Darien', '105278-IT', '272.24'
'136373', '2024-01-15', 'Bridgeport', '105369-T', '228.30'
'136378', '2024-01-15', 'Litchfield County', '105527-T', '228.30'
'136380', '2024-01-15', 'New Haven', '105654-T', '152.40'
'136381', '2024-01-15', 'Old Saybrook', '105345-IT', '120.82'
'136379', '2024-01-15', 'Litchfield County', '105317-IT', '33.13'
'136377', '2024-01-15', 'Litchfield County', '105484-A', '28.92'
'136382', '2024-01-15', 'Waterbury', '105479-A', '20.36'
'136372', '2024-01-15', 'Bridgeport', '105703-B', '17.70'
'136374', '2024-01-15', 'Darien', '105574-A', '13.13'
'136371', '2024-01-15', 'Bridgeport', '105794-S', '2.40'
....
QUESTION 2
Which transactions had a sale amount greater than $500? Display the transaction date, store ID,
product number, and sale amount.
SELECT
    ss.Transaction_Date,
    ss.Store_ID,
    ss.Prod_Num,
    ss.Sale_Amount
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE ss.Sale_Amount > 500
  AND sl.State = 'Connecticut'
ORDER BY ss.Sale_Amount DESC;
----ANS--# Transaction_Date, Store_ID, Prod_Num, Sale_Amount
'2023-06-04', '869', '105333-IT', '1292.00'
'2023-07-10', '866', '105333-IT', '1292.00'
'2023-08-29', '867', '105333-IT', '1292.00'
'2023-10-22', '865', '105333-IT', '1292.00'
'2024-03-13', '865', '105333-IT', '1292.00'
'2024-03-28', '871', '105333-IT', '1292.00'
          :              :

     
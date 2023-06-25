/*
Query 1: Sales Order Shipments by Month and Category Code1

Write an SQL statement to display the sum of the extended cost and the sum of the quantity. The results should include data for shipments (transaction type 5) in calendar year 2011. Summarize the result by calendar month and Address Category Code 1. The result should include the grouped columns and the full totals for every combination of grouped columns. Do not use the GROUPING SETS and UNION operators.
*/

SELECT CalMonth, AddrCatCode1, SUM(inf.ExtCost) AS "TOTAL COST ",
	SUM(inf.quantity) AS "TOTAL QUANTITY"
FROM date_dim dd, inventory_fact inf, addr_cat_code1 ad1, cust_vendor_dim cd
WHERE dd.DateKey = inf.DateKey
	AND cd.AddrCatCode1 = ad1.AddrCatCodeKey
	AND inf.CustVendorKey = cd.CustVendorKey
	AND dd.CalYear = '2011'
	AND inf.TransTypeKey= 5
GROUP BY CUBE(dd.calmonth, cd.AddrCatCode1)
ORDER BY dd.CalMonth, cd.AddrCatCode1;
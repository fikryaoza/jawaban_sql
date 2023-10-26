SELECT a1.customerNumber FROM 
(
	Select a.customerNumber, COUNT(c.productLine) total
	from orders as a
	left join orderdetails as b on a.orderNumber = b.orderNumber
	left join products as c on c.productCode = b.productCode
	where c.productLine = 'Classic Cars'
	GROUP BY a.customerNumber
) a1 
WHERE a1.total > 23
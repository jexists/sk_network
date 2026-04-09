 가장 잘 팔리는 제품 분석 쿼리 실행
 각 제품의 총 판매량(total_quantity)를 계산하고, 가장 많이 팔린 제품을 상위 5개 출력
 
 
 SELECT 
 	productCode,
 	productName
 FROM products;
 
  
 SELECT 
 	*
 FROM products;
 
 
 SELECT 
 	status
 FROM orders
 GROUP BY status;
--  shipped / resolved

 SELECT
--  	p.productCode,
--  	p.productName,
--  	od.orderNumber,
--  	od.quantityOrdered,
--  	o.status
 	od.productCode,
 	sum(od.quantityOrdered)
 FROM products AS p
 JOIN orderdetails AS od
 	ON od.productCode = p.productCode
 JOIN orders AS o
 WHERE o.status IN ('Shipped', 'resolved')
 GROUP BY productCode
 
 
 SELECT
 	od.productCode,
    p.productName,
 	sum(od.quantityOrdered) AS total_quantity
 FROM products AS p
 JOIN orderdetails AS od
 	ON od.productCode = p.productCode
 JOIN orders AS o
 WHERE o.status IN ('Shipped', 'resolved')
 GROUP BY productCode
 ORDER BY total_quantity desc
 LIMIT 5
 
 SELECT 
 	*
 FROM payments;
 
 
-- 가장 많이 팔린 제품 분석 쿼리 실행
-- 각 제품의 총 매출(total_sales)을 계산하고, 
-- 가장 높은 매출을 기록한 상위 5개 제품을 찾는 쿼리
 
 SELECT
 	od.productCode,
    p.productName,
 	sum(od.quantityOrdered) * p.buyPrice AS total_quantity
 FROM products AS p
 JOIN orderdetails AS od
 	ON od.productCode = p.productCode
 JOIN orders AS o
 WHERE o.status IN ('Shipped', 'resolved')
 GROUP BY productCode
 ORDER BY total_quantity desc
 LIMIT 5
 

 

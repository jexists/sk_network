
-- 각 고객의 총 주문수(total_order)와 가장 최근의 주문 날짜(last_order_date)를 조회하는 쿼리
SELECT *
FROM orders

SELECT 
	customerNumber,
	count(*) AS cnt,
	max(orderDate) 
FROM orders
GROUP BY customerNumber
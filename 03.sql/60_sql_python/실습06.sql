
SELECT *
FROM orders;

-- 가장 돈을 많이 쓴 상위 10명 고객
-- 해당 고객의 주문 횟수
SELECT customernumber,
	sum(amount) AS total_spent
FROM payments
GROUP BY customernumber
ORDER by total_spent DESC
LIMIT 10;

-- 가장 돈을 많이 쓴 상위 10명 고객
-- 해당 고객의 주문 횟수
SELECT p.customernumber,
	count(DISTINCT o.ordernumber) AS order_count, -- 해당 고객의 주문 횟수 (중복 주문번호 제거)
	sum(p.amount) AS total_spent -- 해당 고객이 결제한 총 금액 합계
FROM payments AS p
JOIN orders AS o
	ON p.customerNumber  = o.customerNumber 
GROUP BY customernumber
ORDER by total_spent DESC
LIMIT 10;


SELECT p.customernumber,
	count(DISTINCT o.ordernumber) AS order_count, -- 해당 고객의 주문 횟수 (중복 주문번호 제거)
	sum(DISTINCT p.amount) AS total_spent -- 해당 고객이 결제한 총 금액 합계
FROM payments AS p
JOIN orders AS o
	ON p.customerNumber  = o.customerNumber 
GROUP BY customernumber
ORDER by total_spent DESC
LIMIT 10;


-- 고객들의 총합이 몇개인지 
SELECT customernumber,
	sum(amount) AS total_spent
FROM payments
GROUP BY customernumber


SELECT p.customernumber,
	o.order_count,
	p.total_spent
FROM (
	SELECT customernumber,
	sum(amount) AS total_spent
	FROM payments
	GROUP BY customernumber
) AS p
JOIN (
	SELECT customernumber,
		count(*) AS order_count
		FROM orders
		GROUP BY customernumber
) AS o
ON p.customernumber  = o.customernumber 
ORDER BY p.total_spent DESC
LIMIT 10;


-- 시간대 별 구매 금액 변화 분석 쿼리 실행
-- vip 고객(결제 금액)을 선정한 후, 두개의 기간(2004년과 2005년) 동안 결제 총액을 비교

SELECT customerNumber,
	count(*) AS order_count
FROM orders
GROUP BY customerNumber

-- vip
SELECT customerNumber,
	sum(amount) AS order_count
FROM payments
GROUP BY customerNumber
ORDER BY sum(amount) DESC;


SELECT p.customerNumber,
       -- 2004년동안 결제한 총 금액
       SUM(CASE 
                   WHEN p.paymentDate BETWEEN '2004-01-01' AND '2004-12-31' THEN p.amount
                   ELSE 0        -- 해당 기간이 아니면 0
       END
       ) AS pre_period_total,
       -- 2005년동안 결제한 총 금액
          SUM(CASE 
                   WHEN p.paymentDate BETWEEN '2005-01-01' AND '2005-12-31' THEN p.amount
                   ELSE 0        -- 해당 기간이 아니면 0
       END
       ) AS recent_period_total
FROM payments p
INNER JOIN ( -- VIP 고객만 조회하기 위해 서브쿼리 사용
            SELECT customerNumber
            FROM payments
            GROUP BY customerNumber
            ORDER BY sum(amount) DESC        -- 총 결제 금액이 높은 순 정렬
) AS vip_customer
ON p.customerNumber = vip_customer.customerNumber
-- vip 고객만 남기기 위해서 inner join을 사용
GROUP BY p.customerNumber;










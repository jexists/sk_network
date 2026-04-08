/*
* [서브쿼리]
* - 하나의 SQL문 안에 포함된 또 다른 SELECT문.
* - 바깥 쿼리(메인쿼리)가 실행될 때, 안쪽 쿼리(서브쿼리)의 결과를 이용
* 
* [특징]
* 1. 서브쿼리는 반드시 소괄호()로 감싸서 사용.
* 2. 서브쿼리는 위치에 따라 역할
* 	- SELECT 절: 스칼라 서브쿼리
* 	- FROM 절: 인라인 뷰
* 	- WHERE 절: 중첩 서브퀄
* 3. 서브쿼리 결과가 1이면 보통 =, <, > 같은 비교 연산자와 함께 사용
* 4. 서브쿼리 결과가 여러 개면 IN, ANY, ALL 등과 사용
* 5. 바깥 쿼리와 독립적으로 실행되면  비상관 서브쿼리,
* 	바깥 쿼리의 값을 참조하면 상관 서브쿼리.
* 
*/

SELECT *
FROM employee2;

-- 1. 단일행 서브쿼리
-- 서브쿼리 결과가 "하나" 일때 사용

-- 이름이 '김철수'인 직원의 정보를 조회
-- 먼저 서브쿼리로 '김철수'의 emp_id를 찾고,
-- 그 emp_id와 일치하는 직원을 바깥쿼리에서 조회

SELECT *
FROM employee2
WHERE name = '김철수';

SELECT *
FROM employee2
WHERE emp_id = (
	SELECT emp_id
	FROM employee2
	WHERE name = '김철수'
);

-- 전체 평균 급여보다 높은 급여를 받는 직원 조회
-- 먼저 employee2 전체의 평균 급여를 구한 뒤,
-- 그 평균보다 salary가 큰 직원만 조회
SELECT *
FROM employee2
WHERE salary > (
	SELECT avg(salary)
	FROM employee2
);

-- 기준값을 먼저 구해서 비교할 때 사용
-- 실무에서는 전체 평균, 최대값, 최소값, 특정 그룹의 평균


-- 2. 다중행 서브쿼리
-- 서브쿼리 결과가 여러 행일 수 있을 때 사용

-- 이름이 '김철수' 또는 '이영희'인 직원의 정보 조회

SELECT *
FROM employee2
WHERE emp_id IN (
	SELECT emp_id 
	FROM employee2
	WHERE name IN ('김철수', '이영희')
);


-- 3, any 사용

-- 여러 값 중 '하나 이상' 조건을 만족하면 참

-- 급여가 5000 초과인 직원들의 급여중
-- 적어도 한명의 급여보다 더 높은 급여를 받는 직원 조회
-- salary > 6000 or salary 7000 or salary 8000과 비슷한 개념
SELECT *
FROM employee2
WHERE salary > ANY (
	SELECT salary
	FROM employee2
	WHERE salary > 5000
);

-- 4. EXISTS
-- 서브쿼리 결과의 '존재 여부'만 검사
-- 값 자체보다 행이 존재하는지가 중요

-- '영업부'에 속한 직원이 실제로 존재하는지 확인
-- exists는 서브 쿼리 결과가 1행 이라도 있으면 TRUE를 반환

SELECT exists(
	SELECT 1
	FROM employee2
	WHERE department = '영업부'
) AS sales_emp;


SELECT exists(
	SELECT 1
	FROM employee2
	WHERE department = '영업부?'
);

-- 같은 부서에서 자신보다 급여가 더 높은 사람이 없는 지 검사
-- 가가 직원 (e1)에 대해 같은 부서 안에 나보다 월급이 더 높은 사람 (e2)이 있는지 확인
-- not exists니까 그런 사람이 없어야만 결과에 남음
-- 부서별 최고 급여 직원
SELECT *
FROM employee2 e1
WHERE NOT EXISTS (
	SELECT 1
	FROM employee2 e2
	WHERE e1.department = e2.department 
		AND e1.salary < e2.salary 
);


-- 위와 결과가 같은 쿼리문
SELECT *
FROM employee2 e1
WHERE salary = (
	SELECT MAX(salary)
	FROM employee2 e2
	WHERE e1.department = e2.department 
);

-- 5. 상관 서브 쿼리
-- 서브 쿼리가 바깥 쿼리의 값을 참조하는 형태

-- 자신의 부서 평균 급여보다 더 많은 급여를 받는 직원 조회
-- 서브쿼리는 그 직원이 속한 부서의 평균 급여를 계산
-- 그리고 현재 직원의 salary와 비교
SELECT *
FROM employee2 e
WHERE salary > (
	SELECT avg(salary)
	FROM employee2
	WHERE department = e.department 
);



-- 6. SELECT 절의 스칼라 서브쿼리
-- 한 행마다 하나의 값(스칼라 값)을 붙여서 조회

-- 각 직원의 정보와 함께, 해당 직원이 속한 부서의 평균 급여를 같이 조회

SELECT 
	e.emp_id,
	e.name,
	e.department,
	e.salary,
	(
		-- 	서브 쿼리가 그 부서의 평균 급여 계산
		SELECT avg(salary)
		FROM employee2
		-- 바깥 쿼리의 department를 기준으로
		WHERE department = e.department 
	) AS avg_salary_per_dept
FROM employee2 e;

-- 7. FROM 절의 서브 쿼리 = 인라인 뷰
-- 서브쿼리 결과를 임시 테이블처럼 사용
-- 보통 별칭을 꼭 붙여줌

-- 부서별 평균 급여가 '영업부 평균 급여'보다 높은 부서 조회

SELECT 
	t.department,
	t.avg_salary
FROM  (
	SELECT 
		department,
		avg(salary) AS avg_salary
	FROM employee2
	GROUP BY department
) t

SELECT 
	t.department,
	t.avg_salary
FROM  (
	SELECT 
		department,
		avg(salary) AS avg_salary
	FROM employee2
	GROUP BY department
) t
WHERE t.avg_salary > (
	SELECT avg(salary)
	FROM employee2
	WHERE department = '영업부'
)


/* CASE문의 역할
 * 1. 값의 바꾸기(남/여 -> M/F)
 * 2. 구간 나누기(점수에 따라 A/B/C)
 * 3. 조건별 라벨 붙이기(고연봉 직원/일반 직원)
 * 4. 집계용 조건 만들기(고연봉 직원 1, 아니면 0)
 * 
 * 데이터를 해석하기 쉬운 형태로 바꾸는 데 자주 사용
 * */

-- 형태1. 단순 case문
SELECT name,
	   CASE gender
	   		WHEN '여' THEN 'F'
	   		WHEN '남' THEN 'M'
	   		ELSE '해당없음'
	   END AS gender_code
FROM employee2;


-- 형태2. 검색 case문
-- When = if
-- then = 그럼 이 값
-- else = 위에 조건이 아니면 이 값
-- end = 끝
SELECT name,
	   CASE 
	   		WHEN gender = '여' THEN 'F'
	   		WHEN gender = '남' THEN 'M'
	   		ELSE '해당없음'
	   END AS gender_code
FROM employee2;

-- 문1. salary 7500 초과이면 '고연봉 직원', 아니면 '일반 직원'
-- 직원 name, salary를 조회
SELECT name, 
	   salary,
	   CASE 
	   		WHEN salary > 7500 THEN '고연봉 직원'
	   		ELSE '일반 직원'
	   END AS salary_type
FROM employee2;

-- 문2. 직원 name, salary를 조회하고, salary가 8000 이상이면 '최상위', 
-- 6000이상이면 '상위', 그 외에는 '일반' 표시하는 salary_level 컬럼을 만드세요.
SELECT name, 
	   salary,
	   CASE 
	   		WHEN salary >= 8000 THEN '최상위'
	   		WHEN salary >= 6000 THEN '상위'
	   		ELSE '일반'
	   END AS salary_level
FROM employee2;


-- 문3. 부서별로 고연봉 직원 수와 일반 연봉 직원 수 조회
-- 급여가 7500이상 이면 고연봉, 아니면 일반 연봉 직원
-- 컬럼 조회 : 부서, 고연봉직원수, 일반 연봉 직원수

SELECT department,
	   sum(CASE 
	   		WHEN salary >= 7500 THEN 1
	   		ELSE 0
	   END) AS high_salary_cnt,
   	   sum(CASE 
	   		WHEN salary < 7500 THEN 1
	   		ELSE 0
	   END) AS normal_salary_cnt
FROM employee2
GROUP BY department;


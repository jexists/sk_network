/*
 * CASE 문
 * 1. 값을 변경시 사용 (남/여 -> M/F)
 * 2. 구간을 나눌 때 (점수에 따라 A/B/C)
 * 3. 조건별 라벨 붙이기 (고연봉 직원 / 일반 직원)
 * 4. 집계용 조건 만들기 (고연봉 직원 1, 아니면 0)
 * 
 * 데이터를 해석하기 쉬운 형태로 바꾸는데 자주 사용
 */


-- when == if
-- than == 그럼 이값
-- else == 위에 조건이 아니면 이 값
-- end == 끝

SELECT name
FROM employee2;


-- 형태1. 단순 case문
SELECT 
	name,
	CASE gender
		WHEN '여' THEN 'F'
		WHEN '남' THEN 'M' 
		ELSE '해당없음'
	 END AS gender_code
FROM employee2

-- 형태2. 검색 case문
SELECT 
	name,
	CASE 
		WHEN gender = '여' THEN 'F'
		WHEN gender = '남' THEN 'M'
		ELSE '해당없음' 
	END AS gender_code
FROM employee2;

-- salary 7500 초과이면 '고연봉 직원' 아니면 '일반 직원'

SELECT
	name,
	salary,
	CASE
		WHEN salary > 7500 THEN '고연봉 직원'
		ELSE '일반직원'
	END AS type
FROM employee2
ORDER BY type

-- 직원 name, salary를 조회 하고 
-- salary가 8000 이상이면 '최상위' 6000이상이면 '상위' 그외에는 일반 표시
SELECT 
	name,
	CASE 
		WHEN salary >= 8000 THEN '최상위'
		WHEN salary >= 6000 THEN '상위'
		ELSE '일반'
	END AS salary_level
FROM employee2;
	

-- 부서별 고연봉 직원 수와 일반 연봉 직원 수 조회
-- 급여가 7500이면 고연봉, 아니면 일반 연봉 직원
SELECT 
	department,
	sum(CASE
		WHEN salary >= 7500 THEN 1
		ELSE 0
	END) AS high_salary_cnt,
	sum(CASE
		WHEN salary < 7500 THEN 1
		ELSE 0
	END) AS normal_salary_cnt
FROM employee2
GROUP BY department


SELECT 
	department,
	count(
		CASE 
			WHEN salary >= 7500 
			THEN 'high'
		END 
	) AS high_salary_cnt, 
     count(
     	CASE 
	     	WHEN salary <=7500 
	     	THEN 'normal'END 
 	)AS normal_salary_cnt
FROM employee2
GROUP BY department;
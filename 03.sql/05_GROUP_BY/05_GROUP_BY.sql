
SELECT *
FROM employee2;

SELECT department
FROM employee2;

-- 부서별로 그룹화
-- 같은 부서끼리 하나의 그룹으로 묶음
-- 결과에는 중복 없는 부서 목록처럼 보임
SELECT department
FROM employee2
GROUP BY department;

--  직급(position) 기준으로 그룹화
SELECT position
FROM employee2
GROUP BY position;

-- 부서별 + 직급별로 그룹화
SELECT department, position
FROM employee2 
GROUP BY department, position;


SELECT position, department
FROM employee2 
GROUP BY position, department;

-- 부서별 직원 수 확인
-- COUNT(*) : 해당 그룹에 속한 전체 행 수를 의미
SELECT department,
	Count(*) AS cnt
FROM employee2
GROUP BY department;

-- 부서별, 직급별 직원 수 확인
SELECT department, position,
	Count(*)
FROM employee2 
GROUP BY department, position;

-- 부서별, 직급별 직원 수 확인
-- cnt 내림차순
SELECT department, position,
	Count(*) AS cnt
FROM employee2 
GROUP BY department, POSITION
ORDER by cnt DESC;

-- cnt가 2명보다 많은 경우 조회 (HAVING)
SELECT department, position,
	Count(*) AS cnt
FROM employee2 
GROUP BY department, POSITION
HAVING cnt > 2;

-- 부서별 평균 급여 계산
-- salary 6000이상인 부서만 조회
-- 내림차순 정렬
SELECT department, 
	avg(salary) AS avg
FROM employee2 
GROUP BY department
HAVING avg >= 6000
ORDER BY avg DESC;



SELECT 
    department,
    GROUP_CONCAT(name) AS names,
    AVG(salary) AS avg
FROM employee2
GROUP BY department;


SELECT 
    department,
	JSON_ARRAYAGG(name) AS employee_json,
    AVG(salary) AS avg
FROM employee2
GROUP BY department;


/*[실습04]
각 지역별 캠핑장 수 출력 (단, 지역은 LOCATION으로 출력)
1번 데이터를 캠핑장 수가 많은 지역부터 출력
각 지역별 영업중인 캠핑장 수 출력
3번 데이터에서 캠핑장 수가 300개 이상인 지역만 출력
년도별 폐업한 캠핑장 수 출력 (단, 년도는 YEAR로 출력)
5번 데이터를 년도별로 내림차순하여 출력*/


SELECT 지번주소
FROM camping_info;

SELECT SUBSTR(지번주소, 1, 5)        -- 이렇게 자르면 제대로 안 짤린 데이터들이 생김. 고정적으로 자르는게 아니고 가변적으로 잘라야 함.
FROM camping_info;

-- INSTR(s, ' ) : 문자열 s에서 ' '(공백)이 처음 나타나는 위치
SELECT INSTR(지번주소, ' ')    -- 스페이스바가 위치한 첫 번째 자리를 리턴
FROM camping_info;

SELECT SUBSTR(지번주소, 1, INSTR(지번주소, ' ')) -- 내가 원하는 부분만 파싱.
FROM camping_info;

-- 1. 각 지역별 캠핑장 수 출력 (단, 지역은 LOCATION으로 출력)
SELECT SUBSTR(지번주소, 1, INSTR(지번주소, ' ')) AS LOCATION,
       count()
FROM camping_info
GROUP BY LOCATION;


-- 2. 1번 데이터를 캠핑장 수가 많은 지역부터 출력
SELECT SUBSTR(지번주소, 1, INSTR(지번주소, ' ')) AS LOCATION,
       count()
FROM camping_info
GROUP BY LOCATION
ORDER BY count() DESC;

-- 3. 각 지역별 영업중인 캠핑장 수 출력
SELECT SUBSTR(지번주소, 1, INSTR(지번주소, ' ')) AS LOCATION,
       count()
FROM camping_info
WHERE 상세영업상태코드 = 13
GROUP BY LOCATION
ORDER BY count() DESC;

-- 4. 3번 데이터에서 캠핑장 수가 300개 이상인 지역만 출력
SELECT SUBSTR(지번주소, 1, INSTR(지번주소, ' ')) AS LOCATION,
       count()
FROM camping_info
WHERE 상세영업상태코드 = 13
GROUP BY LOCATION
HAVING count() >= 300
ORDER BY count() DESC;

-- 5. 년도별 폐업한 캠핑장 수 출력 (단, 년도는 YEAR로 출력)
SELECT SUBSTR(폐업일자, 1, 4) AS YEAR,
       count()
FROM camping_info
GROUP BY YEAR;

SELECT SUBSTR(폐업일자, 1, 4) AS YEAR,
       count()
FROM camping_info
WHERE 상세영업상태코드 = 3
GROUP BY YEAR;


-- 6. 5번 데이터를 년도별로 내림차순하여 출력
SELECT SUBSTR(폐업일자, 1, 4) AS YEAR,
       count(*)
FROM camping_info
WHERE 상세영업상태코드 = 3
GROUP BY YEAR
ORDER BY YEAR DESC;
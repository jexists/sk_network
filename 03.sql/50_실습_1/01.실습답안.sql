/*
[실습01]
캠핑장의 사업장명과 지번주소를 출력(단, 사업장명은 NAME, 지번주소는 ADDRESS로 출력)
1번 데이터에서 정상 영업 하고 있는 캠핑장만 출력
양양에 위치한 캠핑장은 몇 개인지 출력
3번 데이터에서 폐업한 캠핑장은 몇 개인지 출력
태안에 위치한 캠핑장의 사업장명 출력
5번 데이터에서 2020년에 폐업한 캠핑장만 출력
제주도와 서울에 위치한 캠핑장은 몇 개인지 출력
*/

SELECT
FROM camping_info;

SELECT count()
FROM camping_info;


-- 1. 캠핑장의 사업장명과 지번주소를 출력(단, 사업장명은 NAME, 지번주소는 ADDRESS로 출력)
SELECT 사업장명 AS NAME,
       지번주소 AS ADDRESS
FROM camping_info;


SELECT 상세영업상태명, 상세영업상태코드
FROM camping_info
GROUP BY 상세영업상태명, 상세영업상태코드;
-- 영업중 = 13
-- 폐업 = 3
-- 휴업 = 2
-- 등록취소 = 31
-- 직권말소 = 35

-- 2. 1번 데이터에서 정상 영업 하고 있는 캠핑장만 출력
SELECT 사업장명 AS NAME,
       지번주소 AS ADDRESS
FROM camping_info
WHERE 상세영업상태코드 = 13;
 
-- 3. 양양에 위치한 캠핑장은 몇 개인지 출력
SELECT count()
FROM camping_info
WHERE 지번주소
LIKE "%양양%";

-- 의심병
SELECT 지번주소, 사업장명
FROM camping_info
WHERE 지번주소
LIKE "%양양%";


-- 4. 3번 데이터에서 폐업한 캠핑장은 몇 개인지 출력
SELECT count()
FROM camping_info
WHERE 지번주소
LIKE "%양양%"
AND 상세영업상태코드 = 3;

-- 5. 태안에 위치한 캠핑장의 사업장명 출력
SELECT count()
FROM camping_info
WHERE 지번주소
LIKE "%태안%";

-- 의심병
SELECT 지번주소, 사업장명
FROM camping_info
WHERE 지번주소
LIKE "%태안%";

-- 6. 5번 데이터에서 2020년에 폐업한 캠핑장만 출력
SELECT 사업장명
FROM camping_info
WHERE 지번주소
LIKE "%태안%"
AND 폐업일자 LIKE '%2020%';


SELECT 사업장명, 지번주소
FROM camping_info
WHERE 지번주소
LIKE "%태안%"
AND 폐업일자 LIKE '%2020%';

-- 7. 제주도와 서울에 위치한 캠핑장은 몇 개인지 출력
SELECT count()
FROM camping_info
WHERE 지번주소 LIKE '%제주특별자치도%'
OR 지번주소 LIKE '%서울%';


-- 폐업이 아닌 경우
SELECT
FROM camping_info
WHERE 상세영업상태코드 != 3;

SELECT *
FROM camping_info
WHERE 상세영업상태코드 <> 3;
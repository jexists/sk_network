
SELECT *
FROM camping_info;

SELECT count(*)
FROM camping_info; -- 4746

/*
* [실습01]
* 1. 캠핑장의 사업장명과 지번주소를 출력(단, 사업장명은 NAME, 지번주소는 ADDRESS로 출력)
* 2. 1번 데이터에서 정상 영업 하고 있는 캠핑장만 출력
* 3. 양양에 위치한 캠핑장은 몇 개인지 출력
* 4. 3번 데이터에서 폐업한 캠핑장은 몇 개인지 출력
* 5. 태안에 위치한 캠핑장의 사업장명 출력
* 6. 6번 데이터에서 2020년에 폐업한 캠핑장만 출력
* 7. 제주도와 서울에 위치한 캠핑장은 몇 개인지 출력
*/

-- 캠핑장의 사업장명과 지번주소를 출력(단, 사업장명은 NAME, 지번주소는 ADDRESS로 출력)
SELECT 
	사업장명 AS name, 
	지번주소 AS address
FROM camping_info;

-- 2. 1번 데이터에서 정상 영업 하고 있는 캠핑장만 출력
SELECT 
	사업장명 AS name, 
	지번주소 AS address
FROM camping_info
WHERE 영업상태명 = '영업/정상';


SELECT 상세영업상태명, 상세영업상태코드
FROM camping_info
GROUP BY 상세영업상태명, 상세영업상태코드
-- 영업중 = 13
-- 폐업 = 3


-- 3. 양양에 위치한 캠핑장은 몇 개인지 출력
SELECT count(*) AS cnt
FROM camping_info
WHERE instr(지번주소, '양양') > 0;

SELECT count(*) AS cnt
FROM camping_info
WHERE 지번주소 like '%양양%';


-- 4. 3번 데이터에서 폐업한 캠핑장은 몇 개인지 출력

SELECT count(*) AS cnt
FROM camping_info
WHERE 
		지번주소 like '%양양%' 
	AND  
		상세영업상태명 = '폐업';

SELECT count(*) AS cnt
FROM camping_info
WHERE instr(지번주소, '양양') > 0 AND 상세영업상태명 = '폐업';

-- 5. 태안에 위치한 캠핑장의 사업장명 출력
SELECT 사업장명
FROM camping_info
WHERE instr(지번주소, '태안') > 0;

-- 6. 5번 데이터에서 2020년에 폐업한 캠핑장만 출력
SELECT 사업장명, 지번주소, 폐업일자
-- 	, 상세영업상태명
FROM camping_info
WHERE instr(지번주소, '태안') > 0 AND 상세영업상태명 = '폐업';

SELECT 사업장명, 지번주소, 폐업일자
-- 	, 상세영업상태명
FROM camping_info
WHERE 지번주소 like '%태안%';


SELECT 사업장명, 지번주소, 폐업일자
FROM camping_info
WHERE 
		지번주소 like '%태안%' 
		AND 
		폐업일자 LIKE "%2020%"


-- 7. 제주도와 서울에 위치한 캠핑장은 몇 개인지 출력
SELECT count(*) AS cnt
FROM camping_info
WHERE instr(지번주소, '제주') > 0 or instr(지번주소, '서울') > 0;

SELECT *
FROM camping_info
WHERE 지번주소 LIKE '%제주특별자치도%'



-- [실습02]
-- 1. 해수욕장에 위치한 캠핑장의 사업장명과 인허가일자를 출력

SELECT 사업장명, 인허가일자
FROM camping_info
WHERE 도로명주소 like '%해수욕장%' OR 사업장명 LIKE '%해수욕%';

-- 
-- SELECT count(*)
-- FROM camping_info
-- WHERE 도로명주소 like '%해수욕장%' OR 사업장명 LIKE '%해수욕%';

-- 
-- SELECT count(*)
-- FROM camping_info
-- WHERE 도로명주소 like '%해수욕장%';
-- 
-- 
-- SELECT *
-- FROM camping_info
-- WHERE 도로명주소 LIKE '제주';

-- SELECT 
-- 	선박척수
-- FROM camping_info
-- GROUP BY 도로명주소;


-- 2. 제주도 해수욕장에 위치한 캠핑장의 지번주소와 사업장명 출력
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE (
		도로명주소 like '%해수욕장%' 
	OR 
		사업장명 LIKE '%해수욕%'
	)
	AND 도로명주소 LIKE '제주%';

-- SELECT *
-- FROM camping_info
-- WHERE 도로명주소 like '제주%';
-- 
-- SELECT 사업장명, 지번주소, 도로명주소
-- FROM camping_info
-- WHERE 도로명주소 like '%해수욕장%';
-- 
-- SELECT 지번주소, 사업장명
-- FROM camping_info
-- WHERE 도로명주소 like '%제주%해수욕장%';

-- 3. 2번 데이터에서 인허가일자가 가장 최근인 곳의 인허가일자 출력
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE (
		도로명주소 like '%해수욕장%' 
	OR 
		사업장명 LIKE '%해수욕%'
	)
	AND 도로명주소 LIKE '제주%'
ORDER BY 인허가일자 desc;

SELECT max(인허가일자)
FROM camping_info
WHERE 사업장명 LIKE '%해수욕장%'
AND 지번주소 LIKE '%제주%'

SELECT max(인허가일자)
FROM camping_info
WHERE 사업장명 LIKE '%해수욕장%'
AND 지번주소 LIKE '%제주%'


-- 사업장명도 같이 보고 싶은경우
-- 1. 서브 쿼리 이용
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE 사업장명 LIKE '%해수욕%'
	AND 도로명주소 LIKE '제주%'
	AND 인허가일자 = (
		SELECT max(인허가일자)
		FROM camping_info
		WHERE 사업장명 LIKE '%해수욕장%'
		AND 지번주소 LIKE '%제주%'
	);

-- 2. orderby
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE 사업장명 LIKE '%해수욕%'
	AND 도로명주소 LIKE '제주%'
ORDER BY 인허가일자 DESC
LIMIT 1;

-- 4. 인천 해수욕장에 위치한 캠핑장 중 영업중인 곳만 출력
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE (
		도로명주소 like '%해수욕장%' 
	OR 
		사업장명 LIKE '%해수욕%'
	)
	AND 도로명주소 LIKE '인천%'
	AND 상세영업상태명 = '영업중'

-- 5. 4번 데이터 중에서 인허가일자가 가장 오래된 곳의 인허가일자 출력
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE (
		도로명주소 like '%해수욕장%' 
	OR 
		사업장명 LIKE '%해수욕%'
	)
	AND 도로명주소 LIKE '인천%'
	AND 상세영업상태명 = '영업중'
ORDER BY 인허가일자;

-- 6. 해수욕장에 위치한 캠핑장 중 시설면적이 가장 넓은 곳의 시설면적 출력
SELECT 사업장명, 시설면적
FROM camping_info
WHERE (
		도로명주소 like '%해수욕장%' 
	OR 
		사업장명 LIKE '%해수욕%'
	)
ORDER BY 시설면적 desc;

-- 7. 해수욕장에 위치한 캠핑장의 평균 시설면적 출력
SELECT avg(시설면적)
FROM camping_info
WHERE (
		도로명주소 like '%해수욕장%' 
	OR 
		사업장명 LIKE '%해수욕%'
	)

-- [실습03]
-- 1. 캠핑장의 사업장명, 시설면적을 시설면적이 가장 넓은 순으로 출력
SELECT 사업장명, 시설면적
FROM camping_info
ORDER BY 시설면적 desc;

-- 2. 1번 데이터에서 10위까지만 출력
SELECT 사업장명, 시설면적
FROM camping_info
ORDER BY 시설면적 DESC
LIMIT 10;

-- 3. 경기도 캠핑장 중에 면적이 가장 넓은 순으로 5개만 출력
SELECT 사업장명, 시설면적
FROM camping_info
WHERE instr(지번주소, '경기도') > 0
ORDER BY 시설면적 DESC
LIMIT 5;


-- 4. 3번 데이터에서 1위는 제외
SELECT 사업장명, 시설면적
FROM camping_info
WHERE instr(지번주소, '경기도') > 0
ORDER BY 시설면적 DESC
LIMIT 1, 4; -- 2개 써주면, 시작위치(1)와 출력하는 데이터 갯수(4)

-- 5. 영업중인 캠핑장 중에서 인허가일자가 가장 오래된 순으로 20개 출력
SELECT 사업장명, 인허가일자
FROM camping_info
WHERE 
	상세영업상태명 = '영업중'
ORDER BY 인허가일자
LIMIT 20;
	
-- 6. 2020년 10월 ~2021년 3월 사이에 폐업한 캠핑장의 사업장명과 지번주소 출력
-- SELECT 영업상태명
-- FROM camping_info
-- GROUP BY 영업상태명

SELECT 사업장명, 지번주소, 폐업일자
FROM camping_info
WHERE 
	영업상태명 = '폐업'
	AND 
	폐업일자 >= "2020-10-01"
	AND
	폐업일자 <= "2021-03-31";

SELECT 사업장명, 지번주소
FROM camping_info
WHERE 폐업일자 
	BETWEEN '2020-10-01'
	AND '2021-03-31';
		

-- SELECT 사업장명, 지번주소, 폐업일자
-- FROM camping_info
-- WHERE 
-- 	영업상태명 = '폐업'
-- 	AND 
-- 	폐업일자 >= "2020-10-%%"
-- 	AND
-- 	폐업일자 <= "2021-03-%%";
-- 
-- SELECT count(*) AS cnt
-- FROM camping_info
-- WHERE 
-- 	영업상태명 = '폐업'
-- 	AND 
-- 	폐업일자 >= "2020-10-%%"
-- 	AND
-- 	폐업일자 <= "2021-03-%%";

-- 7. 폐업한 캠핑장 중에서 시설면적이 가장 컷던 곳의 사업장명과 시설면적 출력

SELECT 사업장명, 시설면적
FROM camping_info
WHERE 
	영업상태명 = '폐업'
ORDER BY 시설면적 DESC
LIMIT 1




-- [실습04]
-- 1. 각 지역별 캠핑장 수 출력 (단, 지역은 LOCATION으로 출력)


SELECT 
	 trim(substr(지번주소, 1, instr(지번주소, ' '))) AS location,
	 count(*) AS cnt
FROM camping_info
GROUP BY location

-- SELECT 
-- 	CASE
-- 		WHEN 지번주소 LIKE "서울%" THEN '서울'
-- 		WHEN 지번주소 LIKE "전북%" THEN '전북특별자치도'
-- 		WHEN 지번주소 LIKE "전라남도%" THEN '전라남도'
-- 		WHEN 지번주소 LIKE "전라남도%" THEN '전라남도'
-- 		WHEN 지번주소 LIKE "충청북%" THEN '충청북도'
-- 		WHEN 지번주소 LIKE "충청남%" THEN '충청남도'
-- 		WHEN 지번주소 LIKE "경상북%" THEN '경상북도'
-- 		WHEN 지번주소 LIKE "경상남%" THEN '경상남도'
-- 		WHEN 지번주소 LIKE "세종%" THEN '세종특별자치도'
-- 		WHEN 지번주소 LIKE "제주%" THEN '제주도'
-- 		WHEN 지번주소 LIKE "경기%" THEN '경기도'
-- 		WHEN 지번주소 LIKE "부산%" THEN '부산'
-- 		WHEN 지번주소 LIKE "대구%" THEN '대구'
-- 		WHEN 지번주소 LIKE "인천%" THEN '인천'
-- 		WHEN 지번주소 LIKE "광주%" THEN '광주'
-- 		WHEN 지번주소 LIKE "대전%" THEN '대전'
-- 		WHEN 지번주소 LIKE "울산%" THEN '울산'
-- 		WHEN 지번주소 LIKE "강원%" THEN '강원도'
-- 		ELSE 지번주소
-- 	 END AS location
-- FROM camping_info
-- GROUP BY location

-- 2. 1번 데이터를 캠핑장 수가 많은 지역부터 출력

SELECT 
	 trim(substr(지번주소, 1, instr(지번주소, ' '))) AS location,
	 count(*) AS cnt
FROM camping_info
GROUP BY location
ORDER BY cnt DESC;

-- 3. 각 지역별 영업중인 캠핑장 수 출력
SELECT 
	 trim(substr(지번주소, 1, instr(지번주소, ' '))) AS location,
	 count(*) AS cnt
FROM camping_info
WHERE 상세영업상태명 = '영업중'
GROUP BY location
ORDER BY cnt DESC;

-- 4. 3번 데이터에서 캠핑장 수가 300개 이상인 지역만 출력
SELECT 
	 trim(substr(지번주소, 1, instr(지번주소, ' '))) AS location,
	 count(*) AS cnt
FROM camping_info
WHERE 상세영업상태명 = '영업중'
GROUP BY location
HAVING cnt >= 300
ORDER BY cnt DESC;

-- 5. 년도별 폐업한 캠핑장 수 출력 (단, 년도는 YEAR로 출력)
SELECT 
	 count(*) AS cnt,
	 DATE_FORMAT(폐업일자, '%Y') AS YEAR
FROM camping_info
WHERE 영업상태명 = '폐업'
GROUP BY DATE_FORMAT(폐업일자, '%Y');


-- 6. 5번 데이터를 년도별로 내림차순하여 출력
SELECT 
	 count(*) AS cnt,
	 DATE_FORMAT(폐업일자, '%Y') AS YEAR
FROM camping_info
WHERE 영업상태명 = '폐업'
GROUP BY DATE_FORMAT(폐업일자, '%Y')
ORDER BY YEAR DESC;
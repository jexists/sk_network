-- 1. 캠핑장의 사업장명, 시설면적을 시설면적이 가장 넓은 순으로 출력
SELECT 사업장명, 시설면적
FROM camping_info
ORDER BY 시설면적 DESC;

-- 2. 1번 데이터에서 10위까지만 출력
SELECT 사업장명, 시설면적
FROM camping_info
ORDER BY 시설면적 DESC
LIMIT 10;

-- 3. 경기도 캠핑장 중에 면적이 가장 넓은 순으로 5개만 출력
SELECT 사업장명, 시설면적
FROM camping_info
WHERE 지번주소 LIKE '%경기%'
ORDER BY 시설면적 DESC
LIMIT 5;

-- 4. 3번 데이터에서 1위는 제외
SELECT 사업장명, 시설면적
FROM camping_info
WHERE 지번주소 LIKE '%경기%'
ORDER BY 시설면적 DESC
LIMIT 1, 4;            -- 2개 써주면, 시작위치(1)와 출력하는 데이터 갯수(4)

-- 5. 영업중인 캠핑장 중에서 인허가일자가 가장 오래된 순으로 20개 출력
SELECT *
FROM camping_info
WHERE 상세영업상태코드 = 13
ORDER BY 인허가일자
LIMIT 20;
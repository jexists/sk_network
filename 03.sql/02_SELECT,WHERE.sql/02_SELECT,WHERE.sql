

SELECT * 
FROM melon_chart;

-- 중복 없이 고유한 가수 목록 조회
SELECT DISTINCT singer 
FROM melon_chart;

-- 중복을 제거한 가수 카운트
SELECT count(DISTINCT singer) 
FROM melon_chart;

-- column 이름을 변경 가능
SELECT count(DISTINCT singer) AS cnt 
FROM melon_chart;

-- 뉴진스만 조회, ranking, song 컬림만 조회
SELECT ranking, 
	song 
FROM melon_chart 
WHERE singer = 'NewJeans';


-- 가수가 Newjeans 이고 ranking이 6 미만
SELECT * 
FROM melon_chart 
WHERE singer = 'NewJeans' 
	AND ranking < 6;

-- 가수가 정국 이거나 박재정
SELECT * 
FROM melon_chart 
WHERE singer = '정국' 
	OR singer = '박재정';

-- 테이블에서 3행만 조회
SELECT *
FROM melon_chart
LIMIT 3;

-- ranking이 5이상 10이하인 데이터 조회
SELECT *
FROM melon_chart
WHERE ranking BETWEEN 5 AND 10;

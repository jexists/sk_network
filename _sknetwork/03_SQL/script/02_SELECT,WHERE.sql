SELECT *
FROM melon_chart;

-- 중복 없이 고유한 가수 목록 조회
SELECT DISTINCT singer
FROM melon_chart;

SELECT COUNT(DISTINCT singer) AS cnt
FROM melon_chart;

-- 문1. 'NewJeans'만 조회. ranking, song 컬럼만 조회
SELECT ranking, 
	   song
FROM melon_chart
WHERE singer ='NewJeans';


-- 문2. 가수가 'NewJeans'이고 raking이 6 미만
SELECT *
FROM melon_chart
WHERE singer ='NewJeans'
  AND ranking < 6;


-- 문3. 가수가 '정국'이거나 '박재정'
SELECT *
FROM melon_chart
WHERE singer = '정국'
   OR singer = '박재정';


-- 테이블에서 3행만 조회
SELECT * 
FROM melon_chart
LIMIT 3;


-- ranking이 5 이상 10이하인 데이터 조회
SELECT * 
FROM melon_chart
WHERE ranking BETWEEN 5 AND 10;















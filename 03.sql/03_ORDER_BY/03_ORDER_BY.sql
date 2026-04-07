
/** 
* ORDER BY
* - 조회한 데이터를 정렬하기 위한 구문
* 
* SELECT [컬럼]
* FROM [테이블]
* WHERE [열] = [조건값]
* ORDER BY [열] [ASC 또는 DESC]
* 
*/

-- 정렬 순서 예시 : 숫자, 영어, 한글
SELECT *
FROM melon_chart
ORDER BY song DESC;

-- 문1. like_no 내림 차순 정렬
SELECT *
FROM melon_chart
ORDER BY like_no DESC;

-- 문1. like_no 내림 차순 정렬
-- 같은 좋아요 수이면 singer를 오름차순 정렬
SELECT *
FROM melon_chart
ORDER BY like_no DESC, singer ASC;


-- 좋아요 수가 가장 많은 10개 곡 조호
SELECT *
FROM melon_chart
ORDER BY like_no DESC, singer ASC
LIMIT 10;

-- 범위 지정 조회 : 6번째부터 2개 (skip, limit)
-- 앞에서 5개 건너뛰기, 그다음 2개 가져오기
SELECT *
FROM melon_chart
ORDER BY like_no DESC, singer ASC 
LIMIT 5, 2;

SELECT song,
		singer,
		like_no,
		like_no / 1000 AS like_k
FROM melon_chart
ORDER BY like_k DESC, ranking ASC;




/*
* 
* UNION: 두개 이상의 SELECT 결과를 위아래로 합치는 연산
* JOIN이 옆으포 붙이는 것이라면, UNION은 아래로 붙이는 것
* 
* 특징
* 1. 중복행을 제거
* 2. 중복까지 모두 보고 싶으면 UNION ALL 사용
* 
* 조건
* 1. 컬럼 갯수가 같아야 함
* 2. 컬럼의 의미와 자료형이 어느 정도 호환되어야 함.
* 
*/

-- 컬럼의 순서가 같아야 의미가 맞는다.
-- 첫번째 SELECT의 1번째 컬럼은 cast
-- 두번째 SELECT의 1번째 컬럼도 cast여야 자연스럽다.
SELECT sg1.CAST, sg1.name
FROM squid_game1 sg1
UNION ALL
SELECT sg2.CAST, sg2.name
FROM squid_game2 sg2;



SELECT sg1.CAST, sg1.cast
FROM squid_game1 sg1
UNION ALL
SELECT sg2.CAST, sg2.name
FROM squid_game2 sg2;


-- 컬럼 별칭은 첫번째 SELECT 기준으로 결정
SELECT sg1.CAST AS 출연자, 
	sg1.name AS 이름
FROM squid_game1 sg1
UNION ALL
SELECT sg2.CAST,
	sg2.name
FROM squid_game2 sg2;


-- ORDER BY는 마지막에 한번만 작성
-- 먼저 합친 뒤 최종 결과를 cast 기준으로 정렬.
SELECT *
FROM squid_game1
UNION ALL
SELECT *
FROM squid_game2
ORDER BY CAST;

-- UNION 
-- UNION ALL과 달리 중복 행을 제거.
-- 완전히 같은 행이 양쪽에 있으면 하나만 남긴다. 
SELECT *
FROM squid_game1
UNION
SELECT *
FROM squid_game2;


-- 시즌별 등장인물 수 구하기
-- 첫번째 select는 squid_game1의 행 수
-- 두번째 select는 squid_game2의 행 수
SELECT 'season1' AS source_name,
    count(*) as cnt
FROM squid_game1
UNION ALL
SELECT 'season2' AS source_name,
	count(*) AS cnt
FROM squid_game2;

-- 출처를 붙여서 전체 데이터 출력
-- season_name 컬럼을 추가해서 어느 시즌 데이터 인지 구분
-- 마지막 cast, season_name 기준 정렬
SELECT CAST, name, 'season1' AS season_name
FROM squid_game1
UNION ALL
SELECT CAST, name, 'season2' AS season_name
FROM squid_game2
ORDER BY CAST, season_name;














SELECT *
FROM squid_game1;

SELECT *
FROM squid_game2;

-- JOIN
-- 여러 테이블을 공통된 값(조건)으로 연결해서 조회하는 방법

-- INNER JOIN
-- 두 테이블에서 조건에 맞는 행만 조회
SELECT sg1.cast
FROM squid_game1 AS sg1
INNER JOIN squid_game2 sg2
   ON sg1.CAST = sg2.CAST;


SELECT sg1.CAST
FROM squid_game1 AS sg1, squid_game2 AS sg2
WHERE sg1.CAST = sg2.CAST;

-- AS 생략 가능
SELECT sg1.CAST
FROM squid_game1 sg1, squid_game2 sg2
WHERE sg1.CAST = sg2.CAST;

-- 문1. 두 테이블을 INNER JOIN하고, '딱지남'을 제외한 name 컬럼 출력
SELECT sg1.name
FROM squid_game1 AS sg1
INNER JOIN squid_game2 sg2
   ON sg1.CAST = sg2.CAST
WHERE sg1.CAST <> '딱지남';
   
-- OUTER JOIN
-- 한쪽 테이블의 데이터는 모두 유지하면서 연결

-- LEFT OUTER JOIN: 왼쪽 테이블의 모든 행을 유지.
-- 오른쪽에 매칭되는 값이 없으면 NULL 표시
SELECT *
FROM squid_game1 AS sg1
LEFT OUTER JOIN squid_game2 AS sg2
  ON sg1.CAST = sg2.CAST;

SELECT *
FROM squid_game1 AS sg1
RIGHT OUTER JOIN squid_game2 AS sg2
  ON sg1.CAST = sg2.CAST;

-- LEFT JOIN 후 NULL 필터를 걸면 INNER JOIN과 같은 결과가 된다.
SELECT *
FROM squid_game1 AS sg1
LEFT OUTER JOIN squid_game2 AS sg2
  ON sg1.CAST = sg2.CAST
WHERE sg2.CAST IS NOT NULL;

-- 주의 : OUTER JOIN에서 조건을 WHERE에 잘못 두면 누락 데이터가 사라질 수 있다. 

-- 문2. 시즌2에만 있는 cast, name 조회
SELECT sg2.CAST, sg2.name 
FROM squid_game2 sg2
LEFT JOIN squid_game1 sg1
  ON sg2.CAST = sg1.CAST
WHERE sg1.CAST IS NULL;




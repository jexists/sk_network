/* 기본 형식
 *
 * SELECT [컬럼] 
 *   FROM [테이블]
 *  WHERE [열] LIKE [조건값]
 * 
 * */

-- 노래 중에 A로 시작하는 것 조회
-- %는 "뒤에 어떤 글자가 0개 이상 와도 됨"을 의미
-- A 다음에 글자가 없어도 되고, 여러 글자가 와도 됨.
SELECT *
FROM melon_chart
WHERE song LIKE 'A%';


-- y로 끝나는 노래 조회
SELECT *
FROM melon_chart
WHERE song LIKE '%y';


-- b가 포함된 노래 조회
SELECT *
FROM melon_chart
WHERE song LIKE '%b%';


CREATE TABLE like_test(
	col varchar(20)
);

INSERT INTO like_test VALUES ('안%녕');
INSERT INTO like_test VALUES ('반_가_워');

SELECT *
FROM like_test;

-- %는 0개 이상의 임의 문자열을 의미하는 와일드카드
SELECT *
FROM like_test
WHERE col LIKE '%';

-- ESCAPE를 사용하여 %, _ 자체를 검색할 수 있다.
-- %#%% 
--   첫번째 % : 앞에 어떤 문자열이 와도 됨
--    # %   : % 문자를 와일드카드가 아니라 "실제 문자 %" 취급 
--   마지막 % : 뒤에 어떤 문자열이 와도 됨
SELECT *
FROM like_test
WHERE col LIKE '%#%%' ESCAPE '#';


-- B로 시작하면서 총 3글자인 가수를 조회
SELECT *
FROM melon_chart
WHERE singer LIKE 'B__';

-- New 시작하는 가수
SELECT *
FROM melon_chart
WHERE singer LIKE 'New%';

-- '소'로 시작하고 '대'로 끝나는 가수
SELECT *
FROM melon_chart
WHERE singer LIKE '소%대';

-- song 컬럼 값 안에 공백이 포함된 데이터 조회
-- % % 는 중간에 공백 한 칸이 포함된 문자열 의미
SELECT *
FROM melon_chart
WHERE singer LIKE '% %';



















/*
* mySQL에서 고정 소수점(decimal)과 부동 소수점 (float, double)을 사용한다.
* - 고정 소수점(decimal) : 금융, 회계 데이터처럼 오차가 거의 없어야 하는 경우 사용
* - 부동 소수점 (float, double) : 통계, 센서 데이터, 과학 계산처럼 아주 미세한 오차를 허용할 수 있는 경우 사용
* 
*/

-- FLOAT 타입 컬럼 생성
-- float 소수를 '근사값'으로 저장
-- 사람이 보기엔 0.5처럼 보여도 내부적으로 완벽히 동일하지 않을 수 있다.
CREATE TABLE data_float(
	col_1 float
);


-- decimal(10,2) : 전체 자리수 10자리, 소수점 이하 2자리 까지 저장 가능
CREATE TABLE data_dec(
	col_1 decimal(10, 2)
);

-- float 테이블에 값 삽입
INSERT INTO data_float VALUES (0.5);
INSERT INTO data_float VALUES (0.8);


-- decimal 테이블에 값 삽입
INSERT INTO data_dec VALUES (0.5);
INSERT INTO data_dec VALUES (0.8);


-- float 테이블 조회
SELECT *
FROM data_float;

SELECT *
FROM data_float
WHERE col_1 = 0.5; -- 0.5

-- 내부 저장값 문제로 기대와 다를 수 있음
SELECT *
FROM data_float
WHERE col_1 = 0.8; -- NULL



-- decimal 테이블 조회
SELECT *
FROM data_dec;

SELECT *
FROM data_dec
WHERE col_1 = 0.5; -- 0.5

SELECT *
FROM data_dec
WHERE col_1 = 0.8; -- 0.8



SELECT 10 / 3;


-- 날짜/시간 관련 자료형 비교 테이블
CREATE TABLE date_table (
    justdate DATE, 			-- 날짜만 저장
    justtime TIME, 			-- 시간만 저장
    justdatetime DATETIME, 	-- 날짜와 시간을 함께 저장
    justtimestamp TIMESTAMP -- 시간대/기본값 처리에서 차이가 있음
);

INSERT INTO date_table VALUES (NOW(), NOW(), NOW(), NOW());

SELECT *
FROM date_table;

-- char와 varchar 비교용 테이블
-- VARCHAR 많이 사용!!!
CREATE TABLE data_char_varchar (
    col_1 CHAR(5),		-- 고정 길이 문자열: 항상 5글자 공간 기준
    col_2 VARCHAR(5)	-- 가변 길이 문자열: 입력한 길이만큼 사용
);

INSERT INTO data_char_varchar VALUES ('12345', '12345');
INSERT INTO data_char_varchar VALUES ('ABCDE', 'ABCDE');
INSERT INTO data_char_varchar VALUES ('가나다라', '가나다라');
INSERT INTO data_char_varchar VALUES ('hello', '안녕');

SELECT *
FROM data_char_varchar;

SELECT
    col_1,
    CHAR_LENGTH(col_1) AS char_length_1,
    LENGTH(col_1) AS byte_length_1,
    col_2,
    CHAR_LENGTH(col_2) AS char_length_2,
    LENGTH(col_2) AS byte_length_2
FROM data_char_varchar;
-- 01. 테이블 생성 및 조회

-- 한줄짜리 주석

/*
 * 여러줄 주석
 * 가능
 */

drop table if exists animal_info;

-- 테이블 생성하기
CREATE TABLE animal_info(
	animal varchar(20),
	TYPE varchar(20),
	name varchar(20),
	age INT
);

-- 한글은 UTF-8 기준 보통 3바이트, 영어와 숫자는 1바이트
SELECT length('가'), length('a'), length(1) FROM DUAL;

-- INSERT 문으로 데이터 삽입
INSERT INTO animal_info VALUES ('강아지','푸들','두부',3);
INSERT INTO animal_info VALUES ('고양이','먼치킨','꼼데',1);
INSERT INTO animal_info VALUES ('강아지','치와와','칫치',11);
INSERT INTO animal_info VALUES ('강아지','포메라니안','별이',8);
INSERT INTO animal_info VALUES ('고양이','페르시아','나나',5);

-- 여러개 데이터 삽입 
INSERT INTO animal_info VALUES
    ('강아지', '포메라니안', '망고', 3),
    ('고양이', '먼치킨', '두부', 5),
    ('고양이', '샴', '망고', 1),
    ('고양이', '페르시안', '지니', 13),
    ('강아지', '치와와', '찰리', 8),
    ('강아지', '푸들', '가을', 6),
    ('강아지', '진돗개', '백구', 10);

-- SELECT 테이블 전체 조회
SELECT * FROM animal_info;

-- 특정 컬럼만 조회
SELECT animal FROM animal_info;

SELECT TYPE, name FROM animal_info;

-- ALTER로 컬럼 추가
ALTER TABLE animal_info ADD gender varchar(10);

-- name이 '두부'인 데이터 조회
SELECT * FROM animal_info WHERE name = '두부';

-- 이름이 '꼼데'인 데이터의 animal 값을 '원숭이'로 변경
-- WHERE 조건을 누락하면 테이블 전체가 수정되므로 주의
UPDATE animal_info SET animal = '원숭이' WHERE name = '꼼데';
`System Info`
SELECT * FROM animal_info;

COMMIT;

-- animal_info에서 name - '두부' 삭제
DELETE FROM animal_info WHERE name = '두부';

-- 커밋되기 전이라서 롤백이 가능
ROLLBACK;

-- DROP : 테이블 구조와 데이터가 모두 삭제됨
-- DELETE : 테이블 유지되고 행 데이터만 삭제됨

-- DROP TABLE animal_info;
-- ROLLBACK;

-- DELETE FROM animal_info;
-- ROLLBACK;


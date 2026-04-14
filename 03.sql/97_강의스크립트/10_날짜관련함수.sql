-- 날짜/시간 함수는 현재 시각 조회, 날짜 더하기/빼기, 날짜 차이 계산, 날짜 형식 변환

-- 1. NOW() 함수
-- 현재 날짜와 시간 반환
SELECT NOW()
FROM DUAL;

-- 2.SYSDATE()함수
-- 현재 날짜와 시간 반환
-- NOW()는 쿼리가 시작된 시점 기준
-- SYSDATE() 함수가 실제 실행되는 시점 기준
SELECT sysdate();

-- 3. SLEEP() 함수
-- 지정한 초만큼 실행을 잠시 멈춤
SELECT now(), sleep(5), now();

SELECT sysdate(), sleep(5), sysdate();

-- 4. CURRENT_DATE()함수
-- 현재 날짜만 반환, 시간 정보는 포함 x
SELECT current_date();	

-- 5. ADDDATE() 함수
-- 날짜에 일정 기간을 더할 때 사용
SELECT ADDDATE(NOW(),3);

SELECT ADDDATE('2025-09-01',3);

-- 달을 더하려면
SELECT ADDDATE('2025-09-01', INTERVAL 1 MONTH);

-- 6. LAST_DAY() 함수
-- 해당 날짜가 속한 달의 마지막 날짜를 반환
SELECT LAST_DAY(NOW());

SELECT LAST_DAY('2025-08-01');


-- 7. YEAR(), MONTH(), DAY() 함수
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());

SELECT YEAR('2025-08-01');
SELECT DAY('2025-08-01');


-- 8. DATEDIFF() 함수
-- 두 날짜 사이의 '일 수 차이'를 구하기
-- '앞에 날짜' - '뒤 날짜' 기준
SELECT DATEDIFF('2026-12-25', now());

-- 9. TIMESTAMPDIFF(unit, 시작날짜, 끝날짜)
-- MONTH 단위로 두 날짜 사이의 차이 계산
SELECT TIMESTAMPDIFF(MONTH, '2026-01-01', '2026-10-21');

-- 10. STR_TO_DATE() 함수
-- 문자열을 날짜 형식으로 변환
SELECT STR_TO_DATE('2025/12/25', '%Y/%m/%d');

-- %Y : 4자리 연도
-- %m : 2자리 월
-- %d : 2자리 일
-- %H : 시(24시간)
-- %i :분
-- %s : 초

SELECT DATE_FORMAT(now(), '%Y-%m-%d %H:%i:%s');


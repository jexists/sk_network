DROP TABLE IF EXISTS squid_game1;
DROP TABLE IF EXISTS squid_game2;

CREATE TABLE squid_game1 (
    cast VARCHAR(20),
    name VARCHAR(10)
);

CREATE TABLE squid_game2 (
    cast VARCHAR(20),
    name VARCHAR(10)
);

INSERT INTO squid_game1 VALUES ('성기훈', '이정재');
INSERT INTO squid_game1 VALUES ('조상우', '박해수');
INSERT INTO squid_game1 VALUES ('오일남', '오영수');
INSERT INTO squid_game1 VALUES ('장덕수', '허성태');
INSERT INTO squid_game1 VALUES ('딱지남', '공유');

INSERT INTO squid_game2 VALUES ('성기훈', '이정재');
INSERT INTO squid_game2 VALUES ('정배', '이서환');
INSERT INTO squid_game2 VALUES ('타노스', '최승현');
INSERT INTO squid_game2 VALUES ('준희', '조유리');
INSERT INTO squid_game2 VALUES ('딱지남', '공유');

COMMIT;

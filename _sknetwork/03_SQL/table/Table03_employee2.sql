DROP TABLE IF EXISTS employee2;

CREATE TABLE employee2 (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,	-- AUTO_INCREMENT가 설정된 열에는 값을 입력하지 않는다. 자동으로 값이 증가 돼 입력되도록 정의되어 있기 때문
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    position VARCHAR(50),
    department VARCHAR(50),    
    salary INT
);

INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('김철수', 29, '남', '대리', '영업부', 5000);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('이영희', 35, '여', '과장', '마케팅부', 7000);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('박민수', 27, '남', '사원', 'IT부', 4500);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('최진호', 30, '남', '대리', 'IT부', 5200);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('한지수', 38, '여', '차장', '영업부', 7500);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('송다희', 33, '여', '과장', '인사부', 6800);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('정우진', 25, '남', '사원', '마케팅부', 4800);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('유민혁', 31, '남', '대리', '영업부', 5100);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('오세훈', 36, '남', '과장', 'IT부', 7300);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('강지원', 40, '여', '차장', '마케팅부', 7800);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('고은별', 26, '여', '사원', 'IT부', 4700);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('남도현', 28, '남', '대리', '영업부', 5300);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('서지훈', 37, '남', '부장', '마케팅부', 8500);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('배지현', 29, '여', '대리', '인사부', 5400);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('이도윤', 34, '남', '과장', 'IT부', 7200);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('조서연', 41, '여', '차장', '인사부', 7800);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('박성우', 32, '남', '과장', '영업부', 7100);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('홍수진', 27, '여', '사원', '마케팅부', 4600);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('정하준', 30, '남', '대리', '마케팅부', 5500);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('윤지혜', 45, '여', '부장', '인사부', 9000);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('김도훈', 33, '남', '과장', 'IT부', 7400);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('박지민', 26, '여', '사원', '영업부', 4900);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('차예진', 31, '여', '대리', '마케팅부', 5800);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('강수현', 42, '남', '부장', 'IT부', 8800);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('이태준', 39, '남', '차장', '영업부', 7700);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('김하영', 25, '여', '사원', '인사부', 4600);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('손민재', 29, '남', '대리', '영업부', 5200);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('유나리', 36, '여', '과장', '마케팅부', 7300);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('신재혁', 40, '남', '차장', 'IT부', 7900);
INSERT INTO employee2 (name, age, gender, position, department, salary) VALUES ('문서윤', 38, '남', '차장', '인사부', 8100);

COMMIT;

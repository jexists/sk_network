DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT NULL,
    department VARCHAR(50) NULL,
    salary INT NULL
);

INSERT INTO employee (name, age, department, salary) VALUES ('Alice', 28, 'HR', 50000);
INSERT INTO employee (name, age, department, salary) VALUES ('Bob', 35, 'Engineering', 70000);
INSERT INTO employee (name, age, department, salary) VALUES ('Charlie', 25, 'Engineering', 60000);
INSERT INTO employee (name, age, department, salary) VALUES ('David', 40, 'HR', 75000);
INSERT INTO employee (name, age, department, salary) VALUES ('Eve', 29, 'Marketing', 55000);
INSERT INTO employee (name, age, department, salary) VALUES ('Frank', 33, 'Engineering', 72000);
INSERT INTO employee (name, age, department, salary) VALUES ('Grace', 45, 'Marketing', 80000);
INSERT INTO employee (name, age, department, salary) VALUES ('Hank', 27, 'HR', 52000);
INSERT INTO employee (name, age, department, salary) VALUES ('Ivy', 38, 'Engineering', 68000);
INSERT INTO employee (name, age, department, salary) VALUES ('Jack', 31, 'Marketing', 57000);
INSERT INTO employee (name, age, department, salary) VALUES ('Kevin', NULL, 'Finance', 65000);
INSERT INTO employee (name, age, department, salary) VALUES ('Lily', 32, NULL, 72000);
INSERT INTO employee (name, age, department, salary) VALUES ('Mike', 40, 'Sales', NULL);
INSERT INTO employee (name, age, department, salary) VALUES ('Nina', NULL, NULL, 55000);
INSERT INTO employee (name, age, department, salary) VALUES ('Oscar', NULL, 'HR', NULL);
INSERT INTO employee (name, age, department, salary) VALUES ('Paul', 37, NULL, NULL);

COMMIT;

SELECT *
FROM employee

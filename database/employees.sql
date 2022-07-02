CREATE DATABASE employees CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;

CREATE TABLE employee (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          first_name VARCHAR(30) NOT NULL,
                          last_name VARCHAR(30) NOT NULL,
                          salary INT NOT NULL,
                          emp_department VARCHAR(30) NOT NULL,
                          birth_date DATE NOT NULL
);

INSERT INTO employee
(first_name, last_name, salary, emp_department, birth_date)
VALUES
    ('Wojciech','Adamczyk',2000,'Management','1985-01-01'),
    ('Adam','Wojciechowicz',8000,'Cleaning','2000-01-01'),
    ('Robert','De Niro',3000,'Marketing','1961-01-01'),
    ('Steven','Seagal',9000,'Security','1965-01-01'),
    ('Albert','Einstein',4500,'Sales','1879-03-14'),
    ('Marcin','Wajs',1000,'Accounter','1990-01-01');


SELECT * FROM employee ORDER BY last_name DESC;

SELECT * FROM employee WHERE emp_department = 'Cleaning';

SELECT * FROM employee WHERE (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) >= 30;

UPDATE employee SET salary = salary * 1.1 WHERE emp_department = 'Cleaning';

SELECT * FROM employee ORDER BY birth_date DESC LIMIT 1;

DROP TABLE employee;

CREATE TABLE employee (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          first_name VARCHAR(30) NOT NULL,
                          last_name VARCHAR(30) NOT NULL
);

CREATE TABLE department (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            employee_id INT UNIQUE NOT NULL,
                            emp_department VARCHAR(30) NOT NULL,
                            dep_description VARCHAR(100) NOT NULL,
                            salary INT NOT NULL,
                            FOREIGN KEY (employee_id) REFERENCES employee(id)
);

CREATE TABLE address (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         employee_id INT UNIQUE NOT NULL,
                         street VARCHAR(30) NOT NULL,
                         localNumber VARCHAR(7) NOT NULL,
                         zip_code VARCHAR(8) NOT NULL,
                         city VARCHAR(25) NOT NULL,
                         FOREIGN KEY (employee_id) REFERENCES employee(id)
);

INSERT INTO department
(employee_id, emp_department, dep_description, salary)
VALUES
    (1, 'Cleaning', 'W brudzie nie da się pracować', 8000),
    (2, 'Management', 'bez Lidera to jak owce bez pasterza', 4000),
    (4, 'IT', 'Zaktualizuje Ci Acrobat Readera', 5500),
    (3, 'Accountant', 'Pozyskiwanie klientów', 2500);

INSERT INTO address
(employee_id, street, localNumber, zip_code, city)
VALUES
    (4, 'Warszawska', '4', '00-007', 'Warszawa'),
    (3, 'Wrocławska', '120/22', '30-500', 'Wrocław'),
    (2, 'Poznańska', '11b', '62-200', 'Poznań'),
    (1, 'Gdańska', '33/2', '11-100', 'Gdańsk');

INSERT INTO employee
(first_name, last_name)
VALUES
    ('Robert', 'De Niro'),
    ('Bogdan', 'Bogdalski'),
    ('Wacław', 'Wacławski'),
    ('Krzysztof', 'Krzysztofik');
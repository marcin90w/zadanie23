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
    ('test','test',1111,'test','2000-01-01'),
    ('Albert','Einstein',4500,'Sales','1879-03-14'),
    ('Marcin','Wajs',1000,'Accounter','1990-01-01');


SELECT * FROM employee ORDER BY last_name DESC;

SELECT * FROM employee WHERE emp_department = 'Cleaning';

SELECT * FROM employee WHERE (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) >= 30;

UPDATE employee SET salary = salary * 1.1 WHERE emp_department = 'Cleaning';

SELECT * FROM employee WHERE birth_date = (SELECT birth_date FROM employee ORDER BY birth_date DESC LIMIT 1);

DROP TABLE employee;


CREATE TABLE employee (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          first_name VARCHAR(30) NOT NULL,
                          last_name VARCHAR(30) NOT NULL,
                          department_id INT,
                          address_id INT,
                          FOREIGN KEY (department_id) REFERENCES department(id),
                          FOREIGN KEY (address_id) REFERENCES address(id)
);

CREATE TABLE department (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            emp_department VARCHAR(30) NOT NULL,
                            dep_description VARCHAR(100) NOT NULL,
                            salary INT NOT NULL
);

CREATE TABLE address (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         street VARCHAR(30) NOT NULL,
                         localNumber VARCHAR(7) NOT NULL,
                         zip_code VARCHAR(8) NOT NULL,
                         city VARCHAR(25) NOT NULL
);

INSERT INTO department
(emp_department, dep_description, salary)
VALUES
    ('Cleaning', 'W brudzie nie da się pracować', 8000),
    ('Management', 'bez Lidera to jak owce bez pasterza', 4000),
    ('IT', 'Zaktualizuje Ci Acrobat Readera', 5500),
    ('Accountant', 'Pozyskiwanie klientów', 2500);

INSERT INTO address
(street, localNumber, zip_code, city)
VALUES
    ('Warszawska', '4', '00-007', 'Warszawa'),
    ('Wrocławska', '120/22', '30-500', 'Wrocław'),
    ('Poznańska', '11b', '62-200', 'Poznań'),
    ('Gdańska', '33/2', '11-100', 'Gdańsk');

INSERT INTO employee
(first_name, last_name, department_id, address_id)
VALUES
    ('Robert', 'De Niro', 1, 1),
    ('Bogdan', 'Bogdalski', 2, 2),
    ('Wacław', 'Wacławski', 1, 3),
    ('Krzysztof', 'Krzysztofik', 3, 4),
    ('Aleksander', 'Aleksandrowicz', 4, 1);

SELECT
    employee.first_name, employee.last_name, address.street, address.localNumber, address.zip_code, address.city,
    department.emp_department, department.dep_description, department.salary
FROM
    employee
JOIN	address
ON		employee.address_id = address.id
JOIN	department
ON		employee.department_id = department.id;

SELECT SUM(t.salary) AS totalSalary
FROM (SELECT employee.id, department.salary
      FROM (employee JOIN department ON employee.department_id = department.id)) AS t;

SELECT t.first_name, t.last_name, t.street, t.localNumber, t.zip_code, t.city
FROM (
    SELECT employee.first_name, employee.last_name, address.street,
        address.localNumber, address.zip_code, address.city
    FROM employee
    JOIN address
    ON employee.address_id = address.id) AS t
WHERE zip_code = '11-100';
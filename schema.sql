DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS customer_list;



CREATE TABLE departments (
  dept_no VARCHAR NOT NULL,
  dept_name character varying(40) NOT NULL
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no character varying(20) NOT NULL,
  from_date DATE  NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE dept_manager (
  dept_no VARCHAR(10) NOT NULL,
  emp_no INT NOT NULL,
  from_date DATE NOT NULL,
  to_date Date NOT NULL
);

CREATE TABLE employees (
    emp_no integer NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date timestamp without time zone DEFAULT now() NOT NULL,
  to_date timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(50) NOT NULL,
  from_date timestamp without time zone DEFAULT now() NOT NULL,
  to_date timestamp without time zone DEFAULT now() NOT NULL
);

--List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT * FROM salaries;
SELECT * FROM employees;
select * FROM dept_emp;

SELECT E.emp_no, E.last_name,E.first_name,E.gender,S.salary 
FROM employees AS E
INNER JOIN salaries AS S ON
E.emp_no = S.emp_no;

--List employees who were hired in 1986.

SELECT * FROM employees
WHERE hire_date > '1986-01-01' AND hire_date < '1986-12-31' ;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT * FROM dept_manager;

SELECT M.dept_no,M.emp_no,M.from_date,M.to_date, E.first_name,E.last_name
FROM dept_manager AS M
INNER JOIN employees AS E ON
M.emp_no = E.emp_no;



SELECT emp_no, first_name,last_name FROM employees
WHERE emp_no IN
(SELECT dept_no FROM dept_manager);


SELECT emp_no,first_name,last_name FROM employees
WHERE emp_no IN
(
SELECT dept_no,from_date,to_date FROM dept_manager
WHERE dept_no IN
(SELECT dept_name FROM departments));

SELECT * FROM employees
WHERE emp_no IN
(SELECT emp_no 
 FROM dept_manager
WHERE dept_no IN
(SELECT dept_no
FROM departments));


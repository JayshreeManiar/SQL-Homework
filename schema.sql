DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS customer_list;



CREATE TABLE departments (
  dept_no VARCHAR NOT NULL AS PRIMARY KEY,
  dept_name VARCHAR NOT NULL
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no  VARCHAR NOT NULL,
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
    emp_no integer NOT NULL AS PRIMARY KEY,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

--List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT * FROM salaries;
SELECT * FROM employees;
select * FROM dept_emp;
SELECT * FROM departments;

SELECT E.emp_no, E.last_name,E.first_name,E.gender,S.salary 
FROM employees AS E
INNER JOIN salaries AS S ON
E.emp_no = S.emp_no;

--List employees who were hired in 1986.

SELECT * FROM employees
WHERE hire_date >='1986-01-01' AND hire_date <= '1986-12-31' ;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT * FROM dept_manager;
SELECT * FROM departments;
--(1)
SELECT M.dept_no,M.emp_no,M.from_date,M.to_date, Emp.first_name,Emp.last_name, Dep.dept_name
FROM dept_manager AS M
JOIN employees AS Emp 
	ON M.emp_no = Emp.emp_no
JOIN departments AS Dep
	ON M.dept_no= Dep.dept_no;
--(2)
SELECT * FROM employees
WHERE emp_no IN
(SELECT emp_no 
 FROM dept_manager
WHERE dept_no IN
(SELECT dept_no
FROM departments));

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT * FROM dept_emp;

SELECT M.emp_no, Emp.first_name,Emp.last_name, Dep.dept_name
FROM dept_emp AS M
JOIN employees AS Emp 
	ON M.emp_no = Emp.emp_no
JOIN departments AS Dep
	ON M.dept_no= Dep.dept_no;
	
--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name  = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT * FROM departments;

SELECT M.emp_no,M.last_name,M.first_name,D.dept_name
FROM dept_emp AS S
JOIN employees AS M
ON M.emp_no = S.emp_no
JOIN departments as D
ON S.dept_no = D.dept_no
WHERE dept_name = 'Sales';


--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT M.emp_no,M.last_name,M.first_name,D.dept_name
FROM dept_emp AS S
JOIN employees AS M
ON M.emp_no = S.emp_no
JOIN departments as D
ON S.dept_no = D.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT COUNT( DISTINCT last_name) AS "FREQUENCY COUNT OF EMPLOYEE LAST NAME " FROM employees;

SELECT DISTINCT COUNT(last_name) AS "Frequency" , last_name FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;

---------------------------------------------------------------------------------------------------------
--EPILOGUE

SELECT * FROM employees
WHERE emp_no = 499942;
---------------------------------------------------------------------------------------------------------

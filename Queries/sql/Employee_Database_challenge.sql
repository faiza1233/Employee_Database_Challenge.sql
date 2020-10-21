
-- Creating tables for PH-EmployeeD
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
CREATE TABLE employees (
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
 
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	PRIMARY KEY (dept_no,emp_no)
);
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no,title,from_date)
);
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_title
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
SELECT * FROM retirement_title;
-- Joining retirement_title and titles tables
SELECT retirement_title.emp_no,
    retirement_title.first_name,
retirement_title.last_name,
	titles.title,
    titles.from_date,
	titles.to_date
INTO new_table 
FROM retirement_title
LEFT JOIN titles
ON retirement_title.emp_no = titles.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title
INTO unique_title
FROM new_table
ORDER BY emp_no,title DESC;
select * from unique_title;

--making a new table "retiring_title"
SELECT title
INTO retiring_title
FROM unique_title

-- Employee count by title
SELECT COUNT (ce.title),ce.title
FROM retiring_title as ce
GROUP BY ce.title
ORDER BY ce.title;
            --Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT employees.emp_no,
employees.first_name,
employees.last_name,
employees.birth_date, 
dept_emp.from_date,
dept_emp.to_date,
titles.title
INTO new_table1
From employees
INNER JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no
INNER JOIN titles 
ON dept_emp.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
select * from new_table;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
INTO mentorship_eligibilty
FROM new_table1
ORDER BY emp_no,title DESC;
select * from mentorship_eligibilty;

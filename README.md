# Employee_Database_Challenge.sql

Purpose of this analysis

Pewlett-Hackard is a large company with thousands of employees and its have been around for a long time. Baby boomers started to retire at a rapid rate. Pewlett-Hackard is looking at the future two ways; first its offering retirement package for those who meet certain criteria. Second, it stated to think which positions can be filled in near future. Number of upcoming retirement will produce thousands of job openings. Bobby is an HR analysis, whose task is to do employee research and answer the following questions. Who will be retiring in the next few years ? How many positions Pewlett-Hackard will need to fill. his analysis will help the company find answers regarding retirement package.

Background

Pewlett-Hackard’s employee data is in csv form as previously the company have been using excel and VBA to work with the data. However, they did an upgrade to SQL. Now, using SQL we need to determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. Then, we’ll write a report that summarizes your analysis and helps prepare Bobby’s manager for the “silver tsunami” as many current employees reach retirement age.

Results

• Using the ERD we created in this module as a reference and our knowledge of SQL queries, created a Retirement Titles table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955.

-- Create new table for retiring employees

    SELECT emp_no, first_name, last_name

    INTO retirement_title

    FROM employees

    WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

    SELECT * FROM retirement_title;
• Because some employees may have multiple titles in the database—for example, due to promotions—we used the DISTINCT ON statement to create a table that contains the most recent title of each employee. Then, used the COUNT() function to create a final table that has the number of retirement-age employees by most recent job title.

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
     
• Also, created a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.

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
Summery

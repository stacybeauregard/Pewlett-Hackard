--Deliverable 1: The Number of Retiring Employees by Title

--Retrieve the emp_no, first_name, and last_name columns from the Employees table.

SELECT emp_no, first_name, last_name
FROM employees;

--Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM titles;

--Create a new table using the INTO clause.

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
--Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
--Create a Unique Titles table using the INTO clause.
--Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

--Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.

--First, retrieve the number of titles from the Unique Titles table.
--Then, create a Retiring Titles table to hold the required information.
--Group the table by title, then sort the count column in descending order.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles;

--DELIVERABLE 2: The Employees Eligible for the Mentorship Program

--Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.

SELECT emp_no, first_name, last_name, birth_date FROM employees AS e;
--Retrieve the from_date and to_date columns from the Department Employee table.

SELECT from_date, to_date FROM dept_emp AS de;
--Retrieve the title column from the Titles table.

SELECT title FROM titles AS t;
--Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
--Create a new table using the INTO clause.
--Join the Employees and the Department Employee tables on the primary key.
--Join the Employees and the Titles tables on the primary key.
--Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
--Order the table by the employee number.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_elig
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no) 
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE t.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_elig;

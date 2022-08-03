# Pewlett-Hackard

## Overview of the Analysis
### Explain the purpose of this analysis.
We've been asked to help prepare for the large number of Pewlett Hackard employees that are eligible to retire. We need to determine the number of employees that are retiring, per title, and find those that are eligible to mentor new employees. 

## Results
### Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.

* The first deliverable was to find all eligible employees (those born between 1952 and 1955) and identify them by their employee number and title. This first table, retirement_titles contains a very large listing of 133,776 employees. Unfortunately, this table contains duplicates as some employees have held more than one title during their career.

![retirementtitles](https://github.com/stacybeauregard/Pewlett-Hackard/blob/main/Resources/retirementtitles.png)

* The next table eliminates the duplicate employee listings by using the Distinct ON statement and retrieving only the first occurance of the emp_no within the retirement_titles table. This has reduced the eligible employee listing to 72,458.

![retiringtitles](https://github.com/stacybeauregard/Pewlett-Hackard/blob/main/Resources/retiringtitles.png)

You can see from this table that the majority of those retiring hold a Senior Engineer or Senior Staff title - 25916 and 24926 respectively. Surprisingly, out of all employees eligible only 2 are managers.

* Pewlett Hackard would like to know how many of their current employees would be eligible to join a mentorship program to help with all the new hires. This table narrows down the predefined eligibility as those born in the year 1965. This table shows that 1549 employees could be considered for the program.

![mentorship](https://github.com/stacybeauregard/Pewlett-Hackard/blob/main/Resources/mentorshipelig.png)

* The employees ready to retire far outpaces those that are to be considered for a mentorship role. 

## Summary
### Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

1. How many roles will need to be filled as the "silver tsunami" begins to make an impact?

 * There are 72,458 retiring employees.
  
  The query used to find this number -eliminating the duplicate rows- is as follows:
  
SELECT COUNT(ut.emp_no), ut.title

INTO retiring_titles

FROM unique_titles AS ut

GROUP BY ut.title

ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles;


2. Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

The query to find those eligible is as follows:

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

   1549 is not nearly enough potentially eligible mentors. Not all employees may be interested in mentoring-or really even qualified to do so. In a best case scenario it would still leave each mentor with 46 mentees! Pewlett Hackard should consider expanding their mentorship eligibility based upon hire date and not birth date. Limiting mentorship by age is not recommended as more experienced employees (though they may be quite younger), would be a great asset to the mentorship program.



-- Create Retirement Titles table
SELECT  e.emp_no,
        e.first_name,
        e.last_name,
        t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC;


-- Create Unique Titles table
SELECT DISTINCT ON (rt.emp_no)
	   rt.emp_no,
	   rt.first_name,
	   rt.last_name,
	   rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;


-- Create Retiring Titles table
SELECT COUNT(t.emp_no), t.title
INTO retiring_titles
FROM unique_titles as t
GROUP BY t.title
ORDER BY t.count DESC;


-- Create Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no)
		e.emp_no,
        e.first_name,
        e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dep_emp AS de
	ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	   AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 	    
ORDER BY e.emp_no ASC;
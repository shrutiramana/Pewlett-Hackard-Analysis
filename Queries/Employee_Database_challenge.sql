
--------------------------------------------------------------
-- # Deliverable 1 - The Number of Retiring Employees by Title
--------------------------------------------------------------

-- Get data for employee retiring with their title. - 133776 rows
SELECT E.EMP_NO,
	E.FIRST_NAME,
	E.LAST_NAME,
	T.TITLE,
	T.FROM_DATE,
	T.TO_DATE INTO RETIREMENT_TITLES
FROM EMPLOYEES AS E
INNER JOIN TITLES AS T ON E.EMP_NO = T.EMP_NO
WHERE E.BIRTH_DATE BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY E.EMP_NO;


-- Use Dictinct with Orderby to remove duplicate rows - 72458 rows

SELECT DISTINCT ON (EMP_NO) EMP_NO,
	FIRST_NAME,
	LAST_NAME,
	TITLE INTO UNIQUE_TITLES
FROM RETIREMENT_TITLES
WHERE TO_DATE = '9999-01-01'
ORDER BY EMP_NO ASC,
	TO_DATE DESC;

-- Counting the total titles for employees.

SELECT COUNT(TITLE),
	TITLE 
	--INTO RETIRING_TITLES
FROM UNIQUE_TITLES
GROUP BY TITLE
ORDER BY COUNT(TITLE) DESC;


-- # Deliverabe 2 The Employees Eligible for the Mentorship Program

SELECT DISTINCT ON (E.EMP_NO) E.EMP_NO,
	E.FIRST_NAME,
	E.LAST_NAME,
	E.BIRTH_DATE,
	DE.FROM_DATE,
	DE.TO_DATE,
	T.TITLE 
	INTO MENTORSHIP_ELIGIBILTY
FROM EMPLOYEES AS E
INNER JOIN DEPT_EMP AS DE ON E.EMP_NO = DE.EMP_NO
INNER JOIN TITLES AS T ON E.EMP_NO = T.EMP_NO
WHERE E.BIRTH_DATE BETWEEN '1965-01-01' AND '1965-12-31'
	AND DE.TO_DATE = ('9999-01-01')
ORDER BY E.EMP_NO;





--------------------------------------------------------------
-- Additional queries to show more insight in the data. ----
--------------------------------------------------------------
-- Get data for employee retiring and their departments .
SELECT E.EMP_NO,
	E.FIRST_NAME,
	E.LAST_NAME,
	D.DEPT_NAME,
	DE.to_date
	into dept_wise_retiring
FROM EMPLOYEES AS E
INNER JOIN DEPT_EMP AS DE ON E.EMP_NO = de.EMP_NO
inner join DEPARTMENTS as D on D.DEPT_NO = DE.DEPT_NO
WHERE E.BIRTH_DATE BETWEEN '1952-01-01' AND '1955-12-31'


-- getting unique rows for current employees who are retiring in each department.

SELECT DISTINCT ON (EMP_NO) EMP_NO,
	FIRST_NAME,
	LAST_NAME,
	DEPT_NAME INTO unique_dept_retiring
FROM DEPT_WISE_RETIRING
WHERE TO_DATE = '9999-01-01'
ORDER BY EMP_NO ASC,
	TO_DATE DESC;

-- count of retiring employees in each department
SELECT COUNT(DEPT_NAME),
	dept_name 
FROM UNIQUE_DEPT_RETIRING
GROUP BY dept_name
ORDER BY COUNT(dept_name) DESC;


SELECT DISTINCT ON (E.EMP_NO) E.EMP_NO,
	E.FIRST_NAME,
	E.LAST_NAME,
	E.BIRTH_DATE,
	DE.FROM_DATE,
	DE.TO_DATE,
	D.dEpt_name 	
FROM EMPLOYEES AS E
INNER JOIN DEPT_EMP AS DE ON E.EMP_NO = DE.EMP_NO
INNER JOIN departments AS d ON d.dept_no = de.dept_no
WHERE E.BIRTH_DATE BETWEEN '1965-01-01' AND '1965-12-31'
	AND DE.TO_DATE = ('9999-01-01')
ORDER BY E.EMP_NO;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name 
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name 
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name 
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';



-- Retirement eligibility
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT * FROM retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;
	
-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no;


-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;


--(emp_no, fname, lname - retirement info) - retirement_info table.
--(emp_no, dept_no, from_date, to_date) - dept_emp table

SELECT ri.emp_no, ri.first_name , ri.last_name , de.to_date
INTO current_emp
FROM retirement_info as ri 
LEFT JOIN dept_emp as de 
ON ri.emp_no = de.emp_no
WHERE de.to_date=('9999-01-01');


--Employee count by department number.

SELECT COUNT(ce.emp_no),de.dept_no
INTO emp_cnt_dept
FROM current_emp AS ce
LEFT JOIN dept_emp AS de 
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee information

SELECT e.emp_no , e.first_name,
	e.last_name,e.gender,s.salary
into emp_info
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no
inner join dept_emp as de
on (e.emp_no=de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')

AND (de.to_date = '9999-01-01');




-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- my attempt at the query for list of manager per department.

SELECT CE.EMP_NO,
	CE.LAST_NAME,
	CE.FIRST_NAME,
	CE.TO_DATE,
	D.DEPT_NO,
	D.DEPT_NAME,
	DM.FROM_DATE
FROM CURRENT_EMP AS CE
INNER JOIN DEPT_MANAGER AS DM ON (CE.EMP_NO = DM.EMP_NO)
INNER JOIN DEPARTMENTS AS D ON (D.DEPT_NO = DM.DEPT_NO);


-- skill drill Create a query that will return only the information relevant to the Sales team.
-- returns 41380 rows

SELECT RI.EMP_NO,
	RI.FIRST_NAME,
	RI.LAST_NAME,
	D.DEPT_NAME
FROM RETIREMENT_INFO AS RI
INNER JOIN DEPT_EMP AS DE ON RI.EMP_NO = De.EMP_NO
INNER JOIN departments AS D ON D.DEPT_NO = DE.DEPT_NO;


-- List of Sales employees
SELECT CE.EMP_NO,
	CE.FIRST_NAME,
	CE.LAST_NAME,
	D.DEPT_NAME
FROM CURRENT_EMP AS CE
INNER JOIN DEPT_EMP AS DE ON CE.EMP_NO = DE.EMP_NO
INNER JOIN DEPARTMENTS AS D ON DE.DEPT_NO = D.DEPT_NO
WHERE D.DEPT_NAME in ('Sales');

-- List of Sales & Development team employees
SELECT CE.EMP_NO,
	CE.FIRST_NAME,
	CE.LAST_NAME,
	D.DEPT_NAME
FROM CURRENT_EMP AS CE
INNER JOIN DEPT_EMP AS DE ON CE.EMP_NO = DE.EMP_NO
INNER JOIN DEPARTMENTS AS D ON DE.DEPT_NO = D.DEPT_NO
WHERE D.DEPT_NAME in ('Sales','Development')
ORDER BY CE.EMP_NO;


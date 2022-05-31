# Overview of the analysis:

At Pewlett-Packard many employees are approaching retirement age and it might result a good amount of Job openings in the company. Bobby has been given following tasks by his manager so that he can prepare an analysis for “Silver Tsunami” - 
    * 	To determine the number of retiring employees per title,
    * 	To identify employees who are eligible to participate in a mentorship program.
 ## Resources:
* PostgreSQL 13
* pgAdmin 4
* Csv files - 
    * employees.csv
    * Departments.csv
    * titles.csv
    * dep_emp.csv
    * Salaries.csv
    * Dept_managers.csv
The csv files are imported to create 6 different tables based on the ERD (entity-relationship diagram)
EmployeesDB.png. Based on this we establish relationship(primary & foreign key) between tables and build the PH-EmployeeDB for Pewlett-Packard. Below attached is the schema of the database.
schema.sql

# Analysis - 
Deliverable 1 - Determining The Number of Retiring Employees by Title.
This is achieved in 3 steps - getting retirement_titles.

	1) We create a new table “retirement_titles” containing employee details -  emp_no, first_name,last_name and title , to_date & from_date from titles table.Both the tables are joined using an INNER JOIN (getting all the records from the both employee & title tables for the emp_no in both.) where the birth_date is between the year (1952 and 1955). 
	2) “retirement_titles” contains duplicate records , with multiple entires for the employees with different titles that change over years. To get unique rows we use DISTINCT COUNT ON() employees  , for all those who are current employees (to_date = ‘9999-01-01’) into “unique_titles”.
	3) We get the count of retiring employees by titles, ordered by emp_no. 
<img width="718" alt="query1" src="https://user-images.githubusercontent.com/98556229/171276949-dc9cbe84-478f-4f20-8505-5d49fe4fd6f6.png">

<img width="608" alt="query2" src="https://user-images.githubusercontent.com/98556229/171276958-3df302b5-a24e-4e8b-a073-679583d5bc55.png">

<img width="313" alt="query3" src="https://user-images.githubusercontent.com/98556229/171276973-acbf8771-ed98-49e1-ba28-4ad02bcdbf93.png">

Deliverable #2 The Employees Eligible for the Mentorship Program - 
To create a “mentorship_eligibilty” table for “current employees” we join “employees”, “titles” & “dept_emp” tables based on the criteria of primary key(emp_no) and eligibility criteria of “birth_date” between(jan-dec 1965). 

<img width="798" alt="query4" src="https://user-images.githubusercontent.com/98556229/171276995-15ef8bc0-e811-4c7b-8133-11fd233da6b9.png">

Attachment : Employee_Database_challenge.sql

1. From query1.png - It shows that there we fetch about 133,776, with employees having multiple entires , having differnt titles - which they would have recieved over a period of time and also 1 entry which is with to_date = ‘9999-01-01’ i.e the current title. These records are for employees with date of birth between(1952-55)
2. Then when we query for the unique results from the above query we get 72,458 unique employees with unique titles that they currently have who are currently working. All the duplicate rows and who are not currently working are eliminated. These unique number of records give us the clearer picture of how many actual number of people will be ready for the retirement. 
3. When we do count on the titles group by title, the output that we see the total number of employees who will retiring in each category of the title. We see that there is about (35%+34%) of senior staff/senior engineers are getting retired i.e about 50,842 employees . 
4. Deliverable 2 shows that 1549 employees are currently eligible for mentorship. Like above here also around 65-70 % of senior staff /senior engineers are eligible for this program.

# Results: 
To prepare for the above analysis, the task can be divided into 2 sub


# Summary: 
Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

* If we do similar analysis for employees who are retiring as based on their department, we get below distinct values : Summary1.pngThe table gives us the no. of roles to be filled in each department.
<img width="532" alt="summar1" src="https://user-images.githubusercontent.com/98556229/171277034-65194167-0768-4b4f-9169-39a640bd92a8.png">


* If we make an analysis of eligible employees for mentorship based on the department we see , that the number remains the same who are retirement-ready employees to mentor the next generation of Pewlett Hackard employees. 
* 
<img width="314" alt="summary2" src="https://user-images.githubusercontent.com/98556229/171277050-ba7a69c0-262c-47aa-9415-7ddf79d6f8f2.png">

<img width="831" alt="summary3" src="https://user-images.githubusercontent.com/98556229/171277075-ce31b183-ff02-41e9-9121-b9726cdf9f23.png">



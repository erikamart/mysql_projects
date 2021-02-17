# Database Design and Normalization
### **Objectives:**  
- Identify data elements to include in a database 
- Identify tables and assign columns
- Identify primary and foreign keys
- Normalize a data structure
- Work with Entity Relationship models and diagrams

### **Read Chapter 10 in the book and Do Exercise 9**  
<br>  
<br>  

### **Database Design**
Steps for Designing a Data Structure:
1. Identify the data elements
    - List the information you need to accomplish the task
    - Interview users, analyze existing systems, review documents, reports and forms 
    - Associate elements with entities (a person, place or thing)
2. Subdivide elements into smallest useful form 
   - Break entities down into components
    - Examples: name into first and last name, address into street, city, state and zip 
3. Identify tables and assign columns
    - Group data elements by entities
    - If an element relates to more than one entity, include in all
    - Add and remove elements as appropriate according to the entities 
    - Data elements will become columns in the database
4. Identify primary keys
    - Each entity must have one or more data elements that uniquely identifies each row 
    - Primary key values should never change
    - If a suitable element does not exist, create an ID column to uniquely identify it
    - The book talks about foreign keys at this point, but it's best to include this in the normalization process.
5. Normalize the data
    - More on this below
6. Identify indexes
    - Used frequently in searches or joins and... 
    - Contain a large number of distinct values and...
    - Updated infrequently
 
<br>

**Data Normalization**  
- Process to separate data into tables in a manner that reduces redundancy, eliminates errors and minimizes maintenance
- **First Normal Form:** remove repeating groups
  - Move related fields that have more than one value to a new table.
  - Determine the primary key for the new table.
  - Each column must a contain a single value and the table must not contain repeating values to be in first normal form.
- **Second Normal Form:** eliminate redundancy and update anomalies:
  - applies to tables that have a composite or compound primary key.
  - Move fields that are dependent on only a portion of the primary key to a new table 
  - Identify the primary key to the new table
  - Identify a foreign key to relate the 2 tables
- **Third Normal Form:** remove fields that are dependent on a non­key attribute 
  - Move related fields that are in more than one record to a new table 
  - Add a primary key to the new table  
<br>

### **Normalization Example**  

**Sample Problem**  
A database at a college must support the following requirements: Start by identifying the fields and functional dependencies.  
1. For a department, store it's name and number  
We have identified 2 fields: `DEPT_NAME` and `DEPT_NUM`. We also know that there is a **functional dependency** between these 2 fields and the `DEPT_NAME` depends on `DEPT_NUM` or `DEPT_NUM =>DEPT_NAME`.
2. For an advisor, store his or her number, last name, first name, and the department number to which the advisor is assigned:  
**Fields:** `ADVISOR_NUM`, `ADVISOR_FIRSTNAME`, `ADVISOR_LASTNAME`.  
**Functional Dependencies:** `ADVISOR_NUM =>ADVISOR_LASTNAME`, `ADVISOR_FIRSTNAME`, `DEPT_NUM`
3. For a course, store its code and description:
**Fields:** `COURSE_CODE`, `COURSE_DESC`  
**Functional Dependencies:** `COURSE_CODE=>COURSE_DESC`
4. For a student, store his or her number, first name and last name. For each course the student
takes, store the course code, the course description, and the grade earned. Also store the number and name of the student's advisor. Assume a student can only have 1 advisor, but an advisor can have multiple students.  
**Fields:** `STUDENT_NUM`, `STUDENT_FIRSTNAME`, `STUDENT_LASTNAME`, `GRADE`  
**Functional Dependencies:** `STUDENT_NUM=>STUDENT_FIRSTNAME`, `STUDENT_LASTNAME`, `ADVISOR_NUM
STUDENT_NUM`, `COURSE_CODE=>GRADE`  
The functional dependencies on `STUDENT_NUM` are pretty obvious. The second one, however, is a little trickier. The grade depends on the student as well as the course, so it requires a compound key.  

Now we can start identifying our tables. It looks like we have four main entities we are dealing with: **`DEPARTMENT`**, **`ADVISOR`**,**`COURSE`** and **`STUDENT`**.  

**TABLES:**  
**`DEPARTMENT`** (`DEPT_NUM`, `DEPT_NAME`)  
**`ADVISOR`** (`ADVISOR_NUM`, `ADVISOR_FIRSTNAME`, `ADVISOR_LASTNAME`, `DEPT_NUM`)  
**`COURSE`** (`COURSE_CODE`, `COURSE_DESC`)  
**`STUDENT`** (`STUDENT_NUM`, `STUDENT_FIRSTNAME`, `STUDENT_LASTNAME`, `ADVISOR_NUM`, `ADVISOR_FIRSTNAME`, `ADVISOR_LASTNAME`, (`COURSE_CODE`, `COURSE_DESC`, `GRADE`))  

This is our first take on the tables, based on the requirements and is not normalized. So now, we need to go through the normalization process:  

**First Normal Form (1NF):** Remove repeating groups to a new table and identify the primary key. The **`STUDENT`** table has a repeating group, so we need to remove it to a separate table. The key for the new table will be a compound key consisting of `STUDENT_NUM` and `COURSE_CODE` which we know from our functional dependencies. So now we have:  
**`STUDENT`** (`STUDENT_NUM`, `STUDENT_FIRSTNAME`, `STUDENT_LASTNAME`, `ADVISOR_NUM`, `ADVISOR_FIRSTNAME`, `ADVISOR_LASTNAME`)  
**`STUDENT_COURSE`** (`STUDENT_NUM`, `COURSE_CODE`, `COURSE_DESC`, `GRADE`)  

**Second Normal Form (2NF):** Move fields that are dependent on only a portion of the primary key to a new table.  
In the **`STUDENT_COURSE`** table, `COURSE_DESC` is dependent on `COURSE_CODE`, but not `STUDENT_NUM`. Since we already have a **`COURSE`** table, we can simply remove `COURSE_DESC` from the **`STUDENT_COURSE`** table:  
**`STUDENT_COURSE`** (`STUDENT_NUM`, `COURSE_CODE`, `GRADE`)  

**Third Normal Form (3NF):** Remove fields that are dependent on a non­key attribute.  
In the **`STUDENT`** table, we have `ADVISOR_FIRSTNAME` and `ADVISOR_LASTNAME` which are dependent on `ADVISOR_NUM` which is a non­key field. Once again, we have already identified an **`ADVISOR`** table, so all we have to do here is remove the redundant information from the **`STUDENT`** table.  
**`STUDENT`** (`STUDENT_NUM`, `STUDENT_FIRSTNAME`, `STUDENT_LASTNAME`, `ADVISOR_NUM`)  

Our final database tables are:  
**`DEPARTMENT`** (`DEPT_NUM`, `DEPT_NAME`)  
**`ADVISOR`** (`ADVISOR_NUM`, `ADVISOR_FIRSTNAME`, `ADVISOR_LASTNAME`, `DEPT_NUM`)  
**`COURSE`** (`COURSE_CODE`, `COURSE_DESC`)  
**`STUDENT_COURSE`** (`STUDENT_NUM`, `COURSE_CODE`, `GRADE`)  
**`STUDENT`** (`STUDENT_NUM`, `STUDENT_FIRSTNAME`, `STUDENT_LASTNAME`, `ADVISOR_NUM`)  

We have now designed and normalized a database.

<br>  
<br>
<br>
<hr> 

# Exercise 9 Instructions

### **Objective:**
- Select a real world application that would require a database.
- Identify the entities and data fields that would be required by the application.
- Normalize your data fields into relational database tables.
- Identify primary and foreign keys.  

### **Requirements:**
- Identify a real world application that would require a database. This could be a business, an organization or a specific area within a business or organization (i.e. human resources, payables and receivables, etc.) - Identify 3 major entities involved in the application. For example, if you were doing a college scheduling application, the entities would be students, classes and instructors.
- For each entity, identify the information about the entities (data fields) that would be needed. You should have about 8-15 fields for each entity.
- Using the identified entities and data fields, go through the data normalization process to identify the tables that would be needed for a relational database.
- Assign valid SQL fieldnames to each field.
- Identify a primary key for each table.
- Identify the foreign keys that would be needed.
- Use the data modeling utilities in the workbench to create a new EER diagram for your database or if you are using a different SQL interface you may attach a text file of your diagram.  

Refer to my college football database files as an example of using the instructions above.
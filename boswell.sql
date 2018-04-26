-- a PL/SQL procedure that performs the following tasks in order to insert a record into the Trip table.

-- The procedure accepts values for Emp_ID, To_City, Dep_Date, Return_Date, and Est_Cost attributes.
SET serveroutput on

ACCEPT emp_id NUMBER PROMPT "Enter the employee ID:   ";
ACCEPT to_city CHAR PROMPT "Enter the destination city:   ";
ACCEPT dep_date DATE PROMPT "Enter the departure date (DD-MMM-YY format):   ";
ACCEPT return_date DATE PROMPT "Enter the return date (DD-MMM-YY format):   ";
ACCEPT est_cost BINARY_DOUBLE PROMPT "Enter the estimated cost for the trip:   ";

DECLARE
    var_emp_id Trip.Emp_ID%type;
    num_records NUMBER;
    new_id Trip.ID%type;
    old_id Trip.ID%type;
    

    -- It then checks to see if the Emp_ID value is valid (i.e., the value exists in the Employee table).  
    -- If not, the procedure prints an appropriate message and quits.

    -- It checks to ensure the return date is not before the departure date.  Else, it prints an appropriate message and quits.

    -- It checks to ensure the estimated cost is within the acceptable range (see the constraint on schema).  
    -- Else, it quits after printing an appropriate message.
BEGIN
    SELECT count(ID) INTO num_records FROM Employee WHERE ID = &emp_id;
    IF num_records = 0 THEN
        dbms_output.put_line('ERROR: That employee ID does not exist');
        dbms_output.put_line('Aborting procedure...');
    ELSE 
        IF '&return_date' < '&dep_date' THEN
            dbms_output.put_line('ERROR: Return date cannot be before the departure date!');
            dbms_output.put_line('Aborting procedure...');
            RETURN;
        ELSE
            IF &est_cost >= 1 AND &est_cost <= 4000 THEN
                SELECT MAX(ID) INTO old_id FROM Trip;
                new_id := old_id + 1;
                INSERT INTO Trip VALUES (new_id, &emp_id, '&to_city', '&dep_date', '&return_date', &est_cost);
                dbms_output.put_line('Successfully inserted record!');
            ELSE
                dbms_output.put_line('ERROR: Estimated cost must be less than 4,000.00 and greater than 1.00');
                dbms_output.put_line('Aborting procedure...');
                RETURN;
            END IF;
        END IF;
    END IF;
END;
/


!cat boswell.sql
SELECT * FROM Trip WHERE ID > 25;
@boswell.sql
100
Fayetteville
20-APR-18
21-APR-18
250
@boswell.sql
5
Fayetteville
21-APR-18
20-APR-18
250
@boswell.sql
5
Fayetteville
20-APR-18
21-APR-18
25000
SELECT * FROM Trip WHERE ID > 25;
@boswell.sql
5
Fayetteville
20-APR-18
21-APR-18
250
SELECT * FROM Trip WHERE ID > 25;
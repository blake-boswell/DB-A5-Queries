-- a PL/SQL procedure that performs the following tasks in order to insert a record into the Trip table.

-- The procedure accepts values for Emp_ID, To_City, Dep_Date, Return_Date, and Est_Cost attributes.
ACCEPT emp_id PROMPT "Enter the employee ID";
ACCEPT to_city PROMPT "Enter the destination city";
ACCEPT dep_date PROMPT "Enter the departure date";
ACCEPT return_date PROMPT "Enter the return date";
ACCEPT est_cost PROMPT "Enter the estimated cost fro the trip";

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
        dbms_output.put_line('[BAD job] That employee ID does not exist');
    ELSE 
        dbms_output.put_line('[Good job] Success! That Employee ID already existed, good job master Boswell!');
        IF TO_DATE(&return_date, 'Dd Mon YYYY') < TO_DATE(&dep_date, 'Dd Mon YYYY') THEN
            dbms_output.put_line('[BAD job] Return date cannot be before the departure date! Our time travelling machine is broken!');
        ELSE
            dbms_output.put_line('[Good job] Return date is after the departure date!');
            IF &est_cost >= 1 AND &est_cost <= 4000 THEN
                dbms_output.put_line('[Good job] Estimated cost is within the range!');
                SELECT MAX(ID) INTO old_id FROM Trip;
                new_id := old_id + 1;
                INSERT INTO Trip VALUES (new_id, &emp_id, &to_city, &dep_date, &return_date, &est_cost);
                dbms_output.put_line('Successfully inserted record!');
            ELSE
                dbms_output.put_line('[BAD job] Estimated cost is NOT within the range!');
            END IF;
        END IF;
    END IF;
END;
/
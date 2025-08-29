CREATE OR REPLACE PACKAGE BODY emp_dept_pkg AS

    -- Department procedures
    PROCEDURE create_department(p_dept_id   IN DEPARTMENT.DEPT_ID%TYPE,
                                p_dept_name IN DEPARTMENT.DEPT_NAME%TYPE,
                                p_location  IN DEPARTMENT.LOCATION%TYPE) IS
    BEGIN
        INSERT INTO DEPARTMENT (DEPT_ID, DEPT_NAME, LOCATION)
        VALUES (p_dept_id, p_dept_name, p_location);
        DBMS_OUTPUT.PUT_LINE('Department created successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Department ID already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in create_department: ' || SQLERRM);
    END;

    PROCEDURE update_department(p_dept_id   IN DEPARTMENT.DEPT_ID%TYPE,
                                p_dept_name IN DEPARTMENT.DEPT_NAME%TYPE,
                                p_location  IN DEPARTMENT.LOCATION%TYPE) IS
    BEGIN
        UPDATE DEPARTMENT
        SET DEPT_NAME = p_dept_name,
            LOCATION  = p_location
        WHERE DEPT_ID = p_dept_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No department found with ID ' || p_dept_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Department updated successfully.');
        END IF;
    END;

    PROCEDURE delete_department(p_dept_id IN DEPARTMENT.DEPT_ID%TYPE) IS
    BEGIN
        DELETE FROM DEPARTMENT WHERE DEPT_ID = p_dept_id;
        DBMS_OUTPUT.PUT_LINE('Department deleted successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in delete_department: ' || SQLERRM);
    END;

    PROCEDURE list_departments IS
    BEGIN
        FOR rec IN (SELECT * FROM DEPARTMENT ORDER BY DEPT_ID) LOOP
            DBMS_OUTPUT.PUT_LINE(rec.dept_id || ' - ' || rec.dept_name || ' (' || rec.location || ')');
        END LOOP;
    END;

    -- Employee procedures
    PROCEDURE create_employee(p_emp_id    IN EMPLOYEE.EMP_ID%TYPE,
                              p_emp_name  IN EMPLOYEE.EMP_NAME%TYPE,
                              p_job_title IN EMPLOYEE.JOB_TITLE%TYPE,
                              p_salary    IN EMPLOYEE.SALARY%TYPE,
                              p_dept_id   IN EMPLOYEE.DEPT_ID%TYPE) IS
    BEGIN
        INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, JOB_TITLE, SALARY, DEPT_ID)
        VALUES (p_emp_id, p_emp_name, p_job_title, p_salary, p_dept_id);
        DBMS_OUTPUT.PUT_LINE('Employee created successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Employee ID already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in create_employee: ' || SQLERRM);
    END;

    PROCEDURE update_employee_dept(p_emp_id  IN EMPLOYEE.EMP_ID%TYPE,
                                   p_dept_id IN EMPLOYEE.DEPT_ID%TYPE) IS
    BEGIN
        UPDATE EMPLOYEE
        SET DEPT_ID = p_dept_id
        WHERE EMP_ID = p_emp_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || p_emp_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Employee department updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in update_employee_dept: ' || SQLERRM);
    END;

    PROCEDURE update_employee_salary(p_emp_id IN EMPLOYEE.EMP_ID%TYPE,
                                     p_salary IN EMPLOYEE.SALARY%TYPE) IS
    BEGIN
        UPDATE EMPLOYEE
        SET SALARY = p_salary
        WHERE EMP_ID = p_emp_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || p_emp_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Employee salary updated successfully.');
        END IF;
    END;

    PROCEDURE delete_employee(p_emp_id IN EMPLOYEE.EMP_ID%TYPE) IS
    BEGIN
        DELETE FROM EMPLOYEE WHERE EMP_ID = p_emp_id;
        DBMS_OUTPUT.PUT_LINE('Employee deleted successfully.');
    END;

    PROCEDURE list_employees(p_dept_id IN EMPLOYEE.DEPT_ID%TYPE DEFAULT NULL) IS
    BEGIN
        FOR rec IN (SELECT * FROM EMPLOYEE 
                    WHERE p_dept_id IS NULL OR dept_id = p_dept_id
                    ORDER BY EMP_ID) LOOP
            DBMS_OUTPUT.PUT_LINE(rec.emp_id || ' - ' || rec.emp_name || 
                                 ' (' || rec.job_title || ' - ' || rec.salary || ') Dept: ' || rec.dept_id);
        END LOOP;
    END;

END emp_dept_pkg;
/

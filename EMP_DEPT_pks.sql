CREATE OR REPLACE PACKAGE emp_dept_pkg AS
    -- Department operations
    PROCEDURE create_department(p_user_id   IN NUMBER,
                                p_dept_id   IN DEPARTMENT.DEPT_ID%TYPE,
                                p_dept_name IN DEPARTMENT.DEPT_NAME%TYPE,
                                p_location  IN DEPARTMENT.LOCATION%TYPE);

    PROCEDURE update_department(p_user_id   IN NUMBER,
                                p_dept_id   IN DEPARTMENT.DEPT_ID%TYPE,
                                p_dept_name IN DEPARTMENT.DEPT_NAME%TYPE,
                                p_location  IN DEPARTMENT.LOCATION%TYPE);

    PROCEDURE delete_department(p_user_id IN NUMBER,
                                p_dept_id IN DEPARTMENT.DEPT_ID%TYPE);

    PROCEDURE list_departments;

    -- Employee operations
    PROCEDURE create_employee(p_user_id   IN NUMBER,
                              p_emp_id    IN EMPLOYEE.EMP_ID%TYPE,
                              p_emp_name  IN EMPLOYEE.EMP_NAME%TYPE,
                              p_job_title IN EMPLOYEE.JOB_TITLE%TYPE,
                              p_salary    IN EMPLOYEE.SALARY%TYPE,
                              p_dept_id   IN EMPLOYEE.DEPT_ID%TYPE);

    PROCEDURE update_employee_dept(p_user_id IN NUMBER,
                                   p_emp_id  IN EMPLOYEE.EMP_ID%TYPE,
                                   p_dept_id IN EMPLOYEE.DEPT_ID%TYPE);

    PROCEDURE update_employee_salary(p_user_id IN NUMBER,
                                     p_emp_id  IN EMPLOYEE.EMP_ID%TYPE,
                                     p_salary  IN EMPLOYEE.SALARY%TYPE);

    PROCEDURE delete_employee(p_user_id IN NUMBER,
                              p_emp_id  IN EMPLOYEE.EMP_ID%TYPE);

    PROCEDURE list_employees(p_dept_id IN EMPLOYEE.DEPT_ID%TYPE DEFAULT NULL);
END emp_dept_pkg;
/

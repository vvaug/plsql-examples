TYPE my_rec IS RECORD 
  (emp_id HR.EMPLOYEES.EMPLOYEE_ID%TYPE, 
   emp_fname HR.EMPLOYEES.FIRST_NAME%TYPE, 
   emp_lname HR.EMPLOYEES.LAST_NAME%TYPE, 
   emp_job HR.EMPLOYEES.JOB_ID%TYPE, 
   emp_sal HR.EMPLOYEES.SALARY%TYPE, 
   emp_date HR.EMPLOYEES.HIRE_DATE%TYPE); 
 
   rec my_rec; 
 
   TYPE array IS TABLE OF my_rec; 
   my_array array := array(); 
 
   FUNCTION construct (emp_id HR.EMPLOYEES.EMPLOYEE_ID%TYPE,    --function that receive the data and construct the record type.
                       emp_fname HR.EMPLOYEES.FIRST_NAME%TYPE, 
                       emp_lname HR.EMPLOYEES.LAST_NAME%TYPE, 
                       emp_job HR.EMPLOYEES.JOB_ID%TYPE, 
                       emp_sal HR.EMPLOYEES.SALARY%TYPE, 
                       emp_date HR.EMPLOYEES.HIRE_DATE%TYPE) RETURN my_rec 
    IS 
        c my_rec; 
 
    BEGIN 
 
        c.emp_id := emp_id; 
        c.emp_fname := emp_fname; 
        c.emp_lname := emp_lname; 
        c.emp_job := emp_job; 
        c.emp_sal := emp_sal; 
        c.emp_date := emp_date; 
 
        RETURN c; 
     
    END construct; 
 
BEGIN 
 
    my_array.EXTEND(10); 
 
    my_array(1) := construct(1, 'Victor', 'Augusto', 'IT_DEV_JR', 2293, to_date('15/08/2018', 'DD/MM/YYYY')); --calling constructor
    my_array(2) := construct(2, 'Helder', 'Boldrim', 'IT_DEV_JR', 2293, to_date('15/08/2018', 'DD/MM/YYYY')); 
    my_array(3) := construct(3, 'Wagner', 'Marcuci', 'IT_SYS_SR', 7000, to_date('01/04/2018', 'DD/MM/YYYY')); 
    my_array(4) := construct(4, 'Paulo', 'Avila', 'IT_SYS_PL', 5000, to_date('10/01/2013', 'DD/MM/YYYY')); 
    my_array(5) := construct(5, 'Tiago', 'Souza', 'IT_BI_PL', 5000, to_date('08/06/2001', 'DD/MM/YYYY')); 
    my_array(6) := construct(6, 'Vitor', 'Lazari', 'IT_SYS_SR',  7000, to_date('01/02/2000', 'DD/MM/YYYY')); 
    my_array(7) := construct(7, 'Eduardo', 'Carnaval', 'IT_BI_MGR', 12000, to_date('02/06/1999', 'DD/MM/YYYY')); 
    my_array(8) := construct(8, 'Fabio', 'Chinaglia', 'IT_MGR', 13000, to_date('05/08/2014', 'DD/MM/YYYY')); 
    my_array(9) := construct(9, 'Igor', 'Beckman', 'IT_MGR', 13000, to_date('19/03/2002', 'DD/MM/YYYY')); 
    my_array(10) := construct(10, 'Tiago', 'Scomparim', 'IT_COORD', 9000, to_date('13/10/2005', 'DD/MM/YYYY')); 
 
     
    FOR i IN my_array.FIRST..my_array.LAST LOOP     --showing results
 
      DBMS_OUTPUT.PUT_LINE('Emp id: '||my_array(i).emp_id|| 
                         ' Name: '||my_array(i).emp_fname|| 
                         ' '||my_array(i).emp_lname|| 
                         ' Job: '||my_array(i).emp_job|| 
                         ' Salary: '||my_array(i).emp_sal|| 
                         ' Hire date: '||my_array(i).emp_date); 
    END LOOP; 
 
END;
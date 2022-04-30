Set Serveroutput on;
--------------------------------------------------------------------------------------------------------------------------------------------
--------------creating a procedure to update and know the status of vaccination of each patient---------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE STATUS_INFO 
IS
    date_of_vacc    DATE;
    inocc_by_days   NUMBER;
    result_         DATE; 
    sys_date        DATE;
    CURSOR curr_status_update IS SELECT date_of_vaccination, inoculated_by_days, status FROM VACCINE v JOIN VACCINE_RECORDS vr ON vr.vaccine_id = v.vaccine_id;
BEGIN
    select CURRENT_DATE into sys_date from dual;
    FOR i IN curr_status_update
    LOOP
        result_ := i.inoculated_by_days + i.date_of_vaccination;
----------------------------if the patient vaccination due date is past then it will show STATUS as active----------------------------------
        UPDATE VACCINE_RECORDS SET status = 'Active'  where date_of_vaccination<SYSDATE- i.inoculated_by_days;
----------------------------if the patient vaccination due date is not near then it will show STATUS as inactive----------------------------
        UPDATE VACCINE_RECORDS SET status = 'InActive'  where date_of_vaccination>SYSDATE- i.inoculated_by_days;
    END LOOP;
    
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No such patient_id found!');
END;
/
-------------------------------------------------------------------------------------------------------------------------------------------
------------calling the procedure----------------------------------------------------------------------------------------------------------
  BEGIN
    STATUS_INFO;
END;
/
---------------------------------------------------------------------------------------------------------------------------------------------
------------dispalying the tables------------------------------------------------------------------------------------------------------------
select * from vaccine_records;

---------------------------------------------------------------------------------------------------------------------------------------------



--------------creating a procedure to update and know the status of vaccination of each patient----------------------------------------------

CREATE OR REPLACE PROCEDURE premium_info 
IS
    sys_date        DATE;
    
    CURSOR curr_premium_info IS SELECT premium_due_date FROM INSURANCE_POLICY p JOIN patient_policy pp on pp.policy_id= p.policy_id;
BEGIN
    FOR i IN curr_premium_info
    LOOP 
----------------------------if the patient vaccination due date is past then it will show STATUS as active-------------------------------------
        UPDATE INSURANCE_POLICY SET status1 = 'Active'  where premium_due_date > SYSDATE;
----------------------------if the patient vaccination due date is not near then it will show STATUS as inactive-------------------------------
        UPDATE INSURANCE_POLICY SET status1 = 'InActive'  where premium_due_date < SYSDATE;
    END LOOP;
    
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No such patient_id found!');
END;
/
-----------------------------------------------------------------------------------------------------------------------------------------------
------------calling the procedure--------------------------------------------------------------------------------------------------------------
BEGIN
    premium_info;
END;
/
-----------------------------------------------------------------------------------------------------------------------------------------------
------------dispalying the tables--------------------------------------------------------------------------------------------------------------
select * from INSURANCE_POLICY;

---------------------------------------------------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

create or replace function payment_info (bn in number)
return number
is 
    paymnt number := 0;
    patientID number :=0;
begin
    select patient_id into patientID from Patient_Policy where policy_id =(select policy_id from Premium_Payments where receipt_no = (select receipt_no from Receipt where bill_no=bn));
    select premium into paymnt from Coverage where coverage_id = (select coverage_id from Insurance_Plan where plan_id =(select plan_id from Insurance_Policy where policy_id =(select policy_id from Premium_Payments where receipt_no = (select receipt_no from Receipt where bill_no=bn))));
    DBMS_OUTPUT.PUT_LINE('Patient ID :'|| patientID);
    DBMS_OUTPUT.PUT_LINE('Premium :'|| paymnt);
    return paymnt;
exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('no such bill number found!');
    when others then
        DBMS_OUTPUT.PUT_LINE('error!! try again!');     
end;
/


declare 
    b_no number;
    premium number;
    patientID number;
    amt number;
begin 
    DBMS_OUTPUT.PUT_LINE('Please enter the bill number');
    b_no:= &b_no;
    DBMS_OUTPUT.PUT_LINE('Bill number :' || b_no);
    select amount into amt from Billing where bill_no=b_no;
    premium := payment_info(b_no);
    If premium >= amt then
        DBMS_OUTPUT.PUT_LINE('Insurance is covered.');
        DBMS_OUTPUT.PUT_LINE('Balance amount in Insurance : '|| (premium - amt));
    Else
        DBMS_OUTPUT.PUT_LINE('Insurance premium does not cover your bill amount.');
        DBMS_OUTPUT.PUT_LINE('Balance amount to be paid : '|| (amt - premium));
    End if;
exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE(' no such bill number found!');
    when others then
        DBMS_OUTPUT.PUT_LINE('error!! try again!');
end;
/


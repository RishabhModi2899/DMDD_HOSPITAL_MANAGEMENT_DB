Set Serveroutput on
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


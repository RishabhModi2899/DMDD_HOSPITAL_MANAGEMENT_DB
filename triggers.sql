set serveroutput on;
------------------------- Creating triggers --------------------------
-- Trigger to populate the billing table when an appointment is booked
CREATE OR REPLACE TRIGGER OnAppointmentBooking
AFTER INSERT ON APPOINTMENTS
DECLARE
app_id NUMBER; -- To store the appointmentId of the patient
file_id_var NUMBER; -- To store the file ID of the patient from the PatientHistory
patient_id_var NUMBER; -- We get this from the PatientDocument
policy_id_var NUMBER; -- To get the plan_id
plan_id_var NUMBER; -- To get plan_id from the Policy table
cov_id_var NUMBER; -- To get the coverage id from INsurancePLan
plan_name_var VARCHAR2(30); -- plan_name
treatment_var VARCHAR2(30);
initial_bill NUMBER;
final_amount NUMBER; -- final result
BEGIN
SELECT APPOINTMENT_ID, FILE_ID INTO app_id, file_id_var FROM APPOINTMENTS ORDER BY APPOINTMENT_ID DESC FETCH FIRST 1 ROWS ONLY;
dbms_output.put_line(app_id);
SELECT PATIENT_ID INTO PATIENT_ID_VAR FROM patient_document WHERE FILE_ID = file_id_var;
dbms_output.put_line(file_id_var);
SELECT POLICY_ID INTO policy_id_var from patient_policy where PATIENT_ID = patient_id_var;
dbms_output.put_line(policy_id_var);
SELECT PLAN_ID INTO plan_id_var FROM insurance_policy where policy_id = policy_id_var;
dbms_output.put_line(plan_id_var);
SELECT COVERAGE_ID INTO cov_id_var FROM insurance_plan where plan_id = plan_id_var;
dbms_output.put_line(cov_id_var);
SELECT PLAN_NAME into plan_name_var FROM coverage where coverage_id = cov_id_var;
dbms_output.put_line(plan_name_var);
SELECT TREATMENT INTO treatment_var FROM patient_history WHERE file_id = file_id_var;
dbms_output.put_line(treatment_var);

IF treatment_var = 'MEDICINE' THEN
initial_bill := 1000;
ELSIF treatment_var = 'XRAY' THEN
initial_bill := 1500;
ELSIF treatment_var = 'ECG' THEN
initial_bill := 2000;
ELSIF treatment_var = 'MRI' THEN
initial_bill := 3000;
ELSIF treatment_var = 'BLOOD TEST' THEN
initial_bill := 100;
ELSIF treatment_var = 'ORTHO' THEN
initial_bill := 2500;
ELSIF treatment_var = 'EYE CHECKUP' THEN
initial_bill := 1200;
ELSE
initial_bill := 500;
END IF;

IF plan_name_var = 'Gold' THEN
final_amount := (initial_bill - (0.50 * (initial_bill)));
DBMS_OUTPUT.put_line('final amt ' || final_amount);
ELSIF plan_name_var = 'Silver' THEN
final_amount := (initial_bill - (0.40 * (initial_bill)));
DBMS_OUTPUT.put_line('final amt ' || final_amount);
ELSIF plan_name_var = 'Platinum' THEN
final_amount := (initial_bill - (0.60 * (initial_bill)));
DBMS_OUTPUT.put_line('final amt ' || final_amount);
ELSIF plan_name_var = 'Diamond' THEN
final_amount := (initial_bill - (0.70 * (initial_bill)));
DBMS_OUTPUT.put_line('final amt ' || final_amount);
ELSE
dbms_output.put_line('This plan does not exists!!');
END IF;

INSERT INTO BILLING (amount, appointment_id) values (final_amount, app_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
        DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
        DBMS_OUTPUT.put_line('Some error occurred. Please contact db admin');
END;
/

---------------------------------- procedure for premium payements ----------------------------------
create or replace procedure PAYPREMIUM(policy_id_var number) is
rec_var NUMBER;
begin
insert into receipt(date_of_payment) values(sysdate);
SELECT receipt_no INTO rec_var FROM receipt ORDER BY receipt_no DESC FETCH FIRST 1 ROWS ONLY;
DBMS_OUTPUT.PUT_LINE(rec_var);
INSERT INTO premium_payments(policy_id, receipt_no) values(policy_id_var, rec_var);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
        DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
        DBMS_OUTPUT.put_line('Some error occurred. Please contact db admin');
end;
/



-------------------------------- Trigger for updating next premium payment date ---------------
create or replace trigger UPDATENEXTPPDATE
AFTER INSERT ON premium_payments
declare
policy_id_var NUMBER;
begin
DBMS_OUTPUT.PUT_LINE('trigger called');
SELECT policy_id INTO policy_id_var FROM premium_payments ORDER BY PREMIUM_BILL_NO
DESC FETCH FIRST 1 ROWS ONLY;
update insurance_policy set premium_due_date = sysdate where policy_id = policy_id_var;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_stack);
        DBMS_OUTPUT.put_line(DBMS_UTILITY.format_error_backtrace);
        DBMS_OUTPUT.put_line('Some error occurred. Please contact db admin');
end;
/



begin
PAYPREMIUM(1000000);
end;
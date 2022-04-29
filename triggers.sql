set serveroutput on;
------------------------- Creating triggers --------------------------
-- Trigger to populate the billing table when an appointment is booked
CREATE OR REPLACE TRIGGER OnAppointmentBooking 
AFTER INSERT ON APPOINTMENTS
DECLARE 
	app_id              NUMBER; -- To store the appointmentId of the patient
    file_id_var         NUMBER; -- To store the file ID of the patient from the PatientHistory
    patient_id_var      NUMBER; -- We get this from the PatientDocument 
    policy_id_var       NUMBER; -- To get the plan_id
    plan_id_var         NUMBER; -- To get plan_id from the Policy table
    cov_id_var          NUMBER; -- To get the coverage id from INsurancePLan
    plan_name_var       VARCHAR2(30); -- plan_name
    treatment_var       VARCHAR2(30);
    initial_bill        NUMBER;
    final_amount        NUMBER; -- final result 
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
    ELSE
        initial_bill := 500;
    END IF;
        
    IF plan_name_var = 'GOLD' THEN
        final_amount := (initial_bill - (0.50 * (initial_bill)));
        DBMS_OUTPUT.put_line('final amt ' || final_amount);
    ELSIF plan_name_var = 'SILVER' THEN
        final_amount := (initial_bill - (0.40 * (initial_bill)));
        DBMS_OUTPUT.put_line('final amt ' || final_amount);
    ELSE
        final_amount := (initial_bill - (0.60 * (initial_bill)));
        DBMS_OUTPUT.put_line('final amt ' || final_amount);
    END IF;
    
	INSERT INTO BILLING (amount, appointment_id) values (final_amount, app_id);
END;
/

set serveroutput on;
------------------------- Creating triggers --------------------------
CREATE OR REPLACE TRIGGER OnAppointmentBooking 
AFTER INSERT ON APPOINTMENTS
DECLARE 
	app_id  NUMBER;
BEGIN	
	SELECT APPOINTMENT_ID INTO app_id FROM APPOINTMENTS ORDER BY APPOINTMENT_ID DESC FETCH FIRST 1 ROWS ONLY;
    dbms_output.put_line(app_id);
	INSERT INTO BILLING (amount, appointment_id) values (1000, app_id);
END;

INSERT INTO APPOINTMENTS(apmt_date, doc_hospital_id, file_id, start_time) 
    values(TO_DATE('2022/02/02', 'yyyy/mm/dd'), 1, 1, TO_DATE('01:00','hh24:mi'));





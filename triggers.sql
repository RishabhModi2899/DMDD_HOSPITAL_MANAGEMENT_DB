set serveroutput on;
------------------------- Creating triggers --------------------------
-- Trigger to populate the billing table when an appointment is booked
CREATE OR REPLACE TRIGGER OnAppointmentBooking 
AFTER INSERT ON APPOINTMENTS
DECLARE 
	app_id  NUMBER;
BEGIN	
	SELECT APPOINTMENT_ID INTO app_id FROM APPOINTMENTS ORDER BY APPOINTMENT_ID DESC FETCH FIRST 1 ROWS ONLY;
    dbms_output.put_line(app_id);
	INSERT INTO BILLING (amount, appointment_id) values (1000, app_id);
END;

-- Trigger to update the patient_history when an appointment is booked





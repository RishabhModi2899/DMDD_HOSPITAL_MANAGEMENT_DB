--------------Hospital and hospital department-------------------------------
DROP VIEW hos_hospitaldept_view;

CREATE VIEW hos_hospitaldept_view AS
SELECT 
h.hospital_id, 
h.hosp_name,
h.hosp_city,
hd.hos_dept_id,
d.dept_id
d.dept_name from HOSPITAL h join HOSPITAL_DEPT hd ON h.hospital_id=hd.hospital_id JOIN DEPARTMENTS d ON d.dept_id=hd.dept_id;

SELECT * FROM hos_hospitaldept_view;
      
      
------------view to create patient documents--------------------------------- 
DROP VIEW patient_view;

CREATE VIEW patient_view AS
SELECT 
 p.patient_id,                     
 p.first_name,
 p.last_name,       
 p.state_name,                      
 p.DOB,                            
 p.contact_no,
 p.email_id,     
 ph.treatment,
 ph.date_of_treatment,
 pd.file_id from patient p join PATIENT_DOCUMENT pd ON p.patient_id=pd.patient_id join PATIENT_HISTORY ph ON pd.file_id=ph.file_id;

SELECT * FROM patient_view;

--------------view to create Patient and vaccine records---------------------
DROP VIEW patient_vaccine_view;

CREATE VIEW patient_vaccine_view AS
SELECT 
 p.patient_id,                     
 p.first_name,
 p.last_name,                            
 p.DOB,                            
 p.contact_no,
 p.email_id, 
 v.vaccine_id,
 v.date_of_vaccination 
 from patient p join VACCINE_RECORDS v ON p.patient_id=v.patient_id;

SELECT * FROM patient_vaccine_view;

                        

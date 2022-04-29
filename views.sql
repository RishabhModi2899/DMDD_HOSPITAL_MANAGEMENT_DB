--------------Hospital and hospital department-------------------------------

CREATE OR REPLACE VIEW hos_hospitaldept_view AS
SELECT 
h.hospital_id, 
h.hosp_name,
h.hosp_city,
hd.hos_dept_id,
d.dept_id,
d.dept_name from HOSPITAL h join HOSPITAL_DEPT hd ON h.hospital_id=hd.hospital_id JOIN DEPARTMENTS d ON d.dept_id=hd.dept_id;

SELECT * FROM hos_hospitaldept_view;
      
      
------------view to create patient documents--------------------------------- 

CREATE OR REPLACE VIEW patient_view AS
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

CREATE OR REPLACE VIEW patient_vaccine_view AS
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

--------------Patient and insurance and coverage details VIEW----------------------------------------------------------------------

CREATE OR REPLACE VIEW patient_insurance_view AS
SELECT 
 p.patient_id,                     
 p.first_name,
 p.last_name,       
 p.state_name,                      
 p.DOB,                            
 p.contact_no,
 p.email_id,
 c.coverage_id,
 c.plan_name,
 c.health_inclusive,
 c.dental_inclusive,
 ip.provider_id,
 ipp.premium_due_date,
 ipp.plan_id  
from patient p join PATIENT_POLICY pp on p.patient_id = pp.patient_id
join insurance_policy ipp on pp.policy_id = ipp.policy_id
join INSURANCE_PLAN ip on ipp.plan_id = ip.plan_id
join coverage c on ip.coverage_id = c.coverage_id;

SELECT * FROM patient_insurance_view;
-------------------------------------------------------------------------------------------------------------------------------------------------------

----------------vaccine status view--------------------------------------------------------------------------------------------------------


CREATE OR REPLACE VIEW VACCINE_RECORD_VIEW AS
SELECT vr.record_id,
vr.vaccine_id,
vr.date_of_vaccination,
p.patient_id,
v.vaccine_name,
v.inoculated_by_days,
vr.status FROM VACCINE_RECORDS vr JOIN VACCINE v ON vr.vaccine_id=v.vaccine_id JOIN PATIENT p ON p.patient_id=vr.patient_id;

select * from VACCINE_RECORD_VIEW;
--------------------------------------------------------------------------------------------------------------------------------------------


                        

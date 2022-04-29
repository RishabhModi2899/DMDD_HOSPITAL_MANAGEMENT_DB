-- Department wise Revenue

select d.dept_id, d.dept_name, b.amount as revenue from departments d, billing b 
where d.dept_id = ( select dept_id from hospital_dept 
where hos_dept_id = (select hos_dept_id from doctor_hospital 
where doc_hospital_id = (select doc_hospital_id from appointments 
where appointment_id = (select appointment_id from billing)))); 




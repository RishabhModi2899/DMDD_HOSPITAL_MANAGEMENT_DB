REM   Script: Doctor max appointment
REM   doctors with maximum appointments 

select d.doctor_id, d.doc_first_name, d.doc_last_name, count(a.appointment_id)as total_count from doctor d 
join doctor_hospital dh on d.doctor_id = dh.doctor_id  
join appointments a on a.doc_hospital_id = dh.doc_hospital_id 
group by d.doctor_id, d.doc_first_name, d.doc_last_name;

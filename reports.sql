------ Total number of doctors in a department--------
Select dt.dept_name, count(d.doctor_id) as no_of_doctors from doctor d 
join doctor_hospital dh on dh.doctor_id = d.doctor_id
join hospital_dept hd on hd.hos_dept_id = dh.hos_dept_id
join departments dt on dt.dept_id = hd.dept_id group by dt.dept_name order by dt.dept_name;

------no.of patients who took each vaccine------------------
select vr.vaccine_id, v.vaccine_name, count(vr.patient_id) as no_of_patients from vaccine_records vr
join vaccine v on v.vaccine_id = vr.vaccine_id group by vr.vaccine_id,v.vaccine_name order by vr.vaccine_id;


--------Doctors and number of appoitnments for each doctor--------------------
select d.doctor_id, d.doc_first_name, d.doc_last_name, count(a.appointment_id)as No_of_appointments from doctor d
join doctor_hospital dh on d.doctor_id = dh.doctor_id 
join appointments a on a.doc_hospital_id = dh.doc_hospital_id
group by d.doctor_id, d.doc_first_name, d.doc_last_name order by d.doctor_id;

--------department wise revenue-------------------
select dt.dept_id, dt.dept_name, sum(b.amount) as revenue from departments dt
join hospital_dept hd on dt.dept_id = hd.dept_id 
join doctor_hospital dh on dh.hos_dept_id = hd.hos_dept_id
join appointments a on a.doc_hospital_id = dh.doc_hospital_id 
join billing b on b.appointment_id = a.appointment_id group by dt.dept_id, dt.dept_name order by dt.dept_id;

--------number of patients in each treatment------------------------
select ph.treatment, count(pd.patient_id) as no_of_patients from PATIENT_DOCUMENT pd 
join PATIENT_HISTORY ph on pd.file_id = ph.file_id group by ph.treatment order by ph.treatment;
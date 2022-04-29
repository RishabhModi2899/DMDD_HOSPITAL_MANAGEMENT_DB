REM   Script: Report_number of patients diagnosed with similar disease.
REM   na

select ph.treatment, count(pd.patient_id) as no_of_patients from PATIENT_DOCUMENT pd  
join PATIENT_HISTORY ph on pd.file_id = ph.file_id group by ph.treatment;

begin
    execute immediate 'drop table patient cascade constraints';
    execute immediate 'drop table doctor cascade constraints';
    execute immediate 'drop table hospital cascade constraints';
    execute immediate 'drop table departments cascade constraints';
    execute immediate 'drop table hospital_dept cascade constraints';
    execute immediate 'drop table doctor_hospital cascade constraints';
    execute immediate 'drop table doc_availability cascade constraints';
    execute immediate 'drop table appointments cascade constraints';
    execute immediate 'drop table patient_history cascade constraints';
    execute immediate 'drop table patient_document cascade constraints';
    execute immediate 'drop table vaccine cascade constraints';
    execute immediate 'drop table vaccine_records cascade constraints';
    execute immediate 'drop table insurance_provider cascade constraints';
    execute immediate 'drop table coverage cascade constraints';
    execute immediate 'drop table insurance_plan cascade constraints';
    execute immediate 'drop table billing cascade constraints';
    execute immediate 'drop table INSURANCE_POLICY cascade constraints';
    execute immediate 'drop table receipt cascade constraints';
    execute immediate 'drop table PREMIUM_PAYMENTS cascade constraints';
    execute immediate 'drop table patient_policy cascade constraints';
    dbms_output.put_line('All tables dropped and purged.')
end;
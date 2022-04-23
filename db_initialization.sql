set serveroutput on;

DECLARE
    ROW_COUNT NUMBER;
BEGIN
    SELECT count(*) into ROW_COUNT from user_tables where table_name = 'MASTER_TABLE';
    IF(ROW_COUNT > 0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE MASTER_TABLE ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE '
            CREATE TABLE MASTER_TABLE (
                TABLE_NAME varchar2(50),
                TABLE_DEFINITION varchar2(3000) NOT NULL,
                CONSTRAINT MASTER_TABLE_PK PRIMARY KEY(TABLE_NAME)
            )';
        DBMS_OUTPUT.PUT_LINE('TABLE MASTER_TABLE TABLE CREATED');
        
        EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('PATIENT','CREATE TABLE PATIENT
            (	
            patient_id NUMBER(10) GENERATED BY DEFAULT AS IDENTITY, 
            first_name varchar2(50) NOT NULL,
            last_name varchar2(50) NOT NULL,
            address_line1 varchar2(50) NOT NULL,
            address_line2 varchar2(50) NOT NULL,
            city varchar(20),
            zip number(5) NOT NULL,
            state_name varchar(3),
            DOB date,
            contact_no number(10),
            email_id VARCHAR2(40),
            SSN number(9) NOT NULL,
            CONSTRAINT restrict_ploc CHECK (state_name IN ("AK","AZ","AR","CA","CO","CT","DE","FL",
            "GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE",
            "NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT",
            "VA","WA","WV","WI","WY")),
            CONSTRAINT patient_id PRIMARY KEY(patient_id),
            CONSTRAINT ssn_unique UNIQUE(SSN),
            CONSTRAINT email_chk CHECK (email_id LIKE "%@%.%" AND email_id NOT LIKE "@%" AND email_id NOT LIKE "%@%@%")
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('DOCTOR','CREATE TABLE DOCTOR
            (	
            doctor_id NUMBER(10) GENERATED BY DEFAULT AS IDENTITY, 
            doc_first_name varchar2(50) NOT NULL,
            doc_last_name varchar2(50) NOT NULL,
            license_no number(7) not null,
            doc_address_line1 varchar2(50) NOT NULL,
            doc_address_line2 varchar2(50) NOT NULL,
            doc_city varchar(20),
            doc_zip number(5) NOT NULL,
            doc_state_name varchar(3),
            SSN number(9) NOT NULL,
            CONSTRAINT doc_restrict_ploc CHECK (doc_state_name IN ("AK","AZ","AR","CA","CO","CT","DE","FL",
            "GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE",
            "NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT",
            "VA","WA","WV","WI","WY")),
            CONSTRAINT doctor_id PRIMARY KEY(doctor_id),
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('DOCTOR_HOSPITAL','CREATE TABLE DOCTOR_HOSPITAL
            (	
                doc_hospital_id number GENERATED BY DEFAULT AS IDENTITY primary key,
                doctor_id number references doctor (doctor_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('PATIENT_HOSPITAL','CREATE TABLE PATIENT_HOSPITAL
            (	
                file_id number GENERATED BY DEFAULT AS IDENTITY primary key,
                treatment varchar2(200),
                date_of_treatment date
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('PATIENT_DOCUMENT','CREATE TABLE PATIENT_DOCUMENT
            (	
                patient_file_id number GENERATED BY DEFAULT AS IDENTITY primary key,
                patient_id number references patient (patient_id),
                file_id number references patient_history (file_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('APPOINTMENTS','CREATE TABLE APPOINTMENTS
            (	
                appointment_id number GENERATED AS IDENTITY (START WITH 20 INCREMENT BY 1) primary key,
                apmt_date date,
                doc_hospital_id number references doctor_hospital(doc_hospital_id),
                file_id number references patient_history(file_id),
                start_time number
            )
    ')]';
    
     EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('HOSPITAL','CREATE TABLE HOSPITAL
            (	
                hospital_id number GENERATED AS IDENTITY (START WITH 50 INCREMENT BY 1) primary key,
                hosp_name varchar2(50),
                hosp_address_line1 varchar2(50),
                hosp_address_line2 varchar2(50),
                hosp_city varchar2(20),
                hosp_zip number(5),
                hosp_state varchar2(3),
                CONSTRAINT hos_restrict_loc CHECK (doc_state_name IN ("AK","AZ","AR","CA","CO","CT","DE","FL",
                "GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE",
                "NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT",
                "VA","WA","WV","WI","WY"))
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('DEPARTMENTS','CREATE TABLE DEPARTMENTS
            (	
                dept_id number GENERATED AS IDENTITY (START WITH 10 INCREMENT BY 20) primary key,
                dept_name varchar2(20) 
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('HOSPITAL_DEPT','CREATE TABLE HOSPITAL_DEPT 
            (	
                hospital_id number GENERATED AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
                dept_id number not null references departments(dept_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('VACCINE','CREATE TABLE VACCINE 
            (	
                vaccine_id number GENERATED AS IDENTITY (START WITH 001 INCREMENT BY 2) primary key,
                vaccine_name varchar2(20),
                inoculated_by_days number
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('VACCINE_RECORDS ','CREATE TABLE VACCINE_RECORDS  
            (	
                record_id number GENERATED AS IDENTITY (START WITH 15 INCREMENT BY 2) primary key,
                patient_id number references patient(patient_id),
                vaccine_id number references vaccine(vaccine_id),
                date_of_vaccination date
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('AVAILABILITY_  ','CREATE TABLE AVAILABILITY_  
            (	
                unique_id number GENERATED AS IDENTITY (START WITH 01 INCREMENT BY 1) primary key,
                doctor_id number references doctor(doctor_id),
                day_ date,
                start_time number, 
                end_time number
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('BILLING  ','CREATE TABLE BILLING  
            (	
                bill_no number GENERATED AS IDENTITY (START WITH 10000 INCREMENT BY 1) primary key,
                amount number,
                appointment_id number references appointments(appointment_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('RECIEPT','CREATE TABLE RECIEPT  
            (	
                reciept_no NUMBER GENERATED AS IDENTITY (START WITH 1000 INCREMENT BY 3) primary key,
                date_of_payment date,
                bill_no number references Billing (bill_no)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('COVERAGE','CREATE TABLE COVERAGE   
            (	
                coverage_id number generated AS identity (start with 15000 increment by 11) primary key,
                plan_name varchar2(100),
                health_inclusive varchar2(100),
                dental_inclusive varchar2(100),
                premium number
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('INSURANCE_PROVIDER','CREATE TABLE INSURANCE_PROVIDER   
            (	
                provider_id number generated AS identity (start with 1 increment by 1) primary key,
                provider_name varchar2(100),
                provider_address_line1 varchar2(100),
                provider_address_line2 varchar2(100),
                provider_city varchar2(20),
                provider_zip number,
                provider_state varchar2(20)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('INSURANCE_PLAN','CREATE TABLE INSURANCE_PLAN   
            (	
                plan_id number generated as identity (start with 10 increment by 5) primary key,
                coverage_id number references coverage (coverage_id),
                provider_id number references insurance_provider (provider_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('POLICY_','CREATE TABLE POLICY_   
            (	
                policy_id number generated as identity (start with  1000000 increment by 1) primary key,
                pol_start_date date,
                pol_end_date date,
                duration_months number,
                patient_copays number,
                premium_payment_option VARCHAR2(5),
                premium_due_date date,
                plan_id number references insurance_plan(plan_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('PATIENT_POLICY','CREATE TABLE PATIENT_POLICY   
            (	
                patient_policy_id number generated AS identity (start with 300000 increment by 1) primary key,
                policy_id number references policy_(policy_id),
                patient_id number references patient(patient_id)
            )
    ')]';
    
    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('PREMIUM_PAYMENTS ','CREATE TABLE PREMIUM_PAYMENTS    
            (	
                premium_bill_no number generated as identity (start with 200 increment BY 2) primary key,
                policy_id number references policy_(policy_id),
                reciept_no NUMBER references reciept(reciept_no)
            )
    ')]';
    
    END IF;
END;
/

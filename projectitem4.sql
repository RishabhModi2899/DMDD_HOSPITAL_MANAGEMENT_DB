set serveroutput on;
	

	-- dropping the tables 
	drop table hospital CASCADE CONSTRAINTS;
	drop table doctor CASCADE CONSTRAINTS;
	drop table doctor_hospital CASCADE CONSTRAINTS;
	drop table patient_history CASCADE CONSTRAINTS;
	drop table patient_document CASCADE CONSTRAINTS;
	drop table appointments CASCADE CONSTRAINTS;
	DROP TABLE patient CASCADE CONSTRAINTS;
	drop table vaccine CASCADE CONSTRAINTS;
	drop table hospital_dept CASCADE CONSTRAINTS;
	drop table departments CASCADE CONSTRAINTS;
	drop table vaccine_records CASCADE CONSTRAINTS;
	drop table availability_ CASCADE CONSTRAINTS;
	drop table Billing CASCADE CONSTRAINTS;
	drop table reciept CASCADE CONSTRAINTS;
	drop table coverage CASCADE CONSTRAINTS;
	drop table insurance_provider CASCADE CONSTRAINTS;
	drop table insurance_plan CASCADE CONSTRAINTS;
	drop table policy_ CASCADE CONSTRAINTS;
	drop table patient_policy CASCADE CONSTRAINTS;
	drop table premium_payments CASCADE CONSTRAINTS;
	

	-- Creating the patient table 
	create table patient (
	patient_id number GENERATED AS IDENTITY(START with 1 INCREMENT by 1) primary key,
	first_name varchar2(50),
	last_name varchar2(50),
	address_line1 varchar2(50),
	address_line2 varchar2(50),
	city varchar(20),
	zip number(5),
	state_name varchar(3),
	CONSTRAINT restrict_ploc CHECK (state_name IN ('AK','AZ','AR','CA','CO','CT','DE','FL',
	'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE',
	'NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
	'VA','WA','WV','WI','WY')),
	DOB date,
	contact_no number(10),
	email_id VARCHAR2(40) CHECK (email_id LIKE '%@%.%' AND email_id NOT LIKE '@%' AND email_id NOT LIKE '%@%@%'),
	SSN number(9) NOT NULL,
	CONSTRAINT ssn_unique UNIQUE(SSN)
	);
	

	

	-- Creating the doctor table
	create table doctor (
	doctor_id number GENERATED AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
	doc_first_name varchar2(50),
	doc_last_name varchar2(50),
	license_no number(7) not null,
	doc_address_line1 varchar2(80),
	doc_address_line2 varchar2(80),
	doc_city varchar2(20),
	doc_zip number(5),
	doc_state varchar2(3),
	CONSTRAINT restrict_dloc CHECK (doc_state IN ('AK','AZ','AR','CA','CO','CT','DE','FL',
	'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE',
	'NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
	'VA','WA','WV','WI','WY'))
	);
	

	

	-- Creating the doctor_hospital table
	create table doctor_hospital(
	doc_hospital_id number primary key,
	doctor_id number references doctor (doctor_id)
	);
	

	

	-- create patient_history table
	create table patient_history (
	file_id number GENERATED AS IDENTITY (START WITH 10 INCREMENT BY 1) primary key,
	treatment varchar2(200),
	date_of_treatment date
	);
	

	

	

	-- create patient_document
	create table patient_document(
	patient_file_id number GENERATED AS IDENTITY (START WITH 200 INCREMENT BY 1) primary key,
	patient_id number references patient (patient_id),
	file_id number references patient_history (file_id)
	);
	

	

	-- create appointments table 
	create table appointments(
	appointment_id number GENERATED AS IDENTITY (START WITH 20 INCREMENT BY 1) primary key,
	apmt_date date,
	doc_hospital_id number references doctor_hospital(doc_hospital_id),
	file_id number references patient_history(file_id),
	start_time number
	);
	

	

	-- create hospital table
	create table hospital(
	hospital_id number GENERATED AS IDENTITY (START WITH 50 INCREMENT BY 1) primary key,
	hosp_name varchar2(50),
	hosp_address_line1 varchar2(50),
	hosp_address_line2 varchar2(50),
	hosp_city varchar2(20),
	hosp_zip number(5),
	hosp_state varchar2(3),
	CONSTRAINT restrict_hloc CHECK (hosp_state IN ('AK','AZ','AR','CA','CO','CT','DE','FL',
	'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE',
	'NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
	'VA','WA','WV','WI','WY'))
	);
	

	

	-- create departments table
	create table departments (
	    dept_id number GENERATED AS IDENTITY (START WITH 10 INCREMENT BY 20) primary key,
	    dept_name varchar2(20) 
	);
	

	-- create hospital_dept table
	create table hospital_dept (
	    hospital_id number GENERATED AS IDENTITY (START WITH 1 INCREMENT BY 1) primary key,
	    dept_id number not null references departments(dept_id)
	);
	

	-- creating the vaccine table 
	create table vaccine (
	    vaccine_id number GENERATED AS IDENTITY (START WITH 001 INCREMENT BY 2) primary key,
	    vaccine_name varchar2(20),
	    inoculated_by_days number
	);
	

	-- creating the table vaccine_records
	create table vaccine_records (
	    record_id number GENERATED AS IDENTITY (START WITH 15 INCREMENT BY 2) primary key,
	    patient_id number references patient(patient_id),
	    vaccine_id number references vaccine(vaccine_id),
	    date_of_vaccination date
	);
	

	-- creating table availability
	create TABLE availability_ (
	    unique_id number GENERATED AS IDENTITY (START WITH 01 INCREMENT BY 1) primary key,
	    doctor_id number references doctor(doctor_id),
	    day_ date,
	    start_time number, 
	    end_time number
	);
	

	-- create table billing 
	create table Billing (
	    bill_no number GENERATED AS IDENTITY (START WITH 10000 INCREMENT BY 1) primary key,
	    amount number,
	    appointment_id number references appointments(appointment_id)
	);
	

	-- create table reciept 
	create table reciept (
	    reciept_no NUMBER GENERATED AS IDENTITY (START WITH 1000 INCREMENT BY 3) primary key,
	    date_of_payment date,
	    bill_no number references Billing (bill_no)
	);
	 
	-- create table coverage
	create table coverage (
	    coverage_id number generated AS identity (start with 15000 increment by 11) primary key,
	    plan_name varchar2(100),
	    health_inclusive varchar2(100),
	    dental_inclusive varchar2(100),
	    premium number
	);
	

	-- creating table insurance provider
	create table insurance_provider(
	    provider_id number generated AS identity (start with 1 increment by 1) primary key,
	    provider_name varchar2(100),
	    provider_address_line1 varchar2(100),
	    provider_address_line2 varchar2(100),
	    provider_city varchar2(20),
	    provider_zip number,
	    provider_state varchar2(20)
	);
	

	-- creating insurance_plan
	create table insurance_plan (
	    plan_id number generated as identity (start with 10 increment by 5) primary key,
	    coverage_id number references coverage (coverage_id),
	    provider_id number references insurance_provider (provider_id)
	);
	

	-- create table policy
	create table policy_ (
	    policy_id number generated as identity (start with  1000000 increment by 1) primary key,
	    pol_start_date date,
	    pol_end_date date,
	    duration_months number,
	    patient_copays number,
	    premium_payment_option VARCHAR2(5),
	    premium_due_date date,
	    plan_id number references insurance_plan(plan_id)
	);
	

	-- create table patient_policy
	create table patient_policy (
	    patient_policy_id number generated AS identity (start with 300000 increment by 1) primary key,
	    policy_id number references policy_(policy_id),
	    patient_id number references patient(patient_id)
	);
	

	-- create premium_payments 
	create table premium_payments (
	    premium_bill_no number generated as identity (start with 200 increment BY 2) primary key,
	    policy_id number references policy_(policy_id),
	    reciept_no NUMBER references reciept(reciept_no)
	);
	 
	COMMIT;

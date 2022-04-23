select * from user_tables;

SET SERVEROUTPUT ON;
DECLARE
nCount NUMBER;

BEGIN

SELECT count(*) into nCount FROM user_tables where table_name = 'PATIENT';

IF(nCount > 0) THEN 
    DBMS_OUTPUT.PUT_LINE('PATIENT TABLE ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'CREATE TABLE PATIENT
            (	
            patient_id NUMBER GENERATED BY DEFAULT AS IDENTITY, 
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
            CONSTRAINT restrict_ploc CHECK (state_name IN (''AK'',''AZ'',''AR'',''CA'',''CO'',''CT'',''DE'',''FL'',
            ''GA'',''HI'',''ID'',''IL'',''IN'',''IA'',''KS'',''KY'',''LA'',''ME'',''MD'',''MA'',''MI'',''MN'',''MS'',''MO'',''MT'',''NE'',
            ''NV'',''NH'',''NJ'',''NM'',''NY'',''NC'',''ND'',''OH'',''OK'',''OR'',''PA'',''RI'',''SC'',''SD'',''TN'',''TX'',''UT'',''VT'',
            ''VA'',''WA'',''WV'',''WI'',''WY'')),
            CONSTRAINT patient_id PRIMARY KEY(patient_id),
            CONSTRAINT ssn_unique UNIQUE(SSN),
            CONSTRAINT email_chk CHECK (email_id LIKE ''%@%.%'' AND email_id NOT LIKE ''@%'' AND email_id NOT LIKE ''%@%@%'')
            )';
    DBMS_OUTPUT.PUT_LINE('PATIENT TABLE CREATED');
    
    EXECUTE IMMEDIATE 'INSERT INTO patient (first_name,last_name,address_line1,address_line2,city,zip,state_name,DOB,contact_no,email_id,SSN) VALUES (''tina'',''natekar'',''2 torpie street'',''apt-1'',''boston'',02120,''MA'',TO_DATE(''1998/06/03'', ''yyyy/mm/dd''),4766443677,''tina@gmail.com'',312829898)';
    DBMS_OUTPUT.PUT_LINE('PATIENT DATA INSERTION COMPLETED');
END IF;



SELECT count(*) into nCount FROM user_tables where table_name = 'COVERAGE';

IF(nCount > 0) THEN 
    DBMS_OUTPUT.PUT_LINE('COVERAGE TABLE ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'CREATE TABLE COVERAGE   
            (	
                coverage_id number generated AS identity (start with 15000 increment by 11) primary key,
                plan_name varchar2(100),
                health_inclusive varchar2(100),
                dental_inclusive varchar2(100),
                premium number
            )';
    DBMS_OUTPUT.PUT_LINE('COVERAGE TABLE CREATED');
    
    EXECUTE IMMEDIATE 'INSERT INTO COVERAGE(plan_name,health_inclusive,dental_inclusive,premium)values(''silver'',''Y'',''N'',2400)';
    DBMS_OUTPUT.PUT_LINE('COVERAGE DATA INSERTION COMPLETED');
END IF;

SELECT count(*) into nCount FROM user_tables where table_name = 'INSURANCE_PROVIDER';

IF(nCount > 0) THEN 
    DBMS_OUTPUT.PUT_LINE('INSURANCE_PROVIDER TABLE ALREADY EXISTS');

ELSE EXECUTE IMMEDIATE 'CREATE TABLE INSURANCE_PROVIDER   
            (	
                provider_id number generated AS identity (start with 1 increment by 1) primary key,
                provider_name varchar2(100),
                provider_address_line1 varchar2(100),
                provider_address_line2 varchar2(100),
                provider_city varchar2(20),
                provider_zip number,
                provider_state varchar2(20)
            )';
    DBMS_OUTPUT.PUT_LINE('INSURANCE_PROVIDER TABLE CREATED');
    
    EXECUTE IMMEDIATE 'INSERT INTO INSURANCE_PROVIDER(provider_name,provider_address_line1,provider_address_line2,provider_city,provider_zip,provider_state) VALUES (''Blue Cross Blue Shield'',''360 Atlantic Ave'',''Suite 1'',''Boston'',02142,''MA'')';
    DBMS_OUTPUT.PUT_LINE('INSURANCE_PROVIDER DATA INSERTION COMPLETED');
END IF;


SELECT count(*) into nCount FROM user_tables where table_name = 'INSURANCE_PLAN';

IF(nCount > 0) THEN 
    DBMS_OUTPUT.PUT_LINE('INSURANCE_PLAN TABLE ALREADY EXISTS');
ELSE EXECUTE IMMEDIATE 'CREATE TABLE INSURANCE_PLAN   
            (	
                plan_id number generated as identity (start with 10 increment by 5) primary key,
                coverage_id number references coverage (coverage_id),
                provider_id number references insurance_provider (provider_id)
            )';
    DBMS_OUTPUT.PUT_LINE('INSURANCE_PLAN TABLE CREATED');
    
    EXECUTE IMMEDIATE 'INSERT INTO insurance_plan (coverage_id,provider_id) values (15000,1)';
    DBMS_OUTPUT.PUT_LINE('INSURANCE_PLAN DATA INSERTION COMPLETED');
END IF;





    
--    EXECUTE IMMEDIATE q'[INSERT INTO MASTER_TABLE VALUES ('RECIEPT','CREATE TABLE RECIEPT  
--            (	
--                reciept_no NUMBER GENERATED AS IDENTITY (START WITH 1000 INCREMENT BY 3) primary key,
--                date_of_payment date,
--                bill_no number references Billing (bill_no)
--            )
--    ')]';

COMMIT;

END;
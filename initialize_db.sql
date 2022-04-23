SET SERVEROUTPUT ON;
DECLARE
nCount NUMBER;

BEGIN

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

COMMIT;

END;

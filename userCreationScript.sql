SET SERVEROUTPUT ON;

DECLARE
    nCountUser  NUMBER;
BEGIN
--------------------- Creating users and granting priveleges -----------------------
    SELECT COUNT(*) into nCountUser FROM dba_users where USERNAME = 'DB_ADMIN_HMS';
    IF(nCountUser = 0) THEN 
        EXECUTE IMMEDIATE 'CREATE USER DB_ADMIN_HMS IDENTIFIED BY BostonCampus2020';
        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO DB_ADMIN_HMS';
		dbms_output.put_line('User creation SUCCESSFUL...!');
        COMMIT;
    ELSE
        dbms_output.put_line('User already exists....!');
    END IF;
    
    SELECT COUNT(*) into nCountUser FROM dba_users where USERNAME = 'RESOURCE_MANAGER';
    IF(nCountUser = 0) THEN 
        EXECUTE IMMEDIATE 'CREATE USER resource_manager IDENTIFIED BY BostonCampus2020#1';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO RESOURCE_MANAGER';
		dbms_output.put_line('User creation SUCCESSFUL...!');
        COMMIT;
    ELSE
        dbms_output.put_line('User already exists....!');
    END IF;

    SELECT COUNT(*) into nCountUser FROM dba_users where USERNAME = 'PATIENT_ADMIN';
    IF(nCountUser = 0) THEN 
        EXECUTE IMMEDIATE 'CREATE USER PATIENT_ADMIN IDENTIFIED BY TestPatient#123';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO PATIENT_ADMIN';
		dbms_output.put_line('User creation SUCCESSFUL...!');
        COMMIT;
    ELSE
        dbms_output.put_line('User already exists....!');
    END IF;

    SELECT COUNT(*) into nCountUser FROM dba_users where USERNAME = 'DOCTOR_ADMIN';
    IF(nCountUser = 0) THEN 
        EXECUTE IMMEDIATE 'CREATE USER DOCTOR_ADMIN IDENTIFIED BY TestDoctor#123';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO DOCTOR_ADMIN';
		dbms_output.put_line('User creation SUCCESSFUL...!');
        COMMIT;
    ELSE
        dbms_output.put_line('User already exists....!');
    END IF;

    SELECT COUNT(*) into nCountUser FROM dba_users where USERNAME = 'INSURANCE_ADMIN';
    IF(nCountUser = 0) THEN 
        EXECUTE IMMEDIATE 'CREATE USER INSURANCE_ADMIN IDENTIFIED BY Insurance#123';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO INSURANCE_ADMIN';
		dbms_output.put_line('User creation SUCCESSFUL...!');
        COMMIT;
    ELSE
        dbms_output.put_line('User already exists....!');
    END IF;

END;
/


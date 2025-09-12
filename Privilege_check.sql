CREATE OR REPLACE FUNCTION has_privilege(
    p_user_id    NUMBER,
    p_role_name  VARCHAR2
) RETURN BOOLEAN IS
    v_result CHAR(1);
BEGIN
    SELECT CASE UPPER(p_role_name)
             WHEN 'DML' THEN r.CAN_DML
             WHEN 'DDL' THEN r.CAN_DDL
             WHEN 'DROP_TRUNCATE' THEN r.CAN_DROP_TRUNCATE
             WHEN 'CREATE_SESSION' THEN r.CAN_CREATE_SESSION
           END
    INTO v_result
    FROM USER_ACCOUNTS u
    JOIN USER_ROLES r ON u.ROLE_NAME = r.ROLE_NAME
    WHERE u.USER_ID = p_user_id;

    RETURN v_result = 'Y';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

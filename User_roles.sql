CREATE TABLE USER_ROLES (
    ROLE_NAME          VARCHAR2(30) PRIMARY KEY,
    CAN_DML            CHAR(1) CHECK (CAN_DML IN ('Y','N')),
    CAN_DDL            CHAR(1) CHECK (CAN_DDL IN ('Y','N')),
    CAN_DROP_TRUNCATE  CHAR(1) CHECK (CAN_DROP_TRUNCATE IN ('Y','N')),
    CAN_CREATE_SESSION CHAR(1) CHECK (CAN_CREATE_SESSION IN ('Y','N')),
    DESCRIPTION        VARCHAR2(200)
);

-- Insert the roles with privileges
INSERT INTO USER_ROLES VALUES 
('ADMINISTRATOR', 'Y', 'Y', 'Y', 'Y', 'Full access: DML, DDL, DROP/TRUNCATE, CREATE SESSION');

INSERT INTO USER_ROLES VALUES 
('DEVELOPER', 'Y', 'Y', 'N', 'Y', 'DML and DDL access, but no DROP or TRUNCATE');

INSERT INTO USER_ROLES VALUES 
('MAINTAINER', 'N', 'Y', 'N', 'Y', 'Can create/modify packages and tables (DDL only)');

INSERT INTO USER_ROLES VALUES 
('SUPPORT', 'N', 'Y', 'N', 'Y', 'Can create packages and tables, maintenance tasks');

INSERT INTO USER_ROLES VALUES 
('REVIEWER', 'N', 'N', 'N', 'Y', 'Read-only access across all objects');

COMMIT;

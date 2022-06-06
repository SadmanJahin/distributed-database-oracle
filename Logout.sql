set linesize 160;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;


Drop PACKAGE Session_Of_User;

CREATE PACKAGE Session_Of_User IS
  isLoggedIn BOOLEAN;
  loggedUserId VARCHAR2(100);
  
END;
/

Clear Screen;
BEGIN

DBMS_OUTPUT.put_line ('Successfully logged out.');

END;
/

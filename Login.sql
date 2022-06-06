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

Drop FUNCTION checkLogin;


CREATE OR REPLACE FUNCTION checkLogin (Email_Check IN VARCHAR2,Phone IN VARCHAR2)
RETURN BOOLEAN
AS 

   login_Success   BOOLEAN;
   tempEmail VARCHAR2(100);
   tempPhone VARCHAR2(100);
BEGIN 
    FOR RowData IN (SELECT * FROM User_List) LOOP
	    tempEmail :=RowData.email;
		tempPhone :=RowData.phone;
		IF  tempPhone = Phone THEN
            login_Success := TRUE;		
	    END IF;
	END LOOP;	
		


   RETURN login_Success;
END checkLogin; 
/

ACCEPT Email  PROMPT "Enter Your Student Email:";
ACCEPT Phone PROMPT "Enter Phone:";

DECLARE

 Email varchar2(100);  
 Phone varchar2(100);  
 login_Success BOOLEAN;
 id NUMBER;
 userEmail varchar2(100);  
BEGIN
   
	Email := '&Email';
    Phone := '&Phone';	
	userEmail := Email;
	
	login_Success := checkLogin(Email,Phone);
	IF login_Success THEN
	   DBMS_OUTPUT.put_line ('Successfully Logined');
	   Session_Of_User.isLoggedIn := TRUE;
	   SELECT user_id into id from User_List where email = userEmail;
	   Session_Of_User.loggedUserId :=id;
	    DBMS_OUTPUT.put_line (Session_Of_User.loggedUserId);
	ELSE
	   DBMS_OUTPUT.put_line ('Login Failed.');
	END IF;
	

   
END;
/


DECLARE
NAME VARCHAR(100);
Notification Number;
Temp  VARCHAR(100);
BEGIN
IF Session_Of_User.isLoggedIn THEN
SELECT name INTO NAME FROM User_List  WHERE user_id = Session_Of_User.loggedUserId;
DBMS_OUTPUT.put_line ('Welcome To The Portal '|| NAME);
DBMS_OUTPUT.put_line ('You Can Find A Book Here and also you can post A Book to Share.');

SELECT Count(notifications) into Notification FROM User_Notification where user_id=Session_Of_User.loggedUserId;
DBMS_OUTPUT.put_line ('You have '|| Notification||' notification');               
FOR RowData IN (SELECT * FROM BookRequested INNER JOIN BookShared ON BookRequested.post_id=BookShared.post_id where user_id=Session_Of_User.loggedUserId) LOOP
    SELECT name into temp from User_List where user_id = RowData.requester_id;
	DBMS_OUTPUT.put_line ('You have 1 Book request from '|| Temp||'');        
END LOOP;

ELSE
DBMS_OUTPUT.put_line ('You are Not Logged In');
END IF;
  
END;
/

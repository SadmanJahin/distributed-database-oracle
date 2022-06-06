set linesize 320;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;




Drop FUNCTION isValid;
Drop FUNCTION isExist;
Drop FUNCTION isRegistered;

CREATE OR REPLACE FUNCTION isValid (Email_Check IN varchar2)
RETURN BOOLEAN
AS 

   b_isvalid   BOOLEAN;
BEGIN 
  b_isvalid :=
      REGEXP_LIKE (Email_Check,
                   '^[A-Za-z0-9._%+-]+@aust.edu$');

   RETURN b_isvalid;
END isValid; 
/

CREATE OR REPLACE FUNCTION isExist (Email_Check IN varchar2)
RETURN BOOLEAN
AS 

   email_isExist   BOOLEAN;
   tempEmail VARCHAR2(100);
BEGIN 
    FOR RowData IN (SELECT * FROM Enlisted_Students) LOOP
	    tempEmail :=RowData.university_email;
		IF tempEmail =  Email_Check THEN
            email_isExist := TRUE;		
	    END IF;
	END LOOP;	
		


   RETURN email_isExist;
END isExist; 
/

CREATE OR REPLACE FUNCTION isRegistered (Email_Check IN varchar2)
RETURN BOOLEAN
AS 

   email_isExist   BOOLEAN;
   tempEmail VARCHAR2(100);
BEGIN 
    FOR RowData IN (SELECT * FROM User_List) LOOP
	    tempEmail :=RowData.email;
		IF tempEmail =  Email_Check THEN
            email_isExist := TRUE;		
	    END IF;
	END LOOP;	
		


   RETURN email_isExist;
END isRegistered; 
/


ACCEPT Email  PROMPT "Enter Your Student Email:";
ACCEPT Name PROMPT "Enter Name:";
ACCEPT Phone   PROMPT "Enter Your Phone Number:";
ACCEPT Semester PROMPT "Enter Semester:";
ACCEPT Location   PROMPT "Enter Your City:";
DECLARE
    Email varchar2(100);  
	Name varchar2(100);  
	Phone varchar2(100);  
	Semester varchar2(10);  
	Location varchar2(10);  
	valid BOOLEAN;
	Exist BOOLEAN;
	Registered BOOLEAN;
	Increment_X1 NUMBER;
	Increment_X2 NUMBER;
	Auto_Increment NUMBER;
BEGIN
   
	Email := '&Email';
	valid := isValid(Email);
	DBMS_OUTPUT.put_line (Email);
	Name := '&Name';
	Phone := '&Phone';
	Semester := '&Semester';
	Location := '&Location';
	
	
	
	
	IF valid THEN
	DBMS_OUTPUT.put_line ('Valid Email');
	Registered := isRegistered(Email);
	Exist := isExist(Email);
	    IF Registered THEN 
		   DBMS_OUTPUT.put_line ('Already Registered.Please Login.');
		ELSIF Exist THEN
		   DBMS_OUTPUT.put_line ('Email Exists in the Server Database.Succssesfully Registered.');
		   
		   SELECT user_id into Increment_X1 from User_list  where rownum = 1  ORDER BY user_id DESC; 
		   SELECT user_id into Increment_X2 from User_list@site1  where rownum = 1  ORDER BY user_id DESC; 
			
           IF Increment_X1>Increment_X2 THEN
              Auto_Increment :=Increment_X1+1;
		   ELSE
		      Auto_Increment :=Increment_X2+1;
           END IF;		   
		   IF LOWER(Location)='dhaka' THEN
			   
			   INSERT INTO User_List (user_id,email,name,phone,semester,location) VALUES (Auto_Increment,Email,Name,Phone,Semester,Location);
			   
		   ELSIF LOWER(Location)='chittagong' THEN
		   
			   INSERT INTO User_List@site1 (user_id,email,name,phone,semester,location) VALUES (Auto_Increment,Email,Name,Phone,Semester,Location);
			   
		   END IF;
		ELSE
           DBMS_OUTPUT.put_line ('Email Does Not Exist. Contact Your Authority');		
	    END IF;
	ELSE
	 DBMS_OUTPUT.put_line ('Invalid Email');
	 
	  
	END IF; 
   
END;
/
COMMIT;
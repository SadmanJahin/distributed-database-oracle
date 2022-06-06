set linesize 160;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;






SELECT user_Id,name,location FROM User_List;

SELECT user_Id,name,location FROM User_List@Site1;


SELECT user_Id,name,location FROM User_List UNION SELECT user_Id,name,location FROM User_List@Site1;



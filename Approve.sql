set linesize 160;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;



ACCEPT approval  PROMPT 'Approve all requests? Yes/No:';
DECLARE
Approval varchar2(100);
postId number;
BEGIN
IF Session_Of_User.isLoggedIn THEN
	IF LOWER(approval)= 'yes' THEN
	   DELETE FROM User_Notification where user_id=Session_Of_User.loggedUserId;
		  FOR RowData IN (SELECT * FROM BookShared where user_id=Session_Of_User.loggedUserId) LOOP
		   postId := RowData.post_id;
		   DELETE FROM BookRequested where post_id=postId;
		  END LOOP;	
	   DELETE FROM BookShared where user_id=Session_Of_User.loggedUserId;
	   DBMS_OUTPUT.put_line ('Book requests Successfully approved');
	END IF;
ELSE
DBMS_OUTPUT.put_line ('You are Not Logged In');
	
END IF;	
END;
/
set linesize 160;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER UpdateNotification 
AFTER INSERT 
ON BookRequested
FOR EACH ROW

DECLARE
postId NUMBER;
userId NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('User Has Been Notified!');
    postId := :NEW.post_id;
	SELECT user_id into userId from BookShared where post_id= postId;
	INSERT INTO User_Notification (user_id,notifications,notification_Type) VALUES (userId,postId,'Book Request');
END;
/


CREATE OR REPLACE PROCEDURE findBook(searchString IN varchar2)
IS

count_result number :=0;
SearchNotFound EXCEPTION;
Found EXCEPTION;

BEGIN

 FOR RowData IN (SELECT post_id,BookShared.book_id,book_name,book_author,BookShared.user_id,name FROM BookShared LEFT JOIN BOOKS ON Books.book_id=BookShared.book_id INNER JOIN User_List ON User_List.user_id=BookShared.user_id WHERE LOWER(book_author) LIKE '%'||LOWER(searchString)||'%' OR LOWER(book_name) LIKE '%'||LOWER(searchString)||'%' OR LOWER(BookShared.book_id) LIKE searchString) LOOP
	 DBMS_OUTPUT.put_line('Found! Post Id: '||RowData.post_id ||' BookName: '|| RowData.book_name ||' Author : '||RowData.book_author||' Posted By '||RowData.name);
	 count_result := count_result+1;
 END LOOP;
 
 IF count_result = 0 THEN 
    RAISE SearchNotFound; 
 END IF;
 
 EXCEPTION
	WHEN Found THEN
		DBMS_OUTPUT.PUT_LINE('FOUND');
	WHEN SearchNotFound THEN
		DBMS_OUTPUT.PUT_LINE('Sorry! No Books Found.');
	
	
END findBook;
/




DECLARE
NAME VARCHAR(100);


BEGIN
IF Session_Of_User.isLoggedIn THEN
SELECT name INTO NAME FROM User_List  WHERE user_id = Session_Of_User.loggedUserId;
DBMS_OUTPUT.put_line ('Welcome '|| NAME);
DBMS_OUTPUT.put_line ('Search for your desired book.');
ELSE
DBMS_OUTPUT.put_line ('You are Not Logged In');
END IF;
  
END;
/





ACCEPT searchString  PROMPT "Enter BookId Or Book Name Or Author To Search Book: ";



DECLARE
searchString varchar2(100);

BEGIN

searchString :='&searchString';
findBook(searchString);

END;
/

ACCEPT postId  PROMPT "Enter Post Id for Requesting Books: ";



DECLARE
postId number;
AutoIncrement number;

BEGIN

postId :=&postId;
SELECT request_id INTO AutoIncrement from BookRequested where rownum = 1  ORDER BY request_id DESC; 
EXCEPTION
 WHEN no_data_found then
      AutoIncrement :=1;
	  
INSERT INTO BookRequested (request_id,post_id,requester_id) VALUES (AutoIncrement,postId,Session_Of_User.loggedUserId);
END;
/



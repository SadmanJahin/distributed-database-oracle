set linesize 160;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;

CLEAR SCREEN;

DECLARE
NAME VARCHAR(100);


BEGIN
IF Session_Of_User.isLoggedIn THEN
SELECT name INTO NAME FROM User_List  WHERE user_id = Session_Of_User.loggedUserId;
DBMS_OUTPUT.put_line ('Welcome '|| NAME);
DBMS_OUTPUT.put_line ('SELECT A BOOK FROM THE LIST YOU WANT TO SHARE.');
ELSE
DBMS_OUTPUT.put_line ('You are Not Logged In');
END IF;
  
END;
/
SELECT * FROM BOOKS;




ACCEPT BookId  PROMPT "Enter BookId From The List You Want to Share:";



DECLARE
BookId NUMBER;
AutoIncrement NUMBER;
BookName varchar2(100);
LoginFirst EXCEPTION;
BEGIN
SELECT post_id INTO AutoIncrement from BookShared where rownum = 1  ORDER BY post_id DESC; 
AutoIncrement := AutoIncrement+1;
DBMS_OUTPUT.put_line (AutoIncrement);
bookId := &bookId;
IF Session_Of_User.isLoggedIn  THEN
	INSERT INTO BookShared (post_id,book_id,user_id) VALUES (AutoIncrement,bookId,Session_Of_User.loggedUserId);
	SELECT book_name into BookName from Books where book_id=bookId;
	DBMS_OUTPUT.put_line (BookName ||' Have been added');
	ELSE 
	DBMS_OUTPUT.put_line ('Login First');
END IF; 
END;
/
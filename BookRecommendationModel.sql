set linesize 160;
set wrap off;

SET SERVEROUTPUT ON;
SET VERIFY OFF;


DROP TABLE Book_RequestData;
CREATE TABLE Book_RequestData
(
SL NUMBER,
NAME VARCHAR2(100),
DEPT VARCHAR2(100),
SEMESTER NUMBER,
BOOK_NEEDED VARCHAR2(100)
);

INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (1,'John','CSE',4.1,'DDS');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (2,'Ron','CSE',3.1,'Numerical');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (3,'Rahim','EEE',2.2,'Electronics');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (4,'Rafayel','EEE',2.1,'Circuit');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (5,'Sakib','CSE',3.1,'Numerical');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (6,'Rafsan','CSE',4.1,'Networking');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (7,'Joy','CSE',1.2,'JAVA');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (8,'Sakib','CSE',4.1,'AI');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (9,'Moinul','IPE',3.2,'Production');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (10,'Farhan','IPE',2.1,'ME Drawing');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (11,'Ahmed','CSE',3.2,'Data');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (12,'Jahin','CSE',4.1,'DDS');
INSERT INTO Book_RequestData (SL,NAME,DEPT,SEMESTER,BOOK_NEEDED) VALUES (13,'Pintu','EEE',4.1,'Design');


 CLEAR SCREEN;
 
 
 ACCEPT Dept  PROMPT "Enter DEPT:";
 ACCEPT Semester  PROMPT "Enter Semester:";

DECLARE
 
 TYPE map_varchar IS TABLE OF NUMBER INDEX BY VARCHAR2(30);
 ValueOF map_varchar;
 preprocessing_value NUMBER := 1;
 type Result is varray(14) of NUMBER;
 array Result := Result(0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 temp number;
 UserDept varchar(100);
 UserSemester number;
 i number;
 minVal1 number;
 minIndex1 number :=1;
 minVal2 number;
 minIndex2 number :=1;
 minVal3 number;
 minIndex3 number :=1;
 bookname1 varchar2(100);
 bookname2 varchar2(100);
 bookname3 varchar2(100);
BEGIN
    
	FOR RowData IN (SELECT * FROM Book_RequestData) LOOP
	   
		 IF (ValueOF.exists(RowData.BOOK_NEEDED)) THEN
		 preprocessing_value := preprocessing_value;
		 ELSE
		 ValueOF(RowData.BOOK_NEEDED) := preprocessing_value;
		 preprocessing_value := preprocessing_value +1;
		 END IF;
	END LOOP;	
	 
    UserDept :='&Dept';
    UserSemester :=&Semester;	
	
    ValueOF('CSE') :=50;
	ValueOF('EEE') :=10;
	ValueOF('IPE') :=30;
	i:=1;
	FOR RowData IN (SELECT * FROM Book_RequestData) LOOP
	     temp :=SQRT(POWER(ValueOF(RowData.DEPT)-ValueOF(UserDept),2) + POWER((RowData.SEMESTER*10-UserSemester*10),2));
		 array(i) := temp;
		 i := i+1;
	
	END LOOP;	
	
	
	minVal1 := array(1);
	FOR j in 1..i-1 loop
	    IF (minVal1 > array(j)) THEN
		   minVal1 := array(j);
		   minIndex1 :=j;
	    END IF;
	END LOOP;
	
	
	
	
	
	array(minIndex1):=9999999;
	
	minVal2 := array(1);
	FOR j in 1..i-1 loop
	    IF (minVal2 > array(j)) THEN
		   minVal2 := array(j);
		   minIndex2 :=j;
	    END IF;
	END LOOP;
	
	
	
	
	array(minIndex2):=9999999;
	
	minVal3 := array(1);
	FOR j in 1..i-1 loop
	    IF (minVal3 > array(j)) THEN
		   minVal3 := array(j);
		   minIndex3 :=j;
	    END IF;
	END LOOP;
	
	
	SELECT BOOK_NEEDED INTO bookname1 FROM Book_RequestData WHERE SL=minIndex1;
	SELECT BOOK_NEEDED INTO bookname2 FROM Book_RequestData WHERE SL=minIndex2;
	SELECT BOOK_NEEDED INTO bookname3 FROM Book_RequestData WHERE SL=minIndex3;
	
	IF bookname1 != bookname2 THEN
	dbms_output.put_line('Recommended Books are: ');
	dbms_output.put_line(bookname1 ||' '||bookname2);
	END IF;
	IF bookname2 != bookname3 THEN
	dbms_output.put_line(bookname3);
	END IF;
	
END;
/



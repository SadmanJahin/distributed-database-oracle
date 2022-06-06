set linesize 160;
set wrap off;

drop TABLE Enlisted_Students;
drop TABLE BookRequested;
drop TABLE BookShared;
drop TABLE User_List;
drop TABLE Books;


CREATE TABLE Enlisted_Students
(
  sl_no number,
  university_email varchar2(100),
  student_name varchar2(50) not null,
  CONSTRAINT university_email_pk PRIMARY KEY (university_email)
);


INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (1,'170204059@aust.edu','Abrar Rafid');
INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (2,'170204066@aust.edu','Farhan Shahrukh');
INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (3,'170204067@aust.edu','Moniruzzaman Joy');
INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (4,'170204069@aust.edu','Rafsan Habib');
INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (5,'170204110@aust.edu','Miyad Bhuiyan');
INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (6,'170204114@aust.edu','Labib Abdullah');
INSERT INTO Enlisted_Students (sl_no,university_email, student_name) VALUES (7,'170204115@aust.edu','Sadman Jahin');




CREATE TABLE User_List
(
user_id number,
email VARCHAR2(100),
name VARCHAR2(100),
phone VARCHAR2(100),
semester VARCHAR2(100),
location VARCHAR2(100),
CONSTRAINT user_id_pk PRIMARY KEY (user_id)
);

INSERT INTO User_List (user_id,email,name,phone,semester,location) VALUES (1,'170204115@aust.edu','Sadman','01521437884','4.1','Dhaka');

CREATE TABLE Books
(
book_id number,
book_name VARCHAR2(100),
book_author VARCHAR2(100),
CONSTRAINT book_id_pk PRIMARY KEY (book_id)
);
INSERT INTO Books (book_id,book_name,book_author) VALUES ('1','DDS','M.Tamer');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('2','Electronics','Boylsted');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('3','Compiler','Alfred V.Aho');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('4','AI','Peter Norvig');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('5','Networking','Kurose Rose');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('6','Numerical Methods','P.Ramesh');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('7','Teach C++','Herbert Shcildt');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('9','Java','Ron');
INSERT INTO Books (book_id,book_name,book_author) VALUES ('10','Microelectornics','Jacob');




CREATE TABLE BookShared
(
post_id number,
book_id number,
user_id number,
CONSTRAINT post_id_pk PRIMARY KEY (post_id),
CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES Books (book_id),
CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES User_List (user_id)
);


INSERT INTO BookShared (post_id,book_id,user_id) VALUES ('1','1','1');


CREATE TABLE BookRequested
(
request_id number,
post_id number,
requester_id number,
CONSTRAINT request_id_pk PRIMARY KEY (request_id),
CONSTRAINT fk_post_id FOREIGN KEY (post_id) REFERENCES BookShared (post_id),
CONSTRAINT fk_requester_id FOREIGN KEY (requester_id) REFERENCES User_List (user_id)
);

CREATE TABLE User_Notification
(
user_id number,
notifications number,
notification_Type varchar2(100)
);
Insert INTO User_Notification(user_id,notifications,notification_Type)VALUES(1,0,'Book Request');

SELECT * FROM Enlisted_Students;
SELECT * FROM User_List;
SELECT * FROM Books;
SELECT * FROM BookShared;
SELECT * FROM BookRequested;
SELECT * FROM User_Notification;







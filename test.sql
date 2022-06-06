CREATE TABLE BookShared
(
post_id number,
book_id number,
user_id number,
CONSTRAINT post_id_pk PRIMARY KEY (post_id),
CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES Books (book_id),
CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES User_List (user_id)
);

DROP TABLE Books_Shared;
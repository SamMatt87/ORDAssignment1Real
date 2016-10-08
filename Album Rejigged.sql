CREATE TYPE ALBUM_TYPE3 AS OBJECT
(ALBUM_ID VARCHAR2(50),
TITLE VARCHAR2(100),
/*NAME OF THE ALBUM*/
PLAYTIME  NUMBER(4),
/*ALBUM LENGTH IN NUMBER OF MINUTES*/
GENRE VARCHAR2(30),
RELEASE_DATE  DATE,
/* THE DATE ON WHICH THE FIRST FORMAT OF THE ALBUM WAS RELEASED*/
TRACK TRACKS,
REVIEWS REVIEWS_TABLE,
BASE_PRICE NUMBER(10,2),
NOT FINAL MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER) NOT FINAL;
/
CREATE TABLE ALBUM3 OF ALBUM_TYPE3
  NESTED TABLE REVIEWS STORE AS REVIEWS_TAB3;
/
INSERT INTO ALBUM3 VALUES(ALBUM_TYPE3('ALB2000','The Future', 60, 'Rock', TO_DATE('10/11/1992', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'The Future',402,0.99,48),
TRACK_TYPE(2,'Waiting for the Miracle',462,0.99,60),
TRACK_TYPE(3,'Be for Real',272,0.99,30),
TRACK_TYPE(4,'Closing Time',360,0.99,36),
TRACK_TYPE(5,'Anthem',369,0.99,42),
TRACK_TYPE(6,'Democracy',434,0.99,18),
TRACK_TYPE(7,'Light As the Breeze',436,0.99,12),
TRACK_TYPE(8,'Always',484,0.99,24),
TRACK_TYPE(9,'Tacoma Trailer',358,0.99,36)),
REVIEWS_TABLE(REVIEW_TYPE(1, 'JAGarsea','No other reveiws? Mr. Cohen at his best since since his return to music. This album is for the those struggling with passion for life and still dancing with nihilism. If youre disenchanted with this world there is more than one song on here for you.',5.0,TO_DATE('23/08/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(2, 'Johnny_Offensive','If you are reading this - BUY THIS ALBUM. You''re welcome. Sad, beautiful - everything Leonard Cohen represents in full form.',5.0,TO_DATE('03/07/2012', 'DD/MM/YYYY'))
), 7.99));
/
CREATE TYPE CD_TYPE3 UNDER ALBUM_TYPE3
(NEW_OR_USED NUMBER(1),
/*1 FOR NEW, 0 FOR USED*/
PRICE NUMBER(5,2)
/*ALBUM PRICE IN $*/);
/
CREATE TYPE VINYL_TYPE3 UNDER ALBUM_TYPE3
(NEW_OR_USED NUMBER(1),
/*1 FOR NEW, 0 FOR USED*/
PRICE NUMBER(5,2)
/*ALBUM PRICE IN $*/);
/
CREATE TABLE CD3 OF CD_TYPE3
  NESTED TABLE REVIEWS STORE AS CD_REVIEWS_TAB3;
/
CREATE TABLE VINYL3 OF VINYL_TYPE3
  NESTED TABLE REVIEWS STORE AS VINYL_REVIEWS_TAB3;
/
INSERT INTO CD3
  SELECT ALB.*, 1, 7.99
  FROM ALBUM3 ALB
  WHERE ALB.ALBUM_ID = 'ALB2000';
/
INSERT INTO VINYL3
  SELECT ALB.*, 0, 12.99
  FROM ALBUM3 ALB
  WHERE ALB.ALBUM_ID = 'ALB2000';

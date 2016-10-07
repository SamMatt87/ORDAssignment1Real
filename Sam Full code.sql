DROP TABLE MP3;
DROP TABLE CD;
DROP TABLE VINYL;
DROP TABLE TAPE;
DROP TABLE PLAYLIST;
DROP TABLE ALSO_BOUGHT;
DROP TABLE ROLE;
DROP TABLE ALBUM;
DROP TABLE ARTIST;
DROP TYPE PLAYLIST_TYPE;
DROP TYPE PLAYLIST_TRACKS;
DROP TYPE PLAYLIST_TRACKS_TYPE;
DROP TYPE ALSO_BOUGHT_TYPE;
DROP TYPE ROLE_TYPE;
DROP TYPE MP3_TYPE;
DROP TYPE CD_TYPE;
DROP TYPE TAPE_TYPE;
DROP TYPE VINYL_TYPE;
DROP TYPE ALBUM_TYPE;
DROP TYPE REVIEWS_TABLE FORCE;
DROP TYPE TRACKS FORCE;
DROP TYPE REVIEW_TYPE FORCE;
DROP TYPE TRACK_TYPE FORCE;
DROP TYPE ARTIST_TYPE;
/
CREATE TYPE ARTIST_TYPE AS OBJECT
(ARTIST_ID  VARCHAR2(50),
ARTIST_NAME VARCHAR2(50));
/
CREATE TYPE TRACK_TYPE AS OBJECT
(TRACK_ID NUMBER(9),
SONG_TITLE  VARCHAR2(100),
SONG_DURATION NUMBER(4),
/* Duration expressed as number of seconds*/
SONG_PRICE  NUMBER(4,2),
/*TRACK PRICE EXPRESSED AS A NUMBER OF CENTS*/
DL_COUNT  NUMBER(10));
/
CREATE TYPE REVIEW_TYPE AS OBJECT
(REVIEW_ID  NUMBER(9),
REVIEWER_NAME VARCHAR2(20),
REVIEW_TEXT CLOB,
/*TEXT OF THE REVIEW*/
REVIEW_SCORE NUMBER(2,1),
/*REVIEW SCORE OUT OF 5*/
REVIEW_DATE DATE,
NOT FINAL MEMBER FUNCTION AVGREVIEWSCORE RETURN NUMBER) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY REVIEW_TYPE AS 
MEMBER FUNCTION AVGREVIEWSCORE RETURN NUMBER IS
AVGSCORE  NUMBER(4,2);
BEGIN
  DECLARE  RCOUNT NUMBER;
    RTOTAL  NUMBER;
  BEGIN
  IF REVIEWER_NAME IS NULL THEN
    RCOUNT:= RCOUNT+1;
    RTOTAL:= RTOTAL+REVIEW_SCORE;
  END IF;
  AVGSCORE:= RTOTAL/RCOUNT;
  RETURN AVGSCORE; 
  END;
END AVGREVIEWSCORE;
END;
/
CREATE TYPE TRACKS AS VARRAY(100) OF TRACK_TYPE;
/
CREATE TYPE REVIEWS_TABLE AS TABLE OF REVIEW_TYPE;
/
CREATE TYPE ALBUM_TYPE AS OBJECT
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
NOT FINAL MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER)NOT INSTANTIABLE NOT FINAL;
/
CREATE OR REPLACE TYPE BODY ALBUM_TYPE AS
MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER IS
BEGIN
  RETURN PLAYTIME;
END DISCOUNTPRICE;
END;
/
CREATE TYPE VINYL_TYPE UNDER ALBUM_TYPE
(NEW_OR_USED NUMBER(1),
/*1 FOR NEW, 0 FOR USED*/
PRICE NUMBER(5,2),
/*ALBUM PRICE IN $*/
OVERRIDING MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER);
/
CREATE OR REPLACE TYPE BODY VINYL_TYPE AS
OVERRIDING MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER IS
NEWPRICE  NUMBER;
BEGIN
IF (GENRE = 'ROCK') THEN
  NEWPRICE := PRICE * 0.85;
ELSIF (GENRE = 'JAZZ') THEN
  NEWPRICE := PRICE * 0.8;
ELSE
  NEWPRICE := PRICE;
END IF;
RETURN NEWPRICE;
END DISCOUNTPRICE;
END;
/
CREATE TYPE TAPE_TYPE UNDER ALBUM_TYPE
(NEW_OR_USED NUMBER(1),
/*1 FOR NEW, 0 FOR USED*/
PRICE NUMBER(5,2)
/*ALBUM PRICE IN $*/);
/
CREATE TYPE CD_TYPE UNDER ALBUM_TYPE
(NEW_OR_USED NUMBER(1),
/*1 FOR NEW, 0 FOR USED*/
PRICE NUMBER(5,2),
/*ALBUM PRICE IN $*/
OVERRIDING MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER);
/
CREATE OR REPLACE TYPE BODY CD_TYPE AS
OVERRIDING MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER IS
NEWPRICE NUMBER;
BEGIN
IF (NEW_OR_USED = 1 AND GENRE = 'CLASSICAL') THEN
  NEWPRICE := PRICE * 0.75;
ELSE
  NEWPRICE := PRICE;
END IF;
END DISCOUNTPRICE;
END;
/
CREATE TYPE MP3_TYPE UNDER ALBUM_TYPE
(PRICE NUMBER(5,2)
/*ALBUM PRICE IN $*/);
/
CREATE TYPE ROLE_TYPE AS OBJECT
(ARTIST_ID  REF ARTIST_TYPE,
ALBUM_ID  REF ALBUM_TYPE,
ROLE  VARCHAR2(20)
/*ROLE THE ARTIST PLAYED ON THE ALBUM*/);
/
CREATE TYPE ALSO_BOUGHT_TYPE AS OBJECT
(ALBUM_1_ID REF ALBUM_TYPE,
ALBUM_2_ID REF  ALBUM_TYPE);
/
CREATE TYPE PLAYLIST_TRACKS_TYPE AS OBJECT
(ALBUM_ID REF ALBUM_TYPE,
TRACK_ID REF TRACK_TYPE,
TRACK_NO  NUMBER(2)
/*NUMBER IN PLAYLIST*/);
/
CREATE TYPE PLAYLIST_TRACKS AS VARRAY(15) OF PLAYLIST_TRACKS_TYPE;
/
CREATE TYPE PLAYLIST_TYPE AS OBJECT
(PLAY_NO NUMBER(10),
/*UNIQUE PLAYLIST NUMBER*/
PLAYLIST_NAME VARCHAR(20),
/*NAME OF THE PLAYLIST*/
TRACKS  PLAYLIST_TRACKS
/*TRACKS IN PLAYLIST*/)
/
CREATE TABLE ARTIST OF ARTIST_TYPE;
CREATE TABLE ALBUM OF ALBUM_TYPE
  NESTED TABLE REVIEWS STORE AS REVIEWS_TAB;
CREATE TABLE ROLE OF ROLE_TYPE;
CREATE TABLE ALSO_BOUGHT OF ALSO_BOUGHT_TYPE;
CREATE TABLE PLAYLIST OF PLAYLIST_TYPE;
CREATE TABLE TAPE OF TAPE_TYPE
  NESTED TABLE REVIEWS STORE AS REVIEWS_TAPE;
CREATE TABLE CD OF CD_TYPE
  NESTED TABLE REVIEWS STORE AS REVIEWS_CD;
CREATE TABLE VINYL OF VINYL_TYPE
  NESTED TABLE REVIEWS STORE AS REVIEWS_VINYL;
CREATE TABLE MP3 OF MP3_TYPE
  NESTED TABLE REVIEWS STORE AS REVIEWS_MP3;
/
INSERT INTO CD VALUES (CD_TYPE('ALB986', 'I Can Stand A Little Rain',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Put Out The Light', 250, 1.29, 50),
TRACK_TYPE(2, 'I Can Stand A Little Rain', 212, 1.29, 50),
TRACK_TYPE(3, 'I Get Mad', 217, 1.29, 50),
TRACK_TYPE(4, 'Sing Me A Song', 144, 1.29, 50),
TRACK_TYPE(5, 'The Moon Is A Harsh Mistress', 210, 1.29, 50),
TRACK_TYPE(6, 'Dont Forget Me', 198, 1.29, 50),
TRACK_TYPE(7, 'You Are So Beautiful', 159, 1.29, 50),
TRACK_TYPE(8, 'Its A Sin When You Love Somebody', 227, 1.29, 50),
TRACK_TYPE(9, 'Performance', 277, 1.29, 50),
TRACK_TYPE(10, 'Guilty', 166, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not as good as some...', 2.0, TO_DATE('02/08/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Went from 8 track to cassette to finally a CD of this album, love every song!', 5.0, TO_DATE('20/06/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Not well recorded and song selection is poor does not bring to life his full voice command Winterland San Francisco 1968 was the best.', 1.0, TO_DATE('23/08/2013', 'DD/MM/YYYY'))),1,3.35));
/
INSERT INTO CD VALUES (CD_TYPE('ALB973', 'I Can Stand A Little Rain',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Put Out The Light', 250, 1.29, 50),
TRACK_TYPE(2, 'I Can Stand A Little Rain', 212, 1.29, 50),
TRACK_TYPE(3, 'I Get Mad', 217, 1.29, 50),
TRACK_TYPE(4, 'Sing Me A Song', 144, 1.29, 50),
TRACK_TYPE(5, 'The Moon Is A Harsh Mistress', 210, 1.29, 50),
TRACK_TYPE(6, 'Dont Forget Me', 198, 1.29, 50),
TRACK_TYPE(7, 'You Are So Beautiful', 159, 1.29, 50),
TRACK_TYPE(8, 'Its A Sin When You Love Somebody', 227, 1.29, 50),
TRACK_TYPE(9, 'Performance', 277, 1.29, 50),
TRACK_TYPE(10, 'Guilty', 166, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not as good as some...', 2.0, TO_DATE('02/08/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Went from 8 track to cassette to finally a CD of this album, love every song!', 5.0, TO_DATE('20/06/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Not well recorded and song selection is poor does not bring to life his full voice command Winterland San Francisco 1968 was the best.', 1.0, TO_DATE('23/08/2013', 'DD/MM/YYYY'))),0,2.34));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB986';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB973';
/
INSERT INTO CD VALUES (CD_TYPE('ALB987', 'Joe Cocker!',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Dear Landlord (Album Version)', 205, 1.29, 50),
TRACK_TYPE(2, 'Bird On A Wire (Album Version)', 268, 1.29, 50),
TRACK_TYPE(3, 'Lawdy Miss Clawdy (Album Version)', 133, 1.29, 50),
TRACK_TYPE(4, 'She Came In Through The Bathroom Window (Album Version)', 156, 1.29, 50),
TRACK_TYPE(5, 'Hitchcock Railway (Album Version)', 277, 1.29, 50),
TRACK_TYPE(6, 'Thats Your Business (Album Version)', 176, 1.29, 50),
TRACK_TYPE(7, 'Something (Album Version)', 211, 1.29, 50),
TRACK_TYPE(8, 'Delta Lady (Album Version)', 170, 1.29, 50),
TRACK_TYPE(9, 'Hello, Little Friend (Album Version)', 312, 1.29, 50),
TRACK_TYPE(10, 'Darling Be Home Soon (Album Version)', 485, 1.29, 50),
TRACK_TYPE(11, 'Shes Good To Me (Single Version)', 180, 1.29, 50),
TRACK_TYPE(12, 'Let It Be (Original Take)', 300, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not 5 stars .... mumbled lyrics , bad production, think its over rated from covers of beatles and Leon Russell connection.', 2.0, TO_DATE('23/05/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'The original and the greatest. Joe, I really miss you', 5.0, TO_DATE('16/05/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Great.', 5.0, TO_DATE('21/02/2015', 'DD/MM/YYYY'))),1,4.66));
/
INSERT INTO CD VALUES (CD_TYPE('ALB974', 'Joe Cocker!',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Dear Landlord (Album Version)', 205, 1.29, 50),
TRACK_TYPE(2, 'Bird On A Wire (Album Version)', 268, 1.29, 50),
TRACK_TYPE(3, 'Lawdy Miss Clawdy (Album Version)', 133, 1.29, 50),
TRACK_TYPE(4, 'She Came In Through The Bathroom Window (Album Version)', 156, 1.29, 50),
TRACK_TYPE(5, 'Hitchcock Railway (Album Version)', 277, 1.29, 50),
TRACK_TYPE(6, 'Thats Your Business (Album Version)', 176, 1.29, 50),
TRACK_TYPE(7, 'Something (Album Version)', 211, 1.29, 50),
TRACK_TYPE(8, 'Delta Lady (Album Version)', 170, 1.29, 50),
TRACK_TYPE(9, 'Hello, Little Friend (Album Version)', 312, 1.29, 50),
TRACK_TYPE(10, 'Darling Be Home Soon (Album Version)', 485, 1.29, 50),
TRACK_TYPE(11, 'Shes Good To Me (Single Version)', 180, 1.29, 50),
TRACK_TYPE(12, 'Let It Be (Original Take)', 300, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not 5 stars .... mumbled lyrics , bad production, think its over rated from covers of beatles and Leon Russell connection.', 2.0, TO_DATE('23/05/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'The original and the greatest. Joe, I really miss you', 5.0, TO_DATE('16/05/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Great.', 5.0, TO_DATE('21/02/2015', 'DD/MM/YYYY'))),0,3.33));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB987';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB974';
/
INSERT INTO CD VALUES (CD_TYPE('ALB988', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),1,4.99));
/
INSERT INTO CD VALUES (CD_TYPE('ALB975', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),0,0.24));

/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART989','Joe Cocker'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB988';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB975';
/
INSERT INTO CD VALUES (CD_TYPE('ALB989', 'The Magnificent Moodies',74,'Rock', TO_DATE('15/12/2014', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Ill Go Crazy', 131, 0.99, 50),
TRACK_TYPE(2, 'Something You Got', 172, 0.99, 50),
TRACK_TYPE(3, 'Go Now', 192, 0.99, 50),
TRACK_TYPE(4, 'Cant Nobody Love You', 242, 0.99, 50),
TRACK_TYPE(5, 'I Dont Mind', 207, 0.99, 50),
TRACK_TYPE(6, 'Ive Got a Dream', 172, 0.99, 50),
TRACK_TYPE(7, 'Let Me Go', 193, 0.99, 50),
TRACK_TYPE(8, 'Stop', 126, 0.99, 50),
TRACK_TYPE(9, 'Thank You Baby', 149, 0.99, 50),
TRACK_TYPE(10, 'It Aint Necessarily So', 201, 0.99, 50),
TRACK_TYPE(11, 'True Story', 105, 0.99, 50),
TRACK_TYPE(12, 'Bye Bye Bird', 173, 0.99, 50),
TRACK_TYPE(13, 'Lose Your Money (But Dont Lose Your Mind)', 119, 0.99, 50),
TRACK_TYPE(14, 'Steal Your Heart Away', 134, 0.99, 50),
TRACK_TYPE(15, 'Go Now! (First Version)', 229, 0.99, 50),
TRACK_TYPE(16, 'Its Easy Child', 193, 0.99, 50),
TRACK_TYPE(17, 'I Dont Want to Go on Without You', 166, 0.99, 50),
TRACK_TYPE(18, 'Time Is on My Side', 183, 0.99, 50),
TRACK_TYPE(19, 'From the Bottom of My Heart (I Love You)', 206, 0.99, 50),
TRACK_TYPE(20, 'And My Babys Gone', 142, 0.99, 50),
TRACK_TYPE(21, 'Everyday', 109, 0.99, 50),
TRACK_TYPE(22, 'You Dont (All the Time)', 142, 0.99, 50),
TRACK_TYPE(23, 'Boulevard De Madeleine', 175, 0.99, 50),
TRACK_TYPE(24, 'This Is My House (But Nobody Calls)', 155, 0.99, 50),
TRACK_TYPE(25, 'People Gotta Go', 155, 0.99, 50),
TRACK_TYPE(26, 'Lifes Not Life', 155, 0.99, 50),
TRACK_TYPE(27, 'He Can Win', 144, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'I quess this is great for historic significance but the sound quality and music, for that matter, is horrible.', 1.0, TO_DATE('21/11/2009', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Michael S', 'Nice history lesson. Better than I expected but certainly NOT like the Moodys I knew in college.', 4.0, TO_DATE('17/03/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Robert E', 'Classic.', 5.0, TO_DATE('12/09/2016', 'DD/MM/YYYY'))),1,13.99));
/
INSERT INTO CD VALUES (CD_TYPE('ALB976', 'The Magnificent Moodies',74,'Rock', TO_DATE('15/12/2014', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Ill Go Crazy', 131, 0.99, 50),
TRACK_TYPE(2, 'Something You Got', 172, 0.99, 50),
TRACK_TYPE(3, 'Go Now', 192, 0.99, 50),
TRACK_TYPE(4, 'Cant Nobody Love You', 242, 0.99, 50),
TRACK_TYPE(5, 'I Dont Mind', 207, 0.99, 50),
TRACK_TYPE(6, 'Ive Got a Dream', 172, 0.99, 50),
TRACK_TYPE(7, 'Let Me Go', 193, 0.99, 50),
TRACK_TYPE(8, 'Stop', 126, 0.99, 50),
TRACK_TYPE(9, 'Thank You Baby', 149, 0.99, 50),
TRACK_TYPE(10, 'It Aint Necessarily So', 201, 0.99, 50),
TRACK_TYPE(11, 'True Story', 105, 0.99, 50),
TRACK_TYPE(12, 'Bye Bye Bird', 173, 0.99, 50),
TRACK_TYPE(13, 'Lose Your Money (But Dont Lose Your Mind)', 119, 0.99, 50),
TRACK_TYPE(14, 'Steal Your Heart Away', 134, 0.99, 50),
TRACK_TYPE(15, 'Go Now! (First Version)', 229, 0.99, 50),
TRACK_TYPE(16, 'Its Easy Child', 193, 0.99, 50),
TRACK_TYPE(17, 'I Dont Want to Go on Without You', 166, 0.99, 50),
TRACK_TYPE(18, 'Time Is on My Side', 183, 0.99, 50),
TRACK_TYPE(19, 'From the Bottom of My Heart (I Love You)', 206, 0.99, 50),
TRACK_TYPE(20, 'And My Babys Gone', 142, 0.99, 50),
TRACK_TYPE(21, 'Everyday', 109, 0.99, 50),
TRACK_TYPE(22, 'You Dont (All the Time)', 142, 0.99, 50),
TRACK_TYPE(23, 'Boulevard De Madeleine', 175, 0.99, 50),
TRACK_TYPE(24, 'This Is My House (But Nobody Calls)', 155, 0.99, 50),
TRACK_TYPE(25, 'People Gotta Go', 155, 0.99, 50),
TRACK_TYPE(26, 'Lifes Not Life', 155, 0.99, 50),
TRACK_TYPE(27, 'He Can Win', 144, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'I quess this is great for historic significance but the sound quality and music, for that matter, is horrible.', 1.0, TO_DATE('21/11/2009', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Michael S', 'Nice history lesson. Better than I expected but certainly NOT like the Moodys I knew in college.', 4.0, TO_DATE('17/03/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Robert E', 'Classic.', 5.0, TO_DATE('12/09/2016', 'DD/MM/YYYY'))),0,10.29));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART990','The Moody Blues'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB989';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB976';
/
INSERT INTO CD VALUES (CD_TYPE('ALB990', 'The Magnificent Void',69,'New Age', TO_DATE('22/02/1996', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Between the Gray and the Purple', 460, 0.99, 50),
TRACK_TYPE(2, 'Void Memory One', 173, 0.99, 50),
TRACK_TYPE(3, 'Infinite Shore', 467, 0.99, 50),
TRACK_TYPE(4, 'Cloud of Unknowing', 638, 0.99, 50),
TRACK_TYPE(5, 'Void Memory Two', 220, 0.99, 50),
TRACK_TYPE(6, 'Void Memory Three', 220, 0.99, 50),
TRACK_TYPE(7, 'The Magnificent Void', 792, 0.99, 50),
TRACK_TYPE(8, 'Atlus', 1201, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Lonnie Collins', 'Another easy listening..', 4.0, TO_DATE('08/03/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Dark and spacey. Great nighttime music for reading or sleeping. One of the best ambient CDs I own.', 5.0, TO_DATE('28/03/2009','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Im a fan of much of Steve Roachs work. Dreamtime Return is still a favorite. But Magnificent Void has none of the magical quality of those discs, and is downright dark. The repetitive bass notes and rumble might be nice for a sci-fi horror movie. But it makes for boring listening. Pass on this one.', 1.0, TO_DATE('29/04/2009', 'DD/MM/YYYY'))),1,13.99));
/
INSERT INTO CD VALUES (CD_TYPE('ALB977', 'The Magnificent Void',69,'New Age', TO_DATE('22/02/1996', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Between the Gray and the Purple', 460, 0.99, 50),
TRACK_TYPE(2, 'Void Memory One', 173, 0.99, 50),
TRACK_TYPE(3, 'Infinite Shore', 467, 0.99, 50),
TRACK_TYPE(4, 'Cloud of Unknowing', 638, 0.99, 50),
TRACK_TYPE(5, 'Void Memory Two', 220, 0.99, 50),
TRACK_TYPE(6, 'Void Memory Three', 220, 0.99, 50),
TRACK_TYPE(7, 'The Magnificent Void', 792, 0.99, 50),
TRACK_TYPE(8, 'Atlus', 1201, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Lonnie Collins', 'Another easy listening..', 4.0, TO_DATE('08/03/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Dark and spacey. Great nighttime music for reading or sleeping. One of the best ambient CDs I own.', 5.0, TO_DATE('28/03/2009','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Im a fan of much of Steve Roachs work. Dreamtime Return is still a favorite. But Magnificent Void has none of the magical quality of those discs, and is downright dark. The repetitive bass notes and rumble might be nice for a sci-fi horror movie. But it makes for boring listening. Pass on this one.', 1.0, TO_DATE('29/04/2009', 'DD/MM/YYYY'))),0,4.90));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART991','Steve Roach'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART991' AND ALB.ALBUM_ID = 'ALB990';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART991' AND ALB.ALBUM_ID = 'ALB977';
/
INSERT INTO CD VALUES (CD_TYPE('ALB991', 'The Magnificent',32,'Rap', TO_DATE('13/08/2002', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'The Magnificent - featuring Pauly Yamz and Baby Blak', 107, 1.29, 50),
TRACK_TYPE(2, 'Shake It Off - featuring Chef Word', 53, 1.29, 50),
TRACK_TYPE(3, 'For The Love of Da Game - featuring Pauly Yamz and Baby Blak', 83, 1.29, 50),
TRACK_TYPE(4, 'How I Do - featuring Shawn Stockman (Boyz II Men)', 134, 1.29, 50),
TRACK_TYPE(5, 'Break It Down - featuring J-Live', 67, 1.29, 50),
TRACK_TYPE(6, ' Musik Lounge - featuring Odyssey', 158, 1.29, 50),
TRACK_TYPE(7, 'Rock Wit U - featuring Erro', 97, 1.29, 50),
TRACK_TYPE(8, 'Scram - featuring Freddie Foxxx', 99, 1.29, 50),
TRACK_TYPE(9, 'My People - featuring Raheem', 71, 1.29, 50),
TRACK_TYPE(10, 'Know Ur Hood - featuring Pauly Yamz and Chef Word', 89, 1.29, 50),
TRACK_TYPE(11, 'Love Saviour - featuring Flo Brown and Raheem', 38, 1.29, 50),
TRACK_TYPE(12, 'Mystery Man - featuring The Last Emperor', 153, 1.29, 50),
TRACK_TYPE(13, 'We Are - featuring Cy Young and Raheem', 81, 1.29, 50),
TRACK_TYPE(14, 'A Charmed Life - featuring J-Live', 118, 1.29, 50),
TRACK_TYPE(15, 'We Live In Philly - featuring Jill Scott', 68, 1.29, 50),
TRACK_TYPE(16, 'In Time - featuring V', 115, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Ryan Rose', 'This album is niceness. 100% natural churned butter baby! Lovely!', 5.0, TO_DATE('15/05/2003', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'L. Dogg', 'Had to have this one.Heavy beats,all round ensemble of artists and a general good feel of an album. Was lacking in some ways,just cant put my finger on it though!', 3.0, TO_DATE('28/02/2005','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'A truly stunning CD. Best beats and music I have had the pleasure of listenin to in a while. All bases covered with STYLE. Buy, listen and enjoy.', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),1,12.42));
/
INSERT INTO CD VALUES (CD_TYPE('ALB977', 'The Magnificent',32,'Rap', TO_DATE('13/08/2002', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'The Magnificent - featuring Pauly Yamz and Baby Blak', 107, 1.29, 50),
TRACK_TYPE(2, 'Shake It Off - featuring Chef Word', 53, 1.29, 50),
TRACK_TYPE(3, 'For The Love of Da Game - featuring Pauly Yamz and Baby Blak', 83, 1.29, 50),
TRACK_TYPE(4, 'How I Do - featuring Shawn Stockman (Boyz II Men)', 134, 1.29, 50),
TRACK_TYPE(5, 'Break It Down - featuring J-Live', 67, 1.29, 50),
TRACK_TYPE(6, ' Musik Lounge - featuring Odyssey', 158, 1.29, 50),
TRACK_TYPE(7, 'Rock Wit U - featuring Erro', 97, 1.29, 50),
TRACK_TYPE(8, 'Scram - featuring Freddie Foxxx', 99, 1.29, 50),
TRACK_TYPE(9, 'My People - featuring Raheem', 71, 1.29, 50),
TRACK_TYPE(10, 'Know Ur Hood - featuring Pauly Yamz and Chef Word', 89, 1.29, 50),
TRACK_TYPE(11, 'Love Saviour - featuring Flo Brown and Raheem', 38, 1.29, 50),
TRACK_TYPE(12, 'Mystery Man - featuring The Last Emperor', 153, 1.29, 50),
TRACK_TYPE(13, 'We Are - featuring Cy Young and Raheem', 81, 1.29, 50),
TRACK_TYPE(14, 'A Charmed Life - featuring J-Live', 118, 1.29, 50),
TRACK_TYPE(15, 'We Live In Philly - featuring Jill Scott', 68, 1.29, 50),
TRACK_TYPE(16, 'In Time - featuring V', 115, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Ryan Rose', 'This album is niceness. 100% natural churned butter baby! Lovely!', 5.0, TO_DATE('15/05/2003', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'L. Dogg', 'Had to have this one.Heavy beats,all round ensemble of artists and a general good feel of an album. Was lacking in some ways,just cant put my finger on it though!', 3.0, TO_DATE('28/02/2005','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'A truly stunning CD. Best beats and music I have had the pleasure of listenin to in a while. All bases covered with STYLE. Buy, listen and enjoy.', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),0,0.98));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART992','DJ Jazzy Jeff'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Rapper'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART992' AND ALB.ALBUM_ID = 'ALB991';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Rapper'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART992' AND ALB.ALBUM_ID = 'ALB977';
/
INSERT INTO CD VALUES (CD_TYPE('ALB992', 'The Vigil',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Galaxy 32 Star 4', 500, 1.29, 50),
TRACK_TYPE(2, 'Planet Chia', 666, 1.29, 50),
TRACK_TYPE(3, 'portals to Forever', 962, 1.29, 50),
TRACK_TYPE(4, 'Royalty', 558, 1.29, 50),
TRACK_TYPE(5, 'Outside of Space', 299, 1.29, 50),
TRACK_TYPE(6, 'Pledge for Peace', 1055, 1.29, 50),
TRACK_TYPE(7, 'Legacy', 600, 1.29, 50),
TRACK_TYPE(8, 'Hot House (Live)', 508, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Penelope Nicolopolis', 'I really like this CD. But, Im not enthralled by it like some of Chick Coreas other works. I dont really know whats missing. It could be that I need to listen to it more. But, in my mind and heart, Chick Corea still remains one of the BEST Jazz musicians around - even if this project doesnt send me', 4.0, TO_DATE('27/01/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'I consider Chick Corea to be the best jazz musician of all time His top albums like Lerechaun are the most creative i have ever heard and he plays all the instruments This cd is Ok but not up the the best of Chick Corea', 3.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This CD is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),1,12.28));
/
INSERT INTO CD VALUES (CD_TYPE('ALB978', 'The Vigil',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Galaxy 32 Star 4', 500, 1.29, 50),
TRACK_TYPE(2, 'Planet Chia', 666, 1.29, 50),
TRACK_TYPE(3, 'portals to Forever', 962, 1.29, 50),
TRACK_TYPE(4, 'Royalty', 558, 1.29, 50),
TRACK_TYPE(5, 'Outside of Space', 299, 1.29, 50),
TRACK_TYPE(6, 'Pledge for Peace', 1055, 1.29, 50),
TRACK_TYPE(7, 'Legacy', 600, 1.29, 50),
TRACK_TYPE(8, 'Hot House (Live)', 508, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Penelope Nicolopolis', 'I really like this CD. But, Im not enthralled by it like some of Chick Coreas other works. I dont really know whats missing. It could be that I need to listen to it more. But, in my mind and heart, Chick Corea still remains one of the BEST Jazz musicians around - even if this project doesnt send me', 4.0, TO_DATE('27/01/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'I consider Chick Corea to be the best jazz musician of all time His top albums like Lerechaun are the most creative i have ever heard and he plays all the instruments This cd is Ok but not up the the best of Chick Corea', 3.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This CD is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),0,3.99));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB992';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB978';
/
INSERT INTO CD VALUES (CD_TYPE('ALB993', 'Childrens Songs',32,'Jazz', TO_DATE('30/09/2008', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Childrens Songs No. 1', 107, 1.29, 50),
TRACK_TYPE(2, 'Childrens Songs No. 2', 53, 1.29, 50),
TRACK_TYPE(3, 'Childrens Songs No. 3', 83, 1.29, 50),
TRACK_TYPE(4, 'Childrens Songs No. 4', 134, 1.29, 50),
TRACK_TYPE(5, 'Childrens Songs No. 5', 67, 1.29, 50),
TRACK_TYPE(6, 'Childrens Songs No. 6', 158, 1.29, 50),
TRACK_TYPE(7, 'Childrens Songs No. 7', 97, 1.29, 50),
TRACK_TYPE(8, 'Childrens Songs No. 8', 99, 1.29, 50),
TRACK_TYPE(9, 'Childrens Songs No. 9', 71, 1.29, 50),
TRACK_TYPE(10, 'Childrens Songs No. 10', 89, 1.29, 50),
TRACK_TYPE(11, 'Childrens Songs No. 11', 38, 1.29, 50),
TRACK_TYPE(12, 'Childrens Songs No. 12', 153, 1.29, 50),
TRACK_TYPE(13, 'Childrens Songs No. 13', 81, 1.29, 50),
TRACK_TYPE(14, 'Childrens Songs No. 14', 118, 1.29, 50),
TRACK_TYPE(15, 'Childrens Songs No. 15', 68, 1.29, 50),
TRACK_TYPE(16, 'Childrens Songs No. 16+17', 115, 1.29, 50),
TRACK_TYPE(17, 'Childrens Songs No. 18', 108, 1.29, 50),
TRACK_TYPE(18, 'Childrens Songs No. 19', 146, 1.29, 50),
TRACK_TYPE(19, 'Childrens Songs No. 20', 80, 1.29, 50),
TRACK_TYPE(20, 'Childrens Songs: Addendum', 310, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'OK, blasphemy coming, but to tell the truth I was very disappointed when this came out in 1979. I had been a fan since Return to Forever with Joe Farrell. I enjoyed some of his Childrens songs compositions on the Piano Improvisations and Crystal silence albums, but when I first heard this album, with great anticipation mind you, I thought his reinterpretations sounded rushed and kind of spoiled my memories of seven years prior. I think its an album he should have recorded earlier. The magic was lost somehow by this time.', 3.0, TO_DATE('02/11/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Martin', 'A classic. Períod.', 5.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Domingo Carbrera', 'One of the best recordings of this great master. !', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),1,10.18));
/
INSERT INTO CD VALUES (CD_TYPE('ALB979', 'Childrens Songs',32,'Jazz', TO_DATE('30/09/2008', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Childrens Songs No. 1', 107, 1.29, 50),
TRACK_TYPE(2, 'Childrens Songs No. 2', 53, 1.29, 50),
TRACK_TYPE(3, 'Childrens Songs No. 3', 83, 1.29, 50),
TRACK_TYPE(4, 'Childrens Songs No. 4', 134, 1.29, 50),
TRACK_TYPE(5, 'Childrens Songs No. 5', 67, 1.29, 50),
TRACK_TYPE(6, 'Childrens Songs No. 6', 158, 1.29, 50),
TRACK_TYPE(7, 'Childrens Songs No. 7', 97, 1.29, 50),
TRACK_TYPE(8, 'Childrens Songs No. 8', 99, 1.29, 50),
TRACK_TYPE(9, 'Childrens Songs No. 9', 71, 1.29, 50),
TRACK_TYPE(10, 'Childrens Songs No. 10', 89, 1.29, 50),
TRACK_TYPE(11, 'Childrens Songs No. 11', 38, 1.29, 50),
TRACK_TYPE(12, 'Childrens Songs No. 12', 153, 1.29, 50),
TRACK_TYPE(13, 'Childrens Songs No. 13', 81, 1.29, 50),
TRACK_TYPE(14, 'Childrens Songs No. 14', 118, 1.29, 50),
TRACK_TYPE(15, 'Childrens Songs No. 15', 68, 1.29, 50),
TRACK_TYPE(16, 'Childrens Songs No. 16+17', 115, 1.29, 50),
TRACK_TYPE(17, 'Childrens Songs No. 18', 108, 1.29, 50),
TRACK_TYPE(18, 'Childrens Songs No. 19', 146, 1.29, 50),
TRACK_TYPE(19, 'Childrens Songs No. 20', 80, 1.29, 50),
TRACK_TYPE(20, 'Childrens Songs: Addendum', 310, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'OK, blasphemy coming, but to tell the truth I was very disappointed when this came out in 1979. I had been a fan since Return to Forever with Joe Farrell. I enjoyed some of his Childrens songs compositions on the Piano Improvisations and Crystal silence albums, but when I first heard this album, with great anticipation mind you, I thought his reinterpretations sounded rushed and kind of spoiled my memories of seven years prior. I think its an album he should have recorded earlier. The magic was lost somehow by this time.', 3.0, TO_DATE('02/11/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Martin', 'A classic. Períod.', 5.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Domingo Carbrera', 'One of the best recordings of this great master. !', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),0,3.83));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB993';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB979';
/

INSERT INTO CD VALUES (CD_TYPE('ALB994', 'Duet',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Very Early', 553, 1.29, 50),
TRACK_TYPE(2, 'How Insensitive', 457, 1.29, 50),
TRACK_TYPE(3, 'Deja Vu', 541, 1.29, 50),
TRACK_TYPE(4, 'Foot on the Hill', 406, 1.29, 50),
TRACK_TYPE(5, 'Humpty Dumpty', 470, 1.29, 50),
TRACK_TYPE(6, 'Bolivar Blues', 525, 1.29, 50),
TRACK_TYPE(7, 'Windows', 465, 1.29, 50),
TRACK_TYPE(8, 'Old Castle', 896, 1.29, 50),
TRACK_TYPE(9, 'Summertime', 530, 1.29, 50),
TRACK_TYPE(10, 'Place to Be', 492, 1.29, 50),
TRACK_TYPE(11, 'Do Mo - Childrens Songs # 12', 782, 1.29, 50),
TRACK_TYPE(12, 'Concierto de Aranjuez/Spain', 731, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'K Patrick Batka', 'Classical type project. Very soothing.', 4.0, TO_DATE('08/11/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Courton Loreno', 'Arrived in timely fashion, no damage done to it.', 5.0, TO_DATE('11/08/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, 'meryes', 'This CD Duet Chick and Hiromi is both artists showcasing their artisty, but I felt that it was too "competitive". Instead of a wonderful collaborative listening experience, I felt as if I listened to two great artists competing with each other. They did not blend and complement each other as much as fight for center stage. I much prefer Hiromis solo album Place To Be to this collaboration.', 2.0, TO_DATE('27/01/2011', 'DD/MM/YYYY'))),1,19.99));
/
INSERT INTO CD VALUES (CD_TYPE('ALB980', 'Duet',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Very Early', 553, 1.29, 50),
TRACK_TYPE(2, 'How Insensitive', 457, 1.29, 50),
TRACK_TYPE(3, 'Deja Vu', 541, 1.29, 50),
TRACK_TYPE(4, 'Foot on the Hill', 406, 1.29, 50),
TRACK_TYPE(5, 'Humpty Dumpty', 470, 1.29, 50),
TRACK_TYPE(6, 'Bolivar Blues', 525, 1.29, 50),
TRACK_TYPE(7, 'Windows', 465, 1.29, 50),
TRACK_TYPE(8, 'Old Castle', 896, 1.29, 50),
TRACK_TYPE(9, 'Summertime', 530, 1.29, 50),
TRACK_TYPE(10, 'Place to Be', 492, 1.29, 50),
TRACK_TYPE(11, 'Do Mo - Childrens Songs # 12', 782, 1.29, 50),
TRACK_TYPE(12, 'Concierto de Aranjuez/Spain', 731, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'K Patrick Batka', 'Classical type project. Very soothing.', 4.0, TO_DATE('08/11/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Courton Loreno', 'Arrived in timely fashion, no damage done to it.', 5.0, TO_DATE('11/08/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, 'meryes', 'This CD Duet Chick and Hiromi is both artists showcasing their artisty, but I felt that it was too "competitive". Instead of a wonderful collaborative listening experience, I felt as if I listened to two great artists competing with each other. They did not blend and complement each other as much as fight for center stage. I much prefer Hiromis solo album Place To Be to this collaboration.', 2.0, TO_DATE('27/01/2011', 'DD/MM/YYYY'))),0, 9.95));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART994','Cick Corea'));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART993','Hiromi'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB994';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART993' AND ALB.ALBUM_ID = 'ALB994';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART993' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO CD VALUES (CD_TYPE('ALB995', 'Blowin in the Wind',32,'Pop', TO_DATE('31/05/2011', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Railroad', 185, 0.99, 50),
TRACK_TYPE(2, 'Blowin in the Wind', 131, 0.99, 50),
TRACK_TYPE(3, 'Edens Island', 127, 0.99, 50),
TRACK_TYPE(4, 'Arri Rang', 136, 0.99, 50),
TRACK_TYPE(5, 'Hes Gone Away', 166, 0.99, 50),
TRACK_TYPE(6, 'Arthurs Line', 101, 0.99, 50),
TRACK_TYPE(7, '	Brazilleros [Bossa Nova]', 160, 0.99, 50),
TRACK_TYPE(8, 'My Coloring Book', 238, 0.99, 50),
TRACK_TYPE(9, 'Watermelon Man', 160, 0.99, 50),
TRACK_TYPE(10, 'Fantasia Mexicana', 239, 0.99, 50),
TRACK_TYPE(11, 'Sweet Someone', 201, 0.99, 50),
TRACK_TYPE(12, 'Suzys Waltz', 176, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'The hell is this', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Well I though it was Good.', 5.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Meh, it was so-so', 2.5, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1,12.98));
/
INSERT INTO CD VALUES (CD_TYPE('ALB981', 'Blowin in the Wind',32,'Pop', TO_DATE('31/05/2011', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Railroad', 185, 0.99, 50),
TRACK_TYPE(2, 'Blowin in the Wind', 131, 0.99, 50),
TRACK_TYPE(3, 'Edens Island', 127, 0.99, 50),
TRACK_TYPE(4, 'Arri Rang', 136, 0.99, 50),
TRACK_TYPE(5, 'Hes Gone Away', 166, 0.99, 50),
TRACK_TYPE(6, 'Arthurs Line', 101, 0.99, 50),
TRACK_TYPE(7, '	Brazilleros [Bossa Nova]', 160, 0.99, 50),
TRACK_TYPE(8, 'My Coloring Book', 238, 0.99, 50),
TRACK_TYPE(9, 'Watermelon Man', 160, 0.99, 50),
TRACK_TYPE(10, 'Fantasia Mexicana', 239, 0.99, 50),
TRACK_TYPE(11, 'Sweet Someone', 201, 0.99, 50),
TRACK_TYPE(12, 'Suzys Waltz', 176, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'The hell is this', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Well I though it was Good.', 5.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Meh, it was so-so', 2.5, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,8.47));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART995','Arthur Lyman'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB995';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB981';
/
INSERT INTO CD VALUES (CD_TYPE('ALB996', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many CDs in my juke boxes yet I get SACDs for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1,6.99));
/
INSERT INTO CD VALUES (CD_TYPE('ALB982', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many CDs in my juke boxes yet I get SACDs for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,3.55));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART996','Bob Dylan'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB996';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB982';
/
INSERT INTO CD VALUES (CD_TYPE('ALB997', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Hey Hey, My My (Into The Black) (1991 Live)', 342, 1.32, 50),
TRACK_TYPE(2, 'Crime In the City (1991 Live)', 392, 1.32, 50),
TRACK_TYPE(3, 'Blowin In the Wind (1991 Live)', 409, 1.32, 50),
TRACK_TYPE(4, 'Welfare Mothers (1991 Live)', 424, 1.32, 50),
TRACK_TYPE(5, 'Love to Burn (1991 Live)', 601, 1.32, 50),
TRACK_TYPE(6, 'Cinamon Girl (1991 Live)', 285, 1.32, 50),
TRACK_TYPE(7, 'Mansion on the Hill (1991 Live)', 374, 1.32, 50),
TRACK_TYPE(8, 'Fuckin Up (1991 Live)', 429, 1.32, 50),
TRACK_TYPE(9, 'Cortez the Killer (1991 Live)', 586, 1.32, 50),
TRACK_TYPE(10, 'Powderfinger (1991 Live)', 358, 1.32, 50),
TRACK_TYPE(11, 'Love and Only Love (1991 Live)', 557, 1.32, 50),
TRACK_TYPE(12, 'Rockin in the Free World (1991 Live Album Version)', 562, 1.32, 50),
TRACK_TYPE(13, 'Like a Hurricane (1991 Live)', 840, 1.32, 50),
TRACK_TYPE(14, 'Farmer John (Into The Black) (1991 Live)', 300, 1.32, 50),
TRACK_TYPE(15, 'Tonights the Night (1991 Live)', 525, 1.32, 50),
TRACK_TYPE(16, 'Roll Another Number (1991 Live)', 319, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'David Marshall', 'Any live album will be enjoyed by all', 5.0, TO_DATE('15/06/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Paul Hackbath', 'Very good.', 3.0, TO_DATE('20/05/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1,4.41));
/
INSERT INTO CD VALUES (CD_TYPE('ALB983', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Hey Hey, My My (Into The Black) (1991 Live)', 342, 1.32, 50),
TRACK_TYPE(2, 'Crime In the City (1991 Live)', 392, 1.32, 50),
TRACK_TYPE(3, 'Blowin In the Wind (1991 Live)', 409, 1.32, 50),
TRACK_TYPE(4, 'Welfare Mothers (1991 Live)', 424, 1.32, 50),
TRACK_TYPE(5, 'Love to Burn (1991 Live)', 601, 1.32, 50),
TRACK_TYPE(6, 'Cinamon Girl (1991 Live)', 285, 1.32, 50),
TRACK_TYPE(7, 'Mansion on the Hill (1991 Live)', 374, 1.32, 50),
TRACK_TYPE(8, 'Fuckin Up (1991 Live)', 429, 1.32, 50),
TRACK_TYPE(9, 'Cortez the Killer (1991 Live)', 586, 1.32, 50),
TRACK_TYPE(10, 'Powderfinger (1991 Live)', 358, 1.32, 50),
TRACK_TYPE(11, 'Love and Only Love (1991 Live)', 557, 1.32, 50),
TRACK_TYPE(12, 'Rockin in the Free World (1991 Live Album Version)', 562, 1.32, 50),
TRACK_TYPE(13, 'Like a Hurricane (1991 Live)', 840, 1.32, 50),
TRACK_TYPE(14, 'Farmer John (Into The Black) (1991 Live)', 300, 1.32, 50),
TRACK_TYPE(15, 'Tonights the Night (1991 Live)', 525, 1.32, 50),
TRACK_TYPE(16, 'Roll Another Number (1991 Live)', 319, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'David Marshall', 'Any live album will be enjoyed by all', 5.0, TO_DATE('15/06/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Paul Hackbath', 'Very good.', 3.0, TO_DATE('20/05/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,3.41));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART998','Neil Young'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART997','Crazy Horse'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB983';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB983';
/
INSERT INTO CD VALUES(CD_TYPE('ALB999','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99,10),
TRACK_TYPE(2,'Will O the wisp',229,0.99,50),
TRACK_TYPE(3,'The Pan Piper',237,0.99,40),
TRACK_TYPE(4,'Saeta',335,0.99,30),
TRACK_TYPE(5,'Solea',938,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))
), 1, 6.99));
/
INSERT INTO CD VALUES(CD_TYPE('ALB984','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99,10),
TRACK_TYPE(2,'Will O the wisp',229,0.99,50),
TRACK_TYPE(3,'The Pan Piper',237,0.99,40),
TRACK_TYPE(4,'Saeta',335,0.99,30),
TRACK_TYPE(5,'Solea',938,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))
), 0, 0.65));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART999','Miles Davis'));
/
INSERT INTO CD VALUES(CD_TYPE('ALB998','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Pharohs dance',1204,0.99,10),
TRACK_TYPE(2,'Bitches Brew',1619,0.99,10),
TRACK_TYPE(3,'Spanish Key',1052,0.99,40),
TRACK_TYPE(4,'John Mclaughlin',262,0.99,30),
TRACK_TYPE(5,'Miles Runs the Voodoo Down',841,0.99,50),
TRACK_TYPE(6,'Sanctuary',656,0.99,10),
TRACK_TYPE(5,'Feio',709,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,NULL,'Im getting broken in. Have listened to it 3 times and am still trying to like it. I like some other Miles Davis albums waaaaay better!
My top 3:
1) Milestones
2) Kind of Blue
3) In a Silent Way',3.0, TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Been waiting a long time to hear this again. Miles is brilliant!', 5.0, TO_DATE('21/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Rita Sweeney', 'Love it!',5.0, TO_DATE('29/6/2016', 'DD/MM/YYYY'))
),1,14.87));
/
INSERT INTO CD VALUES(CD_TYPE('ALB985','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Pharohs dance',1204,0.99,10),
TRACK_TYPE(2,'Bitches Brew',1619,0.99,10),
TRACK_TYPE(3,'Spanish Key',1052,0.99,40),
TRACK_TYPE(4,'John Mclaughlin',262,0.99,30),
TRACK_TYPE(5,'Miles Runs the Voodoo Down',841,0.99,50),
TRACK_TYPE(6,'Sanctuary',656,0.99,10),
TRACK_TYPE(5,'Feio',709,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,NULL,'Im getting broken in. Have listened to it 3 times and am still trying to like it. I like some other Miles Davis albums waaaaay better!
My top 3:
1) Milestones
2) Kind of Blue
3) In a Silent Way',3.0, TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Been waiting a long time to hear this again. Miles is brilliant!', 5.0, TO_DATE('21/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Rita Sweeney', 'Love it!',5.0, TO_DATE('29/6/2016', 'DD/MM/YYYY'))
),0,4.99));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB984';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB999';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB985';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB998';
/
INSERT INTO ALSO_BOUGHT
SELECT REF(CD1), REF(CD2)
FROM CD CD1, CD CD2
WHERE CD1.ALBUM_ID = 'ALB999' AND CD2.ALBUM_ID = 'ALB998'
/

INSERT INTO TAPE VALUES (TAPE_TYPE('ALB985', 'Joe Cocker!',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Dear Landlord (Album Version)', 205, 1.29, 50),
TRACK_TYPE(2, 'Bird On A Wire (Album Version)', 268, 1.29, 50),
TRACK_TYPE(3, 'Lawdy Miss Clawdy (Album Version)', 133, 1.29, 50),
TRACK_TYPE(4, 'She Came In Through The Bathroom Window (Album Version)', 156, 1.29, 50),
TRACK_TYPE(5, 'Hitchcock Railway (Album Version)', 277, 1.29, 50),
TRACK_TYPE(6, 'Thats Your Business (Album Version)', 176, 1.29, 50),
TRACK_TYPE(7, 'Something (Album Version)', 211, 1.29, 50),
TRACK_TYPE(8, 'Delta Lady (Album Version)', 170, 1.29, 50),
TRACK_TYPE(9, 'Hello, Little Friend (Album Version)', 312, 1.29, 50),
TRACK_TYPE(10, 'Darling Be Home Soon (Album Version)', 485, 1.29, 50),
TRACK_TYPE(11, 'Shes Good To Me (Single Version)', 180, 1.29, 50),
TRACK_TYPE(12, 'Let It Be (Original Take)', 300, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not 5 stars .... mumbled lyrics , bad production, think its over rated from covers of beatles and Leon Russell connection.', 2.0, TO_DATE('23/05/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'The original and the greatest. Joe, I really miss you', 5.0, TO_DATE('16/05/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Great.', 5.0, TO_DATE('21/02/2015', 'DD/MM/YYYY'))),0,9.98));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB985';
/
INSERT INTO TAPE VALUES (TAPE_TYPE('ALB984', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),1,39.99));
/
/
INSERT INTO TAPE VALUES (TAPE_TYPE('ALB983', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),0,2.98));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB984';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB983';
/

INSERT INTO TAPE VALUES (TAPE_TYPE('ALB982', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many TAPEs in my juke boxes yet I get SATAPEs for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,19.96));

/
INSERT INTO TAPE VALUES (TAPE_TYPE('ALB981', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many TAPEs in my juke boxes yet I get SATAPEs for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,19.96));

/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB982';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB981';
/
INSERT INTO TAPE VALUES (TAPE_TYPE('ALB980', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Hey Hey, My My (Into The Black) (1991 Live)', 342, 1.32, 50),
TRACK_TYPE(2, 'Crime In the City (1991 Live)', 392, 1.32, 50),
TRACK_TYPE(3, 'Blowin In the Wind (1991 Live)', 409, 1.32, 50),
TRACK_TYPE(4, 'Welfare Mothers (1991 Live)', 424, 1.32, 50),
TRACK_TYPE(5, 'Love to Burn (1991 Live)', 601, 1.32, 50),
TRACK_TYPE(6, 'Cinamon Girl (1991 Live)', 285, 1.32, 50),
TRACK_TYPE(7, 'Mansion on the Hill (1991 Live)', 374, 1.32, 50),
TRACK_TYPE(8, 'Fuckin Up (1991 Live)', 429, 1.32, 50),
TRACK_TYPE(9, 'Cortez the Killer (1991 Live)', 586, 1.32, 50),
TRACK_TYPE(10, 'Powderfinger (1991 Live)', 358, 1.32, 50),
TRACK_TYPE(11, 'Love and Only Love (1991 Live)', 557, 1.32, 50),
TRACK_TYPE(12, 'Rockin in the Free World (1991 Live Album Version)', 562, 1.32, 50),
TRACK_TYPE(13, 'Like a Hurricane (1991 Live)', 840, 1.32, 50),
TRACK_TYPE(14, 'Farmer John (Into The Black) (1991 Live)', 300, 1.32, 50),
TRACK_TYPE(15, 'Tonights the Night (1991 Live)', 525, 1.32, 50),
TRACK_TYPE(16, 'Roll Another Number (1991 Live)', 319, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'David Marshall', 'Any live album will be enjoyed by all', 5.0, TO_DATE('15/06/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Paul Hackbath', 'Very good.', 3.0, TO_DATE('20/05/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,6.86));
/
INSERT INTO TAPE VALUES (TAPE_TYPE('ALB979', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Hey Hey, My My (Into The Black) (1991 Live)', 342, 1.32, 50),
TRACK_TYPE(2, 'Crime In the City (1991 Live)', 392, 1.32, 50),
TRACK_TYPE(3, 'Blowin In the Wind (1991 Live)', 409, 1.32, 50),
TRACK_TYPE(4, 'Welfare Mothers (1991 Live)', 424, 1.32, 50),
TRACK_TYPE(5, 'Love to Burn (1991 Live)', 601, 1.32, 50),
TRACK_TYPE(6, 'Cinamon Girl (1991 Live)', 285, 1.32, 50),
TRACK_TYPE(7, 'Mansion on the Hill (1991 Live)', 374, 1.32, 50),
TRACK_TYPE(8, 'Fuckin Up (1991 Live)', 429, 1.32, 50),
TRACK_TYPE(9, 'Cortez the Killer (1991 Live)', 586, 1.32, 50),
TRACK_TYPE(10, 'Powderfinger (1991 Live)', 358, 1.32, 50),
TRACK_TYPE(11, 'Love and Only Love (1991 Live)', 557, 1.32, 50),
TRACK_TYPE(12, 'Rockin in the Free World (1991 Live Album Version)', 562, 1.32, 50),
TRACK_TYPE(13, 'Like a Hurricane (1991 Live)', 840, 1.32, 50),
TRACK_TYPE(14, 'Farmer John (Into The Black) (1991 Live)', 300, 1.32, 50),
TRACK_TYPE(15, 'Tonights the Night (1991 Live)', 525, 1.32, 50),
TRACK_TYPE(16, 'Roll Another Number (1991 Live)', 319, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'David Marshall', 'Any live album will be enjoyed by all', 5.0, TO_DATE('15/06/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Paul Hackbath', 'Very good.', 3.0, TO_DATE('20/05/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1, 14.90));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB979';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB979';
/
INSERT INTO TAPE VALUES(TAPE_TYPE('ALB999','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99,10),
TRACK_TYPE(2,'Will O the wisp',229,0.99,50),
TRACK_TYPE(3,'The Pan Piper',237,0.99,40),
TRACK_TYPE(4,'Saeta',335,0.99,30),
TRACK_TYPE(5,'Solea',938,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))
), 1, 90.38));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART999','Miles Davis'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, TAPE ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB999';
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB987', 'Joe Cocker!',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Dear Landlord (Album Version)', 205, 1.29, 50),
TRACK_TYPE(2, 'Bird On A Wire (Album Version)', 268, 1.29, 50),
TRACK_TYPE(3, 'Lawdy Miss Clawdy (Album Version)', 133, 1.29, 50),
TRACK_TYPE(4, 'She Came In Through The Bathroom Window (Album Version)', 156, 1.29, 50),
TRACK_TYPE(5, 'Hitchcock Railway (Album Version)', 277, 1.29, 50),
TRACK_TYPE(6, 'Thats Your Business (Album Version)', 176, 1.29, 50),
TRACK_TYPE(7, 'Something (Album Version)', 211, 1.29, 50),
TRACK_TYPE(8, 'Delta Lady (Album Version)', 170, 1.29, 50),
TRACK_TYPE(9, 'Hello, Little Friend (Album Version)', 312, 1.29, 50),
TRACK_TYPE(10, 'Darling Be Home Soon (Album Version)', 485, 1.29, 50),
TRACK_TYPE(11, 'Shes Good To Me (Single Version)', 180, 1.29, 50),
TRACK_TYPE(12, 'Let It Be (Original Take)', 300, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not 5 stars .... mumbled lyrics , bad production, think its over rated from covers of beatles and Leon Russell connection.', 2.0, TO_DATE('23/05/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'The original and the greatest. Joe, I really miss you', 5.0, TO_DATE('16/05/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Great.', 5.0, TO_DATE('21/02/2015', 'DD/MM/YYYY'))),0,0.79));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB987';
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB988', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),1,49.99));
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB980', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),0,8.00));

/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB988';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB989', 'The Magnificent Moodies',74,'Rock', TO_DATE('15/12/2014', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Ill Go Crazy', 131, 0.99, 50),
TRACK_TYPE(2, 'Something You Got', 172, 0.99, 50),
TRACK_TYPE(3, 'Go Now', 192, 0.99, 50),
TRACK_TYPE(4, 'Cant Nobody Love You', 242, 0.99, 50),
TRACK_TYPE(5, 'I Dont Mind', 207, 0.99, 50),
TRACK_TYPE(6, 'Ive Got a Dream', 172, 0.99, 50),
TRACK_TYPE(7, 'Let Me Go', 193, 0.99, 50),
TRACK_TYPE(8, 'Stop', 126, 0.99, 50),
TRACK_TYPE(9, 'Thank You Baby', 149, 0.99, 50),
TRACK_TYPE(10, 'It Aint Necessarily So', 201, 0.99, 50),
TRACK_TYPE(11, 'True Story', 105, 0.99, 50),
TRACK_TYPE(12, 'Bye Bye Bird', 173, 0.99, 50),
TRACK_TYPE(13, 'Lose Your Money (But Dont Lose Your Mind)', 119, 0.99, 50),
TRACK_TYPE(14, 'Steal Your Heart Away', 134, 0.99, 50),
TRACK_TYPE(15, 'Go Now! (First Version)', 229, 0.99, 50),
TRACK_TYPE(16, 'Its Easy Child', 193, 0.99, 50),
TRACK_TYPE(17, 'I Dont Want to Go on Without You', 166, 0.99, 50),
TRACK_TYPE(18, 'Time Is on My Side', 183, 0.99, 50),
TRACK_TYPE(19, 'From the Bottom of My Heart (I Love You)', 206, 0.99, 50),
TRACK_TYPE(20, 'And My Babys Gone', 142, 0.99, 50),
TRACK_TYPE(21, 'Everyday', 109, 0.99, 50),
TRACK_TYPE(22, 'You Dont (All the Time)', 142, 0.99, 50),
TRACK_TYPE(23, 'Boulevard De Madeleine', 175, 0.99, 50),
TRACK_TYPE(24, 'This Is My House (But Nobody Calls)', 155, 0.99, 50),
TRACK_TYPE(25, 'People Gotta Go', 155, 0.99, 50),
TRACK_TYPE(26, 'Lifes Not Life', 155, 0.99, 50),
TRACK_TYPE(27, 'He Can Win', 144, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'I quess this is great for historic significance but the sound quality and music, for that matter, is horrible.', 1.0, TO_DATE('21/11/2009', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Michael S', 'Nice history lesson. Better than I expected but certainly NOT like the Moodys I knew in college.', 4.0, TO_DATE('17/03/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Robert E', 'Classic.', 5.0, TO_DATE('12/09/2016', 'DD/MM/YYYY'))),1,19.95));
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB981', 'The Magnificent Moodies',74,'Rock', TO_DATE('15/12/2014', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Ill Go Crazy', 131, 0.99, 50),
TRACK_TYPE(2, 'Something You Got', 172, 0.99, 50),
TRACK_TYPE(3, 'Go Now', 192, 0.99, 50),
TRACK_TYPE(4, 'Cant Nobody Love You', 242, 0.99, 50),
TRACK_TYPE(5, 'I Dont Mind', 207, 0.99, 50),
TRACK_TYPE(6, 'Ive Got a Dream', 172, 0.99, 50),
TRACK_TYPE(7, 'Let Me Go', 193, 0.99, 50),
TRACK_TYPE(8, 'Stop', 126, 0.99, 50),
TRACK_TYPE(9, 'Thank You Baby', 149, 0.99, 50),
TRACK_TYPE(10, 'It Aint Necessarily So', 201, 0.99, 50),
TRACK_TYPE(11, 'True Story', 105, 0.99, 50),
TRACK_TYPE(12, 'Bye Bye Bird', 173, 0.99, 50),
TRACK_TYPE(13, 'Lose Your Money (But Dont Lose Your Mind)', 119, 0.99, 50),
TRACK_TYPE(14, 'Steal Your Heart Away', 134, 0.99, 50),
TRACK_TYPE(15, 'Go Now! (First Version)', 229, 0.99, 50),
TRACK_TYPE(16, 'Its Easy Child', 193, 0.99, 50),
TRACK_TYPE(17, 'I Dont Want to Go on Without You', 166, 0.99, 50),
TRACK_TYPE(18, 'Time Is on My Side', 183, 0.99, 50),
TRACK_TYPE(19, 'From the Bottom of My Heart (I Love You)', 206, 0.99, 50),
TRACK_TYPE(20, 'And My Babys Gone', 142, 0.99, 50),
TRACK_TYPE(21, 'Everyday', 109, 0.99, 50),
TRACK_TYPE(22, 'You Dont (All the Time)', 142, 0.99, 50),
TRACK_TYPE(23, 'Boulevard De Madeleine', 175, 0.99, 50),
TRACK_TYPE(24, 'This Is My House (But Nobody Calls)', 155, 0.99, 50),
TRACK_TYPE(25, 'People Gotta Go', 155, 0.99, 50),
TRACK_TYPE(26, 'Lifes Not Life', 155, 0.99, 50),
TRACK_TYPE(27, 'He Can Win', 144, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'I quess this is great for historic significance but the sound quality and music, for that matter, is horrible.', 1.0, TO_DATE('21/11/2009', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Michael S', 'Nice history lesson. Better than I expected but certainly NOT like the Moodys I knew in college.', 4.0, TO_DATE('17/03/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Robert E', 'Classic.', 5.0, TO_DATE('12/09/2016', 'DD/MM/YYYY'))),0,71.94));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB989';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB981';

/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB991', 'The Magnificent',32,'Rap', TO_DATE('13/08/2002', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'The Magnificent - featuring Pauly Yamz and Baby Blak', 107, 1.29, 50),
TRACK_TYPE(2, 'Shake It Off - featuring Chef Word', 53, 1.29, 50),
TRACK_TYPE(3, 'For The Love of Da Game - featuring Pauly Yamz and Baby Blak', 83, 1.29, 50),
TRACK_TYPE(4, 'How I Do - featuring Shawn Stockman (Boyz II Men)', 134, 1.29, 50),
TRACK_TYPE(5, 'Break It Down - featuring J-Live', 67, 1.29, 50),
TRACK_TYPE(6, ' Musik Lounge - featuring Odyssey', 158, 1.29, 50),
TRACK_TYPE(7, 'Rock Wit U - featuring Erro', 97, 1.29, 50),
TRACK_TYPE(8, 'Scram - featuring Freddie Foxxx', 99, 1.29, 50),
TRACK_TYPE(9, 'My People - featuring Raheem', 71, 1.29, 50),
TRACK_TYPE(10, 'Know Ur Hood - featuring Pauly Yamz and Chef Word', 89, 1.29, 50),
TRACK_TYPE(11, 'Love Saviour - featuring Flo Brown and Raheem', 38, 1.29, 50),
TRACK_TYPE(12, 'Mystery Man - featuring The Last Emperor', 153, 1.29, 50),
TRACK_TYPE(13, 'We Are - featuring Cy Young and Raheem', 81, 1.29, 50),
TRACK_TYPE(14, 'A Charmed Life - featuring J-Live', 118, 1.29, 50),
TRACK_TYPE(15, 'We Live In Philly - featuring Jill Scott', 68, 1.29, 50),
TRACK_TYPE(16, 'In Time - featuring V', 115, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Ryan Rose', 'This album is niceness. 100% natural churned butter baby! Lovely!', 5.0, TO_DATE('15/05/2003', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'L. Dogg', 'Had to have this one.Heavy beats,all round ensemble of artists and a general good feel of an album. Was lacking in some ways,just cant put my finger on it though!', 3.0, TO_DATE('28/02/2005','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'A truly stunning VINYL. Best beats and music I have had the pleasure of listenin to in a while. All bases covered with STYLE. Buy, listen and enjoy.', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),0,18.49));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Rapper'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART992' AND ALB.ALBUM_ID = 'ALB991';
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB992', 'The Vigil',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Galaxy 32 Star 4', 500, 1.29, 50),
TRACK_TYPE(2, 'Planet Chia', 666, 1.29, 50),
TRACK_TYPE(3, 'portals to Forever', 962, 1.29, 50),
TRACK_TYPE(4, 'Royalty', 558, 1.29, 50),
TRACK_TYPE(5, 'Outside of Space', 299, 1.29, 50),
TRACK_TYPE(6, 'Pledge for Peace', 1055, 1.29, 50),
TRACK_TYPE(7, 'Legacy', 600, 1.29, 50),
TRACK_TYPE(8, 'Hot House (Live)', 508, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Penelope Nicolopolis', 'I really like this VINYL. But, Im not enthralled by it like some of Chick Coreas other works. I dont really know whats missing. It could be that I need to listen to it more. But, in my mind and heart, Chick Corea still remains one of the BEST Jazz musicians around - even if this project doesnt send me', 4.0, TO_DATE('27/01/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'I consider Chick Corea to be the best jazz musician of all time His top albums like Lerechaun are the most creative i have ever heard and he plays all the instruments This VINYL is Ok but not up the the best of Chick Corea', 3.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This VINYL is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),1,20.45));
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB982', 'The Vigil',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Galaxy 32 Star 4', 500, 1.29, 50),
TRACK_TYPE(2, 'Planet Chia', 666, 1.29, 50),
TRACK_TYPE(3, 'portals to Forever', 962, 1.29, 50),
TRACK_TYPE(4, 'Royalty', 558, 1.29, 50),
TRACK_TYPE(5, 'Outside of Space', 299, 1.29, 50),
TRACK_TYPE(6, 'Pledge for Peace', 1055, 1.29, 50),
TRACK_TYPE(7, 'Legacy', 600, 1.29, 50),
TRACK_TYPE(8, 'Hot House (Live)', 508, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Penelope Nicolopolis', 'I really like this VINYL. But, Im not enthralled by it like some of Chick Coreas other works. I dont really know whats missing. It could be that I need to listen to it more. But, in my mind and heart, Chick Corea still remains one of the BEST Jazz musicians around - even if this project doesnt send me', 4.0, TO_DATE('27/01/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'I consider Chick Corea to be the best jazz musician of all time His top albums like Lerechaun are the most creative i have ever heard and he plays all the instruments This VINYL is Ok but not up the the best of Chick Corea', 3.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This VINYL is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),1,20.45));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB992';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB982';

/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB995', 'Blowin in the Wind',32,'Pop', TO_DATE('31/05/2011', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Railroad', 185, 0.99, 50),
TRACK_TYPE(2, 'Blowin in the Wind', 131, 0.99, 50),
TRACK_TYPE(3, 'Edens Island', 127, 0.99, 50),
TRACK_TYPE(4, 'Arri Rang', 136, 0.99, 50),
TRACK_TYPE(5, 'Hes Gone Away', 166, 0.99, 50),
TRACK_TYPE(6, 'Arthurs Line', 101, 0.99, 50),
TRACK_TYPE(7, '	Brazilleros [Bossa Nova]', 160, 0.99, 50),
TRACK_TYPE(8, 'My Coloring Book', 238, 0.99, 50),
TRACK_TYPE(9, 'Watermelon Man', 160, 0.99, 50),
TRACK_TYPE(10, 'Fantasia Mexicana', 239, 0.99, 50),
TRACK_TYPE(11, 'Sweet Someone', 201, 0.99, 50),
TRACK_TYPE(12, 'Suzys Waltz', 176, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'The hell is this', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Well I though it was Good.', 5.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Meh, it was so-so', 2.5, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,4.49));

/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB995';

/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB996', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many VINYLs in my juke boxes yet I get SAVINYLs for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1,22.42));
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB983', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many VINYLs in my juke boxes yet I get SAVINYLs for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),0,14.99));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB996';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB983';
/
INSERT INTO VINYL VALUES (VINYL_TYPE('ALB997', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Hey Hey, My My (Into The Black) (1991 Live)', 342, 1.32, 50),
TRACK_TYPE(2, 'Crime In the City (1991 Live)', 392, 1.32, 50),
TRACK_TYPE(3, 'Blowin In the Wind (1991 Live)', 409, 1.32, 50),
TRACK_TYPE(4, 'Welfare Mothers (1991 Live)', 424, 1.32, 50),
TRACK_TYPE(5, 'Love to Burn (1991 Live)', 601, 1.32, 50),
TRACK_TYPE(6, 'Cinamon Girl (1991 Live)', 285, 1.32, 50),
TRACK_TYPE(7, 'Mansion on the Hill (1991 Live)', 374, 1.32, 50),
TRACK_TYPE(8, 'Fuckin Up (1991 Live)', 429, 1.32, 50),
TRACK_TYPE(9, 'Cortez the Killer (1991 Live)', 586, 1.32, 50),
TRACK_TYPE(10, 'Powderfinger (1991 Live)', 358, 1.32, 50),
TRACK_TYPE(11, 'Love and Only Love (1991 Live)', 557, 1.32, 50),
TRACK_TYPE(12, 'Rockin in the Free World (1991 Live Album Version)', 562, 1.32, 50),
TRACK_TYPE(13, 'Like a Hurricane (1991 Live)', 840, 1.32, 50),
TRACK_TYPE(14, 'Farmer John (Into The Black) (1991 Live)', 300, 1.32, 50),
TRACK_TYPE(15, 'Tonights the Night (1991 Live)', 525, 1.32, 50),
TRACK_TYPE(16, 'Roll Another Number (1991 Live)', 319, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'David Marshall', 'Any live album will be enjoyed by all', 5.0, TO_DATE('15/06/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Paul Hackbath', 'Very good.', 3.0, TO_DATE('20/05/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1,395.12));

/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO VINYL VALUES(VINYL_TYPE('ALB998','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Pharohs dance',1204,0.99,10),
TRACK_TYPE(2,'Bitches Brew',1619,0.99,10),
TRACK_TYPE(3,'Spanish Key',1052,0.99,40),
TRACK_TYPE(4,'John Mclaughlin',262,0.99,30),
TRACK_TYPE(5,'Miles Runs the Voodoo Down',841,0.99,50),
TRACK_TYPE(6,'Sanctuary',656,0.99,10),
TRACK_TYPE(5,'Feio',709,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,NULL,'Im getting broken in. Have listened to it 3 times and am still trying to like it. I like some other Miles Davis albums waaaaay better!
My top 3:
1) Milestones
2) Kind of Blue
3) In a Silent Way',3.0, TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Been waiting a long time to hear this again. Miles is brilliant!', 5.0, TO_DATE('21/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Rita Sweeney', 'Love it!',5.0, TO_DATE('29/6/2016', 'DD/MM/YYYY'))
),1,18.32));
/
INSERT INTO VINYL VALUES(VINYL_TYPE('ALB985','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Pharohs dance',1204,0.99,10),
TRACK_TYPE(2,'Bitches Brew',1619,0.99,10),
TRACK_TYPE(3,'Spanish Key',1052,0.99,40),
TRACK_TYPE(4,'John Mclaughlin',262,0.99,30),
TRACK_TYPE(5,'Miles Runs the Voodoo Down',841,0.99,50),
TRACK_TYPE(6,'Sanctuary',656,0.99,10),
TRACK_TYPE(5,'Feio',709,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,NULL,'Im getting broken in. Have listened to it 3 times and am still trying to like it. I like some other Miles Davis albums waaaaay better!
My top 3:
1) Milestones
2) Kind of Blue
3) In a Silent Way',3.0, TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Been waiting a long time to hear this again. Miles is brilliant!', 5.0, TO_DATE('21/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Rita Sweeney', 'Love it!',5.0, TO_DATE('29/6/2016', 'DD/MM/YYYY'))),1,15.95));
/
INSERT INTO ALSO_BOUGHT
SELECT REF(VINYL1), REF(VINYL2)
FROM VINYL VINYL1, VINYL VINYL2
WHERE VINYL1.ALBUM_ID = 'ALB999' AND VINYL2.ALBUM_ID = 'ALB998'
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB986', 'I Can Stand A Little Rain',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Put Out The Light', 250, 1.29, 50),
TRACK_TYPE(2, 'I Can Stand A Little Rain', 212, 1.29, 50),
TRACK_TYPE(3, 'I Get Mad', 217, 1.29, 50),
TRACK_TYPE(4, 'Sing Me A Song', 144, 1.29, 50),
TRACK_TYPE(5, 'The Moon Is A Harsh Mistress', 210, 1.29, 50),
TRACK_TYPE(6, 'Dont Forget Me', 198, 1.29, 50),
TRACK_TYPE(7, 'You Are So Beautiful', 159, 1.29, 50),
TRACK_TYPE(8, 'Its A Sin When You Love Somebody', 227, 1.29, 50),
TRACK_TYPE(9, 'Performance', 277, 1.29, 50),
TRACK_TYPE(10, 'Guilty', 166, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not as good as some...', 2.0, TO_DATE('02/08/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Went from 8 track to cassette to finally a MP3 of this album, love every song!', 5.0, TO_DATE('20/06/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Not well recorded and song selection is poor does not bring to life his full voice command Winterland San Francisco 1968 was the best.', 1.0, TO_DATE('23/08/2013', 'DD/MM/YYYY'))),9.49));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB986';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB987', 'Joe Cocker!',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Dear Landlord (Album Version)', 205, 1.29, 50),
TRACK_TYPE(2, 'Bird On A Wire (Album Version)', 268, 1.29, 50),
TRACK_TYPE(3, 'Lawdy Miss Clawdy (Album Version)', 133, 1.29, 50),
TRACK_TYPE(4, 'She Came In Through The Bathroom Window (Album Version)', 156, 1.29, 50),
TRACK_TYPE(5, 'Hitchcock Railway (Album Version)', 277, 1.29, 50),
TRACK_TYPE(6, 'Thats Your Business (Album Version)', 176, 1.29, 50),
TRACK_TYPE(7, 'Something (Album Version)', 211, 1.29, 50),
TRACK_TYPE(8, 'Delta Lady (Album Version)', 170, 1.29, 50),
TRACK_TYPE(9, 'Hello, Little Friend (Album Version)', 312, 1.29, 50),
TRACK_TYPE(10, 'Darling Be Home Soon (Album Version)', 485, 1.29, 50),
TRACK_TYPE(11, 'Shes Good To Me (Single Version)', 180, 1.29, 50),
TRACK_TYPE(12, 'Let It Be (Original Take)', 300, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Not 5 stars .... mumbled lyrics , bad production, think its over rated from covers of beatles and Leon Russell connection.', 2.0, TO_DATE('23/05/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'The original and the greatest. Joe, I really miss you', 5.0, TO_DATE('16/05/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Great.', 5.0, TO_DATE('21/02/2015', 'DD/MM/YYYY'))),6.99));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB987';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB988', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Feelin Alright', 250, 1.29, 50),
TRACK_TYPE(2, 'Bye Bye Blackbird', 207, 1.29, 50),
TRACK_TYPE(3, 'Change In Louise', 203, 1.29, 50),
TRACK_TYPE(4, 'Marjorine', 158, 1.29, 50),
TRACK_TYPE(5, 'Just Like A Woman', 317, 1.29, 50),
TRACK_TYPE(6, 'Do I Still Figure In Your Life?', 239, 1.29, 50),
TRACK_TYPE(7, 'Sandpaper Cadillac', 196, 0.99, 50),
TRACK_TYPE(8, 'Dont Let Me Be Misunderstood', 281, 1.29, 50),
TRACK_TYPE(9, 'With A Little Help From My Friends', 312, 1.29, 50),
TRACK_TYPE(10, 'I Shall Be Released', 276, 1.29, 50),
TRACK_TYPE(11, 'The New Age of Lilly', 135, 1.29, 50),
TRACK_TYPE(12, 'Somethings Coming On', 135, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'Masterful album with more soul than you can shake a stick to. Cockers version of Bye Bye Blackbirdis worth the price alone.
When Cocker does covers of the Beatles or Dylan, he does sonething that is difficult to do--he adds new elements and takes em to a new level.
This record is a must for the audiophile who loves 60s R and B or just good ole rock n roll.', 5.0, TO_DATE('20/05/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'This is Joes first album and it is his best IMHO. His following release, Joe Cocker, is also highly praised but I think falls a distant second to this one. Alot of soul and great musicians to back him up, including Jimmy Page. This one is great.', 5.0, TO_DATE('12/11/2004','DD/MM/YYYY')),
REVIEW_TYPE(3, null, 'Joe Cocker and a stellar case of rocks Whos Who from the late `60s overcame a bit of turbulence in the studio to create one of the defining works of that time, a great introduction to Mr. Cocker, and a great reminder of just how much talent and musicianship existed then.

Listening to these songs now, its interesting to hear Jimmy Page underplaying his parts and to hear how Albert Lee was already the consummate guitar session man. Of course, this album is all about vocals, and Mr. Cocker let the world know he was ready to be reckoned with on this debut. The fine backup singers really help frame his sometimes out-of-bounds singing, but this set still swings and sound remarkably fresh considering it is 40-plus years old now.

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),5.00));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB988';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB989', 'The Magnificent Moodies',74,'Rock', TO_DATE('15/12/2014', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Ill Go Crazy', 131, 0.99, 50),
TRACK_TYPE(2, 'Something You Got', 172, 0.99, 50),
TRACK_TYPE(3, 'Go Now', 192, 0.99, 50),
TRACK_TYPE(4, 'Cant Nobody Love You', 242, 0.99, 50),
TRACK_TYPE(5, 'I Dont Mind', 207, 0.99, 50),
TRACK_TYPE(6, 'Ive Got a Dream', 172, 0.99, 50),
TRACK_TYPE(7, 'Let Me Go', 193, 0.99, 50),
TRACK_TYPE(8, 'Stop', 126, 0.99, 50),
TRACK_TYPE(9, 'Thank You Baby', 149, 0.99, 50),
TRACK_TYPE(10, 'It Aint Necessarily So', 201, 0.99, 50),
TRACK_TYPE(11, 'True Story', 105, 0.99, 50),
TRACK_TYPE(12, 'Bye Bye Bird', 173, 0.99, 50),
TRACK_TYPE(13, 'Lose Your Money (But Dont Lose Your Mind)', 119, 0.99, 50),
TRACK_TYPE(14, 'Steal Your Heart Away', 134, 0.99, 50),
TRACK_TYPE(15, 'Go Now! (First Version)', 229, 0.99, 50),
TRACK_TYPE(16, 'Its Easy Child', 193, 0.99, 50),
TRACK_TYPE(17, 'I Dont Want to Go on Without You', 166, 0.99, 50),
TRACK_TYPE(18, 'Time Is on My Side', 183, 0.99, 50),
TRACK_TYPE(19, 'From the Bottom of My Heart (I Love You)', 206, 0.99, 50),
TRACK_TYPE(20, 'And My Babys Gone', 142, 0.99, 50),
TRACK_TYPE(21, 'Everyday', 109, 0.99, 50),
TRACK_TYPE(22, 'You Dont (All the Time)', 142, 0.99, 50),
TRACK_TYPE(23, 'Boulevard De Madeleine', 175, 0.99, 50),
TRACK_TYPE(24, 'This Is My House (But Nobody Calls)', 155, 0.99, 50),
TRACK_TYPE(25, 'People Gotta Go', 155, 0.99, 50),
TRACK_TYPE(26, 'Lifes Not Life', 155, 0.99, 50),
TRACK_TYPE(27, 'He Can Win', 144, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'I quess this is great for historic significance but the sound quality and music, for that matter, is horrible.', 1.0, TO_DATE('21/11/2009', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Michael S', 'Nice history lesson. Better than I expected but certainly NOT like the Moodys I knew in college.', 4.0, TO_DATE('17/03/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Robert E', 'Classic.', 5.0, TO_DATE('12/09/2016', 'DD/MM/YYYY'))),8.99));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB989';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB990', 'The Magnificent Void',69,'New Age', TO_DATE('22/02/1996', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Between the Gray and the Purple', 460, 0.99, 50),
TRACK_TYPE(2, 'Void Memory One', 173, 0.99, 50),
TRACK_TYPE(3, 'Infinite Shore', 467, 0.99, 50),
TRACK_TYPE(4, 'Cloud of Unknowing', 638, 0.99, 50),
TRACK_TYPE(5, 'Void Memory Two', 220, 0.99, 50),
TRACK_TYPE(6, 'Void Memory Three', 220, 0.99, 50),
TRACK_TYPE(7, 'The Magnificent Void', 792, 0.99, 50),
TRACK_TYPE(8, 'Atlus', 1201, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Lonnie Collins', 'Another easy listening..', 4.0, TO_DATE('08/03/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Dark and spacey. Great nighttime music for reading or sleeping. One of the best ambient MP3s I own.', 5.0, TO_DATE('28/03/2009','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Im a fan of much of Steve Roachs work. Dreamtime Return is still a favorite. But Magnificent Void has none of the magical quality of those discs, and is downright dark. The repetitive bass notes and rumble might be nice for a sci-fi horror movie. But it makes for boring listening. Pass on this one.', 1.0, TO_DATE('29/04/2009', 'DD/MM/YYYY'))),7.92));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART991' AND ALB.ALBUM_ID = 'ALB990';

/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB992', 'The Vigil',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Galaxy 32 Star 4', 500, 1.29, 50),
TRACK_TYPE(2, 'Planet Chia', 666, 1.29, 50),
TRACK_TYPE(3, 'portals to Forever', 962, 1.29, 50),
TRACK_TYPE(4, 'Royalty', 558, 1.29, 50),
TRACK_TYPE(5, 'Outside of Space', 299, 1.29, 50),
TRACK_TYPE(6, 'Pledge for Peace', 1055, 1.29, 50),
TRACK_TYPE(7, 'Legacy', 600, 1.29, 50),
TRACK_TYPE(8, 'Hot House (Live)', 508, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Penelope Nicolopolis', 'I really like this MP3. But, Im not enthralled by it like some of Chick Coreas other works. I dont really know whats missing. It could be that I need to listen to it more. But, in my mind and heart, Chick Corea still remains one of the BEST Jazz musicians around - even if this project doesnt send me', 4.0, TO_DATE('27/01/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'I consider Chick Corea to be the best jazz musician of all time His top albums like Lerechaun are the most creative i have ever heard and he plays all the instruments This MP3 is Ok but not up the the best of Chick Corea', 3.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This MP3 is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),9.49));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB992';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB993', 'Childrens Songs',32,'Jazz', TO_DATE('30/09/2008', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Childrens Songs No. 1', 107, 1.29, 50),
TRACK_TYPE(2, 'Childrens Songs No. 2', 53, 1.29, 50),
TRACK_TYPE(3, 'Childrens Songs No. 3', 83, 1.29, 50),
TRACK_TYPE(4, 'Childrens Songs No. 4', 134, 1.29, 50),
TRACK_TYPE(5, 'Childrens Songs No. 5', 67, 1.29, 50),
TRACK_TYPE(6, 'Childrens Songs No. 6', 158, 1.29, 50),
TRACK_TYPE(7, 'Childrens Songs No. 7', 97, 1.29, 50),
TRACK_TYPE(8, 'Childrens Songs No. 8', 99, 1.29, 50),
TRACK_TYPE(9, 'Childrens Songs No. 9', 71, 1.29, 50),
TRACK_TYPE(10, 'Childrens Songs No. 10', 89, 1.29, 50),
TRACK_TYPE(11, 'Childrens Songs No. 11', 38, 1.29, 50),
TRACK_TYPE(12, 'Childrens Songs No. 12', 153, 1.29, 50),
TRACK_TYPE(13, 'Childrens Songs No. 13', 81, 1.29, 50),
TRACK_TYPE(14, 'Childrens Songs No. 14', 118, 1.29, 50),
TRACK_TYPE(15, 'Childrens Songs No. 15', 68, 1.29, 50),
TRACK_TYPE(16, 'Childrens Songs No. 16+17', 115, 1.29, 50),
TRACK_TYPE(17, 'Childrens Songs No. 18', 108, 1.29, 50),
TRACK_TYPE(18, 'Childrens Songs No. 19', 146, 1.29, 50),
TRACK_TYPE(19, 'Childrens Songs No. 20', 80, 1.29, 50),
TRACK_TYPE(20, 'Childrens Songs: Addendum', 310, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'OK, blasphemy coming, but to tell the truth I was very disappointed when this came out in 1979. I had been a fan since Return to Forever with Joe Farrell. I enjoyed some of his Childrens songs compositions on the Piano Improvisations and Crystal silence albums, but when I first heard this album, with great anticipation mind you, I thought his reinterpretations sounded rushed and kind of spoiled my memories of seven years prior. I think its an album he should have recorded earlier. The magic was lost somehow by this time.', 3.0, TO_DATE('02/11/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Martin', 'A classic. Períod.', 5.0, TO_DATE('17/08/2015','DD/MM/YYYY')),
REVIEW_TYPE(3, 'Domingo Carbrera', 'One of the best recordings of this great master. !', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),11.49));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB993';
/

INSERT INTO MP3 VALUES (MP3_TYPE('ALB994', 'Duet',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Very Early', 553, 1.29, 50),
TRACK_TYPE(2, 'How Insensitive', 457, 1.29, 50),
TRACK_TYPE(3, 'Deja Vu', 541, 1.29, 50),
TRACK_TYPE(4, 'Foot on the Hill', 406, 1.29, 50),
TRACK_TYPE(5, 'Humpty Dumpty', 470, 1.29, 50),
TRACK_TYPE(6, 'Bolivar Blues', 525, 1.29, 50),
TRACK_TYPE(7, 'Windows', 465, 1.29, 50),
TRACK_TYPE(8, 'Old Castle', 896, 1.29, 50),
TRACK_TYPE(9, 'Summertime', 530, 1.29, 50),
TRACK_TYPE(10, 'Place to Be', 492, 1.29, 50),
TRACK_TYPE(11, 'Do Mo - Childrens Songs # 12', 782, 1.29, 50),
TRACK_TYPE(12, 'Concierto de Aranjuez/Spain', 731, 1.29, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'K Patrick Batka', 'Classical type project. Very soothing.', 4.0, TO_DATE('08/11/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Courton Loreno', 'Arrived in timely fashion, no damage done to it.', 5.0, TO_DATE('11/08/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, 'meryes', 'This MP3 Duet Chick and Hiromi is both artists showcasing their artisty, but I felt that it was too "competitive". Instead of a wonderful collaborative listening experience, I felt as if I listened to two great artists competing with each other. They did not blend and complement each other as much as fight for center stage. I much prefer Hiromis solo album Place To Be to this collaboration.', 2.0, TO_DATE('27/01/2011', 'DD/MM/YYYY'))),18.99));
/



INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB994';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART993' AND ALB.ALBUM_ID = 'ALB994';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB995', 'Blowin in the Wind',32,'Pop', TO_DATE('31/05/2011', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Railroad', 185, 0.99, 50),
TRACK_TYPE(2, 'Blowin in the Wind', 131, 0.99, 50),
TRACK_TYPE(3, 'Edens Island', 127, 0.99, 50),
TRACK_TYPE(4, 'Arri Rang', 136, 0.99, 50),
TRACK_TYPE(5, 'Hes Gone Away', 166, 0.99, 50),
TRACK_TYPE(6, 'Arthurs Line', 101, 0.99, 50),
TRACK_TYPE(7, '	Brazilleros [Bossa Nova]', 160, 0.99, 50),
TRACK_TYPE(8, 'My Coloring Book', 238, 0.99, 50),
TRACK_TYPE(9, 'Watermelon Man', 160, 0.99, 50),
TRACK_TYPE(10, 'Fantasia Mexicana', 239, 0.99, 50),
TRACK_TYPE(11, 'Sweet Someone', 201, 0.99, 50),
TRACK_TYPE(12, 'Suzys Waltz', 176, 0.99, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,Null, 'The hell is this', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,Null, 'Well I though it was Good.', 5.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'Meh, it was so-so', 2.5, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),9.49));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB995';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB996', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Blowin in the Wind', 165, 0.99, 50),
TRACK_TYPE(2, 'Girl from the North Country', 199, 0.99, 50),
TRACK_TYPE(3, 'Masters of War', 271, 0.99, 50),
TRACK_TYPE(4, 'Down the Highway', 204, 0.99, 50),
TRACK_TYPE(5, 'Bob Dylans Blues', 140, 0.99, 50),
TRACK_TYPE(6, 'A Hard Rains A-Gonna Fall', 412, 0.99, 50),
TRACK_TYPE(7, 'Dont Think Twice, Its Alright', 217, 0.99, 50),
TRACK_TYPE(8, 'Bob Dylans Dream', 300, 0.99, 50),
TRACK_TYPE(9, 'Oxford Town', 107, 0.99, 50),
TRACK_TYPE(10, 'Talkin World War III Blues', 385, 0.99, 50),
TRACK_TYPE(11, 'Corrina, Corrina', 161, 0.99, 50),
TRACK_TYPE(12, 'Honey, Just Allow Me One More Chance', 118, 0.99, 50),
TRACK_TYPE(13, 'I Shall Be Free', 840, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'Josephine', 'Dated, not classic.', 1.0, TO_DATE('22/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Donald Meek', 'I have many MP3s in my juke boxes yet I get SAMP3s for the 5.1 surround mix this one is plain stereo so its just ok love bob dylan yet wanted him in surround.', 3.0, TO_DATE('18/10/2013','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),9.99));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB996';
/
INSERT INTO MP3 VALUES (MP3_TYPE('ALB997', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1, 'Hey Hey, My My (Into The Black) (1991 Live)', 342, 1.32, 50),
TRACK_TYPE(2, 'Crime In the City (1991 Live)', 392, 1.32, 50),
TRACK_TYPE(3, 'Blowin In the Wind (1991 Live)', 409, 1.32, 50),
TRACK_TYPE(4, 'Welfare Mothers (1991 Live)', 424, 1.32, 50),
TRACK_TYPE(5, 'Love to Burn (1991 Live)', 601, 1.32, 50),
TRACK_TYPE(6, 'Cinamon Girl (1991 Live)', 285, 1.32, 50),
TRACK_TYPE(7, 'Mansion on the Hill (1991 Live)', 374, 1.32, 50),
TRACK_TYPE(8, 'Fuckin Up (1991 Live)', 429, 1.32, 50),
TRACK_TYPE(9, 'Cortez the Killer (1991 Live)', 586, 1.32, 50),
TRACK_TYPE(10, 'Powderfinger (1991 Live)', 358, 1.32, 50),
TRACK_TYPE(11, 'Love and Only Love (1991 Live)', 557, 1.32, 50),
TRACK_TYPE(12, 'Rockin in the Free World (1991 Live Album Version)', 562, 1.32, 50),
TRACK_TYPE(13, 'Like a Hurricane (1991 Live)', 840, 1.32, 50),
TRACK_TYPE(14, 'Farmer John (Into The Black) (1991 Live)', 300, 1.32, 50),
TRACK_TYPE(15, 'Tonights the Night (1991 Live)', 525, 1.32, 50),
TRACK_TYPE(16, 'Roll Another Number (1991 Live)', 319, 1.32, 50)),
REVIEWS_TABLE(REVIEW_TYPE(1,'David Marshall', 'Any live album will be enjoyed by all', 5.0, TO_DATE('15/06/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Paul Hackbath', 'Very good.', 3.0, TO_DATE('20/05/2016','DD/MM/YYYY')),
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),9.49));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO MP3 VALUES(MP3_TYPE('ALB999','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99,10),
TRACK_TYPE(2,'Will O the wisp',229,0.99,50),
TRACK_TYPE(3,'The Pan Piper',237,0.99,40),
TRACK_TYPE(4,'Saeta',335,0.99,30),
TRACK_TYPE(5,'Solea',938,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))
), 6.99));
/

INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, MP3 ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB999';
/
INSERT INTO MP3 VALUES(MP3_TYPE('ALB998','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Pharohs dance',1204,0.99,10),
TRACK_TYPE(2,'Bitches Brew',1619,0.99,10),
TRACK_TYPE(3,'Spanish Key',1052,0.99,40),
TRACK_TYPE(4,'John Mclaughlin',262,0.99,30),
TRACK_TYPE(5,'Miles Runs the Voodoo Down',841,0.99,50),
TRACK_TYPE(6,'Sanctuary',656,0.99,10),
TRACK_TYPE(5,'Feio',709,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,NULL,'Im getting broken in. Have listened to it 3 times and am still trying to like it. I like some other Miles Davis albums waaaaay better!
My top 3:
1) Milestones
2) Kind of Blue
3) In a Silent Way',3.0, TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Been waiting a long time to hear this again. Miles is brilliant!', 5.0, TO_DATE('21/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Rita Sweeney', 'Love it!',5.0, TO_DATE('29/6/2016', 'DD/MM/YYYY'))
),14.99));
/
INSERT INTO ALSO_BOUGHT
SELECT REF(MP31), REF(MP32)
FROM MP3 MP31, MP3 MP32
WHERE MP31.ALBUM_ID = 'ALB999' AND MP32.ALBUM_ID = 'ALB998'
/
DROP TABLE ALSO_BOUGHT;
DROP TABLE ROLE;
DROP TABLE MP3;
DROP TABLE TAPE;
DROP TABLE VINYL;
DROP TABLE CD;
DROP TABLE ALBUM;
DROP TABLE PLAYLIST;
DROP TABLE ARTIST;
DROP TYPE ALSO_BOUGHT_TYPE;
DROP TYPE ROLE_TYPE;
DROP TYPE MP3_TYPE;
DROP TYPE TAPE_TYPE;
DROP TYPE VINYL_TYPE;
DROP TYPE CD_TYPE;
DROP TYPE ALBUM_TYPE;
DROP TYPE PLAYLIST_TYPE;
DROP TYPE PLAYLIST_TRACKS;
DROP TYPE PLAYLIST_TRACKS_TYPE;
DROP TYPE REVIEWS_TABLE;
DROP TYPE TRACKS;
DROP TYPE REVIEW_TYPE;
DROP TYPE TRACK_TYPE;
DROP TYPE ARTIST_TYPE;
/
DROP TABLE ALSO_BOUGHT;
DROP TABLE ROLE;
DROP TABLE MP3;
DROP TABLE TAPE;
DROP TABLE VINYL;
DROP TABLE CD;
DROP TABLE ALBUM;
DROP TABLE PLAYLIST;
DROP TABLE ARTIST;
DROP TYPE ALSO_BOUGHT_TYPE;
DROP TYPE ROLE_TYPE;
DROP TYPE MP3_TYPE;
DROP TYPE TAPE_TYPE;
DROP TYPE VINYL_TYPE;
DROP TYPE CD_TYPE;
DROP TYPE ALBUM_TYPE;
DROP TYPE PLAYLIST_TYPE;
DROP TYPE PLAYLIST_TRACKS;
DROP TYPE PLAYLIST_TRACKS_TYPE;
DROP TYPE REVIEWS_TABLE;
DROP TYPE TRACKS;
DROP TYPE REVIEW_TYPE;
DROP TYPE TRACK_TYPE;
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
MEMBER FUNCTION AVGREVIEWSCORE RETURN NUMBER) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY REVIEW_TYPE AS 
MEMBER FUNCTION AVGREVIEWSCORE RETURN NUMBER IS
AVGSCORE  NUMBER(4,2);
BEGIN
  DECLARE  RCOUNT NUMBER;
    RTOTAL  NUMBER;
  BEGIN
  IF (REVIEWER_NAME = NULL) THEN
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
BASE_PRICE NUMBER(10,2),
MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER,
MEMBER FUNCTION AVGREVIEWSCORE RETURN NUMBER,
MEMBER FUNCTION FIND_ALBUM_BY_SONG RETURN BOOLEAN,
MEMBER FUNCTION GET_SONG_LENGTH RETURN NUMBER) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY ALBUM_TYPE AS
MEMBER FUNCTION DISCOUNTPRICE RETURN NUMBER IS
BEGIN
  RETURN SELF.BASE_PRICE;
END DISCOUNTPRICE;
MEMBER FUNCTION AVGREVIEWSCORE RETURN NUMBER IS
AVGSCORE  NUMBER(4,2);
RCOUNT NUMBER;
    RTOTAL  NUMBER;
    REV REVIEW_TYPE;
  BEGIN
  IF (REV.REVIEWER_NAME = NULL) THEN
    RCOUNT:= RCOUNT+1;
    RTOTAL:= RTOTAL+REV.REVIEW_SCORE;
  END IF;
  AVGSCORE:= RTOTAL/RCOUNT;
  RETURN AVGSCORE; 
  END AVGREVIEWSCORE;
MEMBER FUNCTION FIND_ALBUM_BY_SONG
(P_SONG_TITLE IN VARCHAR2)
   RETURN BOOLEAN
IS
   trackarray TRACKS;
   total integer;
BEGIN
  SELECT ALB.TRACK INTO trackarray from ALBUM ALB;
     total := trackarray.count;
     FOR i in 1 .. total LOOP
        IF(trackarray(i).SONG_TITLE = P_SONG_TITLE) THEN
          RETURN TRUE;
        END IF;
     END LOOP;
  RETURN FALSE;
END FIND_ALBUM_BY_SONG;
MEMBER FUNCTION GET_SONG_LENGTH
(P_SONG_TITLE IN VARCHAR2)
	RETURN NUMBER
IS
   trackarray TRACKS;
   total integer;
   high_dl integer :=0;
BEGIN
	SELECT TRACK INTO trackarray from ALBUM;
	total := trackarray.count;
   FOR i in 1 .. total LOOP
   	IF(trackarray(i).SONG_TITLE = P_SONG_TITLE) THEN
      	RETURN trackarray(i).SONG_DURATION;
		END IF;
	END LOOP;
END GET_SONG_LENGTH;
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
IF (NEW_OR_USED = 1 AND GENRE = 'Rock') THEN
  NEWPRICE := PRICE * 0.85;
ELSIF (NEW_OR_USED = 1 AND GENRE = 'Jazz') THEN
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
IF (NEW_OR_USED = 1 AND GENRE = 'Classical') THEN
  NEWPRICE := PRICE * 0.75;
ELSE
  NEWPRICE := PRICE;
END IF;
RETURN NEWPRICE;
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
(PLAY_NO VARCHAR2(10),
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
INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB986', 'I Can Stand A Little Rain',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, null, 'Not well recorded and song selection is poor does not bring to life his full voice command Winterland San Francisco 1968 was the best.', 1.0, TO_DATE('23/08/2013', 'DD/MM/YYYY'))),3.35));
/

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB987', 'Joe Cocker!',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, null, 'Great.', 5.0, TO_DATE('21/02/2015', 'DD/MM/YYYY'))),4.66));
/

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB988', 'With A Little Help From My Friends',46,'Rock', TO_DATE('05/10/1999', 'DD/MM/YYYY'),
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

The sound is a bit cleaner on this remaster, and the bonus tracks, while worth a listen, neither add to or detract from the recordings status.', 5.0, TO_DATE('19/03/2010', 'DD/MM/YYYY'))),4.99));
/
INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB989', 'The Magnificent Moodies',74,'Rock', TO_DATE('15/12/2014', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, 'Robert E', 'Classic.', 5.0, TO_DATE('12/09/2016', 'DD/MM/YYYY'))),13.99));
/

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB990', 'The Magnificent Void',69,'New Age', TO_DATE('22/02/1996', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, Null, 'Im a fan of much of Steve Roachs work. Dreamtime Return is still a favorite. But Magnificent Void has none of the magical quality of those discs, and is downright dark. The repetitive bass notes and rumble might be nice for a sci-fi horror movie. But it makes for boring listening. Pass on this one.', 1.0, TO_DATE('29/04/2009', 'DD/MM/YYYY'))),13.99));
/
INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB991', 'The Magnificent',32,'Rap', TO_DATE('13/08/2002', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, Null, 'A truly stunning CD. Best beats and music I have had the pleasure of listenin to in a while. All bases covered with STYLE. Buy, listen and enjoy.', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),12.42));
/

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB992', 'The Vigil',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This CD is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),12.28));
/

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB993', 'Childrens Songs',32,'Jazz', TO_DATE('30/09/2008', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, 'Domingo Carbrera', 'One of the best recordings of this great master. !', 5.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),10.18));

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB994', 'Duet',85,'Jazz', TO_DATE('06/08/2013', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, 'meryes', 'This CD Duet Chick and Hiromi is both artists showcasing their artisty, but I felt that it was too "competitive". Instead of a wonderful collaborative listening experience, I felt as if I listened to two great artists competing with each other. They did not blend and complement each other as much as fight for center stage. I much prefer Hiromis solo album Place To Be to this collaboration.', 2.0, TO_DATE('27/01/2011', 'DD/MM/YYYY'))),19.99));
/

INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB995', 'Blowin in the Wind',32,'Pop', TO_DATE('31/05/2011', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, Null, 'Meh, it was so-so', 2.5, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),12.98));
/
INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB996', 'The Freewheelin Bob Dylan',49,'Rock', TO_DATE('12/8/1988', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, Null, 'One of the clearest records Ive ever listened to. Very high quality!', 5.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),6.99));
/
/
INSERT INTO ALBUM VALUES (ALBUM_TYPE('ALB997', 'Weld',121,'Pop', TO_DATE('22/10/1991', 'DD/MM/YYYY'),
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
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),4.41));
/

INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB999','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
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

INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB998','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
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
),14.87));
/
INSERT INTO CD
  SELECT ALB.*, 1, 3.35
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB986';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 2.34
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB986';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 4.66
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB987';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 3.33
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB987';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 4.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 0.24
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 13.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB989';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 10.29
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB989';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 13.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB990';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 4.90
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB990';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 12.92
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB991';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 0.98
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB991';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 12.28
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB992';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 3.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB992';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 10.18
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB993';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 3.83
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB993';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 19.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB994';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 9.95
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB994';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 12.98
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB995';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 8.47
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB995';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 6.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB996';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 3.55
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB996';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 4.41
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB997';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 3.41
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB997';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 6.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB998';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 0.65
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB998';
 /
 INSERT INTO CD
  SELECT ALB.*, 1, 14.87
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB999';
 /
 INSERT INTO CD
  SELECT ALB.*, 0, 4.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB999';
 /
INSERT INTO VINYL
  SELECT ALB.*, 0, 0.79
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB987';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 1, 49.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 8.00
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 1, 19.95
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB989';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 71.94
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB989';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 18.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB991';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 4.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB995';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 1,22.42
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB996';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 14.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB996';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 4.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB999';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 1, 395.12
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB997';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 1, 18.32
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB998';
 /
 INSERT INTO VINYL
  SELECT ALB.*, 0, 15.95
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB998';
 /
INSERT INTO TAPE
  SELECT ALB.*, 0, 9.98
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB987';
 /
INSERT INTO TAPE
  SELECT ALB.*, 1, 39.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
  INSERT INTO TAPE
  SELECT ALB.*, 0, 2.98
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
  INSERT INTO TAPE
  SELECT ALB.*, 0, 6.86
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB997';
 /
  INSERT INTO TAPE
  SELECT ALB.*, 1, 14.90
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB997';
 /
  INSERT INTO TAPE
  SELECT ALB.*, 1, 90.38
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB999';
 /
INSERT INTO MP3
  SELECT ALB.*, 9.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB986';
 /
INSERT INTO MP3
  SELECT ALB.*, 6.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB987';
 /
INSERT INTO MP3
  SELECT ALB.*, 5.00
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB988';
 /
INSERT INTO MP3
  SELECT ALB.*, 8.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB989';
 /
INSERT INTO MP3
  SELECT ALB.*, 7.92
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB990';
 /
INSERT INTO MP3
  SELECT ALB.*, 9.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB992';
 /
INSERT INTO MP3
  SELECT ALB.*, 11.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB993';
 /
INSERT INTO MP3
  SELECT ALB.*, 18.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB994';
 /
INSERT INTO MP3
  SELECT ALB.*, 9.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB995';
 /
INSERT INTO MP3
  SELECT ALB.*, 9.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB996';
 /
INSERT INTO MP3
  SELECT ALB.*, 9.49
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB997';
 /
INSERT INTO MP3
  SELECT ALB.*, 6.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB998';
 /
INSERT INTO MP3
  SELECT ALB.*, 14.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB999';
 /
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART989','Joe Cocker'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART991','Steve Roach'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART994','Cick Corea'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART993','Hiromi'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART995','Arthur Lyman'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART996','Bob Dylan'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART998','Neil Young'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART997','Crazy Horse'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART999','Miles Davis'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB986';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB973';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB987';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB974';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB988';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART989' AND ALB.ALBUM_ID = 'ALB975';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB989';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART990' AND ALB.ALBUM_ID = 'ALB976';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART991' AND ALB.ALBUM_ID = 'ALB990';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART991' AND ALB.ALBUM_ID = 'ALB977';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Rapper'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART992' AND ALB.ALBUM_ID = 'ALB991';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Rapper'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART992' AND ALB.ALBUM_ID = 'ALB977';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB992';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB978';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB993';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB979';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB994';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART993' AND ALB.ALBUM_ID = 'ALB994';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART993' AND ALB.ALBUM_ID = 'ALB980';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB995';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB981';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB996';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB982';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART998' AND ALB.ALBUM_ID = 'ALB983';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Band'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART997' AND ALB.ALBUM_ID = 'ALB983';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB984';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB999';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB985';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB998';
/
INSERT INTO ALSO_BOUGHT
SELECT REF(ALB1), REF(ALB2)
FROM ALBUM ALB1, ALBUM ALB2
WHERE ALB1.ALBUM_ID = 'ALB999' AND ALB2.ALBUM_ID = 'ALB998'
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART1','Piotr Ilyitch Tchaikovsky'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART2','Wolfgang Sawallisch'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART3','Philadelphia Orchestra'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART4','Mark Ermler'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART5','Orchestra of the Royal Opera House, Covent Garden'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART6','Efrem Kurtz'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART7','Philharmonia Orchestra'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART8','Leonard Cohen'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART9','J.B.F. Wright'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART10','Little Junior Parker'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART11','Kris Kristofferson'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART12','Sam Shepard'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART13','Tom Petty'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART14','Carole Sayer Bager'));

-- QUESTION 1

INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB1','Tchaikovsky: Swan Lake (Complete Ballet)', 180, 'Classical', TO_DATE('01/06/2004', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Introduction: Moderato Assai - Allegro Ma Non Troppo',180,0.99,30),
TRACK_TYPE(2,'No.1 - Scene: Allegro Giusto',180,0.99,30),
TRACK_TYPE(3,'No.2 - Valse: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(4,'No.3 - Scene: Allegro Moderato',180,0.99,30),
TRACK_TYPE(5,'I: Intrada: Allegro',180,0.99,30),
TRACK_TYPE(6,'I: Intrada: Allegro',180,0.99,30),
TRACK_TYPE(7,'III: Allegro Semplice',180,0.99,30),
TRACK_TYPE(8,'IV: Moderato',180,0.99,30),
TRACK_TYPE(9,'V: Allegro',180,0.99,30),
TRACK_TYPE(10,'VI: Coda: Allegro Vivaceo',180,0.99,30),
TRACK_TYPE(11,'I: Tempo Di Valse Ma Non Troppo Vivo, Quasi Moderato',180,0.99,30),
TRACK_TYPE(12,' II: Andante - Allegro - Norman Carol',180,0.99,30),
TRACK_TYPE(13,'III: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(14,'IV: Coda: Allegro Molto Vivace',180,0.99,30),
TRACK_TYPE(15,'No.6 - Pas D Action: Andantino Quasi Moderato - Allegro',180,0.99,30),
TRACK_TYPE(16,'No.7 - Sujet',180,0.99,30),
TRACK_TYPE(17,'No.8 - Danse Des Coupes: Tempo Di Polacca',180,0.99,30),
TRACK_TYPE(18,'No.9 - Finale: Andante',180,0.99,30),
TRACK_TYPE(19,'No.10 - Scene: Moderato',180,0.99,30),
TRACK_TYPE(20,'No.11 - Scene: Allegro Moderato - Allegro Vivo',180,0.99,30),
TRACK_TYPE(21,'No.12 - Scene: Allegro',180,0.99,30),
TRACK_TYPE(22,'I: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(23,'II: Moderato Assai - Molto Piu Mosso',180,0.99,30),
TRACK_TYPE(24,'III: Danses Des Cygnes: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(25,'IV: Allegro Moderato',180,0.99,30),
TRACK_TYPE(26,'V: Pas D Action (Odette Et Le Prince): Andante - Andante Non Troppo - Allegro - Norman Carol',180,0.99,30),
TRACK_TYPE(27,'VI: Tempo Di Valse: Tout Le Monde Danse',180,0.99,30),
TRACK_TYPE(28,'VII: Coda: Allegro Vivo',180,0.99,30),
TRACK_TYPE(29,'No.14 - Scene: Moderato',180,0.99,30),
TRACK_TYPE(30,'No.15 - Scene: Allegro Giusto',180,0.99,30),
TRACK_TYPE(31,'No.16 - Danse Du Corps De Ballet Et Des Nains: Moderato Assai - Allegro Vivo',180,0.99,30),
TRACK_TYPE(32,'No.17 - Scene: Sortie Des Invites Et Valse: Allegro - Tempo Di Valse',180,0.99,30),
TRACK_TYPE(33,'No.18 - Scene: Allegro - Allegro Giusto',180,0.99,30),
TRACK_TYPE(34,'I: Intrada: Moderato Assai',180,0.99,30),
TRACK_TYPE(35,'II: Variation I: Allegro',180,0.99,30),
TRACK_TYPE(36,'III: Variation II: Andante Con Moto',180,0.99,30),
TRACK_TYPE(37,'IV: Variation III: Moderato',180,0.99,30),
TRACK_TYPE(38,'V: Variation IV: Allegro',180,0.99,30),
TRACK_TYPE(39,'VI: Variation V: Moderato - Allegro Semplice',180,0.99,30),
TRACK_TYPE(40,'VII: Coda: Allegro Molto',180,0.99,30),
TRACK_TYPE(41,'I: Moderato - Andante - Norman Carol',180,0.99,30),
TRACK_TYPE(42,'II: Variation I: Allegro Moderato',180,0.99,30),
TRACK_TYPE(43,'III: Variation II: Allegro',180,0.99,30),
TRACK_TYPE(44,'III: Coda: Allegro Molto Vivace',180,0.99,30),
TRACK_TYPE(45,'No.20 - Danse Hongroise - Czardas (Moderato Assai - Allegro Moderato - Vivace',180,0.99,30),
TRACK_TYPE(46,'Appendix 2: Danse Russe: Moderato - Allegro Semplice - Allegro Vivo - Norman Carol',180,0.99,30),
TRACK_TYPE(47,'No.21 - Danse Espagnole: Allegro Non Troppo, Tempo Di Bolero',180,0.99,30),
TRACK_TYPE(48,'No.22 - Danse Napolitaine: Allegro Moderato - Andantino Quasi Moderato - Presto - Frank Kaderbarek',180,0.99,30),
TRACK_TYPE(49,'No.23 - Mazurka: Solistes Et Corps De Ballet Tempo Di Mazurka',180,0.99,30),
TRACK_TYPE(50,'No.24 - Scene: Allegro - Valse - Allegro Vivo',180,0.99,30),
TRACK_TYPE(51,'No.25 - EntrActe: Moderato',180,0.99,30),
TRACK_TYPE(52,'No.26 - Scene: Allegro Non Troppo',180,0.99,30),
TRACK_TYPE(53,'No.27 - Danses Des Petits Cygnes: Moderato',180,0.99,30),
TRACK_TYPE(54,'No.28 - Scene: Allegro Agitato - Molto Meno Mosso - Allegro Vivace',180,0.99,30),
TRACK_TYPE(55,'No.29 - Scene Finale: Andante - Allegro Agitato - Alla Breve - Moderato',180,0.99,30)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Rudy Avila','Tchaikovskys Swan Lake remains a ballet favorite and a powerful star vehicle for the prima ballerina who must dance the roles of two characters- the "white swan" Odette and the black swan Odile, good and evil. Swan Lake has been recorded many times by celebrated conductors and their orchestras - Eugene Ormandy and the Philadelphia Orchestra (here its Wolfgang Sawallisch and the same orchestra from an earlier period) Canadian Charles Dutroit and the Montreal forces, Seiji Ozawa, Andre Previn and the London Symphony Orchestra, Richard Bonynge better known for his operatic vehicles with his wife Joan Sutherland, Antal Dorati and his orchestra, and even Herbert Von Karajan joined the band wagon of conducting great ballets- he conducted the complete Giselle and a concert suite of Tchaikovskys Swan Lake, Sleeping Beauty and Nutcracker. Wolfgang Sawallisch was a brilliant conductor, and unfortunately like so many conductors in Karajans time, he was underappreciated. This Swan Lake is beautifully restored and sounds fresh, powerful and lyrical. The music for Swan Lake has symphonic qualities, with a contrast of serene and jovial dances and melancholy and even fatalistic themes. The Dance of the Little Swans is bouncy and cheery, the violin solos for Odettes solo dances are almost mournful (shes mourning her swan condition/curse) and the Swan Theme is powerful and stormy, borrowed from the last notes to a Wagners Lohengrin prelude. For these reasons critics did not initially warm up to the "heavy" music of Swan Lake. But eventually it became the most beautiful of the "ballet-blancs" ever made. Other "white tutu" ballets include Giselle (Act 2 the Willis) and La Bayadere (Act 2 The Land of Shades). The music is to die for in this recording and I highly recommend it.',5.0,TO_DATE('06/07/2005', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Mateo','Herbert Von Karajan comes to mind. Slow. No sense of the arc of the entire dance, but rather a series of orchestral pieces that are played mostly mezzo forte, with limited drama and zero spontaneity. In sum, the performance fails to realize the composers intentions. I purchased the recording based on the reviews here, but will be giving it away as a gift. I may try again with Bonynges recording, which is said to be more balletic, or continue to look into the more obscure Russian recordings.', 3.0, TO_DATE('01/07/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'S. Vinokurov', 'Love the CD (it has two rare favs of mine... the faster Black Swan Variation and the extended Russian Dance) however, I was shocked not to find Black Swan Pas de Deux. How can you have a COMPLETE Swan Lake recording and not include that?!?!?!',4.0, TO_DATE('31/07/2006', 'DD/MM/YYYY'))
), 11.99));
/
INSERT INTO CD
	SELECT ALB.*, 1, 11.99
	FROM ALBUM ALB
	WHERE ALB.ALBUM_ID = 'ALB1'
/
INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB2','Tchaikovsky: Swan Lake', 180, 'Classical', TO_DATE('01/06/2004', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Introduction',180,0.99,30),
TRACK_TYPE(2,'No. 1 Scene',180,0.99,30),
TRACK_TYPE(3,'No. 2 Valse',180,0.99,30),
TRACK_TYPE(4,'No. 3 Scene',180,0.99,30),
TRACK_TYPE(5,'No. 4 Pas de Trois: Intrada',180,0.99,30),
TRACK_TYPE(6,'No. 4 Pas de Trois: Andante Sostenuto',180,0.99,30),
TRACK_TYPE(7,'No. 4 Pas de Trois: Allegro Semplice',180,0.99,30),
TRACK_TYPE(8,'No. 4 Pas de Trois: Moderato',180,0.99,30),
TRACK_TYPE(9,'No. 4 Pas de Trois: Allegro',180,0.99,30),
TRACK_TYPE(10,'No. 4 Pas de Trois: Allegro Vivace',180,0.99,30),
TRACK_TYPE(11,'No. 5 Pas de Deux: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(12,'No. 5 Pas de Deux: Andante',180,0.99,30),
TRACK_TYPE(13,'No. 5 Pas de Deux: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(14,'No. 5 Pas de Deux: Allegro Molto Vivace',180,0.99,30),
TRACK_TYPE(15,'No. 6 Pas D action',180,0.99,30),
TRACK_TYPE(16,'No. 7 Sujet',180,0.99,30),
TRACK_TYPE(17,'No. 8 Danse Des Coupes',180,0.99,30),
TRACK_TYPE(18,'No. 9 Finale',180,0.99,30),
TRACK_TYPE(19,'No. 10 Scene',180,0.99,30),
TRACK_TYPE(20,'No. 11 Scene',180,0.99,30),
TRACK_TYPE(21,'No. 12 Scene',180,0.99,30),
TRACK_TYPE(22,'No. 13 Danses Des Cygnes: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(23,'No. 13 Danses Des Cygnes: Moderato Assai',180,0.99,30),
TRACK_TYPE(24,'No. 13 Danses Des Cygnes: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(25,'No. 13 Danses Des Cygnes: Allegro Moderato',180,0.99,30),
TRACK_TYPE(26,'No. 13 Danses Des Cygnes: Andante',180,0.99,30),
TRACK_TYPE(27,'No. 13 Danses Des Cygnes: Tempo Di Valse',180,0.99,30),
TRACK_TYPE(28,'No. 13 Danses Des Cygnes: Coda',180,0.99,30),
TRACK_TYPE(29,'No.14 Scene',180,0.99,30),
TRACK_TYPE(30,'No.15 Allegro Giusto',180,0.99,30),
TRACK_TYPE(31,'No.16 Danse du Corps de Ballet Et Des Nains',180,0.99,30),
TRACK_TYPE(32,'No.17 Scene (La Sortie Des Invites Et la Valse',180,0.99,30),
TRACK_TYPE(33,'No.18 Scene',180,0.99,30),
TRACK_TYPE(34,'No 19 Pas de Six: Intrada',180,0.99,30),
TRACK_TYPE(35,'No 19 Pas de Six: Variation 1',180,0.99,30),
TRACK_TYPE(36,'No 19 Pas de Six: Variation 2',180,0.99,30),
TRACK_TYPE(37,'No 19 Pas de Six: Variation 3',180,0.99,30),
TRACK_TYPE(38,'No 19 Pas de Six: Variation 4',180,0.99,30),
TRACK_TYPE(39,'No 19 Pas de Six: Variation 5',180,0.99,30),
TRACK_TYPE(40,'No 19 Pas de Six: Coda',180,0.99,30),
TRACK_TYPE(41,'No 20 Danse Hongroise: Czardas',180,0.99,30),
TRACK_TYPE(42,'No 20 Danse Russe',180,0.99,30),
TRACK_TYPE(43,'No 21 Danse Espagnole',180,0.99,30),
TRACK_TYPE(44,'No 22 Danse Napolitaine',180,0.99,30),
TRACK_TYPE(45,'No 23 Mazurka',180,0.99,30),
TRACK_TYPE(46,'No 24 Scene',180,0.99,30),
TRACK_TYPE(47,'No 25 EntrActe',180,0.99,30),
TRACK_TYPE(48,'No 26 Scene',180,0.99,30),
TRACK_TYPE(49,'No 27 Danses Des Petits Cygnes',180,0.99,30),
TRACK_TYPE(50,'No 28 Scene',180,0.99,30),
TRACK_TYPE(51,'No 29 Scene Finale',180,0.99,30)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Ihor G. Murashchyk','Finally got myself a COMPLETE score of the best ballet ever written, not just a digest that is being widely offered. Thanks! ANd the preformance is quite good too :)',4.0,TO_DATE('01/10/2011', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'John Howard','BUYER BEWARE! This recording of Tchaikovsky Swan Lake is NOT one of the highly acclaimed recordings of Tchaikovsky by the Orchestra of the Royal Opera House Covent Garden with Mark Ermler as the Conductor. Rather, it is a recording of Swan Lake by the London Symphony Orchestra, conducted by Michael Tilson Thomas. The Identification codes embedded in the disc clearly reveal this fact. Insert this disc in any computer drive and see for yourself. Nevertheless, I feel that the LSO''s performance on this disc is just as great as the Royal Opera House. It is a five-star recording. The three-stars I gave is for the misrepresentation.', 3.0, TO_DATE('04/10/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(3,'Ronald Gold', 'How sad that five years ago one of your reviewers had to pay $105 for this three-disc recording, which is now listed for less than $8 .He''s right, though, that it''s a terrific performance. My guess is that this is because Ermler and his orchestra had countless previous performances WITH DANCERS to perfect this version, and the conductor doubtless had lots of practice, WITH DANCERS, in his native Russia. Another favorite version is that by Fistoulari, also with a British orchestra. ',5.0, TO_DATE('21/12/2012', 'DD/MM/YYYY'))
), 11.39));
/
INSERT INTO CD
	SELECT ALB.*, 1, 11.39
	FROM ALBUM ALB
	WHERE ALB.ALBUM_ID = 'ALB2'
/
SET ESCAPE '\'

INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB3','Tchaikovsky Swan Lake Suite From the Ballet', 55, 'Classical', TO_DATE('24/06/2016', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Introduction',186,0.99,12),
TRACK_TYPE(2,'No. 2: Valse',416,0.99,12),
TRACK_TYPE(3,'No. 4: Pas de Trois Nos. 1-6',604,0.99,12),
TRACK_TYPE(4,'No. 5: Pas de Deux Nos. 1 \& 2 (Act 1)',436,0.99,12),
TRACK_TYPE(5,'No. 5: Pas de Deux Nos. 3 \& 4 (Act 1)',201,0.99,12),
TRACK_TYPE(6,'No. 10: Scene (Act 2)',171,0.99,12),
TRACK_TYPE(7,'No. 13: Danses Des Cygnes Nos. 1, 2 \& 4 (Act 2)',314,0.99,12),
TRACK_TYPE(8,'No. 13: Danses Des Cygnes Nos. 5 (Act 2)',442,0.99,12),
TRACK_TYPE(9,'No. 20: Danse Hongroise (Czardas)(Act 3)',182,0.99,12),
TRACK_TYPE(10,'Danse Russe (from Supplement)',250,0.99,12)),
REVIEWS_TABLE(REVIEW_TYPE(1, NULL,'tHIS IS BULLSHIT. i THOUGHT i WAS BUYING THE cd',0.0,TO_DATE('30/06/2016', 'DD/MM/YYYY'))), 22.59));
/
INSERT INTO VINYL
	SELECT ALB.*, 1, 22.59
	FROM ALBUM ALB
	WHERE ALB.ALBUM_ID = 'ALB3'
/
INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB4','Tchaikovsky the Nutcracker Suite From the Ballet', 49, 'Classical', TO_DATE('24/06/2016', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Overture',189,0.99,48),
TRACK_TYPE(2,'No. 2 - Marche',150,0.99,48),
TRACK_TYPE(3,'No. 3 - Petit Galop Des Enfants Et Entre De Parents',144,0.99,48),
TRACK_TYPE(4,'No. 8 - Scene, No. 9 - Valse Des Flocons De Neige',669,0.99,48),
TRACK_TYPE(5,'No. 12 - Divertissement - Le Chocolat, Le Cafe',266,0.99,48),
TRACK_TYPE(6,'No. 12 - Divertissement - Le The, Trepak, Danse Des Mirlitons',266,0.99,48),
TRACK_TYPE(7,'No. 13 - Valse Des Fleurs',364,0.99,48),
TRACK_TYPE(8,'No. 14a - Pas De Deux',282,0.99,48),
TRACK_TYPE(9,'No. 14b - Pour Le Danse, Pour La Danseuse, Coda - No. 15 - Valse Finale',499,0.99,48)
),
REVIEWS_TABLE(REVIEW_TYPE(1, 'Patsy Morita','There are only so many ways you can say it, but it''s worth repeating: the combination of Efrem Kurtz and the Philharmonia Orchestra is one of the all-time best when it comes to performing Russian music for the stage. The recording of the Nutcracker Suite is just one example of their particular skills. There is a clarity and precision to the orchestra''s playing that gives Tchaikovsky''s music sparkle, while Kurtz breathes life into the dances and few moments of drama that are in the story. Even if you are only half-paying attention to it, you can still make out every distinct line, as melodies and countermelodies seamlessly pass from one instrument to another, and every nuance of dynamics and timing. And yet that attention to detail does not detract from the enchantment of the presentation. It''s a refreshing reading of the complete ballet that stands in contrast to the often run-of-the-mill and clichéd performances of the Nutcracker Suite.',5.0,TO_DATE('24/06/2016', 'DD/MM/YYYY'))
), 8.91));
/
INSERT INTO CD
	SELECT ALB.*, 1, 201.61
	FROM ALBUM ALB
	WHERE ALB.ALBUM_ID = 'ALB4'
/
INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB5','The Future', 60, 'Rock', TO_DATE('10/11/1992', 'DD/MM/YYYY'),
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
INSERT INTO CD
  SELECT ALB.*, 1, 7.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB5';
/
INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB6','Empire Burlesque', 46, 'Rock', TO_DATE('10/06/1985', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Tight Connection to My Heart (Has Anybody Seen My Love)',322,0.99,30),
TRACK_TYPE(2,'Seeing the Real You at Last',261,0.99,30),
TRACK_TYPE(3,'I''ll Remember You',254,0.99,30),
TRACK_TYPE(4,'Clean Cut Kid',257,0.99,30),
TRACK_TYPE(5,'Never Gonna Be the Same Again',191,0.99,30),
TRACK_TYPE(6,'Trust Yourself',209,0.99,30),
TRACK_TYPE(7,'Emotionally Yours',270,0.99,30),
TRACK_TYPE(8,'When the Night Comes Falling from the Sky',450,0.99,30),
TRACK_TYPE(9,'Something''s Burning, Baby',294,0.99,30),
TRACK_TYPE(10,'Dark Eyes',307,0.99,30)),
REVIEWS_TABLE(
REVIEW_TYPE(1, NULL,'If you want to live life like it doesn''t matter, and if you think pain is a good form of entertainment, and if you hate yourself, your ears and your very soul, you should buy this album. It has bad production, horribly bad instrumentation, visciously bad arrangements, excruciatingly bad vocals, and an indescribably bad cover. If you like Elton John, you''ll like this CD! And that says more than I ever could! The songs themselves are not horrible, it is just the way they were crafted that makes it so utterly sickening to listen to. If I were you, I''d buy Planet Waves, Blood on the Tracks, Oh Mercy or Time Out of Mind and hear the works of genius, not the works of a demented tired musical wanderer, who was apparently out of ideas, hope, and musical direction.',0.0,TO_DATE('05/08/2002', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'Schroedinger','Bob Dylan has said on multiple occasions that he has never liked the great acclaim he''s been given nor the title ''Voice of a Generation'', and so produced crappy albums to silence the fanatics. Yeah, this would be one of them. Dylan meets 80''s synth? The result is . . . it''s terrifying.', 0.0, TO_DATE('26/12/2004', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Marc Pottle','Found a skip in one of the songs as if a few words were cut.... Sent it back once, (I think) and the next one skipped too ! ? ! Hmmm.. studio didn''t do right on this one. Amazon was great',3.0, TO_DATE('11/07/2013', 'DD/MM/YYYY')),
REVIEW_TYPE(4, 'couchgrouch','don''t be misled by naysayers. this is a great record. I avoided it for years because of bad reviews. I took a chance on it 2 months ago and now it''s a staple in my cd player. it''s not Blood On the Tracks(what is?) but it''s a blast nonetheless. it''s catchy, stompin'' and downright funky. People complain that it''s too synthy, but it''s no more synthy than B.S.''s Born In the USA. Frankly, Empire is a better record. if Al Green had done Emotionally Yours, they''d say it was a great soul song. it is anyway. Something''s Burning is great. Trust Yourself, Clean Cut Kid are both funky as gramma''s old goat. Dark Eyes is fantastic and will stick in your head long after it''s over. the sound of the cd is contemporary, but so what? the songs are good, the performances are good. to me, that''s good music. don''t be put off because it doesn''t sound like a "Dylan album". check it out and give it a few listens. you won''t be disappointed.',4.0, TO_DATE('20/08/2000', 'DD/MM/YYYY')),
REVIEW_TYPE(5, 'Eric','arguably his best album but I doubt it. I like it but Bob has done better -- although not recently. Despite the requirement for a longer review, I think that this is all that needs to be said.',4.0, TO_DATE('09/08/2013', 'DD/MM/YYYY')),
REVIEW_TYPE(6, NULL,'In a decade where most of his work was mediocre at best, Bob Dylan hit the heights with this album full of catchy rock, compelling folk and touching love songs. By far, Dylan''s best album of the 80s. Two other Dylan goodies from the 80s are ''Infidels'' (1983) and ''Oh Mercy'' (1989).',5.0, TO_DATE('24/07/1998', 'DD/MM/YYYY'))
), 5.99));
/
INSERT INTO CD
  SELECT ALB.*, 1, 5.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB6';
/
INSERT INTO VINYL
  SELECT ALB.*, 1, 25.26
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB6';
/
INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB7','Knocked Out Loaded', 36, 'Rock', TO_DATE('14/07/1986', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'You Wanna Ramble',191,0.99,30),
TRACK_TYPE(2,'They Killed Him',240,0.99,30),
TRACK_TYPE(3,'Driftin'' Too Far from Shore',219,0.99,30),
TRACK_TYPE(4,'Precious Memories',193,0.99,30),
TRACK_TYPE(5,'Maybe Someday',197,0.99,30),
TRACK_TYPE(6,'Brownsville Girl',660,0.99,30),
TRACK_TYPE(7,'Got My Mind Made Up',173,0.99,30),
TRACK_TYPE(8,'Got My Mind Made Up',238,0.99,30)),
REVIEWS_TABLE(
REVIEW_TYPE(1, NULL,'Most of the reviews are by the same person. It is obvious that this album is simply awful and that the same person wrote all of the rave reviews below. Take my word for it. This album stinks. And thats saying a lot because I am a huge Dylan fan. Don''t Buy It!!!!',0.0,TO_DATE('24/03/1999', 'DD/MM/YYYY')),
REVIEW_TYPE(2,'monkeytot','this lp isn''t as bad as its reputation. It''s got a lot of gut-bucket blues on it, the same kind that got accolades on LOVE AND THEFT. In fact, ''You Wanna ramble'' is a precursor to ''Summer Days'' off of L\&T. ''Brownsville'' is great. Dylan delivers it in a dramatic monologue style, something he hasnt done before or since. This isn''t the worst Dylan. That honor goes to UNDER THE RED SKY.', 3.0, TO_DATE('11/04/2002', 'DD/MM/YYYY')),
REVIEW_TYPE(3, NULL,'Maybe this isn''t Bob''s best cd, but it''s better than anything ever released by the Rolling Stones, the Beatles, or Paul Simon. Bob proves that even his scraps are more meaningfull than anything released by Eric Clapton or Neil Young.',0.0, TO_DATE('29/01/1999', 'DD/MM/YYYY')),
REVIEW_TYPE(4, NULL,'This cd oozes with vibrancy and warmth. A pleasant journey to the heart of american music, with a world renowned conducter at the wheel. Survey says: buy it, you won''t regret it.',0.0, TO_DATE('21/01/1999', 'DD/MM/YYYY'))
), 5.99));
/
INSERT INTO CD
  SELECT ALB.*, 1, 5.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO VINYL
  SELECT ALB.*, 1, 5.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB7';
/
-- ROLES/ALSO BOUGHT
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART1' AND ALB.ALBUM_ID = 'ALB1';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Conductor'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART2' AND ALB.ALBUM_ID = 'ALB1';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Orchestra'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART3' AND ALB.ALBUM_ID = 'ALB1';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART1' AND ALB.ALBUM_ID = 'ALB2';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Conductor'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART4' AND ALB.ALBUM_ID = 'ALB2';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Orchestra'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART5' AND ALB.ALBUM_ID = 'ALB2';
/
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB1'
	AND SEC_ALB.ALBUM_ID = 'ALB2';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART1' AND ALB.ALBUM_ID = 'ALB3';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Conductor'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART6' AND ALB.ALBUM_ID = 'ALB3';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Orchestra'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART7' AND ALB.ALBUM_ID = 'ALB3';
/	
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB1'
	AND SEC_ALB.ALBUM_ID = 'ALB3';
/	
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB2'
	AND SEC_ALB.ALBUM_ID = 'ALB3';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART1' AND ALB.ALBUM_ID = 'ALB4';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Conductor'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART6' AND ALB.ALBUM_ID = 'ALB4';
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Orchestra'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART7' AND ALB.ALBUM_ID = 'ALB4';
/
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB3'
	AND SEC_ALB.ALBUM_ID = 'ALB4';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Composer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART8' AND ALB.ALBUM_ID = 'ALB5';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART8' AND ALB.ALBUM_ID = 'ALB5';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB6';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB6';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART10' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART11' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART12' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART13' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART14' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART9' AND ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ALBUM VALUES(ALBUM_TYPE('ALB8','Oh Mercy', 46, 'Rock', TO_DATE('18/09/1989', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Political World',322,0.99,30),
TRACK_TYPE(2,'Where Teardrops Fall',261,0.99,30),
TRACK_TYPE(3,'Everything Is Broken',254,0.99,30),
TRACK_TYPE(4,'Ring Them Bells',257,0.99,30),
TRACK_TYPE(5,'Man in the Long Black Coat',191,0.99,30),
TRACK_TYPE(6,'Most of the Time',209,0.99,30),
TRACK_TYPE(7,'What Good Am I',270,0.99,30),
TRACK_TYPE(8,'Disease of Conceit',450,0.99,30),
TRACK_TYPE(9,'What Was It You Wanted',294,0.99,30),
TRACK_TYPE(10,'Shooting Star',307,0.99,30)),
REVIEWS_TABLE(
REVIEW_TYPE(1, 'Jon Nelson','This one of the best albums of the 1980''s. It has an unique sound. This is my favorite Bob Dylan album (I have over 18 of his albums). The SACD is marginally better than the standard CD but you will not be disappointed.',5.0,TO_DATE('23/06/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2, NULL ,'I''m sorry to say it but this album just isn''t up to Dylan par. With the exception of Ring Them Bells, there isn''t a truly good song on the CD. Its very forced sounding and the writing is really gimmicky, as if Dylan doesn''t actually have much to say so he tries to go back in time with ''Political World'' and ''Disease of Conceit'', but they just come off sounding phony. If you''re a true Dylan fan, buy this album just to have it, but otherwise, you could do better with something from the 60''s or 70''s.', 2.0, TO_DATE('12/01/2001', 'DD/MM/YYYY'))
), 8.99));
/
INSERT INTO CD
  SELECT ALB.*, 1, 6.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB8';
/
INSERT INTO VINYL
  SELECT ALB.*, 1, 23.60
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB8';
/
INSERT INTO MP3
  SELECT ALB.*, 8.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB8';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB8';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Songwriter'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART996' AND ALB.ALBUM_ID = 'ALB8';
/
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB6'
	AND SEC_ALB.ALBUM_ID = 'ALB7';
/
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB6'
	AND SEC_ALB.ALBUM_ID = 'ALB8';
/
INSERT INTO ALSO_BOUGHT
	SELECT REF(FIR_ALB), REF(SEC_ALB)
	FROM ALBUM FIR_ALB, ALBUM SEC_ALB
	WHERE FIR_ALB.ALBUM_ID = 'ALB7'
	AND SEC_ALB.ALBUM_ID = 'ALB8';
/
CREATE OR REPLACE VIEW QUESTION_9 (TITLE, RELEASE_DATE, STANDARD_PRICE) AS
SELECT ALB1.TITLE, ALB1.RELEASE_DATE, CD.PRICE FROM
ALBUM ALB1, ALBUM ALB2, ALSO_BOUGHT AB, CD
WHERE AB.ALBUM_1_ID = REF(ALB1)
AND AB.ALBUM_2_ID = REF(ALB2)
AND ALB2.ALBUM_ID = 'ALB999'
AND CD.TITLE = ALB1.TITLE
AND CD.NEW_OR_USED = 1
UNION
SELECT ALB1.TITLE, ALB1.RELEASE_DATE, CD.PRICE FROM
ALBUM ALB1, ALBUM ALB2, ALSO_BOUGHT AB, CD
WHERE AB.ALBUM_1_ID = REF(ALB2)
AND AB.ALBUM_2_ID = REF(ALB1)
AND ALB2.TITLE = 'Sketches of Spain'
AND CD.TITLE = ALB1.TITLE
AND CD.NEW_OR_USED = 1;

/
SELECT * FROM U12227359.ALSO_BOUGHT;
/
SELECT SONG_TITLE FROM CD;
/
CREATE OR REPLACE VIEW QUESTION_7 (TITLE, RELEASE_DATE, FORMAT, PRICE, DISCOUNTED_PRICE) AS
SELECT ALB.TITLE, ALB.RELEASE_DATE, 'CD', C.PRICE, C.DISCOUNTPRICE() FROM ALBUM ALB, ARTIST ART, ROLE ROL, CD C
WHERE ART.ARTIST_NAME = 'Cick Corea' AND ROL.ARTIST_ID = REF(ART) AND ROL.ALBUM_ID = REF(ALB) AND ALB.ALBUM_ID = C.ALBUM_ID
UNION
SELECT ALB.TITLE, ALB.RELEASE_DATE,'VINYL', V.PRICE, V.DISCOUNTPRICE() FROM ALBUM ALB, ARTIST ART, ROLE ROL, VINYL V
WHERE ART.ARTIST_NAME = 'Cick Corea' AND ROL.ARTIST_ID = REF(ART) AND ROL.ALBUM_ID = REF(ALB) AND ALB.ALBUM_ID = V.ALBUM_ID
UNION
SELECT ALB.TITLE, ALB.RELEASE_DATE,'TAPE', T.PRICE, T.DISCOUNTPRICE() FROM ALBUM ALB, ARTIST ART, ROLE ROL, TAPE T
WHERE ART.ARTIST_NAME = 'Cick Corea' AND ROL.ARTIST_ID = REF(ART) AND ROL.ALBUM_ID = REF(ALB) AND ALB.ALBUM_ID = T.ALBUM_ID
UNION
SELECT ALB.TITLE, ALB.RELEASE_DATE,'MP3', M.PRICE, M.DISCOUNTPRICE() FROM ALBUM ALB, ARTIST ART, ROLE ROL, MP3 M
WHERE ART.ARTIST_NAME = 'Cick Corea' AND ROL.ARTIST_ID = REF(ART) AND ROL.ALBUM_ID = REF(ALB) AND ALB.ALBUM_ID = M.ALBUM_ID;
/
SELECT ALB.TITLE, ALB.RELEASE_DATE, V.PRICE, V.DISCOUNTPRICE() FROM ALBUM ALB, VINYL V
WHERE ALB.ALBUM_ID = V.ALBUM_ID;
/
SELECT TITLE, RELEASE_DATE FROM ALBUM WHERE TITLE LIKE '%Magnificent%';
/
SELECT ALB.TITLE, ALB.RELEASE_DATE, ALB.AVGREVIEWSCORE() FROM ALBUM ALB, ARTIST ART, ROLE ROL
WHERE ART.ARTIST_NAME = 'Joe Cocker' AND ROL.ARTIST_ID = REF(ART) AND ROL.ALBUM_ID = REF(ALB);
/
SELECT ALB.TITLE, ALB.RELEASE_DATE, C.PRICE, C.DISCOUNTPRICE() FROM ALBUM ALB, ARTIST ART, ROLE ROL, CD C
WHERE ART.ARTIST_NAME = 'Chick Corea' AND ROL.ARTIST_ID = REF(ART) AND ROL.ALBUM_ID = REF(ALB) AND ALB.ALBUM_ID = C.ALBUM_ID;
/
SELECT DISCOUNTPRICE() FROM ALBUM;
/
INSERT INTO PLAYLIST VALUES ('PLAY1', 'Classical', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),1 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB1' AND TRK.TRACK_ID = 2; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),2 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB3' AND TRK.TRACK_ID = 9; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),3 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB1' AND TRK.TRACK_ID = 14; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),4 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB1' AND TRK.TRACK_ID = 25; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),5 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB1' AND TRK.TRACK_ID = 32; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),6 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB1' AND TRK.TRACK_ID = 42; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),7 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB4' AND TRK.TRACK_ID = 5; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),8 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB2' AND TRK.TRACK_ID = 7; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),9 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB2' AND TRK.TRACK_ID = 9; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),10 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB2' AND TRK.TRACK_ID = 32; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),11 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB2' AND TRK.TRACK_ID = 41; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),12 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB2' AND TRK.TRACK_ID = 43; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),13 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB2' AND TRK.TRACK_ID = 48; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),14 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB3' AND TRK.TRACK_ID = 4; ),
(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),15 FROM ALBUM ALB, TRACK TR WHERE ALB.ALBUM_ID = 'ALB4' AND TRK.TRACK_ID = 1; ));
/
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),1 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB992' AND TRK.TRACK_ID = 2; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),2 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB992' AND TRK.TRACK_ID = 1; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),3 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB993' AND TRK.TRACK_ID = 8; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),4 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB993' AND TRK.TRACK_ID = 11; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),5 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB993' AND TRK.TRACK_ID = 16; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),6 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB993' AND TRK.TRACK_ID = 16; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),7 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB994' AND TRK.TRACK_ID = 2; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),8 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB994' AND TRK.TRACK_ID = 4; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),9 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB992' AND TRK.TRACK_ID = 7; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),10 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB994' AND TRK.TRACK_ID = 9; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),11 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB994' AND TRK.TRACK_ID = 11; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),12 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB998' AND TRK.TRACK_ID = 1; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),13 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB998' AND TRK.TRACK_ID = 2; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),14 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB999' AND TRK.TRACK_ID = 5; )
INSERT INTO PLAYLIST VALUES ('PLAY2', 'Jazz', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),15 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB999' AND TRK.TRACK_ID = 1; )
/
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),1 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB5' AND TRK.TRACK_ID = 2; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),2 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB5' AND TRK.TRACK_ID = 5; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),3 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB986' AND TRK.TRACK_ID = 6; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),4 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB6' AND TRK.TRACK_ID = 4; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),5 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB6' AND TRK.TRACK_ID = 7; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),6 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB7' AND TRK.TRACK_ID = 8; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),7 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB8' AND TRK.TRACK_ID = 5; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),8 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB986' AND TRK.TRACK_ID = 2; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),9 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB987' AND TRK.TRACK_ID = 1; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),10 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB988' AND TRK.TRACK_ID = 6; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),11 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB989' AND TRK.TRACK_ID = 1; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),12 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB989' AND TRK.TRACK_ID = 11; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),13 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB996' AND TRK.TRACK_ID = 11; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),14 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB996' AND TRK.TRACK_ID = 13; )
INSERT INTO PLAYLIST VALUES ('PLAY3', 'Rock', PLAYLIST_TRACKS(PLAYLIST_TRACK_TYPE(SELECT REF(ALB), REF(TR),15 FROM ALBUM ALB, TACK TR WHERE ALB.ALBUM_ID = 'ALB987' AND TRK.TRACK_ID = 9; )

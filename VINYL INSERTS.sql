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
INSERT INTO VINYL VALUES(VINYL_TYPE('ALB999','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99,10),
TRACK_TYPE(2,'Will O the wisp',229,0.99,50),
TRACK_TYPE(3,'The Pan Piper',237,0.99,40),
TRACK_TYPE(4,'Saeta',335,0.99,30),
TRACK_TYPE(5,'Solea',938,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))
), 1, 19.46));
/
INSERT INTO VINYL VALUES(VINYL_TYPE('ALB984','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99,10),
TRACK_TYPE(2,'Will O the wisp',229,0.99,50),
TRACK_TYPE(3,'The Pan Piper',237,0.99,40),
TRACK_TYPE(4,'Saeta',335,0.99,30),
TRACK_TYPE(5,'Solea',938,0.99,10)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))

/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB999';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, VINYL ALB
	WHERE ART.ARTIST_ID = 'ART999' AND ALB.ALBUM_ID='ALB984';
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
SERT INTO VINYL VALUES(VINYL_TYPE('ALB985','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
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
),1,15.95));
/
INSERT INTO ALSO_BOUGHT
SELECT REF(VINYL1), REF(VINYL2)
FROM VINYL VINYL1, VINYL VINYL2
WHERE VINYL1.ALBUM_ID = 'ALB999' AND VINYL2.ALBUM_ID = 'ALB998'
/
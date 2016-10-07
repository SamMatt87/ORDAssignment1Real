
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
	WHERE ART.ARTIST_ID = 'ART997' AND (ALB.ALBUM_ID = 'ALB980';
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


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
REVIEW_TYPE(3, Null, 'Well, let me clarify that... If your used to and like the "Electrik Band" and the more progressive side of Chic and his band members, then this is not for you! This CD is very mellow!', 1.0, TO_DATE('14/04/2015', 'DD/MM/YYYY'))),1,9.49));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB992';
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
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Piano'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART994' AND ALB.ALBUM_ID = 'ALB993';
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
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART995','Arthur Lyman'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Singer'
	FROM ARTIST ART, CD ALB
	WHERE ART.ARTIST_ID = 'ART995' AND ALB.ALBUM_ID = 'ALB995';
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
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART996','Bob Dylan'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(CD), 'Singer'
	FROM ARTIST ART, CD
	WHERE ART.ARTIST_ID = 'ART996' AND CD.ALBUM_ID = 'ALB996';
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
REVIEW_TYPE(3, Null, 'How could you go wrong when its Neil?', 4.0, TO_DATE('24/08/2016', 'DD/MM/YYYY'))),1,10.18));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART998','Neil Young'));
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART997','Crazy Horse'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(CD), 'Singer'
	FROM ARTIST ART, CD
	WHERE ART.ARTIST_ID = 'ART998' AND CD.ALBUM_ID = 'ALB997';
/
INSERT INTO ROLE
	SELECT REF(ART), REF(CD), 'Band'
	FROM ARTIST ART, CD
	WHERE ART.ARTIST_ID = 'ART997' AND CD.ALBUM_ID = 'ALB997';
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
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART999','Miles Davis'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(CD), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, ALBUM ALB
	WHERE ART.ARTIST_ID = 'ART999' AND CD.ALBUM_ID = 'ALB999';
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
INSERT INTO ALSO_BOUGHT
SELECT REF(CD1), REF(CD2)
FROM CD CD1, CD CD2
WHERE CD1.ALBUM_ID = 'ALB999' AND CD2.ALBUM_ID = 'ALB998'
/
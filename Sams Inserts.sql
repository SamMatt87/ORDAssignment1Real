INSERT INTO ALBUM VALUES(CD_TYPE('ALB999','Sketches of Spain', 45, 'Jazz', TO_DATE('01/01/1960', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Concerto de Arunjez: Adagio',981,0.99),
TRACK_TYPE(2,'Will O the wisp',229,0.99),
TRACK_TYPE(3,'The Pan Piper',237,0.99),
TRACK_TYPE(4,'Saeta',335,0.99),
TRACK_TYPE(5,'Solea',938,0.99)),
REVIEWS_TABLE(
REVIEW_TYPE(1,'Betty Bo','Recording quality is good for such an old recording',3.0,TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Ive tried....really tried with this one , but it just doesnt do anything for me.But Ill try again ....maybe eventually it will click.', 3.0, TO_DATE('30/09/2010', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Sarah Knapp', 'My mom had this on vinyl when I was a small child. I grew up to these cuts and learned to love Miles Davis from a very early age. Ive had it on vinyl and cassette myself, but can no longer play those. This is AWESOME and brings my hear great joy!',5.0, TO_DATE('03/10/2006', 'DD/MM/YYYY'))
), 1, 6.99));
/
INSERT INTO ARTIST VALUES(ARTIST_TYPE('ART999','Miles Davis'));
/
INSERT INTO ROLE
	SELECT REF(ART), REF(ALB), 'Flugelhorn/Trumpet'
	FROM ARTIST ART, ALBUM ALB
	WHERE ARTIST_ID = 'ART999' AND ALB.ALBUM_ID = 'ALB999';
/
INSERT INTO ALBUM VALUES(CD_TYPE('ALB998','Bitches Brew', 105, 'Jazz', TO_DATE('08/06/1999', 'DD/MM/YYYY'),
TRACKS(TRACK_TYPE(1,'Pharohs dance',1204,0.99),
TRACK_TYPE(2,'Bitches Brew',1619,0.99),
TRACK_TYPE(3,'Spanish Key',1052,0.99),
TRACK_TYPE(4,'John Mclaughlin',262,0.99),
TRACK_TYPE(5,'Miles Runs the Voodoo Down',841,0.99),
TRACK_TYPE(6,'Sanctuary',656,0.99),
TRACK_TYPE(5,'Feio',709,0.99)),
REVIEWS_TABLE(
REVIEW_TYPE(1,NULL,'Im getting broken in. Have listened to it 3 times and am still trying to like it. I like some other Miles Davis albums waaaaay better!
My top 3:
1) Milestones
2) Kind of Blue
3) In a Silent Way',3.0, TO_DATE('23/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(2,NULL,'Been waiting a long time to hear this again. Miles is brilliant!', 5.0, TO_DATE('21/09/2016', 'DD/MM/YYYY')),
REVIEW_TYPE(3, 'Rita Sweeney', 'Love it!',5.0, TO_DATE('29/6/2016', 'DD/MM/YYYY'))
),1,14.87);
/
INSERT INTO ALSO_BOUGHT
SELECT REF(ALB1), REF(ALB2)
FROM ALBUM ALB1, ALBUM ALB2
WHERE AL1.ALBUM_ID = ALB999 AND ALB2.ALBUM_ID = ALB998
/

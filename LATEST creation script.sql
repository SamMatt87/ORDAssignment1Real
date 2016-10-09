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
--SET ESCAPE '\'

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
REVIEW_TYPE(1, 'Jon Nelson','This one of the best albums of the 1980's. It has an unique sound. This is my favorite Bob Dylan album (I have over 18 of his albums). The SACD is marginally better than the standard CD but you will not be disappointed.',5.0,TO_DATE('23/06/2014', 'DD/MM/YYYY')),
REVIEW_TYPE(2, NULL ,'I'm sorry to say it but this album just isn't up to Dylan par. With the exception of Ring Them Bells, there isn't a truly good song on the CD. Its very forced sounding and the writing is really gimmicky, as if Dylan doesn't actually have much to say so he tries to go back in time with "Political World" and "Disease of Conceit", but they just come off sounding phony. If you're a true Dylan fan, buy this album just to have it, but otherwise, you could do better with something from the 60's or 70's.', 2.0, TO_DATE('12/01/2001', 'DD/MM/YYYY')))
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
  SELECT ALB.*, 1, 8.99
  FROM ALBUM ALB
  WHERE ALB.ALBUM_ID = 'ALB8';
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

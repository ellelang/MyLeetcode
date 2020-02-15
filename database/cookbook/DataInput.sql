SHOW databases;
USE cookbook;
SHOW TABLES;
DROP TABLE IF EXISTS mail;
CREATE TABLE mail
(
  t       DATETIME,    # when message was sent
  srcuser VARCHAR(8),  # sender (source user and host)
  srchost VARCHAR(20),
  dstuser VARCHAR(8),  # recipient (destination user and host)
  dsthost VARCHAR(20),
  size    BIGINT,      # message size in bytes
  INDEX (t)
);
INSERT INTO mail (t,srchost,srcuser,dsthost,dstuser,size)
  VALUES
    ('2014-05-11 10:15:08','saturn','barb','mars','tricia',58274),
    ('2014-05-12 12:48:13','mars','tricia','venus','gene',194925),
    ('2014-05-12 15:02:49','mars','phil','saturn','phil',1048),
    ('2014-05-12 18:59:18','saturn','barb','venus','tricia',271),
    ('2014-05-14 09:31:37','venus','gene','mars','barb',2291),
    ('2014-05-14 11:52:17','mars','phil','saturn','tricia',5781),
    ('2014-05-14 14:42:21','venus','barb','venus','barb',98151),
    ('2014-05-14 17:03:01','saturn','tricia','venus','phil',2394482),
    ('2014-05-15 07:17:48','mars','gene','saturn','gene',3824),
    ('2014-05-15 08:50:57','venus','phil','venus','phil',978),
    ('2014-05-15 10:25:52','mars','gene','saturn','tricia',998532),
    ('2014-05-15 17:35:31','saturn','gene','mars','gene',3856),
    ('2014-05-16 09:00:28','venus','gene','mars','barb',613),
    ('2014-05-16 23:04:19','venus','phil','venus','barb',10294),
    ('2014-05-19 12:49:23','mars','phil','saturn','tricia',873),
    ('2014-05-19 22:21:51','saturn','gene','venus','gene',23992)
;
SHOW TABLES;

DROP TABLE IF EXISTS sales_region;
CREATE TABLE sales_region
(
  region_id INT UNSIGNED NOT NULL,
  name      VARCHAR(30) NOT NULL,
  PRIMARY KEY(region_id)
);

DROP TABLE IF EXISTS sales_volume;
CREATE TABLE sales_volume
(
  region_id  INT UNSIGNED NOT NULL,
  year       INT NOT NULL,
  quarter    INT NOT NULL,
  volume     INT NOT NULL
);

INSERT INTO sales_region (region_id, name) VALUES
(1, 'London, United Kingdom'),
(2, 'Madrid, Spain'),
(3, 'Berlin, Germany'),
(4, 'Athens, Greece');

INSERT INTO sales_volume (region_id, year, quarter, volume) VALUES
(1, 2014, 1, 100400),
(1, 2014, 2, 120000),
(3, 2014, 1, 280000),
(3, 2014, 2, 250000),
(5, 2014, 1, 18000),
(5, 2014, 2, 32000);

DROP TABLE IF EXISTS weatherdata;
CREATE TABLE weatherdata
(
station INT UNSIGNED NOT NULL,
type ENUM('precip','temp','cloudiness','humidity','barometer') NOT NULL,
value FLOAT,
PRIMARY KEY (station, type)
);


DROP TABLE IF EXISTS states;
CREATE TABLE states
(
  name       VARCHAR(20),  # sender (source user and host)
  abbrev       VARCHAR(20),
  statehood       DATETIME,  
  pop          INT
);


SET GLOBAL LOCAL_INFILE = True;

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

#LOAD DATA LOCAL INFILE '/Users/langzx/Desktop/states.txt' INTO TABLE states;
INSERT INTO states (name,abbrev,statehood,pop) VALUES
('Alabama','AL','1819-12-14',4779736),
('Alaska','AK','1959-01-03',710231),
('Arizona','AZ','1912-02-14',6392017),
('Arkansas','AR','1836-06-15',2915918),
('California','CA','1850-09-09',37253956),
('Colorado','CO','1876-08-01',5029196),
('Connecticut','CT','1788-01-09',3574097),
('Delaware','DE','1787-12-07',897934),
('Florida','FL','1845-03-03',18801310),
('Georgia','GA','1788-01-02',9687653),
('Hawaii','HI','1959-08-21',1360301),
('Idaho','ID','1890-07-03',1567582),
('Illinois','IL','1818-12-03',12830632),
('Indiana','IN','1816-12-11',6483802),
('Iowa','IA','1846-12-28',3046355),
('Kansas','KS','1861-01-29',2853118),
('Kentucky','KY','1792-06-01',4339367),
('Louisiana','LA','1812-04-30',4533372),
('Maine','ME','1820-03-15',1328361),
('Maryland','MD','1788-04-28',5773552),
('Massachusetts','MA','1788-02-06',6547629),
('Michigan','MI','1837-01-26',9883640),
('Minnesota','MN','1858-05-11',5303925),
('Mississippi','MS','1817-12-10',2967297),
('Missouri','MO','1821-08-10',5988927),
('Montana','MT','1889-11-08',989415),
('Nebraska','NE','1867-03-01',1826341),
('Nevada','NV','1864-10-31',2700551),
('New Hampshire','NH','1788-06-21',1316470),
('New Jersey','NJ','1787-12-18',8791894),
('New Mexico','NM','1912-01-06',2059179),
('New York','NY','1788-07-26',19378102),
('North Carolina','NC','1789-11-21',9535483),
('North Dakota','ND','1889-11-02',672591),
('Ohio','OH','1803-03-01',11536504),
('Oklahoma','OK','1907-11-16',3751351),
('Oregon','OR','1859-02-14',3831074),
('Pennsylvania','PA','1787-12-12',12702379),
('Rhode Island','RI','1790-05-29',1052567),
('South Carolina','SC','1788-05-23',4625364),
('South Dakota','SD','1889-11-02',814180),
('Tennessee','TN','1796-06-01',6346105),
('Texas','TX','1845-12-29',25145561),
('Utah','UT','1896-01-04',2763885),
('Vermont','VT','1791-03-04',625741),
('Virginia','VA','1788-06-25',8001024),
('Washington','WA','1889-11-11',6724540),
('West Virginia','WV','1863-06-20',1852994),
('Wisconsin','WI','1848-05-29',5686986),
('Wyoming','WY','1890-07-10',563626);

SHOW TABLES;


DROP TABLE IF EXISTS tax;
CREATE TABLE tax
(
  statename       VARCHAR(20),  # sender (source user and host)
  rate            DOUBLE
);

INSERT INTO tax (statename,rate) VALUES
('AK',0.03),
('AL',0.03),
('AR',0.06),
('AZ',0.02),
('CA',0.02),
('CO',0.05),
('CT',0.06),
('DE',0.08),
('FL',0.02),
('GA',0.06),
('HI',0.02),
('IA',0.02),
('ID',0.05),
('IL',0.08),
('IN',0.07),
('KS',0.08),
('KY',0.02),
('LA',0.03),
('MA',0.01),
('MD',0.05),
('ME',0.02),
('MI',0.07),
('MN',0.06),
('MO',0.02),
('MS',0.05),
('MT',0.06),
('NC',0.08),
('ND',0.09),
('NE',0.04),
('NH',0.01),
('NJ',0.05),
('NM',0.02),
('NV',0.04),
('NY',0.09),
('OH',0.07),
('OK',0.07),
('OR',0.02),
('PA',0.01),
('RI',0.07),
('SC',0.02),
('SD',0.08),
('TN',0.07),
('TX',0.1),
('UT',0.07),
('VA',0.07),
('VT',0.01),
('WA',0.07),
('WI',0.03),
('WV',0.02),
('WY',0.03);
SELECT * FROM tax;

DROP TABLE IF EXISTS city;
CREATE TABLE city
(
  state      VARCHAR(20),  # sender (source user and host)
  capital     VARCHAR(20),
  center      VARCHAR(20)
);

INSERT INTO city (state,capital, center) VALUES
('Alabama','Montgomery','Birmingham'),
('Alaska','Juneau','Anchorage'),
('Arizona','Phoenix','Phoenix'),
('Arkansas','Little Rock','Little Rock'),
('California','Sacramento','Los Angeles'),
('Colorado','Denver','Denver'),
('Connecticut','Hartford','Bridgeport'),
('Delaware','Dover','Wilmington'),
('Florida','Tallahassee','Jacksonville'),
('Georgia','Atlanta','Atlanta'),
('Hawaii','Honolulu','Honolulu'),
('Idaho','Boise','Boise'),
('Illinois','Springfield','Chicago'),
('Indiana','Indianapolis','Indianapolis'),
('Iowa','Des Moines','Des Moines'),
('Kansas','Topeka','Wichita'),
('Kentucky','Frankfort','Louisville'),
('Louisiana','Baton Rouge','New Orleans'),
('Maine','Augusta','Portland'),
('Maryland','Annapolis','Baltimore'),
('Massachusetts','Boston','Boston'),
('Michigan','Lansing','Detroit'),
('Minnesota','St. Paul','Minneapolis'),
('Mississippi','Jackson','Jackson'),
('Missouri','Jefferson City','Kansas City'),
('Montana','Helena','Billings'),
('Nebraska','Lincoln','Omaha'),
('Nevada','Carson City','Las Vegas'),
('New Hampshire','Concord','Manchester'),
('New Jersey','Trenton','Newark'),
('New Mexico','Santa Fe','Albuquerque'),
('New York','Albany','New York City'),
('North Carolina','Raleigh','Charlotte'),
('North Dakota','Bismarck','Fargo'),
('Ohio','Columbus','Columbus'),
('Oklahoma','Oklahoma City','Oklahoma City'),
('Oregon','Salem','Portland'),
('Pennsylvania','Harrisburg','Philadelphia'),
('Rhode Island','Providence','Providence'),
('South Carolina','Columbia','Columbia'),
('South Dakota','Pierre','Sioux Falls'),
('Tennessee','Nashville','Memphis'),
('Texas','Austin','Houston'),
('Utah','Salt Lake City','Salt Lake City'),
('Vermont','Montpelier','Burlington'),
('Virginia','Richmond','Virginia Beach'),
('Washington','Olympia','Seattle'),
('West Virginia','Charleston','Charleston'),
('Wisconsin','Madison','Milwaukee'),
('Wyoming','Cheyenne','Cheyenne');

DROP TABLE IF EXISTS al_winner;
CREATE TABLE al_winner (
name VARCHAR(20),
wins INT
);
INSERT INTO al_winner (name,wins) VALUES
('Mulder, Mark',21),
('Clemens, Roger',20),
('Moyer, Jamie',20),
('Garcia, Freddy',18),
('Hudson, Tim',18),
('Abbott, Paul',17),
('Mays, Joe',17),
('Mussina, Mike',17),
('Sabathia, C.C.',17),
('Zito, Barry',17),
('Buehrle, Mark',16),
('Milton, Eric',15),
('Pettitte, Andy',15),
('Radke, Brad',15),
('Sele, Aaron',15);

DROP TABLE IF EXISTS standings1;
CREATE TABLE standings1
(
  team  CHAR(20), # team name
  wins  INT,      # number of wins
  losses  INT     # number of losses
);

# Load Northern League final 1902 standings into the table

INSERT INTO standings1 (team, wins, losses) VALUES ('Winnipeg',37,20);
INSERT INTO standings1 (team, wins, losses) VALUES ('Crookston',31,25);
INSERT INTO standings1 (team, wins, losses) VALUES ('Fargo',30,26);
INSERT INTO standings1 (team, wins, losses) VALUES ('Grand Forks',28,26);
INSERT INTO standings1 (team, wins, losses) VALUES ('Devils Lake',19,31);
INSERT INTO standings1 (team, wins, losses) VALUES ('Cavalier',15,32);


DROP TABLE IF EXISTS weekday;
#@ _CREATE_TABLE_
CREATE TABLE weekday
(
  day ENUM('Sunday','Monday','Tuesday','Wednesday',
           'Thursday','Friday','Saturday')
);
#@ _CREATE_TABLE_

# insert one record for each day of the week (insert in random order)

INSERT INTO weekday (day) VALUES('Monday'),('Friday'),
('Tuesday'),('Sunday'),('Thursday'),('Saturday'),('Wednesday');

show tables;
SELECT * FROM tax;


DROP TABLE IF EXISTS movies_actors;
#@ _CREATE_MOVIE_ACTOR_TABLE_
CREATE TABLE movies_actors
(
  year  YEAR NOT NULL,        # year movie was released
  movie VARCHAR(80) NOT NULL, # movie name
  actor VARCHAR(60) NOT NULL  # actor name
);
#@ _CREATE_MOVIE_ACTOR_TABLE_

INSERT INTO movies_actors (year,movie,actor)
  VALUES
 (2005,'Kingdom of Heaven','Liam Neeson')
,(2005,'Kingdom of Heaven','Orlando Bloom')
,(1997,'The Fifth Element','Bruce Willis')
,(1997,'The Fifth Element','Gary Oldman')
,(1997,'The Fifth Element','Ian Holm')
,(1999,'The Phantom Menace','Ewan McGregor')
,(1999,'The Phantom Menace','Liam Neeson')
,(2001,'The Fellowship of the Ring','Ian McKellen')
,(2001,'The Fellowship of the Ring','Ian Holm')
,(2001,'The Fellowship of the Ring','Orlando Bloom')
,(2001,'The Fellowship of the Ring','Elijah Wood')
,(2010,'Red','Helen Mirren')
,(2010,'Red','Bruce Willis')
,(2011,'Unknown','Diane Kruger')
,(2011,'Unknown','Liam Neeson')
,(1995,'Twelve Monkeys','Brad Pitt')
,(1995,'Twelve Monkeys','Bruce Willis')
,(1995,'Rob Roy','Brian Cox')
,(1995,'Rob Roy','Liam Neeson')
,(2005,'Batman Begins','Liam Neeson')
,(2005,'Batman Begins','Christian Bale')
,(2000,'X-Men 2','Halle Berry')
,(2000,'X-Men 2','Hugh Jackman')
,(2000,'X-Men 2','Ian McKellen')
,(2000,'X-Men 2','Brian Cox')
,(2004,'Troy','Brad Pitt')
,(2004,'Troy','Brian Cox')
,(2004,'Troy','Diane Kruger')
,(2004,'Troy','Eric Bana')
,(2004,'Troy','Orlando Bloom')
,(2004,'Troy','Sean Bean')
,(2001,'Swordfish','Halle Berry')
,(2001,'Swordfish','Hugh Jackman')
,(2011,'Hanna','Cate Blanchett')
,(2011,'Hanna','Eric Bana')
,(2005,'The Island','Ewan McGregor')
,(2005,'The Island','Michael Clarke Duncan')
,(2005,'The Island','Sean Bean')
;


DROP TABLE IF EXISTS artist;
#@ _CREATE_TABLE_ARTIST_
CREATE TABLE artist
(
  a_id  INT UNSIGNED NOT NULL AUTO_INCREMENT, # artist ID
  name  VARCHAR(30) NOT NULL,                 # artist name
  PRIMARY KEY (a_id),
  UNIQUE (name)
);
#@ _CREATE_TABLE_ARTIST_

INSERT INTO artist (a_id, name) VALUES
  (1, 'Da Vinci'),
  (2, 'Monet'),
  (3, 'Van Gogh'),
  (4, 'Renoir')
;

SELECT * FROM artist;

DROP TABLE IF EXISTS painting;
#@ _CREATE_TABLE_PAINTING_
CREATE TABLE painting
(
  a_id  INT UNSIGNED NOT NULL,                # artist ID
  p_id  INT UNSIGNED NOT NULL AUTO_INCREMENT, # painting ID
  title VARCHAR(100) NOT NULL,                # title of painting
  state VARCHAR(2) NOT NULL,                  # state where purchased
  price INT UNSIGNED,                         # purchase price (dollars)
  INDEX (a_id),
  PRIMARY KEY (p_id)
);
#@ _CREATE_TABLE_PAINTING_

# Use INSERT INTO ... SELECT form to get proper artist ID corresponding
# to artist name

INSERT INTO painting (a_id,P_id,title,state,price) VALUES
 (1, 1, 'The Last Supper', 'IN', 34),
 (1, 2,  'Mona Lisa', 'MI', 87 ),
 (3, 3, 'Starry Night', 'KY', 48),
 (3, 4, 'The Potato Eaters', 'KY', 67),
 (4, 5, 'Les Deux Soeurs', 'NE', 64);

SELECT * FROM painting;

DROP TABLE IF EXISTS driver_log;
#@ _CREATE_TABLE_
CREATE TABLE driver_log
(
  rec_id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name      VARCHAR(20) NOT NULL,
  trav_date DATE NOT NULL,
  miles     INT NOT NULL,
  PRIMARY KEY (rec_id)
);
#@ _CREATE_TABLE_

# When updating these dates, pick year and month so that first one
# falls on a Wednesday. Update the others by the same amount.

INSERT INTO driver_log (rec_id, name,trav_date,miles)
  VALUES
    (1, 'Ben','2014-07-30',152),
    (2, 'Suzi','2014-07-29',391),
    (3, 'Henry','2014-07-29',300),
    (4, 'Henry','2014-07-27',96),
    (5, 'Ben','2014-07-29',131),
    (6, 'Henry','2014-07-26',115),
    (7, 'Suzi','2014-08-02',502),
    (8, 'Henry','2014-08-01',197),
    (9, 'Ben','2014-08-02',79),
    (10, 'Henry','2014-07-30',203)
;
CREATE TABLE dates (d DATE);
INSERT INTO dates (d)
VALUES('2014-07-26'),('2014-07-27'),('2014-07-28'),
('2014-07-29'),('2014-07-30'),('2014-07-31'),
('2014-08-01'),('2014-08-02');


DROP TABLE IF EXISTS time_val;
CREATE TABLE time_val
(
  t1  TIME,
  t2  TIME
);

INSERT INTO time_val (t1,t2) VALUES
('15:00:00','15:00:00'),
('05:01:30','02:30:20'),
('12:30:20','17:30:45');

SELECT * FROM time_val;


DROP TABLE IF EXISTS expt;
#@ _CREATE_TABLE_
CREATE TABLE expt
(
  subject VARCHAR(10),
  test    VARCHAR(5),
  score INT
);
#@ _CREATE_TABLE_

INSERT INTO expt (subject,test,score) VALUES
('Jane','A',47),
('Jane','B',50),
('Jane','C',NULL),
('Jane','D',NULL),
('Marvin','A',52),
('Marvin','B',45),
('Marvin','C',53),
('Marvin','D',NULL);



DROP TABLE IF EXISTS testscore;
#@ _CREATE_TABLE_
CREATE TABLE testscore
(
  subject INT UNSIGNED NOT NULL AUTO_INCREMENT,
  age     INT UNSIGNED NOT NULL,
  sex     ENUM('M','F') NOT NULL,
  score   INT,
  PRIMARY KEY (subject)
);
#@ _CREATE_TABLE_

INSERT INTO testscore (age,sex,score)
  VALUES
  (5,'M',5),
  (5,'M',4),
  (5,'F',6),
  (5,'F',7),
  (6,'M',8),
  (6,'M',9),
  (6,'F',4),
  (6,'F',6),
  (7,'M',8),
  (7,'M',6),
  (7,'F',9),
  (7,'F',7),
  (8,'M',9),
  (8,'M',6),
  (8,'F',7),
  (8,'F',10),
  (9,'M',9),
  (9,'M',7),
  (9,'F',10),
  (9,'F',9)
;

DROP TABLE IF EXISTS ttscore;
#@ _CREATE_TABLE_
CREATE TABLE ttscore
(
  subject INT UNSIGNED NOT NULL AUTO_INCREMENT,
  score   INT,
  PRIMARY KEY (subject)
);
#@ _CREATE_TABLE_

INSERT INTO ttscore (score)
  VALUES
  (38),
  (NULL),
  (47),
  (NULL),
  (37),
  (45),
  (54),
  (NULL),
  (40),
  (49);
  
  SELECT * FROM ttscore;
  
  DROP TABLE IF EXISTS die;
#@ _CREATE_TABLE_DIE_
CREATE TABLE die (n INT);
#@ _CREATE_TABLE_DIE_

# Insert values 1 through 6, corresponding to faces of a die

INSERT INTO die (n) VALUES(1),
(2),
(3),
(4),
(5),
(6);

DROP TABLE IF EXISTS trip_log;
#@ _CREATE_TABLE_
CREATE TABLE trip_log
(
  seq   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  city  VARCHAR(30) NOT NULL,   # location of stop
  t     DATETIME NOT NULL,      # time of stop
  miles INT UNSIGNED NOT NULL,  # miles traveled so far
  fuel  DECIMAL(6,3),           # gas used between citees
  PRIMARY KEY (seq)
);
#@ _CREATE_TABLE_

INSERT INTO trip_log (t, city, miles, fuel)
VALUES
  ('2013-10-23 05:00:00', 'San Antonio, TX', 0, 0),
  ('2013-10-23 09:10:00', 'Dallas, TX', 263, 11.375),
  ('2013-10-23 13:40:00', 'Benton, AR', 566, 12.398),
  ('2013-10-23 16:51:00', 'Memphis, TN', 745, 6.820),
  ('2013-10-23 19:06:00', 'Portageville, MO', 745+133, 7.007),
  ('2013-10-23 23:16:00', 'Champaign, IL', 745+419, 11.354),
  ('2013-10-24 03:27:00', 'Madison, WI', 745+667, 13.016)
;

DROP TABLE IF EXISTS player_stats;
#@ _CREATE_TABLE_
CREATE TABLE player_stats
(
  id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id),
  date  DATE NOT NULL,          # date of cumulative stats
  ab    INT UNSIGNED NOT NULL,  # total at-bats as of date
  h     INT UNSIGNED NOT NULL   # total hits as of date
);
#@ _CREATE_TABLE_

INSERT INTO player_stats (date, ab, h)
VALUES
  ('2013-04-30', 0, 0),
  ('2013-05-31', 38, 13),
  ('2013-06-30', 109, 31),
  ('2013-07-31', 196, 49),
  ('2013-08-31', 304, 98)
;

DROP TABLE IF EXISTS rainfall;
#@ _CREATE_TABLE_
CREATE TABLE rainfall
(
  date    DATE NOT NULL,
  precip  FLOAT(10,2) NOT NULL
);
#@ _CREATE_TABLE_

INSERT INTO rainfall (date, precip)
  VALUES
    ('2014-06-01', 1.5),
    ('2014-06-02', 0),
    ('2014-06-03', 0.5),
    ('2014-06-04', 0),
    ('2014-06-05', 1.0)
;

ROP TABLE IF EXISTS marathon;
#@ _CREATE_TABLE_
CREATE TABLE marathon
(
  stage INT UNSIGNED NOT NULL AUTO_INCREMENT,
  km    INT UNSIGNED NOT NULL,  # length of stage, in km
  t     TIME NOT NULL,          # elapsed time for stage
  PRIMARY KEY (stage)
);
#@ _CREATE_TABLE_

INSERT INTO marathon (km, t)
VALUES
  (5,'00:15:00'),
  (7,'00:19:30'),
  (9,'00:29:20'),
  (5,'00:17:50')
;


DROP TABLE IF EXISTS standings1;
CREATE TABLE standings1
(
  team  CHAR(20), # team name
  wins  INT,      # number of wins
  losses  INT     # number of losses
);

# Load Northern League final 1902 standings into the table

INSERT INTO standings1 (team, wins, losses) VALUES
 ('Winnipeg',37,20),
 ('Crookston',31,25),
('Fargo',30,26),
('Grand Forks',28,26),
 ('Devils Lake',19,31),
 ('Cavalier',15,32);
 
 DROP TABLE IF EXISTS standings2;
CREATE TABLE standings2
(
  half      INT,      # which half of season
  division  CHAR(10), # league division
  team      CHAR(20), # team name
  wins      INT,      # number of wins
  losses    INT       # number of losses
);
INSERT INTO standings2 (half, division, team, wins, losses)
  VALUES (1,'Eastern','St. Paul',24,18),
(1,'Eastern','Thunder Bay',18,24),
 (1,'Eastern','Duluth-Superior',17,24),
(1,'Eastern','Madison',15,27),
 (1,'Western','Winnipeg',29,12),
(1,'Western','Sioux City',28,14),
(1,'Western','Fargo-Moorhead',21,21),
 (1,'Western','Sioux Falls',15,27),
 (2,'Eastern','Duluth-Superior',22,20),
 (2,'Eastern','St. Paul',21,21),
 (2,'Eastern','Madison',19,23),
 (2,'Eastern','Thunder Bay',18,24),
 (2,'Western','Fargo-Moorhead',26,16),
 (2,'Western','Winnipeg',24,18),
 (2,'Western','Sioux City',22,20),
 (2,'Western','Sioux Falls',16,26);

SELECT * FROM standings1;
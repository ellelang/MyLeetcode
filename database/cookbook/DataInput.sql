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
  statename       VARCHAR(20),  # sender (source user and host)
  shortname       VARCHAR(20),
  statehood       DATETIME,  
  records          INT
);


SET GLOBAL LOCAL_INFILE = True;

SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

#LOAD DATA LOCAL INFILE '/Users/langzx/Desktop/states.txt' INTO TABLE states;
INSERT INTO states (statename,shortname,statehood,records) VALUES
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
  rate          INT
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

DROP TABLE IF EXISTS winter;
CREATE TABLE winter (
city VARCHAR(20),
degree INT
);
INSERT INTO winter (city,degree) VALUES
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
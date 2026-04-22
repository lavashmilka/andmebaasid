--tabeli struktuuri muutmine 
--1. uue veeru lisamine
ALTER TABLE tootaja ADD testVeerg int;
Select * from tootaja;
--2. veeru kustutamine
ALTER TABLE tootaja DROP COLUMN testVeerg;
--3. andmetüübi muutmine veerus
ALTER TABLE tootaja ALTER COLUMN testVeerg varchar(5);
--struktuuri kontrollimiseks kasutame protseduur sp_help
sp_help tootaja; 

--piirangute lisamine 
CREATE TABLE ryhm(
ryhmId int not null,
ryhmNimi char(10));
DROP TABLE ryhm;
--muudame tabeli ja lisame piirang - primary key
ALTER TABLE ryhm ADD CONSTRAINT pk_ryhm PRIMARY KEY (ryhmId);

INSERT INTO ryhm 
VALUES (2, 'LOGITpv24');
SELECT * FROM ryhm;
UPDATE ryhm SET ryhmNimi='TITpe24' WHERE ryhmId=3
--lisame piirang UNIQUE
ALTER TABLE ryhm ADD CONSTRAINT un_ryhm UNIQUE (ryhmNimi);

--lisame uus veerg
ALTER TABLE ryhm ADD ryhmajuhataja int;
--lisame piirang Foreign Key
ALTER TABLE ryhm ADD CONSTRAINT fk_ryhm
FOREIGN KEY (ryhmajuhataja) REFERENCES tootaja(tootajaId);
--kontorllimiseks 
SELECT * from tootaja;
SELECT * from ryhm;
UPDATE ryhm SET ryhmajuhataja=3 WHERE ryhmNimi='LOGITpv24'

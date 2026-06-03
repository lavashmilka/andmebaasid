Create Database Kasbaas;
USE Kasbaas;
CREATE TABLE tootaja(
tootajaID int PRIMARY KEY identity(1,1), --identity - automaatselt kasvav arv +1
eesnimi varchar(15) not null,
perekonnanimi varchar(30) not null,
synniaeg date,
aadress TEXT,
koormus int CHECK (koormus>0), -- piirang, et koormus > 0
aktiivne bit)

--tabeli kuvamine
SELECT * FROM tootaja;

--tabeli andmete lisamine
INSERT INTO tootaja(perekonnanimi,eesnimi,synniaeg)
VALUES ('Mari','Liis','2006-06-16')

INSERT INTO tootaja
VALUES ('Ilja','Kolos','2021-09-22','Narva', 200, 1),
('Maksim','Petrov','2008-11-03','Narva', 200, 1);

UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
WHERE tootajaID=1;

CREATE TABLE toovahetus(
toovahetusID int PRIMARY KEY identity(1,1),
kuupaev date,
tundideArv int,
tootajaID int,
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID))

select * from toovahetus;
select * from tootaja;

--täidame tabeli
INSERT INTO toovahetus
VALUES ('2026-04-14', 7, 3),
('2026-03-25', 8, 2),
('2026-04-22', 6, 1);

--tabeli struktuuri muutmine
--1. uue veeru lisamine
ALTER TABLE tootaja ADD testVeerg int;

--2. veeru kustumine
ALTER TABLE tootaja DROP COLUMN testVeerg;

--3. andmetüübi muutmine veerus
ALTER TABLE tootaja ALTER COLUMN testVeerg varchar(5);

--struktuuri kontrollimiseks kasutame protseduuri sp_help
sp_help tootaja;


--piirangute lisamine
CREATE TABLE ryhm(
ryhmID int not null,
ryhmNimi char(10));

DROP TABLE ryhm;

--muudame tabeli ja lisame piirang - primary key
ALTER TABLE ryhm ADD CONSTRAINT pk_ryhm PRIMARY KEY (ryhmID);

INSERT INTO ryhm
VALUES (3, 'TITpe24');

SELECT * FROM ryhm;

--lisame piirang UNIQUE
ALTER TABLE ryhm ADD CONSTRAINT un_ryhm UNIQUE (ryhmNimi);

--lisame uus veerg
ALTER tABLE ryhm ADD ryhmajuhataja int;

--lisame piirang Foreign Key
ALTER TABLE ryhm ADD CONSTRAINT fk_ryhm
FOREIGN KEY (ryhmajuhataja) REFERENCES tootaja(tootajaID);

--kontrollimiśeks
SELECT * from tootaja;
SELECT * from ryhm;
UPDATE ryhm SET ryhmajuhataja=1 WHERE ryhmNimi='TITpe24';

Create Database Kasimtsevabaas;

--ab kustutamine
--DROP Database BakaTrigger;(näide)

USE Kasimtsevabaas;
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
VALUES ('Ilus','Liis','2005-05-15')

INSERT INTO tootaja
VALUES ('Katja','Punane','2022-09-22','Tartu', 120, 1),
('Maksim','Petrov','2008-11-03','Narva', 200, 1);

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
WHERE tootajaID=1;

--teine tabel
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
VALUES ('2026-04-14', 7, 3)


CREATE TABLE koolitus(
koolitusID int PRIMARY KEY identity(1,1), --identity - automaatselt kasvav arv +1
nimetus TEXT not null,
kestvus int,
algus datetime,
lõpp datetime,
õpetaja varchar(80) not null);

CREATE TABLE opetamine(
opetamineID int PRIMARY KEY identity(1,1),
kuupaev date,
tundideArv int,
tootajaID int,
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID),
koolitusID int,
FOREIGN KEY (koolitusID) REFERENCES koolitus(koolitusID),
Tunnistus bit,
Hinne int)

select * from toovahetus;
select * from tootaja;
select * from koolitus;
select * from opetamine;

INSERT INTO koolitus
VALUES ('Andmebaasid',4,'2026-04-15 08:30:00','2026-04-15 11:45:00', 'Irina'),
('IT korraldus',4,'2026-04-15 12:40:00','2026-04-15 16:45:00', 'Irina');

INSERT INTO opetamine
VALUES (1,1,1,5),
(2,2,1,5);

-- udalenie lishnego stolbca
ALTER TABLE opetamine
DROP COLUMN tundideArv;

UPDATE koolitus SET õpetaja='Jelizaveta'
WHERE koolitusID=2;

INSERT INTO opetamine
VALUES (4,1,0,2);

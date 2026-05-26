create database RetseptRaamat
--1 tabel

create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
email varchar(150));
--2 tabel

create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50));
--3 tabel

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100));
--4 tabel

create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100));
--5 tabel

create table retsept(
retsept_id int  primary key identity(1,1),
retsepti_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
kategooria_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),
foreign key (kategooria_id) references kategooria(kategooria_id));
--6 tabel

create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
toiduaine_id int,
retsept_retsept_id int,
yhik_id int,
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
foreign key (retsept_retsept_id) references retsept(retsept_id),
foreign key (yhik_id) references yhik(yhik_id));

--7 tabel
create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
foreign key (retsept_id) references retsept(retsept_id));

-- Protseduur kasutaja lisamiseks
CREATE PROCEDURE lisaKasutaja
@eesnimi VARCHAR(50),
@perenimi VARCHAR(50),
@email VARCHAR(150)
AS
BEGIN
    INSERT INTO kasutaja(eesnimi, perenimi, email)
    VALUES (@eesnimi, @perenimi, @email);
END;
--kutse 
EXEC lisaKasutaja 'Alex','Gover','alex@gmail.com';
select * from kasutaja

-- Protseduur kategooria lisamiseks
CREATE PROCEDURE lisaKategooria
@nimi VARCHAR(50)
AS
BEGIN
    INSERT INTO kategooria (kategooria_nimi) 
	VALUES (@nimi);
END;
--kutse
EXEC lisaKategooria 'Mahl'
select * from kategooria
delete from kategooria;
select * from kategooria
-- Protseduur toiduaine lisamiseks ja tabeli kuvamiseks
create procedure lisaToiduaineJaKuva
@nimi varchar(100)
as
begin
    insert into toiduaine (toiduaine_nimi) 
	VALUES (@nimi);
    select * from toiduaine;
end;
--kutse
exec lisaToiduaineJaKuva 'Piim'

-- Protseduur ühiku lisamiseks
create procedure lisaYhik
@nimi VARCHAR(100)
as
begin
    insert into yhik (yhik_nimi) 
	VALUES (@nimi);
	SELECT * FROM yhik;
end;
EXEC lisaYhik 'P';
--Protseduur retsepti lisamiseks
CREATE PROCEDURE lisaRetsept
@nimi VARCHAR(100),
@kirjeldus VARCHAR(200),
@juhend VARCHAR(500),
@sisestatud_kp DATE,
@kasutaja_id INT,
@kategooria_id INT
AS
BEGIN
	INSERT INTO retsept(retsepti_nimi,kirjeldus,juhend,sisestatud_kp,kasutaja_id,kategooria_id)
	VALUES(@nimi,@kirjeldus,@juhend,@sisestatud_kp,@kasutaja_id,@kategooria_id);
	SELECT * FROM retsept;
END;

EXEC lisaRetsept 'Supp','Supp', 'Kanasupp', '2026-05-30',5,7;
select * from kasutaja
select * from kategooria


CREATE PROCEDURE lisaKoostis
@kogus INT,
@retsept INT,
@toiduaine INT,
@yhik INT
AS
BEGIN
	INSERT INTO koostis(kogus,retsept_retsept_id,toiduaine_id,yhik_id)
	VALUES(@kogus,@retsept,@toiduaine,@yhik);
END;
select * from koostis
exec lisaKoostis 5,5,3,4 

create procedure lisatehtud
@tehtud_kp date,
@retsept_id int
AS
BEGIN
    INSERT INTO tehtud (tehtud_kp, retsept_id) 
	VALUES (@tehtud_kp, @retsept_id);
	SELECT * FROM tehtud;
END;
exec lisatehtud '2026-05-7',1;


select * from toiduaine
select * from yhik
select * from retsept
select * from tehtud



CREATE PROCEDURE muudatabel
	@tegevus VARCHAR(10),
	@tabelinimi VARCHAR(50),
	@veerunimi VARCHAR(50),
	@tyyp VARCHAR(50)=NULL
AS
BEGIN
	DECLARE @sqltegevus VARCHAR(MAX)
	SET @sqltegevus = CASE
		WHEN @tegevus='add' THEN
			CONCAT ('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

		WHEN @tegevus='drop' THEN
			CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)

		WHEN @tegevus='alter' THEN
			CONCAT('ALTER TABLE ', @tabelinimi, ' ALTER COLUMN ', @veerunimi, ' ', @tyyp)
		END;
	PRINT @sqltegevus;
	EXEC(@sqltegevus);
END;

EXEC muudaTabel 'add','kasutaja','telefon','varchar(20)';
EXEC muudaTabel 'alter','kasutaja','telefon','varchar(50)';
EXEC muudaTabel 'drop','kasutaja','telefon';

SELECT * FROM kasutaja;


--Võtame andmed tabelitest kasutaja ja retsept ning näitame ainult neid ridu, kus kasutaja ID-d on samad.
SELECT 
    kasutaja.eesnimi, 
    kasutaja.perenimi, 
    retsept.retsepti_nimi
FROM kasutaja, retsept
WHERE kasutaja.kasutaja_id = retsept.kasutaja_id;

--See päring kuvab retsepti nime ja selle kategooria (nt "Mahl" või "Supp"). 
--võtasin andmed tabelitest retsept ja kategooria ning sidumiseks vaatame, et kategooria_id oleks mõlemas tabelis sama.
SELECT 
    retsept.retsepti_nimi, 
    kategooria.kategooria_nimi
FROM retsept, kategooria
WHERE retsept.kategooria_id = kategooria.kategooria_id;
--See päring näitab, millisel kuupäeval mingit retsepti tehti.
--Me võtame kuupäeva tabelist tehtud ja toidu nime tabelist retsept, sidudes need kokku läbi retsept_id.
SELECT 
    tehtud.tehtud_kp, 
    retsept.retsepti_nimi
FROM tehtud, retsept
WHERE tehtud.retsept_id = retsept.retsept_id;

-- Uus tabel (minu oma) 
--kasutajate lemmikretseptid
CREATE TABLE lemmikud (
lemmik_id INT PRIMARY KEY IDENTITY(1,1),
lisatud_kp DATE,
kasutaja_id INT,
retsept_id INT,
FOREIGN KEY (kasutaja_id) REFERENCES kasutaja(kasutaja_id),
FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id));

--Kirjete kiire lisamise protseduur
CREATE PROCEDURE lisaLemmik
@lisatud_kp DATE,
@kasutaja_id INT,
@retsept_id INT
AS
BEGIN
    INSERT INTO lemmikud (lisatud_kp, kasutaja_id, retsept_id)
    VALUES (@lisatud_kp, @kasutaja_id, @retsept_id);    
    SELECT * FROM lemmikud;
END;
EXEC lisaLemmik '2026-05-26', 1, 1;
EXEC lisaLemmik '2026-05-26', 1, 2;
EXEC lisaLemmik '2026-05-26', 2, 1;
EXEC lisaLemmik '2026-05-26', 3, 3;
EXEC lisaLemmik '2026-05-26', 4, 2;
--lõin proceduur mu uue tabeli jaoks
--ID-koodi alusel kirje kustutamise protseduur
CREATE PROCEDURE kustutaLemmik
@id INT
AS
BEGIN
    DELETE FROM lemmikud 
    WHERE lemmik_id = @id;   
    SELECT * FROM lemmikud;
END;

EXEC kustutaLemmik 1;
--Et näha, millisel kasutajal on millised retseptid lemmikute hulgas
SELECT 
    kasutaja.eesnimi,  --Kasutaja on tabeli nimi., . on eraldaja (sees/väljas), eesnimi on otsitava veeru nimi.
    retsept.retsepti_nimi,
    lemmikud.lisatud_kp
FROM kasutaja, retsept, lemmikud
WHERE lemmikud.kasutaja_id = kasutaja.kasutaja_id 
AND lemmikud.retsept_id = retsept.retsept_id;
--Ühendab kasutaja (kasutaja), retsepti (retsept) ja küpsetusajaloo (tehtud) tabelid. 
--See näitab kasutaja nime, valmistatud rooga ja selle täpset valmistuskuupäeva.
SELECT 
    kasutaja.eesnimi, 
    retsept.retsepti_nimi, 
    tehtud.tehtud_kp
FROM kasutaja, retsept, tehtud
WHERE retsept.kasutaja_id = kasutaja.kasutaja_id 
AND tehtud.retsept_id = retsept.retsept_id;



--staff
GRANT SELECT ON toiduaine TO staff;
GRANT INSERT ON toiduaine TO staff;
GRANT SELECT ON kategooria TO staff;
GRANT INSERT ON kategooria TO staff;

-- Lubab vaadata (SELECT) ja lisada (INSERT) tabelitesse toiduaine ja kategooria
DENY UPDATE ON toiduaine TO staff;
DENY DELETE ON toiduaine TO staff;
DENY UPDATE ON kategooria TO staff;
DENY DELETE ON kategooria TO staff;

-- Lubame AINULT kasutajalaua vaatamist
GRANT SELECT ON kasutaja TO staff;
DENY INSERT ON kasutaja TO staff;
DENY UPDATE ON kasutaja TO staff;
DENY DELETE ON kasutaja TO staff;

--manager
-- Täielikud õigused retsepti- ja koostisetabelite haldamiseks (SELECT, INSERT, UPDATE, DELETE)
GRANT SELECT, INSERT, UPDATE, DELETE ON retsept TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON koostis TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON tehtud TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON yhik TO manager;

-- Õigused teistele tabelitele (vaatamine ja muutmine, kuid ILMA uusi tabeleid lisamata)
GRANT SELECT, UPDATE, DELETE ON toiduaine TO manager;
GRANT SELECT, UPDATE, DELETE ON kasutaja TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON kategooria TO manager;

-- Uute toodete ja kasutajate lisamise (INSERT) range keeld
DENY INSERT ON toiduaine TO manager;
DENY INSERT ON kasutaja TO manager;


--staff
select * from toiduaine
insert into toiduaine(toiduaine_nimi)
values('Komm')
DELETE FROM toiduaine WHERE toiduaine_id = 2; --
SELECT * FROM retsept; --

--manager
SELECT * FROM retsept;
insert into retsept(retsepti_nimi,kirjeldus,juhend,sisestatud_kp,kasutaja_id,kategooria_id)
values ('Lapsha','Supp', 'Kimchi', '2026-05-30',5,7)
select * from kasutaja
INSERT INTO kasutaja (eesnimi, perenimi, email) 
VALUES ('Test', 'Test1', 'test@test.ee');
select * from toiduaine
INSERT INTO toiduaine (toiduaine_nimi) 
VALUES ('Sokolaad');


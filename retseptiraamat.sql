create database RetseptRaamat
--1 esimene tabel

create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
email varchar(150));
--2 esimene tabel

create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50));
--3 esimene tabel

create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100));
--4 esimene tabel

create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100));
--5 esimene tabel

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
--6 esimene tabel

create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
toiduaine_id int,
retsept_retsept_id int,
yhik_id int,
foreign key (toiduaine_id) references toiduaine(toiduaine_id),
foreign key (retsept_retsept_id) references retsept(retsept_id),
foreign key (yhik_id) references yhik(yhik_id));

--7 esimene tabel
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
exec lisaToiduaineJaKuva 'Paprika'

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

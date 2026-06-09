create database Arvestustoo

use Arvestustoo

--Loo tabel isik
create table isik(
isik_id int primary key identity(1,1),
eesnimi varchar(30) unique,
perenimi varchar(30) unique,
isikukood char(11),
sugu char(5));

--Loo tabel aadress
create table aadress(
aadress_id int primary key identity(1,1),
riik varchar(50),
linn varchar(50),
tanav varchar(100),
maja varchar(10),
korter varchar(10),
postiindeks varchar(15));

--Loo tabel elamine koos kahe võtmega 
create table elamine(
elamine_id int primary key identity(1,1),
isik_id int,
aadress_id int,
foreign key (isik_id) references isik(isik_id),
foreign key (aadress_id) references aadress(aadress_id),
alates date,
kuni date,
kommentaar varchar(max));

--lisamine andmete 
insert into isik (eesnimi, perenimi, isikukood, sugu) 
values('juri', 'jogi', '39503240222', 'mees'),
('andres', 'kuusk', '39108150444', 'mees'),
('tiina', 'kask', '49706110555', 'naine');

-- lisa naidisandmed tabelisse aadress
insert into aadress (riik, linn, tanav, maja, korter, postiindeks) 
values('eesti', 'tallinn', 'tehnika', '5', '6', '10145')

select * from isik
select * from aadress



-- 4. õigused (lisamine, uuendamine ja vaatamine)
grant select, insert, update on isik to isikNimi;
grant select, insert, update on elamine to isikNimi;
--õigused tabelile aadress(ainult vaatamine)
grant select on aadress to isikNimi;


--create tabeli logi(5 p.)
Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kuupaev DATETIME,
kasutaja varchar(50),
toiming  varchar(100),
andmed TEXT)



-- 6. p
create trigger elamiseUuendamine
on elamine --tabelinimi, mis on vaja jalgida
for update
as
insert into logi(kuupaev, kasutaja, toiming, andmed)
select
getdate(), --aeg
system_user, --kasutaja mis on sisselogitud serverisse
'on tehtud UPDATE kask', --toiming
concat('vanad andmed - isik: ', deleted.isik_id, ', aadress: ', deleted.aadress_id, ', kommentaar: ', deleted.kommentaar, ' uued andmed - isik: ', inserted.isik_id, ', aadress: ', inserted.aadress_id, ', kommentaar: ', inserted.kommentaar) --andmed tabelist elamine
from deleted inner join inserted
on deleted.elamine_id=inserted.elamine_id



-- 7. p
create trigger elamiseLisamine
on elamine --tabelinimi, mis on vaja jalgida
for insert
as
insert into logi(kuupaev, kasutaja, toiming, andmed)
select
getdate(), --aeg
system_user, -- kasutaja mis on sisse logitud serverisse
'on tehtud INSERT kask', --toiming
concat('isik: ',isik.perenimi, ', aadress: ', inserted.aadress_id, ', kommentaar: ', inserted.kommentaar) --andmed
from inserted 
inner join isik on isik.isik_id=inserted.isik_id
inner join aadress on aadress.aadress_id=inserted.aadress_id

--10 p.
-- 1. lisamine isik protseduur
create procedure lisaisik
@eesnimi varchar(50),
@perenimi varchar(50),
@isikukood char(11),
@sugu varchar(10)
as
begin
insert into isik
values(@eesnimi, @perenimi, @isikukood, @sugu)
select * from isik
end;
-- kutse
exec lisaisik 'toomas', 'tamm', '38902120000', 'mees';


-- 2. otsimine isikut esimese tahe jargi protseduur
create procedure otsing1taht
@taht char(1)
as
begin
select * from isik
where eesnimi like @taht + '%';
end;
-- kutse
exec otsing1taht 't';


-- 3. elamise min/max alates kuupaev 
create procedure minmaxAlates
@minAlates date output,
@maxAlates date output
as
begin
select
@minAlates = min(alates),
@maxAlates = max(alates)
from elamine;
end;
-- kutse
declare @minAlates date, @maxAlates date;
exec minmaxAlates @minAlates output, @maxAlates output;
print 'Min alates kuupaev = ' + convert(varchar, @minAlates);
print 'Max alates kuupaev = ' + convert(varchar, @maxAlates);




-- 11 p.  Kolm vaadet
create view vaadeIsikudElamised
as
select Eesnimi, Perenimi, Kommentaar from isik, elamine
where isik.isik_id=elamine.isik_id;

select * from vaadeIsikudElamised;

create view vaadeIsikudAadressid
as
select Eesnimi, Perenimi, Linn, Tanav from isik, elamine, aadress
where elamine.isik_id=isik.isik_id 
and elamine.aadress_id=aadress.aadress_id;

select * from vaadeIsikudAadressid;

create view vaadeAadressidElamised
as
select Linn, Tanav, Alates, Kuni from aadress, elamine
where aadress.aadress_id=elamine.aadress_id;

select * from vaadeAadressidElamised;


--12 p.
--See protseduur kustutab kõik kirjed logi tabelist ja kuvab tühja tabeli
create procedure puhastalogi
as
begin
--kustutame kõik read logi tabelist
delete from logi;
select * from logi;
end;
--kutse
exec puhastalogi;
select * from logi




--klient
select * from aadress;

insert into aadress(riik)
values ('Eesti');

create table test_tabel(
id int primary key identity(1,1))

alter table isik add test_veerg varchar(10);

select * from isik
select * from elamine
select * from logi

insert into isik(eesnimi, perenimi, isikukood, sugu)
values('Test22', 'Test222', '6074623345', 'Naine')
update isik set aadress_id= 'Test2' where eesnimi='Test';
delete from isik 
where eesnimi='Test' 

insert into elamine(isik_id, alates, kuni, kommentaar)
values(6,'2025-01-01','2025-01-02','testandmeddd')
update elamine set aadress_id=2 where elamine_id=6;



--triggerite kontrollimine
insert into elamine(isik_id, aadress_id, alates, kuni, kommentaar) 
values(4, 3, '2026-01-01','2026-02-02', 'test122')
--UPDATE trigeri kontroll
update elamine set kommentaar = 'uuendatud test-elamine' where kommentaar = 'Test';

select * from elamine;


--ja uuendamine triggerid
--1 trigger
USE [Arvestustoo]
GO
/****** Object:  Trigger [dbo].[elamiseLisamine]    Script Date: 09.06.2026 11:38:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[elamiseLisamine]
on [dbo].[elamine] --tabelinimi, mis on vaja jalgida
for insert
as
insert into logi(kuupaev, kasutaja, toiming, andmed)
select
getdate(), --aeg
system_user, -- kasutaja mis on sisse logitud serverisse
'on tehtud INSERT kask', --toiming
concat('isik: ', isik.perenimi,', aadress: ', aadress.linn, ' ', aadress.tanav,', kommentaar: ', inserted.kommentaar) --andmed
from inserted
inner join isik on isik.isik_id=inserted.isik_id
inner join aadress on aadress.aadress_id=inserted.aadress_id;

--2 trigger
USE [Arvestustoo]
GO
/****** Object: Trigger [dbo].[elamiseUuendamine] Script Date: 09.06.2026 11:43:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[elamiseUuendamine]
on [dbo].[elamine] --tabelinimi, mis on vaja jalgida
for update
as
insert into logi(kuupaev, kasutaja, toiming, andmed)
select
getdate(), --aeg
system_user, --kasutaja mis on sisselogitud serverisse
'on tehtud UPDATE kask', --toiming
concat(
'vanad andmed - isik: ', vanaisik.perenimi,', aadress: ', vanaaadress.linn, ' ', vanaaadress.tanav,', kommentaar: ', deleted.kommentaar,'uued andmed - isik: ', uusisik.perenimi,', aadress: ', uusaadress.linn, ' ', uusaadress.tanav,', kommentaar: ', inserted.kommentaar)
from deleted
inner join inserted on deleted.elamine_id = inserted.elamine_id
inner join isik vanaisik on vanaisik.isik_id = deleted.isik_id
inner join aadress vanaaadress on vanaaadress.aadress_id = deleted.aadress_id
inner join isik uusisik on uusisik.isik_id = inserted.isik_id
inner join aadress uusaadress on uusaadress.aadress_id = inserted.aadress_id;

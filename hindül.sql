create database kasimtsevabaas

create table klient(
klient_id int primary key identity(1,1),
klient_nimi varchar(30) not null,
linn varchar(15),
vanus int,
saldo money)

insert into klient
values('Lisa', 'Tartu', 37, 255);

select * from klient

--Kuva kliendid
create procedure KuvaKliendid
as
begin
select * from klient;
end
exec KuvaKliendid

--Kuva kliendid(nimi ja linn)
create procedure KuvanimijaLinn
as
begin
select klient_nimi, linn from klient
end
--kutse
exec KuvanimijaLinn

--Lisa klient
create procedure lisaKlient
@klient_nimi varchar(30),
@linn varchar(15),
@vanus int,
@saldo money
as
begin 

insert into klient
values(@klient_nimi, @linn, @vanus, @saldo)
end
--kutse
exec lisaKlient 'Karl', 'Narva', 19, 50 

--Muuda kliendi andmeid
create procedure muudaklient
@klient_id int, 
@linn varchar(30),
@saldo money
as
begin
	update klient
	set linn = @linn,
	saldo = @saldo
where klient_id = @klient_id
end
--kutse
exec muudaklient 1, 'Kohtla-Järve', 500;

-- kustuta klient
create procedure kustutaKlient
@klient_id int
as
begin
	select * from klient
	delete from klient where klient_id=@klient_id
	select * from klient
end
--kutse
exec kustutaKlient 2

--Otsi klienti esimese tähe järgi
create procedure otsing1taht
@taht char(1)
as
begin
select * from klient
where klient_nimi like @taht + '%';
end
--kutse
exec otsing1taht 'R';

--Saldo min/max
drop procedure minmaxSaldo
create procedure minmaxSaldo
@minSaldo money output,
@maxSaldo money output
as
begin
	select
	@minSaldo = min(saldo),
	@maxSaldo = max(saldo)
	from klient;
end;
declare @minSaldo MONEY, @maxSaldo MONEY;
--kutse
exec minmaxSaldo @minSaldo output, @maxSaldo output;

PRINT 'Min saldo = ' + CONVERT(varchar, @minSaldo);
PRINT 'Max saldo = ' + CONVERT(varchar, @maxSaldo);

--Tingimuslause kasutamine (CASE / IF)
create procedure staatusKliendi
as
begin
	select
	klient_nimi,
	saldo,
	case
		when saldo > 100 then 'Hea klient'
		else 'Tavaklient'
	end as staatusKliendi
	from klient
end;
--kutse
 exec staatusKliendi


--Dünaamiline SQL protseduuris (ALTER TABLE)
CREATE PROCEDURE veeruHaldus
    @tegevus varchar(15),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE
        WHEN @tegevus = 'add' THEN
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;

--Kasutamine
-- veeru lisamine
EXEC veeruHaldus
    @tegevus='add',
    @tabelinimi='klient',
    @veerunimi='email',
    @tyyp='varchar(MAX)';

-- veeru kustutamine
EXEC veeruHaldus
    @tegevus='drop',
    @tabelinimi='klient',
    @veerunimi='email';

## SQL protseduur - 
store procedur - salvestatud protseduurid - sama mis on funktsioonid programmeerimises, mingi tegevus, mis on salvestatud andmebaasi, ja mida saab automaatselt teha (INSERT, UPDATE, SELECT).
```sql
create Procedure lisaKategooria
--parameetrid @...
@uusKategooria varchar(30)
AS
begin  
--kirjeldus
insert into categories(category_name)
values(@uusKategooria);
select * from categories
end;
```
<img width="256" height="274" alt="{2129F820-CC17-4D19-9200-F7369EAF7C35}" src="https://github.com/user-attachments/assets/47551a41-28c8-4e6c-895f-26eea1228df9" />
<img width="273" height="235" alt="{194D6309-040F-4D62-AAD9-27B772F11B67}" src="https://github.com/user-attachments/assets/e1c51092-ff65-457f-9984-d6905e352259" />

```sql
-- protseduur, mis kustutab kategooria id järgi
create procedure kustutaKategooria
@kustutaId int
AS
BEGIN
 select * from categories
 delete from categories where category_id=@kustutaId;
 select * from categories
END
--kutse
exec kustutaKategooria 3
```
<img width="218" height="277" alt="{F1103600-D9DD-41CF-B8A2-9169C26BAFD0}" src="https://github.com/user-attachments/assets/e41ef831-93bc-4ad6-b637-b8128fd53ff9" />
<img width="237" height="196" alt="{787F58C6-B579-4405-A651-4ABA6882D607}" src="https://github.com/user-attachments/assets/cfc24e9e-af78-4e25-ab77-3d4f1b7f2f3c" />


```sql
--protseduur mis kuvab kategooriad sisestatud esimese tähe järgi
create procedure otsing1taht
@taht char(1)
as
begin
select * from categories 
where category_name like @taht + '%'; --% - teised sümboolid
end
--kutse
exec otsing1taht 'a';
```
<img width="231" height="127" alt="{CD6225F5-391C-4D53-99FD-0754F5FDA2FE}" src="https://github.com/user-attachments/assets/dd05a5a8-089f-4e28-8fb4-593a8f5bf10f" />
<img width="246" height="215" alt="{15000FD1-CA04-44FD-93EB-3814162C3B18}" src="https://github.com/user-attachments/assets/8db1f819-84d4-467b-bbbb-4c8a5c869131" />

```sql
--protseduur, mis kuvab tooded, kus on hind suurem kui sisestatud hind
create procedure suuremHind
@hind int 
as
begin
select * from products
where list_price > @hind;
end
--kutse
exec suuremHind 400;
```
<img width="476" height="125" alt="{0CFCE502-D3A7-4F28-8CC2-E22107DA9242}" src="https://github.com/user-attachments/assets/35571992-a285-4c6a-ab8e-4b558fc91f34" />
<img width="480" height="92" alt="{9E1259DE-38A2-4A91-AB61-40DD0F151BBB}" src="https://github.com/user-attachments/assets/7c08828e-ea4a-4f93-aba6-6ed37bdfb7f9" />
<img width="224" height="278" alt="{99021E6A-FC00-4912-90BB-7CBAED85F893}" src="https://github.com/user-attachments/assets/093bbdec-cfb5-4787-ac27-5fb1e1300491" />


## OUTPUT parameetrid (min ja max väärtus)
```sql
CREATE PROCEDURE minmaxHind
    @minHind MONEY OUTPUT,
    @maxHind MONEY OUTPUT
AS
BEGIN
    SELECT 
        @minHind = MIN(list_price),
        @maxHind = MAX(list_price)
    FROM products;
END;

--kutse
DECLARE @minHind MONEY, @maxHind MONEY;

EXEC minmaxHind @minHind OUTPUT, @maxHind OUTPUT;

PRINT 'Min hind = ' + CONVERT(varchar, @minHind);
PRINT 'Max hind = ' + CONVERT(varchar, @maxHind);
```
<img width="207" height="58" alt="{D076D990-1CE6-48A3-8086-2F9D9FD1364B}" src="https://github.com/user-attachments/assets/de0811a4-be8f-4d38-82b7-ece8f28b224f" />
<img width="224" height="278" alt="{99021E6A-FC00-4912-90BB-7CBAED85F893}" src="https://github.com/user-attachments/assets/cf5a70e6-f315-4215-a904-9042aa5b5e0c" />


## Dünaamiline SQL protseduuris (ALTER TABLE)
```sql
--6.Dünaamiline SQL protseduuris (ALTER TABLE) - universaalne protseduur, mis töötab üks kõik millese tabeliga
--Protseduur veeru lisamiseks või kustutamiseks 
--muudab struktuuri (veeru lisamine ADD, veeru kustutamine DROP)
CREATE PROCEDURE muudatus
    @tegevus varchar(10),
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

exec muudatus 'add', 'categories', 'testVeerg', 'int'
select * from categories
exec muudatus 'drop', 'categories', 'testVeerg', 'int'
```
<img width="355" height="75" alt="{5E7EC651-CC0D-40DC-8CA9-312FFCB808B8}" src="https://github.com/user-attachments/assets/08d9535d-b648-4a88-b679-53fe26407e18" />
<img width="259" height="101" alt="{7E8798FE-97B1-4DBA-AEC6-35A9695E9570}" src="https://github.com/user-attachments/assets/643f1680-2262-4184-a2b0-b4532087e5c7" />
<img width="309" height="50" alt="{3DE49050-0AA5-4747-948C-088196BD2E91}" src="https://github.com/user-attachments/assets/39299635-2b9d-4e32-b348-1842e1af0168" />
<img width="211" height="121" alt="{55D8855A-6966-479E-B22C-210FEC1185CA}" src="https://github.com/user-attachments/assets/6602ab31-72af-4824-8279-fda9303f1fd4" />
<img width="230" height="271" alt="{D0B5A201-2822-4060-BFAD-02412A2398C7}" src="https://github.com/user-attachments/assets/a6b2d28b-9e9f-43e0-be59-ee6930c7d607" />








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


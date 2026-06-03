## Trigger - päästik

[Põhimõisted](README.md) | [Kasutajad](kasutaja.md) | [Kasutajad XAMPP](kasutajaXampp.md) | [Trigerid](trigger.md) | [Triggerid XAMPP](triggerXamp.md) | [Protseduurid](protseduurid.md) | [Võtmed/Keys](keys.md) | [Küsimused](kysimused.md)

### SQL triggerid on spetsiaalsed andmebaasi objektid, mis käivituvad automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE või DELETE).
```sql
--Trigger lisatud kirjeid jälgimiseks tabelis “linnad” – INSERT
--Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi

Create table linnad(
linnID int PRIMARY KEY IDENTITY (1,1),
linnanimi varchar(15) NOT NULL,
rahvaarv int);

-- Trigger lisatud kirjeid jälgimiseks tabelis “linnad” – INSERT
-- Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi

CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
'on tehtud INSERT käsk',  --toiming
concat('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed
FROM inserted;
```
<img width="744" height="594" alt="image" src="https://github.com/user-attachments/assets/ae16f1cf-d579-462d-881b-564772b28fcc" />

```sql
--DELETE triger

CREATE TRIGGER linnaKustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud DELETE käsk',  --toiming
concat('linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv)  --andmed tabelist linnad
FROM deleted;

--drop trigger ....
DISABLE TRIGGER linnaKustutamine ON linnad;
ENABLE TRIGGER linnaKustutamine ON linnad;

--DELETE trigeri kontroll

DELETE FROM linnad WHERE linnID=3;
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="630" height="328" alt="image" src="https://github.com/user-attachments/assets/c1def771-1164-4ab7-9ed8-350dc449d9f6" />

### Kombineerime INSERT ja DELETE triggerid
### See SQL trigger linnaLisKustuta salvestab logi iga kord, kui linnade tabelis lisatakse uus linn või kustutatakse olemasolev linn. Trigger käivitub pärast INSERT või DELETE toimingut ja salvestab logisse andmed.

```sql
--Kombineerime INSERT ja DELETE triggerid
DISABLE TRIGGER linnaLisamine ON linnad;
DISABLE TRIGGER linnaKustutamine ON linnad;

CREATE TRIGGER linnaLisaKustuta
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
	'on tehtud INSERT käsk',  --toiming
	concat('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed tabelist linnad
	FROM inserted

	UNION ALL

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
	'on tehtud DELETE käsk',  --toiming
	concat('linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv)  --andmed tabelist linnad
	FROM deleted;
END;

--kontroll
--INSERT Trigeri tegevuse kontroll
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Parnu2', 200000);

DELETE FROM linnad WHERE linnID=8;
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="689" height="330" alt="image" src="https://github.com/user-attachments/assets/b31effa5-60e1-4b43-82e8-21660cbc606f" />

### Trigger muudetud kirjeid jälgimiseks tabelis “linnad” – UPDATE
```sql
--UPDATE triger
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisselogitud srverisse
'on tehtud UPDATE käsk',  --toiming
concat('vanad andmed - linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv, 'uued andmed - linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed tabelist linnad
FROM deleted INNER JOIN inserted 
ON deleted.linnID=inserted.linnID;

--UPDATE kontroll
UPDATE linnad SET linnanimi='Narva22', rahvaarv=0 WHERE linnanimi='Narva';
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="706" height="364" alt="image" src="https://github.com/user-attachments/assets/a257bb92-b82f-46cb-b148-5870c2c3b2fe" />

### kasutaja sekretaarMilana, parool 12345
### Õigused - sekretaarMilana ei saa luua ehk muuta trigeri, ei näi tabeli logi,
### saab ainult näha, lisada ja kustutada tabelist linnad
```sql
GRANT SELECT, INSERT, DELETE ON linnad TO sekretaarMilana;
DENY SELECT, DELETE ON logi TO sekretaarMilana;
```
### kasutaja sekretaarAnastassia kontroll
```sql
SELECT * FROM logi;

INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Narva35', 225000);

DELETE FROM linnad WHERE linnID=7;
SELECT * FROM linnad;
SELECT * FROM logi;
```
EXEC sp_helptext 'linnaUuendamine';

<img width="457" height="351" alt="image" src="https://github.com/user-attachments/assets/1f478e12-22bf-410c-b603-e28501ffbdad" />

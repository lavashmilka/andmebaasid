Create database autoremont
use autoremont
CREATE TABLE autoremont(
id INT PRIMARY KEY IDENTITY(1,1),
auto_mark VARCHAR(100),
töö_nimetus VARCHAR(150),
hind MONEY,
kuupäev DATE,
mehaanik VARCHAR(100));

INSERT INTO autoremont (auto_mark, töö_nimetus, hind, kuupäev, mehaanik)
VALUES 
('Audi A6', 'Õlivahetus', 120.00, '2026-06-01', 'Andrei'),
('BMW X5', 'Piduriklotside vahetus', 250.00, '2026-06-01', 'Dmitri'),
('Toyota Corolla', 'Tehniline ülevaatus', 60.00, '2026-06-02', 'Aleksei'),
('Volkswagen Passat', 'Amortisaatorite vahetus', 310.00, '2026-06-02', 'Andrei'),
('Volvo XC90', 'Hammasrihma komplekti vahetus', 450.00, '2026-06-03', 'Dmitri');

SELECT * FROM autoremont;
SELECT * FROM logi;

CREATE TABLE logi(
id INT PRIMARY KEY IDENTITY(1,1),
kuupaev DATETIME,
kasutaja VARCHAR(100), 
toiming VARCHAR(100), --tegevuse kirjeldus, nt "Lisatud uus remont", "Muudetud remont", "Kustutatud remont"
andmed TEXT); --tabelist või muudest allikatest pärinevad andmed, mis on seotud toiminguga, nt "Auto: Audi A6, Töö: Õlivahetus, Hind: 120.00"

--insert trigger, mis logib autoremont tabelisse tehtud INSERT toiminguid logi tabelisse
CREATE TRIGGER remontLisamine
ON autoremont --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
BEGIN
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT 
GETDATE(), --aeg, millal toiming toimub
SYSTEM_USER, --kasutaja mis on sisselogitud ja teeb toimingu
'Lisatud uus remont', 
CONCAT('Auto: ', inserted.auto_mark, ', Töö: ', inserted.töö_nimetus, ', Hind: ', inserted.hind) --andmed, mis on seotud toiminguga, nt lisatud remondi auto mark, töö nimetus ja hind
FROM inserted;
END;

INSERT INTO autoremont (auto_mark, töö_nimetus, hind, kuupäev, mehaanik)
VALUES ('Mazda 6', 'Kliima täitmine', 80.00, '2026-06-03', 'Aleksei');
SELECT * FROM autoremont;
SELECT * FROM logi;


CREATE TRIGGER remontUuendamine
ON autoremont --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
BEGIN
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT 
GETDATE(), --aeg, millal toiming toimub
SYSTEM_USER, --kasutaja mis on sisselogitud ja teeb toimingu
'Muudetud remondi andmed', 
CONCAT('VANAD -> Hind: ', deleted.hind, ' | UUED -> Hind: ', inserted.hind, ' Autol: ', inserted.auto_mark) --andmed, mis on seotud toiminguga, nt muudetud remondi auto mark ja töö nimetus
FROM deleted INNER JOIN inserted 
ON deleted.id = inserted.id;
END;

UPDATE autoremont SET hind = 280.00 WHERE auto_mark = 'BMW X5';
SELECT * FROM autoremont;
SELECT * FROM logi;


CREATE TRIGGER remontKustutamine
ON autoremont --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
BEGIN
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT 
GETDATE(), --aeg, millal toiming toimub
SYSTEM_USER, --kasutaja mis on sisselogitud ja teeb toimingu
'Kustutatud remont', 
CONCAT('Oli auto: ', deleted.auto_mark, ', Töö: ', deleted.töö_nimetus) --andmed, mis on seotud toiminguga, nt kustutatud remondi auto mark ja töö nimetus
FROM deleted;
END;

DELETE FROM autoremont WHERE auto_mark = 'Toyota Corolla';

SELECT * FROM autoremont;
SELECT * FROM logi;


DISABLE TRIGGER remontLisamine ON autoremont;
DISABLE TRIGGER remontKustutamine ON autoremont;


CREATE TRIGGER remont_Lisamine_Kustutamine_Kombineeritud
ON autoremont --tabelinimi, mis on vaja jälgida
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;   
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT 
GETDATE(), --aeg, millal toiming toimub
SYSTEM_USER, --kasutaja mis on sisselogitud ja teeb toimingu
'Kombineeritud INSERT käsk', --toiming
CONCAT('Lisatud: ', inserted.auto_mark, ' - ', inserted.töö_nimetus)
FROM inserted

UNION ALL 

SELECT 
GETDATE(), --aeg, millal toiming toimub
SYSTEM_USER, --kasutaja mis on sisselogitud ja teeb toimingu
'Kombineeritud DELETE käsk', --toiming
CONCAT('Kustutatud: ', deleted.auto_mark, ' - ', deleted.töö_nimetus)
FROM deleted;
END;

--kontroll
--INSERT trigeri tegevuse kontroll
INSERT INTO autoremont (auto_mark, töö_nimetus, hind, kuupäev, mehaanik)
VALUES ('Honda Civic', 'Rehvide vahetus', 100.00, '2026-06-04', 'Dmitri');

SELECT * FROM autoremont;
SELECT * FROM logi;

DELETE FROM autoremont WHERE auto_mark = 'Honda Civic';

EXEC sp_helptext 'remontLisamine';
EXEC sp_helptext 'remontUuendamine';
EXEC sp_helptext 'remontKustutamine';


GRANT SELECT, INSERT, DELETE ON autoremont TO sekretär;
DENY SELECT,DELETE ON logi TO sekretär;


USE autoremont;

SELECT * FROM autoremont;

INSERT INTO autoremont (auto_mark, töö_nimetus, hind, kuupäev, mehaanik)
VALUES ('Toyota', 'Õlivahetus', 79.99, '2024-06-01', 'Jüri');

DELETE FROM autoremont
WHERE id = 8;

SELECT * FROM logi;

EXEC sp_helptext 'remontLisamine';

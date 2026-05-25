## SQL Server – Kasutajate autentimine ja õiguste haldamine
Mis on autentimine SQL Serveris?
### Autentimine tähendab kasutaja tuvastamist ehk kontrollimist, kas kasutajal on õigus SQL Serverisse sisse logida.

**SQL Serveris kasutatakse kahte peamist autentimise tüüpi:**

1. Windows Authentication
Selle puhul kasutatakse samu kasutajaandmeid, millega logitakse sisse Windows operatsioonisüsteemi.

>Kasutajanimi ja parool on seotud Windowsiga. 
>Turvalisem lahendus. 
>Paroole haldab Windows. 
>Kasutaja ei pea eraldi SQL Serveri parooli teadma.


2. SQL Server Authentication
>Selle puhul luuakse kasutaja otse SQL Serverisse.
>Kasutaja ei ole seotud Windowsiga. 
>Määratakse eraldi kasutajanimi ja parool. 
>Sobib veebirakenduste jaoks.
<img width="271" height="223" alt="image" src="https://github.com/user-attachments/assets/d2ffa2d4-e72c-40b4-a66d-3d6ed146195e" />


---------------------------------------------------------------
**Näide kasutajast: DirectorMilana. Parool: director**
----------------------------------------------------------------
## Kasutaja loomine SQL Serveris
1. Serveritaseme kasutaja loomine (Login)
Sammud
Ava:

Security → Logins
Tee paremklikk ja vali:

New Login...

<img width="707" height="641" alt="image" src="https://github.com/user-attachments/assets/020e9162-3cdd-4089-8377-48055acc5f81" />



Harjutamiseks võib eemaldada linnukese:  User must change password at next login.

**Server Roles**
Menüüst Server Roles saab määrata serveri üldised õigused.

Tavaliselt piisab rollist: public

<img width="710" height="638" alt="image" src="https://github.com/user-attachments/assets/89eae82a-bad1-4c57-b9e5-5199726dad96" />



2. Andmebaasi kasutaja loomine (User)
Ava:

Database → Security → Users
Tee paremklikk:  New User...

Seosta kasutaja loginiga
<img width="343" height="293" alt="image" src="https://github.com/user-attachments/assets/dc8f8aa4-f328-4145-934d-c38032cb0e69" />



**Membership ja õigused**
Menüüst Membership saab määrata kasutaja rollid.

>db_datareader → võib lugeda SELECT

>db_datawriter → võib kirjutada INSERT, UPDATE, DELETE


<img width="722" height="561" alt="image" src="https://github.com/user-attachments/assets/bae16acc-d42d-4a1e-a9e1-aa467e6474f8" />


-----------------------------------------------------------------------
## Kasutaja õiguste kontroll

1. tuleb sisselogida kasutajana DirectorMilana. Connect--> Database Engine

<img width="479" height="582" alt="image" src="https://github.com/user-attachments/assets/d3f2dc61-a9bf-4528-8ba5-ae68bb8e6224" />


2. saab tabeli sisu näha ja sisestada uus kiri.
<img width="662" height="601" alt="image" src="https://github.com/user-attachments/assets/2940511a-ff3e-433a-ab60-15379e77d73d" />


3. kontrollime tegevus, mis ei ole lubatud kasutajale, näiteks tabeli loomine.

<img width="659" height="548" alt="image" src="https://github.com/user-attachments/assets/1cb81e35-4c92-4e3e-bcd8-38770888f76a" />





------------------------------------------------------------------------
```
#### SQL Server Authentication Mode muutmine
Kui ilmub viga: Error 18456, siis on tavaliselt lubatud ainult Windows Authentication.
Lahendus: Server → Properties -->
Security
 Vali: SQL Server and Windows Authentication mode
```

```sql
--GRANT - õiguste määramine
--DENY - õiguste keelamine

--db_datareader -SELECT 
--db_datawriter - INSERT, DELETE, UPDATE

--anname kasutajale DirectorMilana õigus 
--ainult kustutada ja uuendada tabelit 
--(DELETE, UPDATE, SELECT)

GRANT DELETE ON puhkus TO DirectorMilana;
GRANT UPDATE ON puhkus TO DirectorMilana;
GRANT SELECT ON puhkus TO DirectorMilana;

--keelame INSERT
DENY INSERT ON puhkus TO DirectorMilana;

```


<img width="709" height="729" alt="image" src="https://github.com/user-attachments/assets/922fcc53-e1fd-4466-bec4-b75a5532d209" />



SELECT	Lugemine
INSERT	Lisamine
UPDATE	Muutmine
DELETE	Kustutamine

<img width="540" height="410" alt="image" src="https://github.com/user-attachments/assets/41557e99-f18c-42ca-a33a-d77d1ebcabab" />
<img width="700" height="495" alt="image" src="https://github.com/user-attachments/assets/29b36edd-482d-4e40-adc9-0751dd972739" />
<img width="613" height="623" alt="image" src="https://github.com/user-attachments/assets/64a0a24a-8e17-4bc2-a637-adaa65a45b9b" />

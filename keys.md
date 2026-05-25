# Andmebaasi võtmed (Keys)
## Primary Key

Primary Key ehk peamine võti on väli või väljade kombinatsioon, mille abil saab iga tabeli rea üheselt ära tunda.

Seda kasutatakse kirjete unikaalseks identifitseerimiseks.

Erinevus teistest võtmetest:
- ei tohi sisaldada NULL väärtusi;
- tabelis saab olla ainult üks Primary Key.

```sql
CREATE TABLE opilased(
opilasedID INT identity(1,1) PRIMARY KEY,
Nimi_op VARCHAR(50));
```

opilaneID määrab iga õpilase unikaalselt.

<img width="247" height="84" alt="image" src="https://github.com/user-attachments/assets/e8875528-a718-4a64-b14c-d3d4f2f60c7c" />


## Foreign Key

Foreign Key ehk välisvõti on väli, mis viitab teise tabeli Primary Key-le.

Selle abil luuakse seos erinevate tabelite vahel.

Erinevus teistest võtmetest:
- ei taga väärtuste unikaalsust;
- kasutatakse tabelite ühendamiseks.

```sql
CREATE TABLE Kursus(
KursusID INT IDENTITY(1,1) PRIMARY KEY,
KursuseNimi VARCHAR(50));

CREATE TABLE Tudeng(
TudengID INT IDENTITY(1,1) PRIMARY KEY,
Nimi VARCHAR(50),
KursusID INT,
FOREIGN KEY (KursusID)
REFERENCES Kursus(KursusID));
```

KursusID näitab, millisele kursusele tudeng kuulub.

<img width="259" height="83" alt="image" src="https://github.com/user-attachments/assets/b38f68d1-cc29-4058-8186-8d623a45d7b2" />

<img width="232" height="101" alt="image" src="https://github.com/user-attachments/assets/513c75f1-867c-4991-b120-dcb201e84c27" />

## Unique Key

Unique Key tagab, et kõik väärtused veerus oleksid erinevad.

Seda kasutatakse korduvate andmete vältimiseks.

Erinevus teistest võtmetest:
- lubab tavaliselt ühe NULL väärtuse;
- tabelis võib olla mitu Unique Key-d.

```sql
CREATE TABLE Kasutajad(
KasutajaID INT IDENTITY(1,1) PRIMARY KEY,
Kasutajanimi VARCHAR(50) UNIQUE);
```

Kõik kasutajanimed peavad olema unikaalsed.

<img width="296" height="135" alt="image" src="https://github.com/user-attachments/assets/3e57fb59-9647-4cc8-907e-59be8d62b271" />


## Simple Key

Simple Key koosneb ainult ühest väljast.

Seda kasutatakse siis, kui ühest veerust piisab rea tuvastamiseks.

Erinevus teistest võtmetest:
- sisaldab ainult ühte atribuuti.

```sql
CREATE TABLE Raamat(
RaamatID INT IDENTITY(1,1) PRIMARY KEY,
Pealkiri VARCHAR(100));
```

RaamatID on simple key.

<img width="274" height="120" alt="image" src="https://github.com/user-attachments/assets/1e250b46-34ad-49f3-9266-f33fc330be36" />


## Composite Key

Composite Key koosneb kahest või rohkemast väljast.

Seda kasutatakse olukorras, kus üks väli üksi ei taga unikaalsust.

Erinevus teistest võtmetest:
- kirje määratakse mitme välja kombinatsiooniga.

```sql
CREATE TABLE Ost(
OstID INT,
ToodeID INT,
PRIMARY KEY (OstID, ToodeID));
```

OstID ja ToodeID moodustavad koos võtme.

<img width="280" height="122" alt="image" src="https://github.com/user-attachments/assets/efb2c85a-b1eb-48c0-a8c4-8ed4b4bdf25a" />


## Compound Key

Compound Key on mitmest väljast koosnev võti, kus kõik väljad on vajalikud rea identifitseerimiseks.

Seda kasutatakse keerukamate tabeliseoste korral.

Erinevus teistest võtmetest:
- mitu välja töötavad ühe võtmena.

```sql
CREATE TABLE Tulemus(
TudengID INT,
KursusID INT,
PRIMARY KEY (TudengID, KursusID));
```

TudengID ja KursusID määravad konkreetse tulemuse.

<img width="297" height="115" alt="image" src="https://github.com/user-attachments/assets/d42a2e7e-a501-4df2-82c2-f3713cee5d21" />


## Superkey

Superkey on üks või mitu välja, mille abil saab kirje unikaalselt määrata.

Seda kasutatakse võimalike identifikaatorite leidmiseks.

Erinevus teistest võtmetest:
- võib sisaldada liigseid välju.

```sql
CREATE TABLE Tootaja(
ID INT IDENTITY(1,1) PRIMARY KEY,
Email VARCHAR(50),
Telefon VARCHAR(20));
```

Näited superkeydest:
(ID)
(ID, Email)
(ID, Email, Telefon)

ID üksi juba identifitseerib kirje.

<img width="338" height="170" alt="image" src="https://github.com/user-attachments/assets/3fc8da8d-f229-4a96-b45f-5f8b8177fc0c" />

## Candidate Key

Candidate Key on võimalik kandidaat Primary Key jaoks.

Seda kasutatakse sobiva peamise võtme valimiseks.

Erinevus teistest võtmetest:
- tabelis võib olla mitu kandidaatvõtit.

```sql
CREATE TABLE Klient (
    KlientID INT IDENTITY(1,1) PRIMARY KEY,
    Telefon VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE
);
```

Telefon ja Email võivad samuti olla Candidate Key-d.

<img width="300" height="166" alt="image" src="https://github.com/user-attachments/assets/f1962ecd-bba0-46d0-95fc-d9ac141e7f52" />


## Alternate Key

Alternate Key on kandidaatvõti, mida ei valitud Primary Key-ks.

Seda kasutatakse täiendava unikaalsuse hoidmiseks.

Erinevus teistest võtmetest:
- ei ole tabeli peamine võti.

```sql
CREATE TABLE Tootaja2(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Isikukood VARCHAR(20) UNIQUE
);
```

Isikukood on Alternate Key, sest peamine võti on ID.

<img width="295" height="133" alt="image" src="https://github.com/user-attachments/assets/1fd477b2-6725-45ff-ae44-c3a981362b0c" />

## Kasutatud allikad

1. Microsoft Learn – Primary and Foreign Key Constraints  
- https://learn.microsoft.com/en-us/sql/relational-databases/tables/primary-and-foreign-key-constraints?view=sql-server-ver17&utm_source=chatgpt.com

3. SQL FOREIGN KEY Constraint
- https://www.w3schools.com/sql/sql_foreignkey.asp

[Põhimõisted](README.md) | [Kasutajad](kasutaja.md) | [Kasutajad XAMPP](kasutajaXampp.md) | [Trigerid](trigger.md) | [Triggerid XAMPP](triggerXamp.md) | [Protseduurid](protseduurid.md) | [Võtmed/Keys](keys.md) | [Küsimused](kysimused.md)

<img width="600" height="642" alt="image" src="https://github.com/user-attachments/assets/071f5254-b97b-439c-83f0-be2c36042b45" />

```sql

INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(),
'on tehtud INSERT käsk', 
concat('linn: ', NEW.linnanimi, ', rahvaarv: ', NEW.rahvaarv)
FROM linnad
WHERE linnad.linnID=NEW.linnID;
```
<img width="545" height="601" alt="image" src="https://github.com/user-attachments/assets/fb299cfd-1476-4a68-bcd6-93de5d1b8f4a" />

```sql

INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(), 
'on tehtud DELETE käsk',  
concat('linn: ', OLD.linnanimi, ', rahvaarv: ', OLD.rahvaarv)
FROM linnad
WHERE linnad.linnID=OLD.linnID
```
<img width="602" height="607" alt="image" src="https://github.com/user-attachments/assets/e82b8a49-ad80-4cfd-952c-3cb9d201bb4a" />

```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(),
'on tehtud UPDATE käsk',
concat('vanad : ', OLD.linnanimi, ',',  OLD.rahvaarv, '\n uued: ', NEW.linnanimi, ', ', NEW.rahvaarv)
FROM linnad a INNER JOIN linnad b
ON a.linnID=b.linnID
WHERE a.linnID=NEW.linnID
```
<img width="898" height="377" alt="image" src="https://github.com/user-attachments/assets/2e00e5ef-542f-4583-82e8-03d99c17306a" />

<img width="619" height="88" alt="image" src="https://github.com/user-attachments/assets/8fac53da-2f23-403c-83a8-713a9e82148c" />

<img width="626" height="340" alt="image" src="https://github.com/user-attachments/assets/a38bc202-6176-4686-be49-4d83bd16a143" />

<img width="1221" height="318" alt="image" src="https://github.com/user-attachments/assets/48eda350-5d99-444e-8a88-11619d1a41d2" />

<img width="1039" height="369" alt="image" src="https://github.com/user-attachments/assets/c362296d-9093-4769-b9a3-7c35918b54f2" />

# Andmebaas sales 
```sql
--1.categories
create table categories(
category_id int primary key identity(1,1),
category_name varchar(25) unique)
insert into categories(category_name)
values('auto');
select * from categories;
```
<img width="232" height="133" alt="{E8B080C9-7EB3-4E98-A04B-6CA1EE343570}" src="https://github.com/user-attachments/assets/b5a0065e-9c02-406b-8ee2-6b57f406f2d1" />

```sql
--2.brands
create table brands(
brand_id int primary key identity(1,1),
brand_name varchar(15) unique);
insert into brands
values('Xiomi')
select * from brands
```
<img width="214" height="110" alt="{6638A738-6F68-40CC-806D-B7C3F5823658}" src="https://github.com/user-attachments/assets/9411128f-3690-48b7-9f23-8aa7878d63f1" />

```sql
--3.products
create table products(
product_id int primary key identity(1,1),
product_name varchar(50) not null,
brand_id int,
foreign key (brand_id)  references brands(brand_id),
category_id int,
foreign key (category_id)  references categories(category_id),
model_year int,
list_price money);
insert into products
values('nutitelefon Samsung',1,2, 2026,1250)
select * from products
```
<img width="484" height="124" alt="{C39943D9-5529-45DB-8C40-761BFF1E67C1}" src="https://github.com/user-attachments/assets/c8e0c741-bad8-4689-9369-99fef45d9eb2" />

```sql
--4.stores
create table stores(
stores_id int primary key identity(1,1),
store_name varchar(30) not null,
phone varchar(13),
email varchar(40),
street varchar(20),
city varchar(30),
state varchar(10),
zip_code char(5))
insert into stores
values('T1', '5879347', 't1@gmail.ee', 'Majaka tee', 'Tallinn', 'Harjumaa', '59674')
select * from stores
```
<img width="611" height="143" alt="{9327F9E0-C849-457D-980A-CCDC7FA1E5FC}" src="https://github.com/user-attachments/assets/ff2fe85f-5a9e-4579-b3c9-6fb53b567cb3" />

```sql
--5.stocks
create table stocks(
stores_id int,
product_id int,
primary key(stores_id, product_id), --kaks võtit koos
foreign key (stores_id) references stores(stores_id),
foreign key (product_id) references products(product_id),
quantity int)
insert into stocks
values(2,1,3)
select * from stocks
```
<img width="228" height="125" alt="{C4CD58E6-E98E-4BE4-9F2B-642AF3A5DBCD}" src="https://github.com/user-attachments/assets/e325f786-78ec-44ba-8f1f-68eff6b5ae6e" />

```sql
--6.customers
create table customers(
customer_id int primary key identity(1,1),
first_name varchar(10) not null,
last_name varchar(15) not null,
phone varchar(13),
email varchar(30),
street varchar(20),
city varchar(15) check(city='Tallinn'or city='Narva'),
state varchar(25),
zip_code char(5))
insert into customers
values('Aang','Bender','5674395','appa@gmail.com','Tallinn tn','Tallinn','Harjumaa','3658')
select * from customers
```
<img width="639" height="123" alt="{FCB20665-1932-4514-AC91-7B78D5D39946}" src="https://github.com/user-attachments/assets/c2ee9510-f469-4fd0-9891-6bf710af0436" />

```sql
--7.staffs
create table staffs(
staff_id int primary key identity(1,1),
first_name varchar(10) not null,
last_name varchar(15) not null,
phone varchar(13),
email varchar(30),
active bit,
stores_id int,
foreign key (stores_id) references stores(stores_id),
manager bit)
insert into staffs
values('Zuko','Bender','56743345','zuko@mail.com',1,2,1)
select * from staffs
```
<img width="554" height="109" alt="{EBB11A08-EDF1-4E1B-B7F1-2B6EAE33BB99}" src="https://github.com/user-attachments/assets/cb060fa5-e0f1-4a2b-a693-1f0b047f3a7a" />

```sql
--8.orders
create table orders(
order_id int primary key identity(1,1),
customer_id int,
stores_id int,
staff_id int,
foreign key (customer_id) references customers(customer_id),
foreign key (stores_id) references stores(stores_id),
foreign key (staff_id) references staffs(staff_id),
order_status varchar(15) check(order_status='complete'or order_status='incomplete'),
order_date date,
required_date date,
shipped_date date)
insert into orders
values(2,1,6,'complete', '2026-5-20','2026-5-30','2026-6-10')
select * from orders
```
<img width="601" height="122" alt="{3AF2BF1A-D0FF-4322-8A06-A6E815C7ECD4}" src="https://github.com/user-attachments/assets/8a5f5928-36a2-4596-845c-ae8b6bddc327" />

```sql
--9.order_items
create table order_items(
order_id int,
item_id int,
primary key(order_id, item_id),
product_id int,
quantity int,
list_price money,
discount int,
foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id))
insert into order_items
values(4,2,1,140,1000,50)
select * from order_items 
```
<img width="406" height="111" alt="{E2B0CFE7-72B5-42F2-B930-809A95E1C719}" src="https://github.com/user-attachments/assets/8bb04438-0659-4cb8-9b02-d79a95410a43" />

# Database Diagram
<img width="1467" height="850" alt="{801B9488-6920-4F46-B67B-84E43EE6F890}" src="https://github.com/user-attachments/assets/91657ead-585a-49fa-b2fb-2cb3807c0640" />

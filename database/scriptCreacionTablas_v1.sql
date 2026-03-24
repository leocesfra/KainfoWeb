create database Kainfo;

use Kainfo;

create table Categories (
id bigint auto_increment primary key,
name varchar(255) not null,
parent_id bigint,
foreign key (parent_id) REFERENCES Categories(id)
);

create table Products (
id bigint primary key,
name varchar(255) not null,
description text not null,
price decimal(10,2) not null,
stock int,
image_url text, 
category_id bigint not null,
brand varchar(255) not null,
SKU varchar(255) not null,
foreign key (category_id) REFERENCES Categories(id)
);

create table ProductsAttributes (
id bigint auto_increment primary key,
name varchar(255) not null,
value varchar(255) not null,
product_id bigint not null,
foreign key (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

create table Users (
id bigint auto_increment primary key ,
email varchar(255) not null,
password varchar(100) not null,
rol varchar(50)  not null
);

create table Orders (
id bigint auto_increment primary key ,
date datetime not null,
client_name varchar(100) not null,
email_client varchar(255) not null,
address varchar(255) not null,
amount decimal(10,2) not null,
state varchar(50) not null
);

create table OrdersLine (
id bigint auto_increment primary key,
quantity int not null,
unitary_price decimal(10,2) not null,
order_id bigint not null,
product_id bigint not null,
foreign key (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
foreign key (product_id) REFERENCES Products(id)
);
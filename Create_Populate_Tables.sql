USE master;
CREATE DATABASE AUTOMOTIVE;

USE AUTOMOTIVE;
CREATE TABLE AUTO (
	Targa VARCHAR(10) primary key,
	Marca VARCHAR(255),
	Cilindrata INT,
	Potenza FLOAT,
	CodF VARCHAR(20),
	CodAss INT UNIQUE
)

CREATE TABLE PROPRIETARI(
	CodF VARCHAR(20) primary key,
	Nome VARCHAR(255),
	Residenza VARCHAR(255)
)

CREATE TABLE ASSICURAZIONI(
	CodAss INT primary key,
	Nome VARCHAR(255),
	Sede VARCHAR(255)
)

CREATE TABLE AUTOCOINVOLTE(
	CodS INT Primary Key,
	Targa VARCHAR(10),
	ImportoDanno FLOAT 
)


CREATE TABLE SINISTRI(
	CodS INT Primary Key,
	Localita Varchar(255),
	Giorno Date  --We could also use "Data", better to avoid any issues   
)


CREATE TABLE SINISTRI_TEMP(
	CodS INT Primary Key,
	Localita Varchar(255),
	Giorno Date  
)



INSERT INTO AUTO
VALUES ('KK456IO', 'Fiat', 1000, 56, 'KKKKIO56E01Y489O', 1234),
('PP456IO', 'Peugeot', 1100, 70,'PPPPIO56E01Y489O', 1235),
('HH456IO', 'Tata', 1200, 90,'HHHHIO56E01Y489O', 1236),
('UU456IO', 'Ford', 2500, 110,'UUUUIO56E01Y489O', 1237),
('CC456IO', 'Ford', 900, 80,'UUUUIO56E01Y489O', 1238)
;

INSERT INTO PROPRIETARI
VALUES ('PPPPIO56E01Y489O', 'Tizio', 'Mestre'),
('KKKKIO56E01Y489O', 'Tiziano', 'Marghera'),
('HHHHIO56E01Y489O', 'Trizio', 'Treviso'),
('UUUUIO56E01Y489O', 'Tito', 'Jesolo')
;

INSERT INTO ASSICURAZIONI 
VALUES (1236, 'SARA', 'Pordenone'),
(1235, 'Generali', 'Trieste'),
(1234, 'Lloyds', 'Padova'),
(1237, 'Allianz', 'Vicenza')
;

INSERT INTO AUTOCOINVOLTE
VALUES (123, 'KK456IO', 750),
(456, 'PP456IO', 300),
(789, 'HH456IO', 900),
(1011, 'ZZ125OI', 1200),
(1201, 'KK456IO',1800),
(1012, 'UU456IO', 999)
;




/*
TRUNCATE TABLE AUTO
TRUNCATE TABLE PROPRIETARI
TRUNCATE TABLE AUTOCOINVOLTE
TRUNCATE TABLE ASSICURAZIONI 
*/


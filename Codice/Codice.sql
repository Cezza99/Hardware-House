CREATE TABLE Negozio(
	
	ID char(5) PRIMARY KEY,
	Indirizzo varchar(20),
	Citta varchar(20)
);

INSERT INTO Negozio (ID, Indirizzo , Citta) VALUES
('PD024', 'Via Altinate 24', 'Padova'),
('PD089', 'Via Gattamelata 89', 'Padova'),
('VI055', 'Via Greco 55', 'Vigonza'),
('AB126', 'Via Principi 126', 'Abano Terme'),
('AL041', 'Via Savona 41', 'Albignasego');

CREATE TABLE Magazzino (

	ID char(5) PRIMARY KEY,
	Indirizzo varchar(20),
	Citta varchar(20),
	Volume int(3),
	Negozio char(5),
	
	FOREIGN KEY(Negozio) REFERENCES Negozio(ID)
				ON DELETE SET NULL
				ON UPDATE CASCADE	
);

INSERT INTO Magazzino (ID, Indirizzo, Citta, Volume, Negozio) VALUES
('PD062', 'Via Altinate 62', 'Padova', 100, 'PD024'),
('PD092', 'Via Gattamelata 92', 'Padova', 200, 'PD089'),
('VI061', 'Via Greco 61', 'Vigonza', 62, 'VI055'),
('AB085', 'Via Principi 85', 'Abano Terme', 120, 'AB126'),
('AL050', 'Via Savona 50', 'Albignasego', 40, 'AL041');

CREATE TABLE Produttore(

	Nome varchar(20) PRIMARY KEY,
	Email varchar(20),
	Telefono char(11)
	
);

INSERT INTO Produttore (Nome, Email, Telefono) VALUES
('Intel Corp.', 'Intel@gmail.com', '049 5671372'),
('AMD', 'AMD@gmail.com', '049 8431652'),
('Cooler Master', 'CM@gmail.com', '012 3890152'),
('Asus', 'Asus@gmail.com', '089 7480945'),
('Corsair', 'Corsair@gmail.com', '045 6783012'),
('Nvidia', 'Nvidia@gmail.com', '023 4860014'),
('MSI', 'MSI@gmail.com', '067 6857124'),
('Samsung', 'Samsung@gmail.com', '076 5341278');


CREATE TABLE Componente (
	
	ID char(5) PRIMARY KEY,
	Nome varchar(20),
	Tipo enum ('SM', 'CPU', 'SV', 'COOLER', 'RAM', 'MEM', 'CASE', 'ALIM'),
	Prezzo float,
	Produttore varchar(20),
	

	FOREIGN KEY(Produttore) REFERENCES Produttore(Nome)
				ON UPDATE CASCADE
);

INSERT INTO Componente (ID, Nome, Tipo, Prezzo, Produttore) VALUES
('A3600', 'AMD Ryzen 5 3600', 'CPU', 194.99, 'AMD'),
('I9700', 'Intel Core i7-9700', 'CPU', 369.99, 'Intel Corp.'),
('CM212', 'Hyper 212 EVO', 'COOLER', 34.49, 'Cooler Master'),
('CH100', 'H100i PRO', 'COOLER', 73.99, 'Corsair'),
('MB450', 'B450 TOMAHAWK', 'SM', 114.99, 'MSI'),
('AS450', 'STRIX B450-F', 'SM', 117.99, 'Asus'),
('CVLPX', 'Vengeance LPX 16GB', 'RAM', 74.67, 'Corsair'),
('I660P', '660P Series', 'MEM', 109.99, 'Intel Corp.'),
('S860E', '860 EVO', 'MEM', 77.00, 'Samsung'),
('N1060', 'GeForce GTX 1060', 'SV', 399.99, 'Nvidia'),
('MXSOC', 'MSI Ventus  XS OC', 'SV', 297.99, 'MSI'),
('Q300L', 'MasterBox Q300L', 'CASE', 44.99, 'Cooler Master'),
('C200R', 'Corsair 200R', 'CASE', 109.99, 'Corsair'),
('CRM19', 'Corsair RM2019', 'ALIM', 109.99, 'Corsair'),
('CSCXM', 'Corsair CXM', 'ALIM', 73.98, 'Corsair');

CREATE TABLE Contenuto_Magazzino(

	Magazzino char(5),
	Componente char(5),
	
	PRIMARY KEY (Magazzino, Componente),
	
	FOREIGN KEY(Magazzino) REFERENCES Magazzino(ID)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	
	FOREIGN KEY(Componente) REFERENCES Componente(ID)
							ON DELETE CASCADE
							ON UPDATE CASCADE

);

INSERT INTO Contenuto_Magazzino (Magazzino, Componente) VALUES 
('PD062', 'A3600'),
('PD062', 'I9700'),
('PD062', 'CM212'),
('PD062', 'CRM19'),
('PD062', 'Q300L'),
('PD062', 'CSCXM'),
('PD062', 'MB450'),
('PD062', 'CVLPX'),
('PD062', 'I660P'),
('PD062', 'N1060'),
('PD092', 'C200R'),
('PD092', 'AS450'),
('VI061', 'CH100'),
('VI061', 'S860E'),
('VI061', 'AS450'),
('VI061', 'MXSOC'),
('VI061', 'CRM19'),
('AB085', 'C200R'),
('AB085', 'CRM19'),
('AB085', 'I9700'),
('AB085', 'AS450'),
('AB085', 'CH100'),
('AL050', 'CSCXM'),
('AL050', 'CRM19'),
('AL050', 'A3600'),
('AL050', 'Q300L'),
('AL050', 'I660P'),
('AL050', 'N1060');


CREATE TABLE Dipendente (

	CF char(16) PRIMARY KEY,
	Nome varchar(20),
	Cognome varchar(20),
	Mansione enum('Consulente', 'Manutentore', 'Commesso'),
	Stipendio int(4),
	Data_Assunzione date,
	Negozio char(5),

	FOREIGN KEY(Negozio) REFERENCES Negozio(ID)
				ON DELETE CASCADE
				ON UPDATE CASCADE,
	
	UNIQUE (Nome, Cognome) 

);

INSERT INTO Dipendente (CF, Nome, Cognome, Mansione, Stipendio, Data_Assunzione, Negozio) VALUES
('RSSMRI67D27A001F', 'Mario', 'Rossi','Consulente', 1350, '2011-10-27', 'PD024'),
('BNCGRG89E20B253D', 'Giorgio', 'Bianchi','Manutentore', 1200, '2010-04-22', 'PD024'),
('BNLVLR97A11G731E', 'Valeria', 'Bonello','Commesso', 1300, '2018-11-04', 'PD024'),
('MNCALR95B23F002C', 'Alberto', 'Mancuso','Consulente', 1400, '2016-02-17', 'PD089'),
('SLVFDR98C21G867D', 'Federico', 'Salvi','Manutentore', 2000, '2019-03-25', 'PD089'),
('SPTSVR94L30F657V', 'Saverio', 'Spatola','Commesso', 1500, '2017-02-15', 'PD089'),
('LSPGCM76F16S450H', 'Giacomo', 'Lespo', 'Consulente', 1100, '2012-12-12', 'VI055'),
('TRNGUD93E25Q829R', 'Guido', 'Tirano', 'Manutentore', 2000, '2016-12-01', 'VI055'),
('CRSANG97E21V645T', 'Angela', 'Cristante', 'Commesso', 1800, '2017-08-24', 'VI055'),
('DMCLUG78F23G758R', 'Luigi', 'DiMarco', 'Consulente', 1500, '2011-05-13', 'AB126'),
('MORPTR99L12S456U', 'Pietro', 'Mori', 'Manutentore', 2100, '2013-07-19', 'AB126'),
('BRNCRL94D11P869S', 'Carla', 'Bruni','Commesso', 1500, '2011-02-10', 'AB126'),
('SLVVTT91F16M859P', 'Vittoria', 'Salvo', 'Consulente', 1500, '2018-09-30', 'AL041'),
('BNDAND90C25L904T', 'Andrea', 'Biondi','Commesso', 1700, '2019-06-09', 'AL041'),
('SCRRCC81B06I846F', 'Riccardo', 'Scuri', 'Manutentore', 1900, '2014-05-18', 'AL041');

CREATE TABLE Cliente(

	ID char(4) PRIMARY KEY,
	Nome varchar(20),
	Cognome varchar(20),
	Email varchar(20)

);

INSERT INTO Cliente (ID, Nome, Cognome, Email) VALUES
('AW10', 'Alberto', 'Wong', 'AW@gmail.com'),
('ZE34', 'Zama', 'Ermes', 'ZE@gmail.com'),
('BT76', 'Barbara', 'Troni', 'BT@gmail.com'),
('NB22', 'Norberto', 'Bola', 'NB@gmail.com'),
('CR90', 'Carlo', 'Rossi', 'CR@gmail.com'),
('SC58', 'Simona', 'Certosini', 'SC@gmail.com'),
('HG79', 'Harry', 'Gentilon', 'HG@gmail.com'),
('DF05', 'Dario', 'Fresola', 'DF@gmail.com'),
('TY51', 'Tancredi', 'Yong', 'TY@gmail.com'),
('FF20', 'Fabio', 'Fumelli', 'FF@gmail.com');

CREATE TABLE Manutenzione (

	Dipendente char(16),
	Data timestamp,
	Cliente char(4),
	Tipo enum ('Riparazione', 'Assemblaggio'),
	Durata time,
	
	PRIMARY KEY(Dipendente, Data),
	
	FOREIGN KEY(Dipendente) REFERENCES Dipendente(CF)
							
	FOREIGN KEY(Cliente) REFERENCES Cliente(ID)

);

INSERT INTO Manutenzione (Dipendente, Data, Cliente, Tipo, Durata) VALUES
('BNCGRG89E20B253D', '2019-12-31 14:17:51', 'SC58', 'Riparazione', '01:15:00'),
('BNCGRG89E20B253D', '2019-02-14 12:09:12', 'DF05', 'Assemblaggio', '02:00:31'),
('SLVFDR98C21G867D', '2020-01-01 16:21:09', 'CR90', 'Assemblaggio', '02:34:51'),
('TRNGUD93E25Q829R', '2019-09-10 18:33:47', 'AW10', 'Assemblaggio', '03:12:07'),
('MORPTR99L12S456U', '2019-04-16 19:01:15', 'TY51', 'Assemblaggio', '02:55:40'),
('TRNGUD93E25Q829R', '2020-01-02 09:47:31', 'AW10', 'Riparazione', '00:37:24'),
('SCRRCC81B06I846F', '2018-01-23 09:47:31', 'FF20', 'Assemblaggio', '02:09:07');


CREATE TABLE Consulenza (

	Dipendente char(16),
	Cliente char(4),
	
	PRIMARY KEY (Dipendente, Cliente),
	
	FOREIGN KEY (Dipendente) REFERENCES Dipendente(CF)
								ON DELETE SET NULL
								ON UPDATE CASCADE,
	
	FOREIGN KEY (Cliente) REFERENCES Cliente(ID)
							ON DELETE NO ACTION
							ON UPDATE CASCADE

);

INSERT INTO Consulenza (Dipendente, Cliente) VALUES
('RSSMRI67D27A001F', 'DF05'),
('MNCALR95B23F002C', 'AW10'),
('LSPGCM76F16S450H', 'CR90'),
('RSSMRI67D27A001F', 'FF20'),
('SLVVTT91F16M859P', 'ZE34'),
('SLVVTT91F16M859P', 'HG79');

CREATE TABLE Acquisto (

	ID char(10) PRIMARY KEY, 
	Data date,
	Totale float,
	Negozio char(5),
	Dipendente char(16),
	Cliente char(4)
	
	FOREIGN KEY (Negozio) REFERENCES Negozio(ID)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
	
	FOREIGN KEY (Dipendente) REFERENCES Dipendente(CF)
								ON UPDATE CASCADE,
	
	FOREIGN KEY (Cliente) REFERENCES Cliente(ID)
							ON UPDATE CASCADE

);

INSERT INTO Acquisto (ID, Data, Totale, Negozio, Dipendente, Cliente) VALUES
('19 0000001', '2019-09-19', 1084.60, 'PD024', 'BNLVLR97A11G731E', 'AW10'),
('19 0000002', '2019-09-19', 399.99, 'PD024', 'BNLVLR97A11G731E', 'DF05'), 
('17 0000001', '2017-07-12', 1195.60, 'PD089', 'SPTSVR94L30F657V', 'CR90'),
('15 0000001', '2015-11-08', 342.98, 'VI055', 'CRSANG97E21V645T', 'NB22'), 
('18 0000001', '2018-05-23', 1355.75, 'AL041', 'SCRRCC81B06I846F', 'HG79'),
('17 0000002', '2017-06-11', 1494.5, 'AB126', 'BRNCRL94D11P869S', 'ZE34'),
('17 0000003', '2017-12-21', 386.97, 'PD024', 'BNLVLR97A11G731E', 'AW10');

CREATE TABLE Acquisto_Componenti (

	ID_Acquisto char(10) PRIMARY KEY,
	Concluso bool,
	
	FOREIGN KEY (ID_Acquisto) REFERENCES Acquisto(ID)
								ON DELETE CASCADE
								ON UPDATE CASCADE
);

INSERT INTO Acquisto_Componenti (ID_Acquisto, Concluso) VALUES
('19 0000001', True),
('19 0000002', True),
('17 0000001', False), 
('15 0000001', False),
('17 0000003', False); 

CREATE TABLE Composizione_Acquisto (

	ID_Acquisto char(10),
	Componente char(5),
	
	PRIMARY KEY (ID_Acquisto, Componente),
	
	FOREIGN KEY(ID_Acquisto) REFERENCES Acquisto_Componenti(ID_Acquisto)
							ON DELETE CASCADE
							ON UPDATE CASCADE,
							
	FOREIGN KEY(Componente) REFERENCES Componente(ID)
							ON UPDATE CASCADE
);

INSERT INTO Composizione_Acquisto (ID_Acquisto, Componente) VALUES
('19 0000001', 'A3600'),
('19 0000001', 'CM212'),
('19 0000001', 'MB450'),
('19 0000001', 'CVLPX'),
('19 0000001', 'I660P'),
('19 0000001', 'N1060'),
('19 0000001', 'Q300L'),
('19 0000001', 'CRM19'),
('19 0000002', 'N1060'),
('17 0000001', 'I9700'), 
('17 0000001', 'CH100'),
('17 0000001', 'AS450'),
('17 0000001', 'CVLPX'),
('17 0000001', 'S860E'),
('17 0000001', 'MXSOC'),
('17 0000001', 'C200R'),
('17 0000001', 'CSCXM'),
('15 0000001', 'MXSOC'),
('15 0000001', 'Q300L'),
('17 0000003', 'A3600'),
('17 0000003', 'CH100'),
('17 0000003', 'AS450');


CREATE TABLE Ordine (

	ID char(5) PRIMARY KEY,
	Data_Ord date,
	Data_Arr date,
	Acquisto_Componente char(10),
	
	FOREIGN KEY (Acquisto_Componente) REFERENCES Acquisto_Componenti(ID_Acquisto)
										ON DELETE CASCADE
										ON UPDATE CASCADE

);

INSERT INTO Ordine (ID, Data_Ord, Data_Arr, Acquisto_Componente) VALUES
('A0001', '2017-07-12', '2017-07-22', '17 0000001'),
('A0002', '2015-11-08', '2015-11-23', '15 0000001'),
('A0003', '2017-12-21', '2017-12-30', '17 0000003');



CREATE TABLE PC (

	Nome varchar(20) PRIMARY KEY,
	Prezzo float,
	Funzione enum ('Ufficio', 'Gaming', 'Grafica', 'Design')

);

INSERT INTO PC (Nome, Prezzo, Funzione) VALUES
('Matrix', 1355.75, 'Gaming'),
('Axys', 1494.5, 'Grafica');


CREATE TABLE Acquisto_Preassemblati (

	ID_Acquisto char(10) PRIMARY KEY,
	NomePc varchar(20),
	
	FOREIGN KEY(ID_Acquisto) REFERENCES Acquisto(ID)
								ON DELETE CASCADE
								ON UPDATE CASCADE,
								
	FOREIGN KEY(NomePc) REFERENCES PC(Nome)
						ON DELETE SET NULL
						ON UPDATE CASCADE
);

INSERT INTO Acquisto_Preassemblati (ID_Acquisto, NomePc) VALUES
('18 0000001', 'Matrix'),
('17 0000002', 'Axys');


CREATE TABLE Configurazione (

	NomePc varchar(20),
	Componente char(5),
	
	PRIMARY KEY(NomePc, Componente),
	
	FOREIGN KEY(NomePc) REFERENCES PC(Nome)
						ON DELETE CASCADE
						ON UPDATE CASCADE,
	
	FOREIGN KEY(Componente) REFERENCES Componente(ID)
							ON DELETE NO ACTION
							ON UPDATE CASCADE

);

INSERT INTO Configurazione (NomePc, Componente) VALUES
('Matrix', 'A3600'),
('Matrix', 'CM212'),
('Matrix', 'MB450'),
('Matrix', 'CVLPX'),
('Matrix', 'I660P'),
('Matrix', 'N1060'),
('Matrix', 'Q300L'),
('Matrix', 'CRM19'),
('Axys', 'I9700'),
('Axys', 'CH100'),
('Axys', 'AS450'),
('Axys', 'CVLPX'),
('Axys', 'S860E'),
('Axys', 'MXSOC'),
('Axys', 'C200R'),
('Axys', 'CSCXM');


CREATE TABLE Registro_Ordini (

	Ordine char(5),
	Componente char(5),
	
	PRIMARY KEY(Ordine, Componente),
	
	FOREIGN KEY(Ordine) REFERENCES Ordine(ID)
						ON DELETE CASCADE
						ON UPDATE CASCADE,
						
	FOREIGN KEY(Componente) REFERENCES Componente(ID)
							ON DELETE NO ACTION
							ON UPDATE CASCADE

);

INSERT INTO Registro_Ordini (Ordine, Componente) VALUES
('A0001', 'I9700'),
('A0001', 'CH100'),
('A0001', 'CVLPX'),
('A0001', 'S860E'),
('A0001', 'MXSOC'),
('A0001', 'CSCXM'),
('A0002', 'Q300L');


/* QUERY */

/* 1) */

SELECT D.Nome, D.Cognome, D.CF, sum(EXTRACT(HOUR_MINUTE FROM M.Durata)) as Durata
FROM Manutenzione as M JOIN Dipendente as D ON M.Dipendente = D.CF 
WHERE EXTRACT(YEAR FROM M.Data) = EXTRACT(YEAR FROM CURDATE()) 
        AND EXTRACT(MONTH FROM M.Data) = EXTRACT(MONTH FROM CURDATE())
GROUP BY D.Nome;

/* 2) */

SELECT C.Nome, C.Cognome, C.Email
FROM Cliente as C LEFT JOIN Acquisto as A ON C.ID = A.Cliente
WHERE C.ID NOT IN (SELECT C.ID
                   FROM Cliente as C JOIN Acquisto as A ON  C.ID = A.Cliente
                   WHERE EXTRACT(YEAR FROM A.Data) = 
                         EXTRACT(YEAR FROM DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
                   GROUP BY C.ID     
                  );

/* 3) */


SELECT A.Negozio, C.ID, C.Nome, count(*) as Vendite
FROM Acquisto as A JOIN Acquisto_Componenti as AC ON A.ID = AC.ID_Acquisto 
     JOIN Composizione_Acquisto as CA ON AC.ID_Acquisto = CA.ID_Acquisto
     JOIN Componente as C ON CA.Componente = C.ID
GROUP BY C.ID
HAVING Vendite > 1
ORDER BY Negozio;

/* 4) */

DROP VIEW IF EXISTS TotAcquisti;
CREATE VIEW TotAcquisti(Negozio,NumeroAcquisti) as 
SELECT Negozio, count(*)
FROM Acquisto
GROUP BY Negozio;

SELECT N.ID, N.Indirizzo, avg(Stipendio) as Media_Stipendi, 
       TA.NumeroAcquisti as TotAcquisti
FROM Dipendente as D JOIN Negozio as N ON D.Negozio = N.ID
     JOIN Acquisto as A ON N.ID = A.Negozio
     JOIN TotAcquisti as TA ON TA.Negozio = N.ID
GROUP BY N.ID; 

/* 5) */

SELECT C.ID, C.Nome 
FROM Composizione_Acquisto as CA JOIN Componente as C ON CA.Componente = C.ID
WHERE CA.ID_Acquisto = '17 0000003' AND
      C.ID NOT IN (SELECT CM.Componente
                   FROM Acquisto as A JOIN Magazzino as M ON A.Negozio = M.Negozio
                        JOIN Contenuto_Magazzino as CM ON CM.Magazzino = M.ID
                   WHERE A.ID = '17 0000003'              
                  );
		
/* 6) */

DROP VIEW IF EXISTS AcquistiSingoli;

CREATE VIEW AcquistiSingoli(ID_Acquisto,ID_Componente,Totale) as
SELECT AC.ID_Acquisto, CA.Componente, A.Totale
FROM Acquisto_Componenti as AC JOIN Composizione_Acquisto as CA 
     ON AC.ID_Acquisto=CA.ID_Acquisto
     JOIN Acquisto as A ON AC.ID_Acquisto = A.ID
GROUP BY CA.ID_Acquisto
HAVING count(CA.Componente) = 1;

SELECT C.ID, C.Nome, C.Prezzo 
FROM Componente as C 
WHERE C.Prezzo < (SELECT AVG(AcquistiSingoli.Totale) 
                  FROM AcquistiSingoli 
                 );


/* INDICI */

CREATE INDEX idx_TipoComponenti ON Componente(Tipo);



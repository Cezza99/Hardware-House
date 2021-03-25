/*  Query 1) Restituisce Nome,Cognome,CF di manutentori che hanno eseguito almeno una manutenzione
*   nell'ultimo mese. Viene inoltre mostrata la durata in minuti di tale manutenzione affinche' il manutentore possa
*   essere retribuito in base al tempo dedicato a tali manutenzioni.
*/


SELECT D.Nome, D.Cognome, D.CF, sum(EXTRACT(HOUR_MINUTE FROM M.Durata)) as Durata
FROM Manutenzione as M JOIN Dipendente as D ON M.Dipendente = D.CF 
WHERE EXTRACT(YEAR FROM M.Data) = EXTRACT(YEAR FROM CURDATE()) 
        AND EXTRACT(MONTH FROM M.Data) = EXTRACT(MONTH FROM CURDATE())
GROUP BY D.Nome;


/*  Query 2) Restituisce Nome, Cognome e Email dei clienti che non hanno acquistato alcun prodotto negli      
*            ultimi 6 mesi.
*
*
*/

SELECT C.Nome, C.Cognome, C.Email
FROM Cliente as C LEFT JOIN Acquisto as A ON C.ID = A.Cliente
WHERE C.ID NOT IN (SELECT C.ID
                   FROM Cliente as C JOIN Acquisto as A ON  C.ID = A.Cliente
                   WHERE EXTRACT(YEAR FROM A.Data) = 
                         EXTRACT(YEAR FROM DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
                   GROUP BY C.ID     
                  );


/* Query 3) Per ogni negozio restituisce ID, Nome e Produttore dei componenti venduti piu' di una volta
*           da tale negozio.
*
*
*/


SELECT A.Negozio, C.ID, C.Nome, count(*) as Vendite
FROM Acquisto as A JOIN Acquisto_Componenti as AC ON A.ID = AC.ID_Acquisto 
     JOIN Composizione_Acquisto as CA ON AC.ID_Acquisto = CA.ID_Acquisto
     JOIN Componente as C ON CA.Componente = C.ID
GROUP BY C.ID
HAVING Vendite > 1
ORDER BY Negozio;


/* Query 4)
*
*/
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





/* Query 5) Restituisce i componenti relativi all'acquisto 17 000003 che non sono presenti in magazzino

*/

SELECT C.ID, C.Nome 
FROM Composizione_Acquisto as CA JOIN Componente as C ON CA.Componente = C.ID
WHERE CA.ID_Acquisto = '17 0000003' AND
      C.ID NOT IN (SELECT CM.Componente
                   FROM Acquisto as A JOIN Magazzino as M ON A.Negozio = M.Negozio
                        JOIN Contenuto_Magazzino as CM ON CM.Magazzino = M.ID
                   WHERE A.ID = '17 0000003'              
                  );

/* Query 6) Restituisce l'ID e il nome di tutti i componenti che risultano avere un prezzo minore della
            media del totale di tutti gli acquisti di componenti registrati, composti dall'acquisto di
            un singolo componente.
*/
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
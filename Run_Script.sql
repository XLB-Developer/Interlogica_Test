
--This needs to run just once in order to allow cmd commands
EXEC sp_configure 'show advanced options', '1'
RECONFIGURE
--Enabling xp_cmdshell
EXEC sp_configure 'xp_cmdshell', '1' 
RECONFIGURE


-- Targa e Marca delle Auto di cilindrata superiore a 2000 cc o di potenza superiore a 120 CV 
Select Targa, Marca
from AUTO 
where Cilindrata > 2000 OR Potenza > 88.26 


-- Nome del proprietario e Targa delle Auto di cilindrata superiore a 2000 cc oppure di potenza superiore a 120 CV 
Select Nome, Targa
from PROPRIETARI
left join AUTO on PROPRIETARI.CodF = AUTO.CodF
where Cilindrata > 2000 OR Potenza > 88.26


--Targa e Nome del proprietario delle Auto di cilindrata superiore a 2000 cc oppure di potenza superiore a 120 CV, assicurate presso la �SARA�
Select PROPRIETARI.Nome, Targa
from PROPRIETARI
left join AUTO on PROPRIETARI.CodF = AUTO.CodF
left join ASSICURAZIONI on AUTO.CodAss = ASSICURAZIONI.CodAss
where (Cilindrata > 2000 OR Potenza > 88.26) and ASSICURAZIONI.Nome ='SARA'


--Per ciascuna auto �Fiat�, la targa dell�auto ed il numero di sinistri in cui � stata coinvolta 
Select distinct(AUTO.Targa), count(*)
from AUTO
left join AUTOCOINVOLTE on AUTO.Targa = AUTOCOINVOLTE.Targa
where Marca='FIAT'
group by AUTO.Targa


--Per ciascuna auto coinvolta in pi� di un sinistro, la targa dell�auto, il nome dell�Assicurazione, ed il totale dei danni riportati
Select distinct(AUTOCOINVOLTE.Targa), count(*) as NSinistri, SUM(ImportoDanno) as TotDanni, Nome
from AUTOCOINVOLTE
left join AUTO on AUTOCOINVOLTE.Targa =AUTO.Targa 
left join ASSICURAZIONI on AUTO.CodAss = ASSICURAZIONI.CodAss
group by AUTOCOINVOLTE.Targa, Nome
having count(*)>1


-- CodF e Nome di coloro che possiedono pi� di un�auto 
select PROPRIETARI.CodF, Nome, count(Targa) as NAuto
from PROPRIETARI
left join Auto on PROPRIETARI.CodF = AUTO.CodF
group by PROPRIETARI.CodF, Nome
having count(Targa)>1






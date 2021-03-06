USE [AUTOMOTIVE_LB]
GO
/****** Object:  StoredProcedure [dbo].[SP_Raise10]    Script Date: 24/02/2022 10:46:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
--This SP is used to revaluate the claim by 10%
-- =============================================
ALTER PROCEDURE [dbo].[SP_Raise10]

AS
BEGIN
	SET NOCOUNT ON;
	--We are running script with condition ImportoRivalutato = Null in order to exclude all the CodS for which revaluation has already occurred.
	--Raising claim by 10% 
	UPDATE AUTOCOINVOLTE
	SET ImportoRivalutato = ImportoDanno * 1.1
	from SINISTRI_TEMP as sinistri
	left join AUTOCOINVOLTE on SINISTRI.CodS = AUTOCOINVOLTE.CodS
	left join AUTO on AUTOCOINVOLTE.Targa = AUTO.Targa
	left join PROPRIETARI on AUTO.CodF = PROPRIETARI.CodF
	left join ASSICURAZIONI on AUTO.CodAss = ASSICURAZIONI.CodAss
	where Giorno < '2021-01-20' and Residenza <> Sede and ImportoRivalutato = Null; 

	
END





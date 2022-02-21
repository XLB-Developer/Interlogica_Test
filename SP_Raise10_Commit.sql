USE [AUTOMOTIVE]
GO
/****** Object:  StoredProcedure [dbo].[SP_Raise10]    Script Date: 21/02/2022 10:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_Raise10_Commit]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	SET NOCOUNT ON;
	--Committing to Sinistri table
	TRUNCATE TABLE SINISTRI; -- this is to avoid breaking primary key condition
	INSERT INTO SINISTRI
	SELECT * FROM SINISTRI_TEMP;

	--Raising claim by 10% 
	UPDATE AUTOCOINVOLTE
	SET ImportoDanno = ImportoDanno * 1.1
	from SINISTRI_TEMP as sinistri
	left join AUTOCOINVOLTE on SINISTRI.CodS = AUTOCOINVOLTE.CodS
	left join AUTO on AUTOCOINVOLTE.Targa = AUTO.Targa
	left join PROPRIETARI on AUTO.CodF = PROPRIETARI.CodF
	left join ASSICURAZIONI on AUTO.CodAss = ASSICURAZIONI.CodAss
	where Giorno < '2021-01-20' and Residenza <> Sede;


END





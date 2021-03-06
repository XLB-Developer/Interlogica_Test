USE [AUTOMOTIVE_LB]
GO
/****** Object:  StoredProcedure [dbo].[SP_File_Upload]    Script Date: 24/02/2022 10:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- This SP is used to bulk upload a csv file and rollback all changes in case of error.
-- =============================================
ALTER PROCEDURE  [dbo].[SP_File_Upload]

AS
BEGIN
	
	SET NOCOUNT ON;
	--Deleting older log files
	DECLARE @cmd NVARCHAR(255) = 'xp_cmdshell "del C:\Github\Interlogica_Test\input\log_error.txt | del C:\Github\Interlogica_Test\input\log_error.txt.Error.Txt"'
		EXEC (@cmd);
	BEGIN TRANSACTION
		BEGIN TRY
			--This error handling will return error when input data is incorrect
			BULK INSERT SINISTRI
			FROM 'C:\Github\Interlogica_Test\input\Elenco_Sinistri.csv'
			WITH
			(
			  FIRSTROW = 2,
			  ERRORFILE='C:\Github\Interlogica_Test\input\log_error.txt', 
			  FORMAT='CSV',
			  ROWTERMINATOR = '\n',
			  KEEPNULLS,
			  MAXERRORS = 0
			);
	   
	COMMIT TRANSACTION

	END TRY	
	BEGIN CATCH
		ROLLBACK TRANSACTION
		--This error handling will return error message when commit doesn't work (maybe you're committing twice the same CodS
		 SELECT ERROR_NUMBER(), ERROR_MESSAGE();
		 SET @Cmd = 'echo. ' + cast(GETDATE() as varchar) + ' ' + cast(ERROR_MESSAGE() as varchar) + ' >> C:\Github\Interlogica_Test\input\commit_error.txt'
		 EXECUTE Master.dbo.xp_CmdShell  @Cmd
	END CATCH
	
	--Moving source file to processed folder
	Set @cmd = 'xp_cmdshell "del C:\Github\Interlogica_Test\processed\Elenco_Sinistri_processed.csv"'
	EXEC (@cmd);
	Set @cmd ='xp_cmdshell "move C:\Github\Interlogica_Test\input\Elenco_Sinistri.csv C:\Github\Interlogica_Test\processed\Elenco_Sinistri_processed.csv"'
	EXEC (@cmd);

	--Revaluating claim
	EXEC SP_Raise10;
END


USE [AUTOMOTIVE]
GO
/****** Object:  StoredProcedure [dbo].[SP_File_Upload]    Script Date: 21/02/2022 10:57:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- This SP is used to bulk upload a csv file and rollback all changes in case of error.
-- Note:in case of huge sized tables it might be useful not to rollback changes in order to save computation time and create a new upload file based on error output 
-- =============================================
ALTER PROCEDURE  [dbo].[SP_File_Upload]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	
	SET NOCOUNT ON;
	--Deleting older log files
	DECLARE @cmd NVARCHAR(255) = 'xp_cmdshell "del C:\Github\input\log_error.txt | del C:\Github\input\log_error.txt.Error.Txt"'
		EXEC (@cmd);
	BEGIN TRANSACTION
		BEGIN TRY
			TRUNCATE TABLE SINISTRI_TEMP;
			BULK INSERT SINISTRI_TEMP
			FROM 'C:\Github\input\Elenco_Sinistri.csv'
			WITH
			(
			  FIRSTROW = 2,
			  ERRORFILE='C:\Github\input\log_error.txt', 
			  FORMAT='CSV',
			  ROWTERMINATOR = '\n',
			  KEEPNULLS,
			  MAXERRORS = 0
			)
		COMMIT TRANSACTION

	END TRY	
	BEGIN CATCH
		ROLLBACK TRANSACTION
		 SELECT ERROR_NUMBER(), ERROR_MESSAGE();
	END CATCH

	--Moving source file to processed folder
	Set @cmd = 'xp_cmdshell "del C:\Github\processed\Elenco_Sinistri_processed.csv"'
	EXEC (@cmd);
	Set @cmd ='xp_cmdshell "move C:\Github\input\Elenco_Sinistri.csv C:\Github\processed\Elenco_Sinistri_processed.csv"'
	EXEC (@cmd);

	--Revaluating claim
	EXEC SP_Raise10_Commit;
END


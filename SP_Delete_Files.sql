USE [AUTOMOTIVE]
GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Files]    Script Date: 19/02/2022 09:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- This SP is used to delete the two error files created during upload SP and to copy input file to processed folder.
-- Note: Move can be used instead of Copy, but it's not wise to delete source file before successful completion.
-- =============================================
ALTER PROCEDURE [dbo].[SP_Delete_Files]

AS
BEGIN
	SET NOCOUNT ON;
	
		DECLARE @cmd NVARCHAR(MAX) = 'xp_cmdshell "del C:\Github\input\log_error.txt | del C:\Github\input\log_error.txt.Error.Txt"'
		EXEC (@cmd);
		set @cmd = 'xp_cmdshell "del C:\Github\processed\Elenco_Sinistri_processed.csv | copy C:\Github\input C:\Github\processed\Elenco_Sinistri_processed.csv"'
		EXEC (@cmd);
END

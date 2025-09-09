USE [Sales]
GO

/*
Autor:	Krason Karolina
Data:	12/05/2024
Opis:	Procedura wyswietlajaca sume kwot zakupow z poszczegolnych sklepow w podziale na tygodnie w roku

*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_purchase_weekly]
AS
BEGIN
	DECLARE 
	@tydzien NVARCHAR(max)
	,@tydzien_value  NVARCHAR(max)
	,@query NVARCHAR(max);

	DROP TABLE IF EXISTS #x;
	SELECT 
		ds.[name]
		,p.amount
		,datepart(week,purchase_date) AS tydzien
	INTO #x
	FROM 
		[dbo].[purchase] p
		INNER join dbo.dict_shop ds on p.id_shop = ds.id 

		/*
		select * from #x
		*/

	SET @tydzien = 	STUFF ((
    SELECT DISTINCT ',' + QUOTENAME (tydzien)
	  FROM #x
	FOR XML PATH(''), TYPE
	).VALUE('.','NVARCHAR(max)'),1,1,'')

	--print  @tydzien

	SET @tydzien_value = STUFF((
		SELECT DISTINCT ',isnull('+QUOTENAME (tydzien)+',0) AS' + QUOTENAME (tydzien)
		FROM #x
	FOR XML PATH(''), TYPE
	).VALUE('.','NVARCHAR(max)'),1,1,'')
	
	--print @tydzien_value
	
	SET @query = N'
	SELECT DISTINCT 
	[name]
	,'+@tydzien_value+'
	FROM(		
		    SELECT 
                [name]
		        ,'+@tydzien+'
		    FROM 
		        #x
		    PIVOT
		        (
                    SUM(amount)for tydzien IN('+ISNULL(@tydzien,0)+')) AS y
		        ) x'
		
EXEC sys.sp_executesql @query

END
;
GO



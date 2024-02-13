/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2014 (12.0.5207)
    Source Database Engine Edition : Microsoft SQL Server Standard Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2014
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [Dadosadv_D1]
GO

/****** Object:  View [dbo].[CUSTO_FECHAMENTO_COMPRAS]    Script Date: 02/11/2017 05:56:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[CUSTO_FECHAMENTO_COMPRAS]
AS

SELECT 
	CASE 	WHEN SB1.B1_AGREGCU = '1' THEN SB1.B1_TIPO + '_TER'			
			WHEN SB1.B1_AGREGCU <>  '1' AND SD1.D1_LOCAL = '99'		THEN SB1.B1_TIPO + '_WIP'
			WHEN SB1.B1_AGREGCU <>  '1' AND SD1.D1_LOCAL <> '99' AND SB1.B1_TIPO IN ('PI','PE')	THEN SB1.B1_TIPO + '_SEMI'
			WHEN SB1.B1_AGREGCU <>  '1' AND SD1.D1_LOCAL <> '99'	THEN SB1.B1_TIPO + '_GD'
			ELSE SB1.B1_TIPO	+ '_OTHER'							END AS 'DESCRICAO'

			,B1_COD
			,B1_DESC
			,B1_GRUPO
			,D1_TES
			,D1_DOC
			,LEFT(D1_DTDIGIT,6) AS PERIODO
			,ISNULL(SUM(D1_CUSTO),0) as valor
			, D1_FILIAL  AS FILIAL

FROM SD1010 AS SD1 WITH (NOLOCK)
INNER JOIN SB1010 AS SB1 WITH (NOLOCK)
			ON  SB1.B1_FILIAL	= ''
			AND	SB1.B1_COD		= SD1.D1_COD
			AND SB1.D_E_L_E_T_	= ''

INNER JOIN SF4010 AS SF4 WITH (NOLOCK)
			ON SF4.F4_FILIAL	= ''
			AND SF4.F4_CODIGO	= SD1.D1_TES
			AND SF4.D_E_L_E_T_	= ''

WHERE SD1.D1_FILIAL IN('01','06')
		AND SD1.D_E_L_E_T_ = ''
		AND SD1.D1_DTDIGIT >= '20140301' 
		AND SF4.F4_ESTOQUE	= 'S' 
		AND SF4.F4_PODER3	= 'N'
		AND SD1.D1_TIPO		<> 'D'
		AND LEFT(SD1.D1_CF,1) <> '3'		
GROUP BY SB1.B1_AGREGCU,SD1.D1_LOCAL,SB1.B1_TIPO, B1_COD,B1_DESC,B1_GRUPO,D1_TES,D1_DOC,LEFT(D1_DTDIGIT,6), D1_FILIAL


GO


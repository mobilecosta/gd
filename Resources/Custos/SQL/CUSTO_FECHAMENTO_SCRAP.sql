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

/****** Object:  View [dbo].[CUSTO_FECHAMENTO_SCRAP]    Script Date: 02/11/2017 06:26:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[CUSTO_FECHAMENTO_SCRAP]
AS

SELECT *,ROUND([Custo Total] / ([Qtde Bom]+[Qtde Perda] ),6) AS [Custo Medio], Round((([Custo Total] / ([Qtde Bom]+[Qtde Perda] )) *  [Qtde Perda]),6) As [Custo Perda]
 FROM (
SELECT 
	D3_FILIAL	AS [Filial]
	,D3_OP		AS [Ordem Producao]
	,D3_COD		AS [Produto]
	,B1_DESC	AS [Descricao]
	,D3_GRUPO	AS [Grupo]
	,B1_TIPO	AS [Tipo]
	,A1_GRPVEN	AS [Segmento]
	,B1_AGREGCU AS [Agrega Custo]
	,B1_APROPRI AS [Apropriacao]
	,LEFT(D3_EMISSAO,6) AS [AnoMes]
,SUM(D3_QUANT) AS [Qtde Bom]
,SUM(D3_PERDA) AS [Qtde Perda]
,SUM(D3_CUSTO1) AS [Custo Total]
FROM SD3010 AS SD3 WITH(NOLOCK)

JOIN SB1010 AS SB1 WITH(NOLOCK) ON SB1.B1_FILIAL = ''
AND SB1.B1_COD = SD3.D3_COD
AND SB1.D_E_L_E_T_ = ''

JOIN SA1010 AS SA1 WITH(NOLOCK) ON A1_FILIAL = ''
AND SA1.A1_COD = B1_CODCLI
AND SA1.D_E_L_E_T_ = ''

WHERE SD3.D3_FILIAL = '06'
AND SD3.D3_ESTORNO = ''
AND SD3.D_E_L_E_T_  =''
AND SD3.D3_OP <> ''
AND SD3.D3_CF = 'PR0'
AND SD3.D3_TIPO <> 'MO'
GROUP BY D3_FILIAL, D3_OP,D3_COD,B1_DESC,D3_GRUPO,B1_TIPO,A1_GRPVEN,B1_AGREGCU,B1_APROPRI,LEFT(D3_EMISSAO,6) 

UNION ALL


SELECT 
	BC_FILIAL	AS [Filial]
	,BC_OP		AS [Ordem Producao]
	,D3_COD		AS [Produto]
	,B1_DESC	AS [Descricao]
	,D3_GRUPO	AS [Grupo]
	,B1_TIPO	AS [Tipo]
	,A1_GRPVEN	AS [Segmento]
	,B1_AGREGCU AS [Agrega Custo]
	,B1_APROPRI AS [Apropriacao]
	,LEFT(BC_DATA,6) AS [AnoMes]
,SUM(0) AS [Qtde Bom]
,SUM(BC_QUANT) AS [Qtde Perda]
,SUM(D3_CUSTO1) AS [Custo Total]
FROM SBC010 AS SBC WITH(NOLOCK)

JOIN SD3010 AS SD3 ON SD3.D3_FILIAL = SBC.BC_FILIAL
AND SD3.D3_NUMSEQ = SBC.BC_SEQSD3
AND SD3.D_E_L_E_T_ = ''
AND SD3.D3_ESTORNO = ''
AND SD3.D3_TM = '999'


JOIN SB1010 AS SB1 WITH(NOLOCK) ON SB1.B1_FILIAL = ''
AND SB1.B1_COD = SD3.D3_COD
AND SB1.D_E_L_E_T_ = ''

JOIN SA1010 AS SA1 WITH(NOLOCK) ON A1_FILIAL = ''
AND SA1.A1_COD = B1_CODCLI
AND SA1.D_E_L_E_T_ = ''

WHERE SBC.BC_FILIAL = '06'
AND SBC.D_E_L_E_T_  =''
AND SB1.B1_TIPO <> 'MO'
GROUP BY BC_FILIAL, BC_OP,D3_COD,B1_DESC,D3_GRUPO,B1_TIPO,A1_GRPVEN,B1_AGREGCU,B1_APROPRI,LEFT(BC_DATA,6) 

) AS PERDAS


WHERE PERDAS.[Qtde Perda] > 0



GO


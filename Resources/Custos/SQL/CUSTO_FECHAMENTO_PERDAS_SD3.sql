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

/****** Object:  View [dbo].[CUSTO_FECHAMENTO_PERDAS_SD3]    Script Date: 02/11/2017 06:24:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CUSTO_FECHAMENTO_PERDAS_SD3]
AS
SELECT D3_CUSTO1,D3_PERDA,D3_QUANT,D3_TM,D3_COD,B1_DESC,B1_AGREGCU,B1_GRUPO,B1_APROPRI,D3_OP,LEFT(D3_EMISSAO,6) AS PERIODO,D3_FILIAL AS FILIAL FROM SD3010
JOIN SB1010 ON SB1010.B1_FILIAL = '  '
AND B1_COD = D3_COD
AND SB1010.D_E_L_E_T_ = ''
WHERE D3_FILIAL IS NOT NULL
AND D3_EMISSAO >= '20140301'
AND D3_PERDA <>0
AND D3_ESTORNO <>'S'
AND SD3010.D_E_L_E_T_ = ''
GO


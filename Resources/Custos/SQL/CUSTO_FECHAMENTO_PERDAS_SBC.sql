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

/****** Object:  View [dbo].[CUSTO_FECHAMENTO_PERDAS_SBC]    Script Date: 02/11/2017 06:09:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CUSTO_FECHAMENTO_PERDAS_SBC]
AS
SELECT D3_CUSTO1,D3_QUANT,D3_COD,B1_DESC,B1_AGREGCU,B1_GRUPO,B1_APROPRI,BC_OP,LEFT(BC_DATA,6) AS PERIODO,BC_FILIAL AS FILIAL from SBC010
JOIN SD3010 ON D3_FILIAL IN ('01','06')
AND BC_SEQSD3 = D3_NUMSEQ
AND BC_FILIAL = D3_FILIAL 
AND SD3010.D_E_L_E_T_ = ''
AND SD3010.D3_ESTORNO = ''
AND SD3010.D3_TM = '999'
JOIN SB1010 ON SB1010.B1_FILIAL = '  '
AND B1_COD = D3_COD
AND SB1010.D_E_L_E_T_ = ''
WHERE BC_FILIAL IN('01','06')
AND BC_DATA >= '20140301'
AND SBC010.D_E_L_E_T_ = ''
GO


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

/****** Object:  View [dbo].[CUSTO_FECHAMENTO_TM_900_400]    Script Date: 02/11/2017 06:26:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CUSTO_FECHAMENTO_TM_900_400]
AS
SELECT B1_COD,
		B1_DESC,
		B1_GRUPO,
		B1_AGREGCU,
		B1_APROPRI,
		B1_TIPO,
		D3_FILIAL,
		D3_TM,
		D3_COD,
		D3_UM,
		D3_CF,
		D3_EMISSAO,
		D3_OP,
		D3_LOCAL,
		D3_QUANT,
		D3_PERDA,
		D3_GRUPO,
		D3_DOC,
		D3_CUSTO1,
		D3_CC,
		D3_CONTA,
		D3_PARCTOT,
		D3_ESTORNO,
		D3_NUMSEQ,
		D3_SEGUM,
		D3_QTSEGUM,
		D3_NIVEL,
		D3_TIPO,
		D3_USUARIO,
		D3_CHAVE,
		D3_IDENT,
		D3_SEQCALC,
		D3_DTVALID,
		D3_TRT,
		LEFT(D3_EMISSAO,6) AS PERIODO,D3_FILIAL AS FILIAL
FROM SD3010 AS SD3
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3.D_E_L_E_T_  ='' 
AND D3_OP = '' 
AND D3_TM IN ('900','400') 
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IS NOT NULL
AND SD3.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_EMISSAO >='20140301'
GO


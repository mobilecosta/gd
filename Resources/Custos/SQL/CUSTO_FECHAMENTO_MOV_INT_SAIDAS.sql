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

/****** Object:  View [dbo].[CUSTO_FECHAMENTO_MOV_INT_SAIDAS]    Script Date: 02/11/2017 06:09:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[CUSTO_FECHAMENTO_MOV_INT_SAIDAS]
AS

SELECT 'MP_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MP'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MP_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MP'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MP_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MP'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL



SELECT 'EB_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'EB'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'EB_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'EB'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'EB_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'EB'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MX_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MX'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MX_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MX'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MX_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MX'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'PI_SEMI' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO IN ('PI','PE')
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'PI_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO IN ('PI','PE')
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'PI_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO in ('PI','PE')
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL

SELECT 'ME_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'ME'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'ME_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'ME'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'ME_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'ME'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'PA_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'PA'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'PA_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'PA'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'PA_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'PA'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MM_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MM'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MM_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MM'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MM_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MM'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'SV_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'SV'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'SV_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'SV'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'SV_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'SV'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MC_GD' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MC'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MC_WIP' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MC'
AND B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL = '99'
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  UNION ALL


SELECT 'MC_TER' AS DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor,D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON 
	B1_FILIAL = ''
AND B1_COD = D3_COD
AND B1_TIPO = 'MC'
AND B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN ('01','06')
AND D3_LOCAL NOT IN ('99')
AND YEAR(D3_EMISSAO) >= YEAR(GETDATE())- 2  
AND D3_ESTORNO= ''
AND (D3_TM NOT IN ('900','400','499','999') 
OR (D3_TM = '999' AND D3_DOC LIKE 'INVENT%')  
OR (D3_TM = '900' AND B1_APROPRI = 'D'))  
AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM > '499'
AND SD3010.D_E_L_E_T_ = ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6), D3_FILIAL  


GO


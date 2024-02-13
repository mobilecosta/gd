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

/****** Object:  View [dbo].[CUSTO_MOV_INTERNO_ENTRADA_SD3]    Script Date: 02/11/2017 06:28:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CUSTO_MOV_INTERNO_ENTRADA_SD3]
AS
SELECT 'MP_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499'  

AND B1_TIPO = 'MP'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'MP_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MP'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'MP_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MP'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'EB_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'EB'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'EB_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'EB'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'EB_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'EB'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'MX_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MX'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'MX_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MX'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'MX_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MX'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'PI_SEMI' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO in ('PI','PE')
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'PI_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO IN ('PI','PE')
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all



SELECT 'PI_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO in ('PI','PE')
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'ME_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'ME'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all
SELECT 'ME_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'ME'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'ME_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'ME'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'PA_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'PA'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'PA_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'PA'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'PA_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'PA'
and B1_AGREGCU ='1'
AND SB1.D_E_L_E_T_ = ''




WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all


SELECT 'MM_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MM'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'MM_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MM'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'MM_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MM'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL 


union all



SELECT 'SV_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'SV'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'SV_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'SV'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'SV_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'SV'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL 


union all



SELECT 'MC_GD' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MC'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'MC_WIP' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MC'
and B1_AGREGCU <> '1'
AND SB1.D_E_L_E_T_ = ''
WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL = '99'
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL  union all

SELECT 'MC_TER' as DESCRICAO, B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6) AS PERIODO,ISNULL(SUM(D3_CUSTO1),0) as valor, D3_FILIAL AS FILIAL 
FROM SD3010
INNER JOIN SB1010 AS SB1 ON B1_COD = D3_COD
AND SD3010.D_E_L_E_T_  ='' AND D3_OP = '' AND D3_TM NOT IN ('900','400','499','999') AND D3_OP = '' AND D3_TIPO <>'MO' AND D3_TM <= '499' 
AND B1_TIPO = 'MC'
and B1_AGREGCU = '1'
AND SB1.D_E_L_E_T_ = ''

WHERE D3_FILIAL IN( '01','06') 
AND SD3010.D_E_L_E_T_ = '' AND D3_ESTORNO= ''
AND D3_LOCAL NOT IN ('99','3','4','5','6','7','8','9','0,','00','0','1','11','14','13','15','16','17','18','19','22','25','28','29','30','31','32','37','39','40','44','47','52','54','57','58','60','65','66','71','74','78','87','88','89','0.','8Q','O','OK','OP','TA','VC','  ')
AND D3_EMISSAO >=  '20140301' AND D3_ESTORNO= ''

GROUP BY B1_COD,B1_DESC,B1_GRUPO,D3_TM,D3_DOC,LEFT(D3_EMISSAO,6),D3_FILIAL 
GO


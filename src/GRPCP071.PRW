#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "topconn.ch"

/*
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GRPCP071  ³ Autor ³ Josuel Silva          ³ Data ³22/03/2017³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina de impressao do Resumo de Custo Por OP.  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 								                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nil                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GRPCP071                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user function GRPCP071()
	oReport := ReportDef()
	oReport:PrintDialog()
return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Josuel Silva           ³ Data ³22/03/2017³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GRPCP071                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

	Local oReport
	Local oSection1
	local cTitulo 	 := 'Resumo do Custo por OP'
	Local cPictQuant := PesqPict('SD3','D3_QUANT')
	Local cPictValor := "@E 999,999,999,999,999.999999"
	Local nQtdTam    := TamSX3('D3_QUANT')[1]
	Local nVltTam    := TamSX3('D3_CUSTO1')[1]

	//Declaracao de Variaveis

	Local cDesc1  := "Este programa tem como objetivo gerar um relatorio "
	Local cDesc1  += "com o resumo do custo por OP."
	Local cDesc1  += ""

	Private cPerg	:= Padr("GRPCP071",10)
	Private cCaminho	:= GetTempPath() //Retorna o caminho da pasta temporária do sistema atual.

	oReport := TReport():New('GRPCP071', cTitulo,cPerg, {|oReport| PrintReport(oReport,"SC2",oSection1)},cDesc1)
	oReport:SetEdit(.F.)
	oReport:SetDevice(4)
	oReport:nEnvironment 	:= 2
	oReport:lEmptyLineExcel := .T.
	oReport:SetLandscape()

	AtuSX1(cPerg)
	Pergunte(oReport:uParam,.F.)

	oSection1 := TRSection():New(oReport,"GRPCP071",{"SD3","SB1","SC2"})
	oSection1:SetEdit(.F.)
	oSection1:SetEditCell(.F.)
	oSection1:SetTotalInLine(.T.)

	TRCell():new(oSection1, "PRODUTO"  	, "", 'Produto'			,PesqPict('SB1',"B1_COD"		)	,TamSX3("B1_COD"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	, /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "DESCRICAO" 	, "", 'Descricao'		,PesqPict('SB1',"B1_DESC"		)	,TamSX3("B1_DESC"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "TIPO"  	, "", 'TP'			,PesqPict('SB1',"B1_TIPO"		)	,TamSX3("B1_TIPO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "GRUPO"  	, "", 'Grupo'			,PesqPict('SB1',"B1_GRUPO"		)	,TamSX3("B1_GRUPO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "UM"  		, "", 'UM'			,PesqPict('SB1',"B1_UM"			)	,TamSX3("B1_UM"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "QTDE"  	, "", 'Qtde'			,cPictQuant	,nQtdTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "PERDA"  	, "", 'Perda'			,cPictQuant	,nQtdTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "INSUMO" 	, "", 'Insumo(F)'		,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "MOD" 		, "", 'MOD(G)'			,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "GGFH" 		, "", 'GGF(H)'			,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "TOTALDIR" 	, "", 'TOTAL DIR.'		,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "MOI" 		, "", 'MOI(I)'			,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "GGFJ" 		, "", 'GGF(J)'			,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "TOTALIND" 	, "", 'TOTAL IND.'		,cPictValor 	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "TOTALGERAL"	, "", 'Total(FGHIJ)'		,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "CUSTO" 	, "", 'C.Unitario'		,cPictValor	,nVltTam,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "ORDEM" 	, "", 'Ordem Producao'		,PesqPict('SD3',"D3_OP"		)	,TamSX3("D3_OP"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )
	TRCell():new(oSection1, "TPOP" 		, "", 'Tipo Op'			,PesqPict('SC2',"C2_TIPO"	)	,TamSX3("B1_GRUPO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,/*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/, /*lBold*/ )

	oSection1:SetTotalInLine(.T.)
	TRFunction():New(oSection1:Cell("QTDE")    	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("PERDA") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("INSUMO") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("MOD") 		,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("GGFH") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("TOTALDIR") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("MOI") 		,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("GGFJ") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("TOTALIND") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)
	TRFunction():New(oSection1:Cell("TOTALGERAL") 	,NIL 	,"SUM",/*oBreak1*/,,cPictValor,/*uFormula*/,.F.,.T.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PrintReport ³ Autor ³Josuel Silva         ³ Data ³22/03/2017³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GRPCP071			                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function PrintReport(oReport,cAliasSC2,oSection1)

	Private oSection1 		:= oReport:Section(1)

	IF	oReport:oExcel <> Nil
		oReport:oExcel:CbgColor2Line 	:= "#C3C3C3"
		oReport:oExcel:CbgColorLine	:= "#FFFFFF"
		oReport:oExcel:CBGCOLORHEADER 	:= "#104E8B"
		oReport:oExcel:CBGCOLORTITLE  	:= "#FFFFFF"
	EndIF

	dEmissDe		:= dtos(MV_PAR05)
	dEmissAte		:= dtos(MV_PAR06)

	MakeSqlExpr(oReport:uParam)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	oReport:Section(1):BeginQuery()

	cAliasSC2	:= GetNextAlias()

	BeginSql Alias cAliasSC2
	%NoParser%
	SELECT C2_FILIAL,C2_NUM, C2_ITEM, C2_SEQUEN, C2_ITEMGRD,C2_TIPO,C2_PRODUTO, B1_DESC, B1_TIPO, B1_GRUPO,B1_UM

	, ISNULL( (SELECT SUM(D3_PERDA) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND D3_TM ='010'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_COD = C2_PRODUTO
	),0) AS PERDASD3

	, ISNULL( (SELECT SUM(D3_QUANT) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND D3_TM ='010'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_COD = C2_PRODUTO
	),0) AS C2_QUANTSD3

	, ISNULL( (SELECT SUM(D3_CUSTO1) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND LEFT(D3_CF,2) = 'RE'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_TIPO <> 'MO'
	),0) AS COLUNAF

	, ISNULL( (SELECT SUM(D3_CUSTO1) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND LEFT(D3_CF,2) = 'RE'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_TIPO = 'MO' AND RIGHT(RTRIM(D3_COD),2) = '01' AND D3_COD  NOT IN ('MOD73019901')
	),0) AS COLUNAG

	, ISNULL( (SELECT SUM(D3_CUSTO1) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND LEFT(D3_CF,2) = 'RE'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_TIPO = 'MO' AND RIGHT(RTRIM(D3_COD),2) = '02' AND D3_COD  NOT IN ('MOD73019902')
	),0) AS COLUNAH

	, ISNULL( (SELECT SUM(D3_CUSTO1) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND LEFT(D3_CF,2) = 'RE'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_TIPO = 'MO' AND D3_COD  IN ('MOD73019901')
	),0) AS COLUNAI

	, ISNULL( (SELECT SUM(D3_CUSTO1) FROM %Table:SD3% AS SD3
	WHERE D3_FILIAL = %xfilial:SD3%
	AND D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND LEFT(D3_CF,2) = 'RE'
	AND D3_OP = C2_NUM + C2_ITEM + C2_SEQUEN + C2_ITEMGRD
	AND D3_EMISSAO BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND D3_TIPO = 'MO' AND D3_COD  IN ('MOD73019902')
	),0) AS COLUNAJ

	FROM  %table:SC2% AS SC2
	INNER JOIN	%table:SB1% AS SB1
	ON	SB1.B1_FILIAL = %xfilial:SB1%
	AND	SB1.B1_COD		= SC2.C2_PRODUTO
	AND	SB1.%notDel%

	INNER JOIN %table:SD3% AS SD3SC2 ON SD3SC2.D3_FILIAL = SC2.C2_FILIAL
	AND SD3SC2.D3_OP = SC2.C2_NUM+SC2.C2_ITEM+SC2.C2_SEQUEN+SC2.C2_ITEMGRD
	AND SD3SC2.%notDel%
	AND SD3SC2.D3_ESTORNO = ''

	WHERE SC2.C2_FILIAL = %xfilial:SC2%
	AND SC2.C2_PRODUTO 		BETWEEN %exp:MV_PAR01% 		AND %exp:MV_PAR02%
	AND SD3SC2.D3_EMISSAO 		BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND SB1.B1_GRUPO		BETWEEN %exp:MV_PAR09% 		AND %exp:MV_PAR10%
	AND SB1.B1_TIPO			BETWEEN %exp:MV_PAR11% 		AND %exp:MV_PAR12%
	AND SC2.C2_TIPO			BETWEEN %exp:MV_PAR07% 		AND %exp:MV_PAR08%
	AND SC2.C2_NUM+SC2.C2_ITEM+SC2.C2_SEQUEN BETWEEN %exp:MV_PAR03% 		AND %exp:MV_PAR04%
	AND SC2.%notDel%
	GROUP BY C2_FILIAL,C2_NUM, C2_ITEM, C2_SEQUEN, C2_ITEMGRD,C2_TIPO,C2_PRODUTO, B1_DESC, B1_TIPO, B1_GRUPO,B1_UM
	ORDER BY C2_FILIAL,C2_PRODUTO, C2_NUM, C2_ITEM, C2_SEQUEN,C2_ITEMGRD

	EndSql

	//ConOut(GetLastQuery()[2])

	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

	DbSelectArea(cAliasSC2)
	(cAliasSC2)->(dbGoTop())
	oReport:SetMeter(RecCount())

	oSection1:Init()

	While (cAliasSC2)->(!Eof())
		If oReport:Cancel()
			DbSelectArea(cAliasSC2)
			(cAliasSC2)->(dbCloseArea())
			Exit
		EndIf
		oReport:IncMeter()

		nDireto		:= (cAliasSC2)->(COLUNAG+COLUNAH)
		nIndireto	:= (cAliasSC2)->(COLUNAI+COLUNAJ)
		nTotal		:= nDireto + nIndireto + (cAliasSC2)->COLUNAF

		IF (cAliasSC2)->C2_QUANTSD3 <> 0
			nCusto		:=  nTotal / (cAliasSC2)->C2_QUANTSD3
		Else
			nCusto	:= 0
		EndIF

		oSection1:Cell("PRODUTO" 	) :SetValue(ALLTRIM((cAliasSC2)->C2_PRODUTO))
		oSection1:Cell("DESCRICAO" 	) :SetValue(ALLTRIM((cAliasSC2)->B1_DESC))
		oSection1:Cell("TIPO" 		) :SetValue((cAliasSC2)->B1_TIPO)
		oSection1:Cell("GRUPO" 		) :SetValue((cAliasSC2)->B1_GRUPO)
		oSection1:Cell("UM" 		) :SetValue((cAliasSC2)->B1_UM)
		oSection1:Cell("QTDE" 		) :SetValue((cAliasSC2)->C2_QUANTSD3)
		oSection1:Cell("PERDA" 		) :SetValue((cAliasSC2)->PERDASD3)
		oSection1:Cell("INSUMO" 	) :SetValue((cAliasSC2)->COLUNAF)
		oSection1:Cell("MOD" 		) :SetValue((cAliasSC2)->COLUNAG)
		oSection1:Cell("GGFH" 		) :SetValue((cAliasSC2)->COLUNAH)
		oSection1:Cell("TOTALDIR" 	) :SetValue(nDireto)
		oSection1:Cell("MOI" 		) :SetValue((cAliasSC2)->COLUNAI)
		oSection1:Cell("GGFJ" 		) :SetValue((cAliasSC2)->COLUNAJ)
		oSection1:Cell("TOTALIND" 	) :SetValue(nIndireto)
		oSection1:Cell("TOTALGERAL" 	) :SetValue(nTotal)
		oSection1:Cell("CUSTO" 		) :SetValue(nCusto)
		oSection1:Cell("ORDEM" 		) :SetValue((cAliasSC2)->(C2_NUM+'.'+C2_ITEM+'.'+C2_SEQUEN))

		Do Case
			Case ((cAliasSC2)->C2_TIPO == "P")
			oSection1:Cell("TPOP" 		) :SetValue('Prod')
			Case ((cAliasSC2)->C2_TIPO == "S")
			oSection1:Cell("TPOP" 		) :SetValue('Serv')
			Case ((cAliasSC2)->C2_TIPO == "R")
			oSection1:Cell("TPOP" 		) :SetValue('ReIm')
			Case ((cAliasSC2)->C2_TIPO == "M")
			oSection1:Cell("TPOP" 		) :SetValue('Manu')
			Case ((cAliasSC2)->C2_TIPO == "I")
			oSection1:Cell("TPOP" 		) :SetValue('Impr')
			Case ((cAliasSC2)->C2_TIPO == "E")
			oSection1:Cell("TPOP" 		) :SetValue('Embe')
			Case ((cAliasSC2)->C2_TIPO == "G")
			oSection1:Cell("TPOP" 		) :SetValue('RepP')
			Case ((cAliasSC2)->C2_TIPO == "H")
			oSection1:Cell("TPOP" 		) :SetValue('RemM')
			OtherWise
			oSection1:Cell("TPOP" 		) :SetValue('')
		EndCase

		oSection1:PrintLine()
		(cAliasSC2)->(dbSkip())
		oReport:IncMeter()
	EndDo

	oSection1:Finish()
	DbSelectArea(cAliasSC2)
	(cAliasSC2)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ AtuSX1   º Autor ³ TOTVS Protheus     º Data ³  04/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Descricao³ Atualizacao do SX1 - Perguntas                             ³±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³ Uso      ³ AtuSX1     - Gerado por EXPORDIC / Upd. V.4.10.7 EFS       ³±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtuSX1(cPerg)
	Local aArea    := GetArea()
	Local aAreaDic := SX1->( GetArea() )
	Local aEstrut  := {}
	Local aStruDic := SX1->( dbStruct() )
	Local aDados   := {}
	Local nI       := 0
	Local nJ       := 0
	Local nTam1    := Len( SX1->X1_GRUPO )
	Local nTam2    := Len( SX1->X1_ORDEM )

	aEstrut := {  "X1_GRUPO"  , "X1_ORDEM"  , "X1_PERGUNT", "X1_PERSPA" , "X1_PERENG" , "X1_VARIAVL", "X1_TIPO"   , ;
	"X1_TAMANHO", "X1_DECIMAL", "X1_PRESEL" , "X1_GSC"    , "X1_VALID"  , "X1_VAR01"  , "X1_DEF01"  , ;
	"X1_DEFSPA1", "X1_DEFENG1", "X1_CNT01"  , "X1_VAR02"  , "X1_DEF02"  , "X1_DEFSPA2", "X1_DEFENG2", ;
	"X1_CNT02"  , "X1_VAR03"  , "X1_DEF03"  , "X1_DEFSPA3", "X1_DEFENG3", "X1_CNT03"  , "X1_VAR04"  , ;
	"X1_DEF04"  , "X1_DEFSPA4", "X1_DEFENG4", "X1_CNT04"  , "X1_VAR05"  , "X1_DEF05"  , "X1_DEFSPA5", ;
	"X1_DEFENG5", "X1_CNT05"  , "X1_F3"     , "X1_PYME"   , "X1_GRPSXG" , "X1_HELP"   , "X1_PICTURE", ;
	"X1_IDFIL"   }

	aAdd( aDados, {cPerg,'01','Produto de ?'		,'Produto de ?'			,'Produto de ?'			,'MV_CH0','C',15,0,0,'G','','MV_PAR01','','','','','','','','','','','','','','','','','','','','','','','','','SB1'	,'','','','',''} )
	aAdd( aDados, {cPerg,'02','Produto Ate ?'		,'Produto Ate ?'		,'Produto Ate ?'		,'MV_CH0','C',15,0,0,'G','','MV_PAR02','','','','','','','','','','','','','','','','','','','','','','','','','SB1'	,'','','','',''} )
	aAdd( aDados, {cPerg,'03','Da OP 	?'		,'Da OP ?'			,'Da OP ?'			,'MV_CH0','C',11,0,0,'G','','MV_PAR03','','','','','','','','','','','','','','','','','','','','','','','','','SC2'	,'','','','',''} )
	aAdd( aDados, {cPerg,'04','Ate a OP ?'			,'Ate a OP ?'			,'Ate a OP ?'			,'MV_CH0','C',11,0,0,'G','','MV_PAR04','','','','','','','','','','','','','','','','','','','','','','','','','SC2'	,'','','','',''} )
	aAdd( aDados, {cPerg,'05','Data de ?'			,'Data de ?'			,'Data de ?'			,'MV_CH0','D',8,0,0,'G','','MV_PAR05','','','','','','','','','','','','','','','','','','','','','','','','',''	,'','','','',''} )
	aAdd( aDados, {cPerg,'06','Data Ate ?'			,'Data Ate ?'			,'Data Ate ?'			,'MV_CH0','D',8,0,0,'G','','MV_PAR06','','','','','','','','','','','','','','','','','','','','','','','','',''	,'','','','',''} )
	aAdd( aDados, {cPerg,'07','Do Tipo de Producao?'	,'Do Tipo de Producao?'		,'Do Tipo de Producao?'		,'MV_CH0','C',1,0,0,'G','','MV_PAR07','','','','','','','','','','','','','','','','','','','','','','','','',''	,'','','','',''} )
	aAdd( aDados, {cPerg,'08','Ate Tipo de Producao?'	,'Ate Tipo de Producao?'	,'Ate Tipo de Producao?'	,'MV_CH0','C',1,0,0,'G','','MV_PAR08','','','','','','','','','','','','','','','','','','','','','','','','',''	,'','','','',''} )
	aAdd( aDados, {cPerg,'09','Grupo de ?'			,'Grupo de ?'			,'Grupo de ?'			,'MV_CH0','C',04,0,0,'G','','MV_PAR09','','','','','','','','','','','','','','','','','','','','','','','','','SBM'	,'','','','',''} )
	aAdd( aDados, {cPerg,'10','Grupo Ate ?'			,'Grupo Ate ?'			,'Grupo Ate ?'			,'MV_CH0','C',04,0,0,'G','','MV_PAR10','','','','','','','','','','','','','','','','','','','','','','','','','SBM'	,'','','','',''} )
	aAdd( aDados, {cPerg,'11','Do Tipo de Produto?'		,'Do Tipo de Produto?'		,'Do Tipo de Produto?'		,'MV_CH0','C',02,0,0,'G','','MV_PAR11','','','','','','','','','','','','','','','','','','','','','','','','','02'	,'','','','',''} )
	aAdd( aDados, {cPerg,'12','Ate Tipo de Produto?'	,'Ate Tipo de Produto?'		,'Ate Tipo de Produto?'		,'MV_CH0','C',02,0,0,'G','','MV_PAR12','','','','','','','','','','','','','','','','','','','','','','','','','02'	,'','','','',''} )

	// Atualizando dicionário
	//
	dbSelectArea( "SX1" )
	SX1->( dbSetOrder( 1 ) )

	For nI := 1 To Len( aDados )
		If !SX1->( dbSeek( PadR( aDados[nI][1], nTam1 ) + PadR( aDados[nI][2], nTam2 ) ) )
			RecLock( "SX1", .T. )
			For nJ := 1 To Len( aDados[nI] )
				If aScan( aStruDic, { |aX| PadR( aX[1], 10 ) == PadR( aEstrut[nJ], 10 ) } ) > 0
					SX1->( FieldPut( FieldPos( aEstrut[nJ] ), aDados[nI][nJ] ) )
				EndIf
			Next nJ
			MsUnLock()
		EndIf
	Next nI

	RestArea( aAreaDic )
	RestArea( aArea )

Return NIL
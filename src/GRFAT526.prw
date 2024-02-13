#INCLUDE "PROTHEUS.CH"
#include "topconn.ch"

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥GCFAT511  ∫Autor  ≥Josuel Silva        ∫ Data ≥19/11/2015   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Relatorio de Faturamento para Custos.                       ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

User Function GRFAT526()

	Private cPerg	:= Padr("GRFAT526",10)

	AtuSX1(cPerg)
	IF Pergunte(cPerg,.T.)
		If  mv_par05 > mv_par06
			MsgStop("A Data Final n„o pode ser menor que a Data Inicial !","Data Inv·lida")
			Return
		ElseIF empty(mv_par05) .OR. empty(mv_par06)
			MsgStop("A Data Inicial e Final tem que ser Informada !","Data Inv·lida")
			Return
		EndIF

		oReport := ReportDef()
		oReport	:Print()

	EndiF

Return

/*/

‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥ReportDef ≥ Autor ≥Josuel Silva-SServices ≥ Data ≥19/11/2015≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥A funcao estatica ReportDef devera ser criada para todos os ≥±±
±±≥          ≥relatorios que poderao ser agendados pelo usuario.          ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥Nenhum                                                      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥GRFAT526                                                    ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function ReportDef(cPerg)

	Local 		oReport
	Local 		oSection1
	Local 		oSection2
	Local 		oSection3
	Local 		oBreak
	local 		cTitulo := 'Relatorio de Faturamento'
	Local 		cAliasNF := GetNextAlias()
	Local 		cArqXML := "Faturamento_"+Dtos(MSDate())+StrTran(Time(),":","")

	Private cPerg	   	:= Padr("GRFAT526",10)
	Private cCaminho	:= "C:\TEMP\"

	oReport := TReport():New(cArqXML, cTitulo,cPerg, {|oReport| PrintReport(oReport,cAliasNF,oSection1,oSection2,oSection3)},"Este relatorio ira imprimir a relacao de Faturamento por Cliente.")

	oReport:SetDevice(4)
	oReport:SetEnvironment(2)
	oReport:lParamPage 		:= .F.
	oReport:lUserInfo		:= .F.
	oReport:lPreview		:= .T.
	oReport:lHeaderVisible 	:= .T.
	oReport:nDevice 		:= 4
	oReport:nEnvironment 	:= 2
	oReport:lEdit 			:= .F.
	oReport:lXlsHeader 		:= .F.
	oReport:lXlsTable 		:= .T.
	oReport:CFONTBODY 		:= "Arial"
	oReport:lBold			:= .F.
	oReport:nFontBody		:= 9
	oReport:lEmptyLineExcel := .T.

	//Se n„o existir a pasta, criar a pasta de destino do Excel.
	MAKEDIR(cCaminho)
	oReport:cDir 		:=	cCaminho
	oReport:CREPORT 	:= 	cCaminho+cArqXML+".xml"
	oReport:CFILE 	:= 	cCaminho+cArqXML+".xml"

	oReport:ShowHeader()
	oReport:SetLandScape(.T.)
	oReport:DisableOrientation()

	Pergunte(oReport:uParam,.F.)

	oSection1 := TRSection():New(oReport,"Faturamento",{"SB1","SA1","SD2","SC6"})

	oSection1:SetTotalInLine(.F.)
	oSection1:SetEdit(.F.)
	oSection1:SetEditCell(.F.)
	oSection1:lHeaderVisible = .F.
	oSection1:SetBorder('')
	oSection1:SetBorder("ALL",,,.T.)

	TRCell():new(oSection1, "D2_FILIAL"  	, "SD2", 'Filial'		,PesqPict('SD2',"D2_FILIAL"		)	,TamSX3("D2_FILIAL"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_DOC"   		, "SD2", 'N.Fiscal'		,PesqPict('SD2',"D2_DOC"		)	,TamSX3("D2_DOC"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_SERIE"   	, "SD2", 'Serie NF'		,PesqPict('SD2',"D2_SERIE"		)	,TamSX3("D2_SERIE"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_ITEM"   	, "SD2", 'Item NF'		,PesqPict('SD2',"D2_ITEM"		)	,TamSX3("D2_ITEM"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_COD"  		, "SD2", 'Produto'		,PesqPict('SD2',"D2_COD"		)	,TamSX3("D2_COD"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_DESC"   	, "SB1", 'Descricao'	,PesqPict('SB1',"B1_DESC"		)	,TamSX3("B1_DESC"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_GRUPO"   	, "SD2", 'Grupo'		,PesqPict('SD2',"D2_GRUPO"		)	,TamSX3("D2_GRUPO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_TIPO"   	, "SB1", 'Tipo'			,PesqPict('SB1',"B1_TIPO"		)	,TamSX3("B1_TIPO"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_QUANT"   	, "SD2", 'Quantidade'	,PesqPict('SD2',"D2_QUANT"		)	,TamSX3("D2_QUANT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_PRCVEN"   	, "SD2", 'Preco Venda'	,PesqPict('SD2',"D2_PRCVEN"		)	,TamSX3("D2_PRCVEN"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_TOTAL"   	, "SD2", 'Total'		,PesqPict('SD2',"D2_TOTAL"		)	,TamSX3("D2_TOTAL"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_CUSTO1"   	, "SD2", 'Custo Total'	,PesqPict('SD2',"D2_CUSTO1"		)	,TamSX3("D2_CUSTO1"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B2_CM1"   		, "SB2", 'Custo Unit.'	,PesqPict('SB2',"B2_CM1"		)	,TamSX3("B2_CM1"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_TES"   		, "SD2", 'TES'			,PesqPict('SD2',"D2_TES"		)	,TamSX3("D2_TES"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "F4_DUPLIC"   	, "SF4", 'Duplicata'	,PesqPict('SF4',"F4_DUPLIC"		)	,TamSX3("F4_DUPLIC"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_CF"   		, "SD2", 'CFOP'			,PesqPict('SD2',"D2_CF"			)	,TamSX3("D2_CF"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_CLIENTE"  	, "SD2", 'Cliente'		,PesqPict('SD2',"D2_CLIENTE"	)	,TamSX3("D2_CLIENTE"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_LOJA"   	, "SD2", 'Loja'			,PesqPict('SD2',"D2_LOJA"		)	,TamSX3("D2_LOJA"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "A1_GRPVEN"   	, "SA1", 'Segmento'		,PesqPict('SA1',"A1_GRPVEN"		)	,TamSX3("A1_GRPVEN"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "A1_NREDUZ"   	, "SA1", 'Razao Social'	,PesqPict('SA1',"A1_NREDUZ"		)	,TamSX3("A1_NREDUZ"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_TIPO"   	, "SD2", 'Tipo NF'		,PesqPict('SD2',"D2_TIPO"		)	,TamSX3("D2_TIPO"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_EMISSAO"  	, "SD2", 'Dt.Emissao'	,PesqPict('SD2',"D2_EMISSAO"	)	,TamSX3("D2_EMISSAO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_PEDIDO"  	, "SD2", 'Pedido Venda'	,PesqPict('SD2',"D2_PEDIDO"		)	,TamSX3("D2_PEDIDO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_ITEMPV"   	, "SD2", 'Item PV'		,PesqPict('SD2',"D2_ITEMPV"		)	,TamSX3("D2_ITEMPV"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_VALLIQ"  	, "SD2", 'Fat.Liquido'	,PesqPict('SD2',"D2_VALBRUT"	)	,TamSX3("D2_VALBRUT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_VALBRUT"  	, "SD2", 'Fat.Bruto'	,PesqPict('SD2',"D2_VALBRUT"	)	,TamSX3("D2_VALBRUT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "C6_INPUTFI"  	, "SC6", 'Input File'	,PesqPict('SC6',"C6_INPUTFI"	)	,TamSX3("C6_INPUTFI"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_GRPGDM"  	, "SB1", 'Prod Group'	,PesqPict('SB1',"B1_GRPGDM"		)	,TamSX3("B1_GRPGDM"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_DESCGRP"  	, "SB1", 'Group Descri'	,PesqPict('SB1',"B1_DESCGRP"	)	,TamSX3("B1_DESCGRP"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_PXFANT"   	, "SB1", 'Modulo'		,PesqPict('SB1',"B1_PXFANT"		)	,TamSX3("B1_PXFANT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_PXSUBCL"  	, "SB1", 'Sub-Cliente'	,PesqPict('SB1',"B1_PXSUBCL"	)	,TamSX3("B1_PXSUBCL"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	TRCell():new(oSection1, "D2_DOCREM"   		, "SD2", 'NF Remessa'			,PesqPict('SD2',"D2_DOC"		)	,TamSX3("D2_DOC"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_SERIEREM"   	, "SD2", 'Serie NF Remessa'		,PesqPict('SD2',"D2_SERIE"		)	,TamSX3("D2_SERIE"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_ITEMREM"   		, "SD2", 'Item NF Remessa'		,PesqPict('SD2',"D2_ITEM"		)	,TamSX3("D2_ITEM"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_CODREM"  		, "SD2", 'Produto Remessa'		,PesqPict('SD2',"D2_COD"		)	,TamSX3("D2_COD"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_DESCREM"   		, "SB1", 'Descricao Remessa'	,PesqPict('SB1',"B1_DESC"		)	,TamSX3("B1_DESC"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_TIPOREM"   		, "SB1", 'Tipo Produto'			,PesqPict('SB1',"B1_TIPO"		)	,TamSX3("B1_TIPO"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_QUANTREM"   	, "SD2", 'Qtde Remessa'			,PesqPict('SD2',"D2_QUANT"		)	,TamSX3("D2_QUANT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_PRCVENREM"   	, "SD2", 'Preco Remessa'		,PesqPict('SD2',"D2_PRCVEN"		)	,TamSX3("D2_PRCVEN"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_TOTALREM"   	, "SD2", 'Total Remessa'		,PesqPict('SD2',"D2_TOTAL"		)	,TamSX3("D2_TOTAL"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_CUSTO1REM"   	, "SD2", 'Custo Total Remessa'	,PesqPict('SD2',"D2_CUSTO1"		)	,TamSX3("D2_CUSTO1"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B2_CM1REM"   		, "SB2", 'Custo Unit Remessa'	,PesqPict('SB2',"B2_CM1"		)	,TamSX3("B2_CM1"			)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_PEDIDOREM"   	, "SD2", 'Pedido Venda Remessa'	,PesqPict('SD2',"D2_PEDIDO"		)	,TamSX3("D2_PEDIDO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_ITEMPVREM"   	, "SD2", 'Item PV Remessa'		,PesqPict('SD2',"D2_ITEMPV"		)	,TamSX3("D2_ITEMPV"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "D2_EMISSAOREM"		, "SD2", 'Dt Emissao Rem.'		,PesqPict('SD2',"D2_EMISSAO"	)	,TamSX3("D2_EMISSAO"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_GRPGDMREM"  	, "SB1", 'Prod Group Rem.'		,PesqPict('SB1',"B1_GRPGDM"		)	,TamSX3("B1_GRPGDM"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection1, "B1_DESCGRPREM"  	, "SB1", 'Group Desc.Rem'		,PesqPict('SB1',"B1_DESCGRP"	)	,TamSX3("B1_DESCGRP"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	oSection1:Cell("D2_FILIAL"	)	:SetHeaderAlign("CENTER")
	oSection1:Cell("D2_QUANT"	)	:SetHeaderAlign("RIGHT"	)
	oSection1:Cell("D2_PRCVEN"	)	:SetHeaderAlign("RIGHT"	)
	oSection1:Cell("D2_TOTAL"	)	:SetHeaderAlign("RIGHT"	)
	oSection1:Cell("D2_CUSTO1"	)	:SetHeaderAlign("RIGHT"	)
	oSection1:Cell("D2_EMISSAO"	)	:SetHeaderAlign("CENTER")

	oSection2 := TRSection():New(oReport,"Resumo",{"SG1"})

	oSection2:SetTotalInLine(.F.)
	oSection2:SetEdit(.F.)
	oSection2:SetEditCell(.F.)
	oSection2:lHeaderVisible = .F.
	oSection2:SetBorder('')
	oSection2:SetBorder("ALL",,,.T.)

	TRCell():new(oSection2, "G1_COD"	, "SG1", 'Produto Acabado'	,PesqPict('SG1',"G1_COD"		)	,TamSX3("G1_COD"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "DESCPAI"	, "SB1", 'Desc. PA'			,PesqPict('SB1',"B1_DESC"   	)	,TamSX3("B1_DESC"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "PRDGPAI"  	, "SB1", 'Prod Group PA'	,PesqPict('SB1',"B1_GRPGDM"		)	,TamSX3("B1_GRPGDM"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection2, "DESCGRPPAI","SB1", 'Desc.Group PA'		,PesqPict('SB1',"B1_DESCGRP"	)	,TamSX3("B1_DESCGRP"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection2, "SEGMENTO"  , "SA1", 'Segmento'			,PesqPict('SA1',"A1_GRPVEN"		)	,TamSX3("A1_GRPVEN"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	TRCell():new(oSection2, "TIPO"		, "SB1", 'Classificacao'	,PesqPict('SB1',"B1_TIPO"   	)	,TamSX3("B1_TIPO"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"CENTER" 		/*cAlign*/	,/*lLineBreak*/	,"CENTER" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "NIVEL"		, "SB1", 'Nivel'			,PesqPict('SB1',"B1_TIPO"   	)	,TamSX3("B1_TIPO"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"CENTER" 		/*cAlign*/	,/*lLineBreak*/	,"CENTER" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )

	TRCell():new(oSection2, "G1_COMP"	, "SG1", 'Componente'		,PesqPict('SG1',"G1_COMP"		)	,TamSX3("G1_COMP"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "DESCCOMP"	, "SB1", 'Desc.Componente'	,PesqPict('SB1',"B1_DESC"   	)	,TamSX3("B1_DESC"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "PRDGCOMP"  , "SB1", 'Prod Group'		,PesqPict('SB1',"B1_GRPGDM"		)	,TamSX3("B1_GRPGDM"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection2, "DESCGRPCOMP","SB1", 'Desc.Group'		,PesqPict('SB1',"B1_DESCGRP"	)	,TamSX3("B1_DESCGRP"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	TRCell():new(oSection2, "GRUPO"		, "SB1", 'Grupo'			,PesqPict('SB1',"B1_GRUPO"   	)	,TamSX3("B1_GRUPO"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"CENTER" 		/*cAlign*/	,/*lLineBreak*/	,"CENTER" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "B2_QUANT"	, "SB2", 'Quantidade'		,PesqPict('SB2',"B2_QATU"		)	,TamSX3("B2_QATU"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 		/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "CUSTOM"  	, "SB2", 'Custo Medio'		,PesqPict('SB2',"B2_CM1"		)	,TamSX3("B2_CM1"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 	/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "CUSTOTOT"  , "SB2", 'Custo Material'		,PesqPict('SB2',"B2_CM1"		)	,TamSX3("B2_CM1"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 	/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "CUSTOMOD"  , "SD3", 'Custo MOD'		,PesqPict('SD3',"D3_CUSTO1"		)	,TamSX3("D3_CUSTO1"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 	/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection2, "VALLIQ"  	, "SD2", 'Fat.Liquido Venda',PesqPict('SD2',"D2_VALBRUT"	)	,TamSX3("D2_VALBRUT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	oSection3 := TRSection():New(oReport,"Resumo-PA-GO",{"SG1"})

	oSection3:SetTotalInLine(.F.)
	oSection3:SetEdit(.F.)
	oSection3:SetEditCell(.F.)
	oSection3:lHeaderVisible = .F.
	oSection3:SetBorder('')
	oSection3:SetBorder("ALL",,,.T.)

	TRCell():new(oSection3, "B1_COD"	, "SG1", 'Produto Servico'	,PesqPict('SB1',"B1_COD"		)	,TamSX3("B1_COD"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "SERVICO"	, "SB1", 'Desc.Servico'		,PesqPict('SB1',"B1_DESC"   	)	,TamSX3("B1_DESC"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )

	TRCell():new(oSection3, "G1_COD"	, "SG1", 'Produto Acabado'	,PesqPict('SG1',"G1_COD"		)	,TamSX3("G1_COD"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "DESCPAI"	, "SB1", 'Desc. PA'			,PesqPict('SB1',"B1_DESC"   	)	,TamSX3("B1_DESC"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "PRDGPAI"  	, "SB1", 'Prod Group PA'	,PesqPict('SB1',"B1_GRPGDM"		)	,TamSX3("B1_GRPGDM"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection3, "DESCGRPPAI" ,"SB1", 'Desc.Group PA'	,PesqPict('SB1',"B1_DESCGRP"	)	,TamSX3("B1_DESCGRP"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection3, "SEGMENTO"  , "SA1", 'Segmento'			,PesqPict('SA1',"A1_GRPVEN"		)	,TamSX3("A1_GRPVEN"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	TRCell():new(oSection3, "TIPO"		, "SB1", 'Classificacao'	,PesqPict('SB1',"B1_TIPO"   	)	,TamSX3("B1_TIPO"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"CENTER" 		/*cAlign*/	,/*lLineBreak*/	,"CENTER" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "NIVEL"		, "SB1", 'Nivel'			,PesqPict('SB1',"B1_TIPO"   	)	,TamSX3("B1_TIPO"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"CENTER" 		/*cAlign*/	,/*lLineBreak*/	,"CENTER" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )

	TRCell():new(oSection3, "G1_COMP"	, "SG1", 'Componente'		,PesqPict('SG1',"G1_COMP"		)	,TamSX3("G1_COMP"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "DESCCOMP"	, "SB1", 'Desc.Componente'	,PesqPict('SB1',"B1_DESC"   	)	,TamSX3("B1_DESC"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"LEFT" 		/*cAlign*/	,/*lLineBreak*/	,"LEFT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "PRDGCOMP"  , "SB1", 'Prod Group'		,PesqPict('SB1',"B1_GRPGDM"		)	,TamSX3("B1_GRPGDM"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():new(oSection3, "DESCGRPCOMP","SB1", 'Desc.Group'		,PesqPict('SB1',"B1_DESCGRP"	)	,TamSX3("B1_DESCGRP"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

	TRCell():new(oSection3, "GRUPO"		, "SB1", 'Grupo'			,PesqPict('SB1',"B1_GRUPO"   	)	,TamSX3("B1_GRUPO"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"CENTER" 		/*cAlign*/	,/*lLineBreak*/	,"CENTER" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "B2_QUANT"	, "SB2", 'Quantidade'		,PesqPict('SB2',"B2_QATU"		)	,TamSX3("B2_QATU"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 		/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "CUSTOM"  	, "SB2", 'Custo Medio'		,PesqPict('SB2',"B2_CM1"		)	,TamSX3("B2_CM1"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 	/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "CUSTOTOT"  , "SB2", 'Custo Material'	,PesqPict('SB2',"B2_CM1"		)	,TamSX3("B2_CM1"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 	/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "CUSTOMOD"  , "SD3", 'Custo MOD'		,PesqPict('SD3',"D3_CUSTO1"		)	,TamSX3("D3_CUSTO1"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT" 	/*cAlign*/	,/*lLineBreak*/	,"RIGHT" /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F./*lBold*/ )
	TRCell():new(oSection3, "VALLIQ"  	, "SD2", 'Fat.Liquido Venda',PesqPict('SD2',"D2_VALBRUT"	)	,TamSX3("D2_VALBRUT"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

Return(oReport)

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Programa  ≥PrintReport ≥ Autor ≥Josuel-SServices     ≥ Data ≥19/11/2015≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥A funcao estatica ReportPrint devera ser criada para todos  ≥±±
±±≥          ≥os relatorios que poderao ser agendados pelo usuario.       ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Retorno   ≥Nenhum                                                      ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Parametros≥ExpO1: Objeto Report do Relatorio                           ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥ Uso      ≥ GRFAT526			                                          ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

Static Function PrintReport(oReport,cAliasNF,oSection1,oSection2,oSection3)

	Local cCodigo 	:= ""
	Local cQRY		:= ""
	Local aFiliais	:= {}
	Local nLoop		:= 0
	//Local cFilAtu 	:= cFilAnt
	Local aRemessa	:= {}
	Local aMods		:= {}

	Private oSection1 		:= oReport:Section(1)
	Private oSection2 		:= oReport:Section(2)
	Private oSection3 		:= oReport:Section(3)

	IF	oReport:oExcel <> Nil
		oReport:oExcel:CbgColor2Line 	:= "#C3C3C3"
		oReport:oExcel:CbgColorLine		:= "#FFFFFF"
		oReport:oExcel:CBGCOLORHEADER 	:= "#104E8B"
		oReport:oExcel:CBGCOLORTITLE  	:= "#FFFFFF"
	EndIF

	//	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//	//≥ Monta o array para todas as filiais desta empresa                     ≥
	//	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	//	aAreaSM0 := SM0->( GetArea() )
	//	cCodigo  := SM0->M0_CODIGO
	//
	//	SM0->( dbSetOrder( 1 ) )
	//	If SM0->( dbSeek( cCodigo ) )
	//		While !SM0->( Eof() ) .And. SM0->M0_CODIGO == cCodigo
	//			If FWGETCODFILIAL >= mv_par07 .And. FWGETCODFILIAL <= mv_par08
	//				aAdd( aFiliais, FWGETCODFILIAL )
	//			EndIf
	//			SM0->( dbSkip())
	//		EndDo
	//	EndIf
	//	RestArea( aAreaSM0 )

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Transforma parametros Range em expressao SQL                            ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

	cClienteDe		:= mv_par01
	cLojaDe		:= mv_par02
	cClienteAte	:= mv_par03
	cLojaAte		:= mv_par04
	dEmissDe		:= dtos(mv_par05)
	dEmissAte		:= dtos(mv_par06)

	MakeSqlExpr(oReport:uParam)

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Query do relatÛrio da secao 1                                       ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	oReport:Section(1):BeginQuery()

	//	For nLoop := 1 to Len( aFiliais )
	//		cFilAnt 	:= aFiliais[nLoop]
	//		cAliasQbr	:= aFiliais[nLoop]

	cAliasNF	:= GetNextAlias()

	BeginSql Alias cAliasNF
	%NoParser%

	SELECT	D2_FILIAL		AS FILIAL		,D2_DOC		AS NFISCAL
	,D2_SERIE		AS SERIENF						,D2_ITEM		AS ITEMNF
	,D2_COD			AS PRODUTO						,B1_DESC		AS DESCRICAO
	,D2_GRUPO		AS GRUPO					,D2_QUANT		AS QUANTIDADE
	,D2_PRCVEN		AS PRECO					,D2_TOTAL		AS TOTAL
	,D2_CUSTO1		AS CUSTO					,D2_TES		AS TES
	,F4_DUPLIC		AS DUPLICATA				,F4_TEXTO		AS TEXTO
	,D2_CF			AS CFOP						,D2_CLIENTE	AS CLIENTE
	,D2_LOJA		AS LOJA						,A1_GRPVEN		AS SEGMENTO
	,A1_NREDUZ		AS APELIDO					,D2_TIPO		AS TIPONF
	,D2_EMISSAO	AS EMISSAO						,C6_INPUTFI	AS INFILE
	,D2_PEDIDO		AS PEDIDO					,D2_ITEMPV		AS ITEMPV
	,D2_VALBRUT	AS VALBRUTO					,B1_GRPGDM
	,B1_DESCGRP	,B1_TIPO						,B1_PXFANT		,B1_PXSUBCL
	,(D2_VALBRUT) - (D2_VALIMP5+D2_VALIMP6+(CASE WHEN D2_VALISS > 0 THEN D2_VALISS ELSE D2_VALICM END)+D2_VALIPI+D2_ICMSRET) AS VALLIQ
	,CASE 	WHEN SC6.C6_INPUTFI = '' AND A1_GRPVEN NOT IN ('ID','GO','CS') THEN ''
	WHEN SC6.C6_INPUTFI <> '' AND A1_GRPVEN IN ('ID','GO','CS')  THEN
	ISNULL ((	SELECT	SC6REM.C6_FILIAL +'|'+ SC6REM.C6_CLI +'|'+ SC6REM.C6_LOJA +'|'+ SC6REM.C6_NUM +'|'+ SC6REM.C6_PRODUTO +'|'+ SC6REM.C6_ITEM
	FROM	%table:SC6% AS SC6REM
	WHERE	SC6REM.C6_FILIAL	= SC6.C6_FILIAL
	AND SC6REM.C6_INPUTFI  	= SC6.C6_INPUTFI
	AND SC6REM.C6_SIPSQ 		= SC6.C6_SIPSQ
	AND SC6REM.C6_QTDVEN		= SC6.C6_QTDVEN
	AND SC6REM.C6_NUM			NOT IN (SD2.D2_PEDIDO)
	AND SC6REM.C6_INPUTFI <> ''
	AND SC6REM.%notDel% ),'')
	ELSE '' END PVGOV
	,CASE 	WHEN SC6.C6_INPUTFI <> '' AND SA1.A1_GRPVEN NOT IN ('FI','PA','FS')	THEN ''
	WHEN SA1.A1_GRPVEN NOT IN ('FI','ID','PA','GO','FS','CS') THEN ''	ELSE	(ISNULL ((	SELECT	Z9F.Z9F_FILIAL	+'|'+ Z9F.Z9F_CLIFAT		+'|'+ Z9F.Z9F_LJFAT	+'|'+ Z9F.Z9F_PVPSRV +'|'+ Z9F.Z9F_ITPSRV
	FROM	%table:Z9F% AS Z9F
	WHERE		Z9F.Z9F_FILIAL	= SC6.C6_FILIAL
	AND Z9F.Z9F_PVPSRV 	= SC6.C6_NUM
	AND Z9F.Z9F_CLIFAT 	= SC6.C6_CLI
	AND Z9F.Z9F_LJFAT 	= SC6.C6_LOJA
	AND Z9F.Z9F_CODPSR	= SC6.C6_PRODUTO
	AND Z9F.Z9F_ITPSRV 	= SC6.C6_ITEM
	AND Z9F.%notDel%
	GROUP BY Z9F.Z9F_FILIAL	,Z9F.Z9F_CLIFAT,Z9F.Z9F_LJFAT,Z9F.Z9F_PVPSRV,Z9F.Z9F_ITPSRV

	),'')
	) END PVPAYMENT

	FROM  %table:SD2% AS SD2

	INNER JOIN	%table:SA1% AS SA1
	ON	SA1.A1_FILIAL 	= %xfilial:SA1%
	AND	SA1.A1_COD			= SD2.D2_CLIENTE
	AND	SA1.A1_LOJA		= SD2.D2_LOJA
	AND	SA1.%notDel%

	INNER JOIN	%table:SB1% AS SB1
	ON	SB1.B1_FILIAL = %xfilial:SB1%
	AND	SB1.B1_COD		= SD2.D2_COD
	AND	SB1.%notDel%

	INNER JOIN  %table:SC6% AS SC6
	ON	SC6.C6_FILIAL	= SD2.D2_FILIAL
	AND SC6.C6_NUM	= SD2.D2_PEDIDO
	AND SC6.C6_ITEM	= SD2.D2_ITEMPV
	AND SC6.C6_CLI	= SD2.D2_CLIENTE
	AND SC6.C6_LOJA	= SD2.D2_LOJA
	AND SC6.%notDel%

	INNER  JOIN %table:SF4% AS SF4
	ON	 SF4.F4_FILIAL = %xfilial:SF4%
	AND	 SF4.F4_CODIGO = SD2.D2_TES
	AND	 SF4.%notDel%
	WHERE  SD2.D2_FILIAL = %xfilial:SD2%
	AND SD2.D2_CLIENTE 	BETWEEN %exp:cClienteDe% 	AND %exp:cClienteAte%
	AND SD2.D2_LOJA 		BETWEEN %exp:cLojaDe% 		AND %exp:cLojaAte%
	AND SD2.D2_EMISSAO 	BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND SD2.%notDel%
	AND SF4.F4_DUPLIC 	= 'S'
	AND SD2.D2_TIPO 		IN('N','C','I')
	AND SA1.A1_GRPVEN		<> '99'

	UNION ALL

	SELECT D1_FILIAL 	AS FILIAL		,D1_DOC 		AS NFISCAL
	,D1_SERIE		AS SERIENF			,D1_ITEM 		AS ITEMNF
	,D1_COD 		AS PRODUTO			,B1_DESC		AS DESCRICAO
	,D1_GRUPO 	AS GRUPO				,D1_QUANT 		AS QUANTIDADE
	,D1_VUNIT 	AS PRECO				,D1_TOTAL 		AS TOTAL
	,D1_CUSTO 	AS CUSTO				,D1_TES 		AS TES
	,F4_DUPLIC 	AS DUPLICATA 			,F4_TEXTO 		AS TEXTO
	,D1_CF 		AS CFOP 				,D1_FORNECE 	AS CLIENTE
	,D1_LOJA 		AS LOJA			 	,'' 			AS SEGMENTO
	,A1_NREDUZ	AS APELIDO 			,D1_TIPO 		AS TIPONF
	,D1_EMISSAO	AS EMISSAO 			,'' 			AS INFILE
	,D1_PEDIDO 	AS PEDIDO 			,D1_ITEMPV 	AS ITEMPV
	,(D1_TOTAL+D1_ICMSRET+D1_VALIPI+D1_VALFRE) 		AS VALBRUTO
	,B1_GRPGDM ,B1_DESCGRP,	B1_TIPO
	,B1_PXFANT ,B1_PXSUBCL
	,(D1_TOTAL+D1_ICMSRET+D1_VALIPI+D1_VALFRE) - (D1_VALIMP5+D1_VALIMP6+(CASE WHEN D1_VALISS > 0 THEN D1_VALISS ELSE D1_VALICM END)+D1_VALIPI+D1_ICMSRET) AS VALLIQ
	,'' AS PVGOV
	,'' AS PVPAYMENT

	FROM  %table:SD1% AS SD1

	INNER JOIN	%table:SA1% AS SA1
	ON	SA1.A1_FILIAL 	= %xfilial:SA1%
	AND	SA1.A1_COD			= SD1.D1_FORNECE
	AND	SA1.A1_LOJA		= SD1.D1_LOJA
	AND	SA1.%notDel%

	INNER JOIN	%table:SB1% AS SB1
	ON	SB1.B1_FILIAL = %xfilial:SB1%
	AND	SB1.B1_COD		= SD1.D1_COD
	AND	SB1.%notDel%

	INNER  JOIN %table:SF4% AS SF4
	ON	 SF4.F4_FILIAL = %xfilial:SF4%
	AND	 SF4.F4_CODIGO = SD1.D1_TES
	AND	 SF4.%notDel%

	WHERE  SD1.D1_FILIAL = %xfilial:SD1%
	AND SD1.D1_FORNECE 	BETWEEN %exp:cClienteDe% 	AND %exp:cClienteAte%
	AND SD1.D1_LOJA 		BETWEEN %exp:cLojaDe% 		AND %exp:cLojaAte%
	AND SD1.D1_EMISSAO 	BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND SD1.%notDel%
	AND SF4.F4_DUPLIC 	= 'S'
	AND SD1.D1_TIPO 		= 'D'
	AND SA1.A1_GRPVEN		<> '99'
	ORDER BY D2_FILIAL,D2_DOC,D2_SERIE,D2_ITEM,D2_COD

	EndSql

	//MEMOWRITE("C:/TEMP/GRFAT999_"+cAliasNF+ ".SQL",GetLastQuery()[2])

	oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

	DbSelectArea(cAliasNF)
	(cAliasNF)->(dbGoTop())
	oReport:SetMeter(RecCount())

	oSection1:Init()
	oSection1:SetHeaderSection(.T.)
	oSection1:SetHeaderBreak(.F.)

	While (cAliasNF)->(!Eof())
		If oReport:Cancel()
			DbSelectArea(cAliasNF)
			dbCloseArea()
			Exit
		EndIf
		oReport:IncMeter()

		oSection1:Cell("D2_FILIAL" 	) :Show()
		oSection1:Cell("D2_DOC" 	) :Show()
		oSection1:Cell("D2_SERIE" 	) :Show()
		oSection1:Cell("D2_ITEM" 	) :Show()
		oSection1:Cell("D2_COD"		) :Show()
		oSection1:Cell("B1_DESC" 	) :Show()
		oSection1:Cell("D2_GRUPO" 	) :Show()
		oSection1:Cell("B1_TIPO" 	) :Show()
		oSection1:Cell("D2_QUANT" 	) :Show()
		oSection1:Cell("D2_PRCVEN" 	) :Show()
		oSection1:Cell("D2_TOTAL" 	) :Show()
		oSection1:Cell("D2_CUSTO1" 	) :Show()
		oSection1:Cell("B2_CM1" 	) :Show()
		oSection1:Cell("D2_TES" 	) :Show()
		oSection1:Cell("F4_DUPLIC" 	) :Show()
		oSection1:Cell("D2_CF" 		) :Show()
		oSection1:Cell("D2_CLIENTE" ) :Show()
		oSection1:Cell("D2_LOJA" 	) :Show()
		oSection1:Cell("A1_GRPVEN" 	) :Show()
		oSection1:Cell("A1_NREDUZ" 	) :Show()
		oSection1:Cell("D2_TIPO" 	) :Show()
		oSection1:Cell("D2_EMISSAO" ) :Show()
		oSection1:Cell("D2_PEDIDO" 	) :Show()
		oSection1:Cell("D2_ITEMPV" 	) :Show()
		oSection1:Cell("D2_VALBRUT" ) :Show()
		oSection1:Cell("D2_VALLIQ" 	) :Show()
		oSection1:Cell("C6_INPUTFI" ) :Show()
		oSection1:Cell("B1_GRPGDM" 	) :Show()
		oSection1:Cell("B1_DESCGRP" ) :Show()
		oSection1:Cell("B1_PXFANT" 	) :Show()
		oSection1:Cell("B1_PXSUBCL"	) :Show()

		oSection1:Cell("D2_FILIAL" 	) :SetValue((cAliasNF)->FILIAL		)
		oSection1:Cell("D2_DOC" 		) :SetValue((cAliasNF)->NFISCAL	)
		oSection1:Cell("D2_SERIE" 	) :SetValue((cAliasNF)->SERIENF		)
		oSection1:Cell("D2_ITEM" 	) :SetValue((cAliasNF)->ITEMNF 		)
		oSection1:Cell("D2_COD"		) :SetValue((cAliasNF)->PRODUTO		)
		oSection1:Cell("B1_DESC" 	) :SetValue((cAliasNF)->DESCRICAO 	)
		oSection1:Cell("D2_GRUPO" 	) :SetValue((cAliasNF)->GRUPO		)
		oSection1:Cell("B1_TIPO" 	) :SetValue((cAliasNF)->B1_TIPO		)
		oSection1:Cell("D2_QUANT" 	) :SetValue((cAliasNF)->QUANTIDADE	)
		oSection1:Cell("D2_PRCVEN" 	) :SetValue((cAliasNF)->PRECO		)
		oSection1:Cell("D2_TOTAL" 	) :SetValue((cAliasNF)->TOTAL		)
		oSection1:Cell("D2_CUSTO1" 	) :SetValue((cAliasNF)->CUSTO		)

		IF (cAliasNF)->CUSTO == 0 .Or. (cAliasNF)->QUANTIDADE == 0
			oSection1:Cell("B2_CM1" 	) :SetValue(0	)
		Else
			oSection1:Cell("B2_CM1" 	) :SetValue((cAliasNF)->CUSTO / (cAliasNF)->QUANTIDADE )
		EndIF

		oSection1:Cell("D2_TES" 		) :SetValue((cAliasNF)->TES  	)
		oSection1:Cell("F4_DUPLIC" 	) :SetValue((cAliasNF)->DUPLICATA	)
		oSection1:Cell("D2_CF" 		) :SetValue((cAliasNF)->CFOP   		)
		oSection1:Cell("D2_CLIENTE" ) :SetValue((cAliasNF)->CLIENTE		)
		oSection1:Cell("D2_LOJA" 	) :SetValue((cAliasNF)->LOJA 		)
		oSection1:Cell("A1_GRPVEN" 	) :SetValue((cAliasNF)->SEGMENTO	)
		oSection1:Cell("A1_NREDUZ" 	) :SetValue((cAliasNF)->APELIDO		)
		oSection1:Cell("D2_TIPO" 	) :SetValue((cAliasNF)->TIPONF 		)
		oSection1:Cell("D2_EMISSAO" ) :SetValue(DTOC(STOD((cAliasNF)->EMISSAO)))
		oSection1:Cell("D2_PEDIDO" 	) :SetValue((cAliasNF)->PEDIDO		)
		oSection1:Cell("D2_ITEMPV" 	) :SetValue((cAliasNF)->ITEMPV		)
		oSection1:Cell("D2_VALBRUT" ) :SetValue(IIF((cAliasNF)->TIPONF=='D',((cAliasNF)->VALBRUTO *(-1)),(cAliasNF)->VALBRUTO))
		oSection1:Cell("D2_VALLIQ" 	) :SetValue(IIF((cAliasNF)->TIPONF=='D',((cAliasNF)->VALLIQ *(-1)),(cAliasNF)->VALLIQ))
		oSection1:Cell("C6_INPUTFI" ) :SetValue((cAliasNF)->INFILE		)
		oSection1:Cell("B1_GRPGDM" 	) :SetValue((cAliasNF)->B1_GRPGDM	)
		oSection1:Cell("B1_DESCGRP" ) :SetValue((cAliasNF)->B1_DESCGRP	)
		oSection1:Cell("B1_PXFANT" 	) :SetValue((cAliasNF)->B1_PXFANT	)
		oSection1:Cell("B1_PXSUBCL"	) :SetValue((cAliasNF)->B1_PXSUBCL	)

		If !( Empty((cAliasNF)->PVGOV)) .Or. !(EmptY((cAliasNF)->PVPAYMENT))
			GR426Remessa((cAliasNF)->PVGOV,(cAliasNF)->PVPAYMENT,dEmissAte,@oSection1)
		Else

			oSection1:Cell("D2_DOCREM" 		) :SetValue('')
			oSection1:Cell("D2_SERIEREM" 	) :SetValue('')
			oSection1:Cell("D2_ITEMREM" 	) :SetValue('')
			oSection1:Cell("D2_CODREM"		) :SetValue('')
			oSection1:Cell("B1_DESCREM" 	) :SetValue('')
			oSection1:Cell("B1_TIPOREM"		) :SetValue('')

			oSection1:Cell("D2_QUANTREM" 	) :SetValue(0 )
			oSection1:Cell("D2_PRCVENREM" 	) :SetValue(0 )
			oSection1:Cell("D2_TOTALREM" 	) :SetValue(0 )
			oSection1:Cell("D2_CUSTO1REM" 	) :SetValue(0 )
			oSection1:Cell("B2_CM1REM" 		) :SetValue(0 )
			oSection1:Cell("D2_PEDIDOREM" 	) :SetValue('')
			oSection1:Cell("D2_ITEMPVREM" 	) :SetValue('')
			oSection1:Cell("D2_EMISSAOREM" 	) :SetValue('')
			oSection1:Cell("B1_GRPGDMREM" 	) :SetValue('')
			oSection1:Cell("B1_DESCGRPREM" 	) :SetValue('')

			oSection1:PrintLine()
		EndIf
		(cAliasNF)->(dbSkip())

	EndDo

	oSection1:Finish()

	DbSelectArea(cAliasNF)
	(cAliasNF)->(dbCloseArea())

	/*Bloco de Busca de Mao-de-OBRA */

	cAliasMOD := GetNextAlias()

	BeginSql Alias cAliasMOD
	%NoParser%

	SELECT CODIGO	,QTDEMOD	,CUSTOTOTAL	,CM_MOD	,PRODUCAO	,ROUND(QTDEMOD / PRODUCAO,6) AS QUANTIDADE
	FROM ( SELECT D3_COD AS CODIGO
	,ROUND(SUM(D3_QUANT		),6) AS QTDEMOD
	,ROUND(SUM(D3_CUSTO1	),6) AS CUSTOTOTAL
	,ROUND((ROUND(SUM(D3_CUSTO1),6) / ROUND(SUM(D3_QUANT),6) ),6) AS CM_MOD
	, (SELECT SUM(D3_QUANT) + SUM(D3_PERDA) AS TOTAL 	FROM %Table:SD3% AS PRD
	WHERE 	PRD.D3_FILIAL = %xFilial:SD3%
	AND 	PRD.D3_OP IN ( SELECT D3_OP FROM %Table:SD3% AS MO
	WHERE MO.D3_FILIAL = %xFilial:SD3%
	AND MO.D3_COD  = SD3.D3_COD
	AND MO.D3_ESTORNO = ''
	AND MO.D3_OP <> ''
	AND MO.D3_EMISSAO BETWEEN %exp:dEmissDe% AND %exp:dEmissAte%
	AND MO.%notDel%
	GROUP BY MO.D3_OP )
	AND PRD.D3_CF = 'PR0'
	AND PRD.D3_EMISSAO BETWEEN %exp:dEmissDe% AND %exp:dEmissAte%
	AND PRD.D3_ESTORNO = ''
	AND PRD.%notDel%  )  AS PRODUCAO

	FROM %Table:SD3%  AS SD3
	WHERE SD3.D3_FILIAL = %xFilial:SD3%
	AND SD3.D3_EMISSAO BETWEEN %exp:dEmissDe% AND %exp:dEmissAte%
	AND SD3.D3_TIPO = 'MO'
	AND SD3.D3_OP <> ''
	AND SD3.D3_ESTORNO = ''
	AND SD3.%notDel%
	GROUP BY SD3.D3_COD ) AS MODS
	ORDER BY MODS.CODIGO

	EndSql

	//MEMOWRITE("C:/TEMP/GRFATMOD.SQL",GetLastQuery()[2])

	DbSelectArea(cAliasMOD)
	(cAliasMOD)->(dbGoTop())

	aMods := {}
	While (cAliasMOD)->(!Eof())

		nCmUn := (((cAliasMOD)->QTDEMOD / (cAliasMOD)->PRODUCAO) *	CM_MOD) //Custo Unitario por Unidade

		aAdd(aMods, { 	(cAliasMOD)->CODIGO;
		,(cAliasMOD)->QTDEMOD;
		,(cAliasMOD)->CUSTOTOTAL;
		,(cAliasMOD)->CM_MOD;
		,(cAliasMOD)->PRODUCAO;
		,(cAliasMOD)->QUANTIDADE;
		, Round(nCmUn,6) })

		(cAliasMOD)->(dbSkip())

	EndDo

	DbSelectArea(cAliasMOD)
	(cAliasMOD)->(dbCloseArea())

	/*Bloco de Busca de Mao-de-OBRA */

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Query do relatÛrio da secao 2                                       ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	oReport:Section(2):BeginQuery()
	cAliasSG1 := GetNextAlias()

	BeginSql Alias cAliasSG1
	%NoParser%

	SELECT FILIAL, PRODUTO ,DESCRICAO ,GRUPO,TIPO, COMPSG1 ,SUM(QUANTIDADE) AS QUANTIDADE , SUM(VALLIQ) AS VALLIQ FROM (

	SELECT	 D2_FILIAL AS FILIAL, D2_COD AS PRODUTO ,B1_DESC AS DESCRICAO ,D2_GRUPO AS GRUPO,B1_TIPO AS TIPO , D2_QUANT AS QUANTIDADE
	,(D2_VALBRUT) - (D2_VALIMP5+D2_VALIMP6+(CASE WHEN D2_VALISS > 0 THEN D2_VALISS ELSE D2_VALICM END)+D2_VALIPI+D2_ICMSRET) AS VALLIQ
	,CASE 	WHEN SC6.C6_INPUTFI = '' AND A1_GRPVEN NOT IN ('ID','GO','CS') THEN ''
	WHEN SC6.C6_INPUTFI <> '' AND A1_GRPVEN IN ('ID','GO','CS') THEN
	ISNULL ((	SELECT	SC6REM.C6_FILIAL +'|'+ SC6REM.C6_CLI +'|'+ SC6REM.C6_LOJA +'|'+ SC6REM.C6_NUM +'|'+ SC6REM.C6_PRODUTO +'|'+ SC6REM.C6_ITEM
	FROM	%table:SC6% AS SC6REM
	WHERE	SC6REM.C6_FILIAL	= SC6.C6_FILIAL
	AND SC6REM.C6_INPUTFI  	= SC6.C6_INPUTFI
	AND SC6REM.C6_SIPSQ 		= SC6.C6_SIPSQ
	AND SC6REM.C6_QTDVEN		= SC6.C6_QTDVEN
	AND SC6REM.C6_NUM			NOT IN (SD2.D2_PEDIDO)
	AND SC6REM.C6_INPUTFI <> ''
	AND SC6REM.%notDel% ),'')
	ELSE '' END PVGOV
	,CASE 	WHEN SC6.C6_INPUTFI <> '' AND SA1.A1_GRPVEN NOT IN ('FI','PA','FS')	THEN ''
	WHEN SA1.A1_GRPVEN NOT IN ('FI','ID','PA','GO','FS','CS') THEN '' ELSE	(ISNULL ((	SELECT	Z9F.Z9F_FILIAL	+'|'+ Z9F.Z9F_CLIFAT		+'|'+ Z9F.Z9F_LJFAT	+'|'+ Z9F.Z9F_PVPSRV +'|'+ Z9F.Z9F_ITPSRV
	FROM	%table:Z9F% AS Z9F
	WHERE		Z9F.Z9F_FILIAL	= SC6.C6_FILIAL
	AND Z9F.Z9F_PVPSRV 	= SC6.C6_NUM
	AND Z9F.Z9F_CLIFAT 	= SC6.C6_CLI
	AND Z9F.Z9F_LJFAT 	= SC6.C6_LOJA
	AND Z9F.Z9F_CODPSR	= SC6.C6_PRODUTO
	AND Z9F.Z9F_ITPSRV 	= SC6.C6_ITEM
	AND Z9F.%notDel%
	GROUP BY Z9F.Z9F_FILIAL	,Z9F.Z9F_CLIFAT,Z9F.Z9F_LJFAT,Z9F.Z9F_PVPSRV,Z9F.Z9F_ITPSRV	),'')
	) END PVPAYMENT
	, (ISNULL((SELECT TOP 1 G1_COD FROM %Table:SG1% AS SG1 WHERE SG1.G1_FILIAL =  %xFilial:SG1% AND SG1.G1_COD = SD2.D2_COD AND SG1.%NotDel% ),'')) AS COMPSG1
	, (ISNULL((SELECT TOP 1 Z9FREM.Z9F_PVPSRV FROM  %Table:Z9F% AS Z9FREM WHERE Z9FREM.Z9F_FILIAL = SC6.C6_FILIAL AND  Z9FREM.Z9F_PVPSRV = SD2.D2_PEDIDO AND Z9FREM.%NotDel%),'')) AS PVREM
	FROM  %table:SD2% AS SD2

	INNER JOIN	%table:SA1% AS SA1
	ON	SA1.A1_FILIAL 	= %xfilial:SA1%
	AND	SA1.A1_COD		= SD2.D2_CLIENTE
	AND	SA1.A1_LOJA		= SD2.D2_LOJA
	AND	SA1.%notDel%

	INNER JOIN	%table:SB1% AS SB1
	ON	SB1.B1_FILIAL = %xfilial:SB1%
	AND	SB1.B1_COD		= SD2.D2_COD
	AND	SB1.%notDel%

	INNER JOIN  %table:SC6% AS SC6
	ON	SC6.C6_FILIAL	= SD2.D2_FILIAL
	AND SC6.C6_NUM		= SD2.D2_PEDIDO
	AND SC6.C6_ITEM		= SD2.D2_ITEMPV
	AND SC6.C6_CLI		= SD2.D2_CLIENTE
	AND SC6.C6_LOJA		= SD2.D2_LOJA
	AND SC6.C6_PRODUTO 	= SD2.D2_COD
	AND SC6.%notDel%

	INNER  JOIN %table:SF4% AS SF4
	ON	 SF4.F4_FILIAL = %xfilial:SF4%
	AND	 SF4.F4_CODIGO = SD2.D2_TES
	AND	 SF4.%notDel%

	WHERE  SD2.D2_FILIAL = %xfilial:SD2%
	AND SD2.D2_CLIENTE 	BETWEEN %exp:cClienteDe% 	AND %exp:cClienteAte%
	AND SD2.D2_LOJA 		BETWEEN %exp:cLojaDe% 		AND %exp:cLojaAte%
	AND SD2.D2_EMISSAO 	BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND SD2.%notDel%
	AND SF4.F4_DUPLIC 	= 'S'
	AND SD2.D2_TIPO 		IN('N','C','I')
	AND SA1.A1_GRPVEN		<> '99'
	) AS PRODUTOS
	WHERE ( PRODUTOS.PVPAYMENT = '' AND PVGOV = '' AND 	COMPSG1 <> '' AND PVREM = '')

	GROUP BY FILIAL, PRODUTO ,DESCRICAO ,GRUPO,TIPO ,COMPSG1
	ORDER BY FILIAL, TIPO	, PRODUTO ,DESCRICAO,GRUPO

	EndSql

	//MEMOWRITE("C:/TEMP/GRFATSG1_"+cAliasSG1+ ".SQL",GetLastQuery()[2])

	oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)

	DbSelectArea(cAliasSG1)
	(cAliasSG1)->(dbGoTop())
	oReport:SetMeter(RecCount())

	oSection2:Init()
	oSection2:SetHeaderSection(.T.)
	oSection2:SetHeaderBreak(.F.)

	DbSelectArea("SB1")
	SB1->(dbSetOrder(1))

	aEstSG1 := {}
	While (cAliasSG1)->(!Eof())
		If oReport:Cancel()
			DbSelectArea(cAliasSG1)
			dbCloseArea()
			Exit
		EndIf

		oReport:IncMeter()

		aEstSG1 := {}
		aEstSG1 := U_GCEST559((cAliasSG1)->PRODUTO,(cAliasSG1)->QUANTIDADE)

		lPri := .T.
		For nG := 1 To Len(aEstSG1) //-1
			IF lPri
				lPri := .F.

				SB1->(MsSeek(xFilial("SB1")+(cAliasSG1)->PRODUTO))

				cSegmento := Posicione("SA1",1, xFilial("SA1")+ SB1->B1_CODCLI, "A1_GRPVEN")
				oSection2:Cell("SEGMENTO" 	) :SetValue( cSegmento )

				oSection2:Cell("PRDGPAI" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
				oSection2:Cell("DESCGRPPAI" ) :SetValue( ALLTRIM(SB1->B1_DESCGRP) )

				oSection2:Cell("G1_COD" 	) :SetValue((cAliasSG1)->PRODUTO  	)
				oSection2:Cell("DESCPAI"	) :SetValue((cAliasSG1)->DESCRICAO  )
				oSection2:Cell("TIPO" 		) :SetValue( 'PA' )
				oSection2:Cell("NIVEL" 		) :SetValue( '' )
				oSection2:Cell("G1_COMP" 	) :SetValue(''  )
				oSection2:Cell("DESCCOMP"	) :SetValue(''  )
				oSection2:Cell("B2_QUANT" 	) :SetValue((cAliasSG1)->QUANTIDADE	)
				oSection2:Cell("CUSTOM" 	) :SetValue( aEstSG1[nG,14] / (cAliasSG1)->QUANTIDADE )
				oSection2:Cell("GRUPO" 		) :SetValue( (cAliasSG1)->GRUPO  	)
				oSection2:Cell("CUSTOTOT" 	) :SetValue( aEstSG1[nG,14] )
				oSection2:Cell("VALLIQ" 	) :SetValue((cAliasSG1)->VALLIQ )
				oSection2:Cell("CUSTOMOD" 	) :SetValue(0 )

				oSection2:Cell("PRDGCOMP" 	) :SetValue( '' )
				oSection2:Cell("DESCGRPCOMP") :SetValue( '' )

				oSection2:PrintLine()

				aMOD :=  GR526MOD((cAliasSG1)->PRODUTO ,dEmissAte )

				For nM := 1 To Len(aMOD)

					oSection2:Cell("NIVEL" 		) :SetValue( '000' )
					oSection2:Cell("G1_COMP" 	) :SetValue(aMOD[nM,1]  )
					oSection2:Cell("DESCCOMP"	) :SetValue(aMOD[nM,2]  )
					oSection2:Cell("TIPO" 		) :SetValue(aMOD[nM,3]  )
					oSection2:Cell("GRUPO" 		) :SetValue(aMOD[nM,4]  )

					oSection2:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aMOD[nM,5]) )
					oSection2:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(aMOD[nM,6]) )

					oSection2:Cell("B2_QUANT" 	) :SetValue((cAliasSG1)->QUANTIDADE )
					oSection2:Cell("CUSTOM" 	) :SetValue(0 )
					oSection2:Cell("CUSTOTOT" 	) :SetValue(0 )
					oSection2:Cell("VALLIQ" 	) :SetValue(0 )

					//Calcula Custo da MOD
					nPosMod := aScan(aMods,{|x| x[1] == aMOD[nM,1] })
					if nPosMod > 0
						oSection2:Cell("CUSTOMOD" 	) :SetValue( aMods[nPosMod,7 ] * (cAliasSG1)->QUANTIDADE )

					Else
						oSection2:Cell("CUSTOMOD" 	) :SetValue(0 )
					EndIF

					oSection2:PrintLine()

				Next nM

				nG++
			EndIF

			cComp := aEstSG1[nG][4]
			nPos := aScan(aEstSG1,{|x| x[2] == cComp })
			If nPos == 0

				//aPrdGroup := GetAdvFval( 'SB1',{'B1_GRPGDM','B1_DESCGRP'}, xFilial("SB1")+ (cAliasSG1)->PRODUTO , 1 )
				SB1->(MsSeek(xFilial("SB1")+(cAliasSG1)->PRODUTO))

				cSegmento := Posicione("SA1",1, xFilial("SA1")+ SB1->B1_CODCLI, "A1_GRPVEN")
				oSection2:Cell("SEGMENTO" 	) :SetValue( cSegmento )

				oSection2:Cell("PRDGPAI" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
				oSection2:Cell("DESCGRPPAI" ) :SetValue( ALLTRIM(SB1->B1_DESCGRP) )

				oSection2:Cell("G1_COD" 	) :SetValue((cAliasSG1)->PRODUTO  	)
				oSection2:Cell("DESCPAI"	) :SetValue((cAliasSG1)->DESCRICAO  )
				oSection2:Cell("TIPO" 		) :SetValue(aEstSG1[nG,11]  )
				oSection2:Cell("NIVEL" 		) :SetValue( StrZero(aEstSG1[nG,1],3))
				oSection2:Cell("G1_COMP" 	) :SetValue(aEstSG1[nG,4]   )
				oSection2:Cell("DESCCOMP"	) :SetValue(aEstSG1[nG,5]  	)
				oSection2:Cell("GRUPO" 		) :SetValue(aEstSG1[nG,12]  )
				oSection2:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] 	)
				oSection2:Cell("CUSTOM" 	) :SetValue(aEstSG1[nG,13]  )
				oSection2:Cell("CUSTOTOT" 	) :SetValue(aEstSG1[nG,14]  )
				oSection2:Cell("VALLIQ" 	) :SetValue(0 )
				oSection2:Cell("CUSTOMOD" 	) :SetValue(0 )

				//aPrdGroup := GetAdvFval( 'SB1',{'B1_GRPGDM','B1_DESCGRP'}, xFilial("SB1")+ aEstSG1[nG,4] , 1 )

				SB1->(MsSeek(xFilial("SB1")+ aEstSG1[nG,4] ))

				oSection2:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
				oSection2:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(SB1->B1_DESCGRP))

				oSection2:PrintLine()

				aMOD :=  GR526MOD(aEstSG1[nG,4],dEmissAte )

				For nM := 1 To Len(aMOD)

					oSection2:Cell("NIVEL" 		) :SetValue( '000' )
					oSection2:Cell("G1_COMP" 	) :SetValue(aMOD[nM,1]  )
					oSection2:Cell("DESCCOMP"	) :SetValue(aMOD[nM,2]  )
					oSection2:Cell("TIPO" 		) :SetValue(aMOD[nM,3]  )
					oSection2:Cell("GRUPO" 		) :SetValue(aMOD[nM,4]  )

					oSection2:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aMOD[nM,5]) )
					oSection2:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(aMOD[nM,6]) )

					oSection2:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] )
					oSection2:Cell("CUSTOM" 	) :SetValue(0 )
					oSection2:Cell("CUSTOTOT" 	) :SetValue(0 )
					oSection2:Cell("VALLIQ" 	) :SetValue(0 )

					//Calcula Custo da MOD
					nPosMod := aScan(aMods,{|x| x[1] == aMOD[nM,1] })
					if nPosMod > 0
						oSection2:Cell("CUSTOMOD" 	) :SetValue( aMods[nPosMod,7 ] * aEstSG1[nG,6] )

					Else
						oSection2:Cell("CUSTOMOD" 	) :SetValue(0 )
					EndIF

					oSection2:PrintLine()

				Next nM

			Else
				//aPrdGroup := GetAdvFval( 'SB1',{'B1_GRPGDM','B1_DESCGRP'}, xFilial("SB1")+ (cAliasSG1)->PRODUTO , 1 )

				SB1->(MsSeek(xFilial("SB1")+ (cAliasSG1)->PRODUTO ))

				oSection2:Cell("PRDGPAI" 	)	:SetValue( ALLTRIM(SB1->B1_GRPGDM) )
				oSection2:Cell("DESCGRPPAI" )	:SetValue( ALLTRIM(SB1->B1_DESCGRP))

				cSegmento := Posicione("SA1",1, xFilial("SA1")+ SB1->B1_CODCLI, "A1_GRPVEN")
				oSection2:Cell("SEGMENTO" 	) :SetValue( cSegmento )

				oSection2:Cell("G1_COD" 	) :SetValue((cAliasSG1)->PRODUTO  	)
				oSection2:Cell("DESCPAI"	) :SetValue((cAliasSG1)->DESCRICAO  )
				oSection2:Cell("TIPO" 		) :SetValue('PI' )
				oSection2:Cell("NIVEL" 		) :SetValue( StrZero(aEstSG1[nG,1],3) )
				oSection2:Cell("G1_COMP" 	) :SetValue(aEstSG1[nG,4]   )
				oSection2:Cell("DESCCOMP"	) :SetValue(aEstSG1[nG,5]  	)
				oSection2:Cell("GRUPO" 		) :SetValue(aEstSG1[nG,12]  )
				oSection2:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] 	)
				oSection2:Cell("CUSTOM" 	) :SetValue(0 )
				oSection2:Cell("CUSTOTOT" 	) :SetValue(0 )
				oSection2:Cell("VALLIQ" 	) :SetValue(0 )
				oSection2:Cell("CUSTOMOD" 	) :SetValue(0 )

				//aPrdGroup := GetAdvFval( 'SB1',{'B1_GRPGDM','B1_DESCGRP'}, xFilial("SB1")+ aEstSG1[nG,4] , 1 )
				//oSection2:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aPrdGroup[1]) )
				//oSection2:Cell("DESCGRPCOMP" ) :SetValue( ALLTRIM(aPrdGroup[2]) )

				SB1->(MsSeek(xFilial("SB1")+ aEstSG1[nG,4] ))

				oSection2:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
				oSection2:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(SB1->B1_DESCGRP))

				oSection2:PrintLine()

				aMOD :=  GR526MOD(aEstSG1[nG,4],dEmissAte )

				For nM := 1 To Len(aMOD)

					oSection2:Cell("NIVEL" 		) :SetValue( '000' )
					oSection2:Cell("G1_COMP" 	) :SetValue(aMOD[nM,1]  )
					oSection2:Cell("DESCCOMP"	) :SetValue(aMOD[nM,2]  )
					oSection2:Cell("TIPO" 		) :SetValue(aMOD[nM,3]  )
					oSection2:Cell("GRUPO" 		) :SetValue(aMOD[nM,4]  )

					oSection2:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aMOD[nM,5]) )
					oSection2:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(aMOD[nM,6]) )

					oSection2:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] )
					oSection2:Cell("CUSTOM" 	) :SetValue(0 )
					oSection2:Cell("CUSTOTOT" 	) :SetValue(0 )
					oSection2:Cell("VALLIQ" 	) :SetValue(0 )

					//Calcula Custo da MOD
					nPosMod := aScan(aMods,{|x| x[1] == aMOD[nM,1] })
					if nPosMod > 0
						oSection2:Cell("CUSTOMOD" 	) :SetValue( aMods[nPosMod,7 ] * aEstSG1[nG,6] )
					Else
						oSection2:Cell("CUSTOMOD" 	) :SetValue(0 )

					EndIF

					oSection2:PrintLine()

				Next nM

			EndIF

		Next nG

		oSection2:Cell("G1_COD" 	) :SetValue('' )
		oSection2:Cell("DESCPAI"	) :SetValue('' )
		oSection2:Cell("TIPO" 		) :SetValue( '' )
		oSection2:Cell("NIVEL" 		) :SetValue( '' )
		oSection2:Cell("GRUPO" 		) :SetValue( '' )
		oSection2:Cell("G1_COMP" 	) :SetValue(''  )
		oSection2:Cell("DESCCOMP"	) :SetValue(''	)
		oSection2:Cell("B2_QUANT" 	) :SetValue( 0 )
		oSection2:Cell("CUSTOM" 	) :SetValue( 0 )
		oSection2:Cell("CUSTOTOT" 	) :SetValue( 0 )
		oSection2:Cell("VALLIQ" 	) :SetValue(0 )
		oSection2:Cell("PRDGPAI" 	) :SetValue( '' )
		oSection2:Cell("DESCGRPPAI" ) :SetValue( '' )
		oSection2:Cell("PRDGCOMP" 	) :SetValue( '' )
		oSection2:Cell("DESCGRPCOMP") :SetValue( '' )
		oSection2:Cell("CUSTOMOD" 	) :SetValue( 0 )
		oSection2:Cell("SEGMENTO" 	) :SetValue( '' )

		oSection2:PrintLine()

		//oReport:SkipLine(1)
		(cAliasSG1)->(dbSkip())

	EndDo

	oSection2:Finish()

	DbSelectArea(cAliasSG1)
	(cAliasSG1)->(dbCloseArea())

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Query do relatÛrio da secao 3                                       ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	oReport:Section(3):BeginQuery()
	cAliasSV := GetNextAlias()

	BeginSql Alias cAliasSV
	%NoParser%

	SELECT FILIAL, PRODUTO ,DESCRICAO ,GRUPO,TIPO,PVPAYMENT,SUM(QUANTIDADE) AS QUANTIDADE , SUM(VALLIQ) AS VALLIQ FROM (

	SELECT	 D2_FILIAL AS FILIAL, D2_COD AS PRODUTO ,B1_DESC AS DESCRICAO ,D2_GRUPO AS GRUPO,B1_TIPO AS TIPO , D2_QUANT AS QUANTIDADE,A1_GRPVEN AS SEGMENTO
	,(D2_VALBRUT) - (D2_VALIMP5+D2_VALIMP6+(CASE WHEN D2_VALISS > 0 THEN D2_VALISS ELSE D2_VALICM END)+D2_VALIPI+D2_ICMSRET) AS VALLIQ
	,CASE 	WHEN SC6.C6_INPUTFI = '' AND A1_GRPVEN NOT IN ('ID','GO','CS') THEN ''
	WHEN SC6.C6_INPUTFI <> '' AND A1_GRPVEN IN ('ID','GO','CS') THEN
	ISNULL ((	SELECT	SC6REM.C6_FILIAL +'|'+ SC6REM.C6_CLI +'|'+ SC6REM.C6_LOJA +'|'+ SC6REM.C6_NUM +'|'+ SC6REM.C6_PRODUTO +'|'+ SC6REM.C6_ITEM
	FROM	%table:SC6% AS SC6REM
	WHERE	SC6REM.C6_FILIAL	= SC6.C6_FILIAL
	AND SC6REM.C6_INPUTFI  	= SC6.C6_INPUTFI
	AND SC6REM.C6_SIPSQ 		= SC6.C6_SIPSQ
	AND SC6REM.C6_QTDVEN		= SC6.C6_QTDVEN
	AND SC6REM.C6_NUM			NOT IN (SD2.D2_PEDIDO)
	AND SC6REM.C6_INPUTFI <> ''
	AND SC6REM.%notDel% ),'')
	ELSE '' END PVGOV
	,CASE 	WHEN SC6.C6_INPUTFI <> '' AND SA1.A1_GRPVEN NOT IN ('FI','PA','FS')	THEN ''
	WHEN SA1.A1_GRPVEN NOT IN ('FI','ID','PA','GO','FS','CS') THEN '' ELSE	(ISNULL ((	SELECT	Z9F.Z9F_FILIAL	+'|'+ Z9F.Z9F_CLIFAT		+'|'+ Z9F.Z9F_LJFAT	+'|'+ Z9F.Z9F_PVPSRV +'|'+ Z9F.Z9F_ITPSRV
	FROM	%table:Z9F% AS Z9F
	WHERE		Z9F.Z9F_FILIAL	= SC6.C6_FILIAL
	AND Z9F.Z9F_PVPSRV 	= SC6.C6_NUM
	AND Z9F.Z9F_CLIFAT 	= SC6.C6_CLI
	AND Z9F.Z9F_LJFAT 	= SC6.C6_LOJA
	AND Z9F.Z9F_CODPSR	= SC6.C6_PRODUTO
	AND Z9F.Z9F_ITPSRV 	= SC6.C6_ITEM
	AND Z9F.%notDel%
	GROUP BY Z9F.Z9F_FILIAL	,Z9F.Z9F_CLIFAT,Z9F.Z9F_LJFAT,Z9F.Z9F_PVPSRV,Z9F.Z9F_ITPSRV	),'')) END PVPAYMENT
	, (ISNULL((SELECT TOP 1 Z9FREM.Z9F_PVPSRV FROM  %Table:Z9F% AS Z9FREM WHERE Z9FREM.Z9F_FILIAL = SC6.C6_FILIAL AND  Z9FREM.Z9F_PVPSRV = SD2.D2_PEDIDO AND Z9FREM.%NotDel%),'')) AS PVREM
	FROM  %table:SD2% AS SD2

	INNER JOIN	%table:SA1% AS SA1
	ON	SA1.A1_FILIAL 	= %xfilial:SA1%
	AND	SA1.A1_COD		= SD2.D2_CLIENTE
	AND	SA1.A1_LOJA		= SD2.D2_LOJA
	AND	SA1.%notDel%

	INNER JOIN	%table:SB1% AS SB1
	ON	SB1.B1_FILIAL = %xfilial:SB1%
	AND	SB1.B1_COD		= SD2.D2_COD
	AND	SB1.%notDel%

	INNER JOIN  %table:SC6% AS SC6
	ON	SC6.C6_FILIAL	= SD2.D2_FILIAL
	AND SC6.C6_NUM		= SD2.D2_PEDIDO
	AND SC6.C6_ITEM		= SD2.D2_ITEMPV
	AND SC6.C6_CLI		= SD2.D2_CLIENTE
	AND SC6.C6_LOJA		= SD2.D2_LOJA
	AND SC6.C6_PRODUTO 	= SD2.D2_COD
	AND SC6.%notDel%

	INNER  JOIN %table:SF4% AS SF4
	ON	 SF4.F4_FILIAL = %xfilial:SF4%
	AND	 SF4.F4_CODIGO = SD2.D2_TES
	AND	 SF4.%notDel%

	WHERE  SD2.D2_FILIAL = %xfilial:SD2%
	AND SD2.D2_CLIENTE 	BETWEEN %exp:cClienteDe% 	AND %exp:cClienteAte%
	AND SD2.D2_LOJA 		BETWEEN %exp:cLojaDe% 		AND %exp:cLojaAte%
	AND SD2.D2_EMISSAO 	BETWEEN %exp:dEmissDe% 		AND %exp:dEmissAte%
	AND SD2.%notDel%
	AND SF4.F4_DUPLIC 	= 'S'
	AND SD2.D2_TIPO 		IN('N','C','I')
	AND SA1.A1_GRPVEN		<> '99'
	) AS PRODUTOS
	WHERE ( PRODUTOS.PVPAYMENT <> '')

	GROUP BY FILIAL, PRODUTO ,DESCRICAO ,GRUPO,TIPO,PVPAYMENT
	ORDER BY FILIAL, TIPO	, PRODUTO ,DESCRICAO,GRUPO

	EndSql

	//MEMOWRITE("C:/TEMP/GRFATSG1_"+cAliasSV+ ".SQL",GetLastQuery()[2])

	oReport:Section(3):EndQuery(/*Array com os parametros do tipo Range*/)

	DbSelectArea(cAliasSV)
	(cAliasSV)->(dbGoTop())
	oReport:SetMeter(RecCount())

	oSection3:Init()
	oSection3:SetHeaderSection(.T.)
	oSection3:SetHeaderBreak(.F.)

	aEstSG1 := {}
	While (cAliasSV)->(!Eof())
		If oReport:Cancel()
			DbSelectArea(cAliasSV)
			dbCloseArea()
			Exit
		EndIf

		oReport:IncMeter()
		oSection3:Cell("B1_COD" 	) :SetValue((cAliasSV)->PRODUTO  	)
		oSection3:Cell("SERVICO"	) :SetValue((cAliasSV)->DESCRICAO  )
		oSection3:Cell("G1_COD" 	) :SetValue( ''  	)
		oSection3:Cell("DESCPAI"	) :SetValue('' 	)
		oSection3:Cell("SEGMENTO" 	) :SetValue( '' )

		oSection3:Cell("TIPO" 		) :SetValue( 'SV' )
		oSection3:Cell("NIVEL" 		) :SetValue('' )
		oSection3:Cell("G1_COMP" 	) :SetValue(''  )
		oSection3:Cell("DESCCOMP"	) :SetValue(''  )
		oSection3:Cell("B2_QUANT" 	) :SetValue((cAliasSV)->QUANTIDADE	)
		oSection3:Cell("CUSTOM" 	) :SetValue( 0 )
		oSection3:Cell("GRUPO" 		) :SetValue( (cAliasSV)->GRUPO  	)
		oSection3:Cell("CUSTOTOT" 	) :SetValue( 0 )
		oSection3:Cell("VALLIQ" 	) :SetValue((cAliasSV)->VALLIQ )

		oSection3:Cell("PRDGPAI" 	) :SetValue( '' )
		oSection3:Cell("DESCGRPPAI" ) :SetValue( '' )
		oSection3:Cell("PRDGCOMP" 	) :SetValue( '' )
		oSection3:Cell("DESCGRPCOMP") :SetValue( '' )
		oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )

		oSection3:PrintLine()

		//((cAliasSV)->PVGOV,(cAliasSV)->PVPAYMENT,dEmissAte,@oSection3)

		cAliasZ9F := GetNextAlias()

		aParam 		:= strtokarr2((cAliasSV)->PVPAYMENT,"|",.F.)

		BeginSql Alias cAliasZ9F
		%NoParser%
		SELECT Z9F_CODREM AS PRDREM , B1_DESC, B1_GRUPO, B1_TIPO, SUM(Z9F_QUANT) AS QTDREM FROM %Table:Z9F%

		INNER JOIN	%table:SB1% AS SB1
		ON	SB1.B1_FILIAL = %xfilial:SB1%
		AND	SB1.B1_COD		= Z9F_CODREM
		AND	SB1.%notDel%

		INNER JOIN	%table:SA1% AS SA1
		ON	SA1.A1_FILIAL = %xfilial:SA1%
		AND	SA1.A1_COD	  = SB1.B1_CODCLI
		AND	SA1.%notDel%

		WHERE Z9F_FILIAL = %xFilial:Z9F%
		AND Z9F_PVPSRV = %exp:aParam[4]%
		AND Z9F_ITPSRV = %exp:aParam[5]%
		AND Z9F_CLIFAT = %exp:aParam[2]%
		AND Z9F_LJFAT =  %exp:aParam[3]%
		GROUP BY Z9F_CODREM,B1_DESC, B1_GRUPO, B1_TIPO
		EndSql
		DbSelectArea(cAliasZ9F)
		(cAliasZ9F)->(dbGoTop())

		While (cAliasZ9F)->(!Eof())
			aEstSG1 := {}
			aEstSG1 := U_GCEST559((cAliasZ9F)->PRDREM,(cAliasZ9F)->QTDREM)

			//aPrdGroup := {}

			lPri := .T.
			For nG := 1 To Len(aEstSG1) //-1
				IF lPri
					lPri := .F.

					oSection3:Cell("B1_COD" 	) :SetValue((cAliasSV)->PRODUTO		)
					oSection3:Cell("SERVICO"	) :SetValue((cAliasSV)->DESCRICAO	)

					oSection3:Cell("G1_COD" 	) :SetValue((cAliasZ9F)->PRDREM		)
					oSection3:Cell("DESCPAI"	) :SetValue( (cAliasZ9F)->B1_DESC	)

					SB1->(MsSeek(xFilial("SB1")+ (cAliasZ9F)->PRDREM ))

					oSection3:Cell("PRDGPAI" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
					oSection3:Cell("DESCGRPPAI" ) :SetValue( ALLTRIM(SB1->B1_DESCGRP))

					cSegmento := Posicione("SA1",1, xFilial("SA1")+ SB1->B1_CODCLI, "A1_GRPVEN")
					oSection3:Cell("SEGMENTO" 	) :SetValue( cSegmento )

					oSection3:Cell("TIPO" 		) :SetValue('PA')
					oSection3:Cell("NIVEL" 		) :SetValue(''	)
					oSection3:Cell("G1_COMP" 	) :SetValue(''  )
					oSection3:Cell("DESCCOMP"	) :SetValue(''  )
					oSection3:Cell("B2_QUANT" 	) :SetValue((cAliasZ9F)->QTDREM	)
					oSection3:Cell("CUSTOM" 	) :SetValue( aEstSG1[nG,14] /(cAliasZ9F)->QTDREM )
					oSection3:Cell("GRUPO" 		) :SetValue( (cAliasZ9F)->B1_GRUPO  )
					oSection3:Cell("CUSTOTOT" 	) :SetValue( aEstSG1[nG,14] )
					oSection3:Cell("VALLIQ" 	) :SetValue( 0 )

					oSection3:Cell("PRDGCOMP" 	) :SetValue( '' )
					oSection3:Cell("DESCGRPCOMP" ):SetValue( '' )
					oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )

					oSection3:PrintLine()

					aMOD :=  GR526MOD((cAliasZ9F)->PRDREM ,dEmissAte )

					For nM := 1 To Len(aMOD)

						oSection3:Cell("NIVEL" 		) :SetValue( '000' )
						oSection3:Cell("G1_COMP" 	) :SetValue(aMOD[nM,1]  )
						oSection3:Cell("DESCCOMP"	) :SetValue(aMOD[nM,2]  )
						oSection3:Cell("TIPO" 		) :SetValue(aMOD[nM,3]  )
						oSection3:Cell("GRUPO" 		) :SetValue(aMOD[nM,4]  )

						oSection3:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aMOD[nM,5]) )
						oSection3:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(aMOD[nM,6]) )

						oSection3:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] )
						oSection3:Cell("CUSTOM" 	) :SetValue(0 )
						oSection3:Cell("CUSTOTOT" 	) :SetValue(0 )
						oSection3:Cell("VALLIQ" 	) :SetValue(0 )

						//Calcula Custo da MOD
						nPosMod := aScan(aMods,{|x| x[1] == aMOD[nM,1] })
						if nPosMod > 0
							oSection3:Cell("CUSTOMOD" 	) :SetValue( aMods[nPosMod,7 ] * aEstSG1[nG,6] )

						Else
							oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )
						EndIF

						oSection3:PrintLine()

					Next nM

					nG++
				EndIF

				cComp := aEstSG1[nG][4]
				nPos := aScan(aEstSG1,{|x| x[2] == cComp })

				If nPos == 0 //.and.  nX > 1
					oSection3:Cell("B1_COD" 	) :SetValue((cAliasSV)->PRODUTO  	)
					oSection3:Cell("SERVICO"	) :SetValue((cAliasSV)->DESCRICAO  )
					oSection3:Cell("G1_COD" 	) :SetValue((cAliasZ9F)->PRDREM  	)
					oSection3:Cell("DESCPAI"	) :SetValue( (cAliasZ9F)->B1_DESC   )
					oSection3:Cell("TIPO" 		) :SetValue(aEstSG1[nG,11]  )
					oSection3:Cell("NIVEL" 		) :SetValue( StrZero(aEstSG1[nG,1],3))
					oSection3:Cell("G1_COMP" 	) :SetValue(aEstSG1[nG,4]   )
					oSection3:Cell("DESCCOMP"	) :SetValue(aEstSG1[nG,5]  	)
					oSection3:Cell("GRUPO" 		) :SetValue(aEstSG1[nG,12]  )
					oSection3:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] 	)
					oSection3:Cell("CUSTOM" 	) :SetValue(aEstSG1[nG,13]  )
					oSection3:Cell("CUSTOTOT" 	) :SetValue(aEstSG1[nG,14]  )
					oSection3:Cell("VALLIQ" 	) :SetValue(0 )

					SB1->(MsSeek(xFilial("SB1")+ (cAliasZ9F)->PRDREM  ))

					oSection3:Cell("PRDGPAI" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
					oSection3:Cell("DESCGRPPAI" ):SetValue( ALLTRIM(SB1->B1_DESCGRP))

					cSegmento := Posicione("SA1",1, xFilial("SA1")+ SB1->B1_CODCLI, "A1_GRPVEN")
					oSection3:Cell("SEGMENTO" 	) :SetValue( cSegmento )

					SB1->(MsSeek(xFilial("SB1")+ aEstSG1[nG,4] ))
					oSection3:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
					oSection3:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(SB1->B1_DESCGRP))

					oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )

					oSection3:PrintLine()

					aMOD :=  GR526MOD(	aEstSG1[nG,4] ,dEmissAte )

					For nM := 1 To Len(aMOD)

						oSection3:Cell("NIVEL" 		) :SetValue( '000' )
						oSection3:Cell("G1_COMP" 	) :SetValue(aMOD[nM,1]  )
						oSection3:Cell("DESCCOMP"	) :SetValue(aMOD[nM,2]  )
						oSection3:Cell("TIPO" 		) :SetValue(aMOD[nM,3]  )
						oSection3:Cell("GRUPO" 		) :SetValue(aMOD[nM,4]  )

						oSection3:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aMOD[nM,5]) )
						oSection3:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(aMOD[nM,6]) )

						oSection3:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] )
						oSection3:Cell("CUSTOM" 	) :SetValue(0 )
						oSection3:Cell("CUSTOTOT" 	) :SetValue(0 )
						oSection3:Cell("VALLIQ" 	) :SetValue(0 )

						//Calcula Custo da MOD
						nPosMod := aScan(aMods,{|x| x[1] == aMOD[nM,1] })
						if nPosMod > 0
							oSection3:Cell("CUSTOMOD" 	) :SetValue( aMods[nPosMod,7 ] * aEstSG1[nG,6] )

						Else
							oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )
						EndIF

						oSection3:PrintLine()

					Next nM

				Else
					oSection3:Cell("B1_COD" 	) :SetValue((cAliasSV)->PRODUTO		)
					oSection3:Cell("SERVICO"	) :SetValue((cAliasSV)->DESCRICAO	)
					oSection3:Cell("G1_COD" 	) :SetValue((cAliasZ9F)->PRDREM  	)
					oSection3:Cell("DESCPAI"	) :SetValue( (cAliasZ9F)->B1_DESC   )
					oSection3:Cell("TIPO" 		) :SetValue('PI' )
					oSection3:Cell("NIVEL" 		) :SetValue( StrZero(aEstSG1[nG,1],3))
					oSection3:Cell("G1_COMP" 	) :SetValue(aEstSG1[nG,4]   )
					oSection3:Cell("DESCCOMP"	) :SetValue(aEstSG1[nG,5]  	)
					oSection3:Cell("GRUPO" 		) :SetValue(aEstSG1[nG,12]  )
					oSection3:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] 	)
					oSection3:Cell("CUSTOM" 	) :SetValue(0 )
					oSection3:Cell("CUSTOTOT" 	) :SetValue(0 )
					oSection3:Cell("VALLIQ" 	) :SetValue(0 )

					SB1->(MsSeek(xFilial("SB1")+ (cAliasZ9F)->PRDREM  ))

					oSection3:Cell("PRDGPAI" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
					oSection3:Cell("DESCGRPPAI" ):SetValue( ALLTRIM(SB1->B1_DESCGRP))

					cSegmento := Posicione("SA1",1, xFilial("SA1")+ SB1->B1_CODCLI, "A1_GRPVEN")
					oSection3:Cell("SEGMENTO" 	) :SetValue( cSegmento )

					SB1->(MsSeek(xFilial("SB1")+ aEstSG1[nG,4] ))
					oSection3:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(SB1->B1_GRPGDM) )
					oSection3:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(SB1->B1_DESCGRP))

					oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )

					oSection3:PrintLine()

					aMOD :=  GR526MOD(	aEstSG1[nG,4] ,dEmissAte )

					For nM := 1 To Len(aMOD)

						oSection3:Cell("NIVEL" 		) :SetValue( '000' )
						oSection3:Cell("G1_COMP" 	) :SetValue(aMOD[nM,1]  )
						oSection3:Cell("DESCCOMP"	) :SetValue(aMOD[nM,2]  )
						oSection3:Cell("TIPO" 		) :SetValue(aMOD[nM,3]  )
						oSection3:Cell("GRUPO" 		) :SetValue(aMOD[nM,4]  )

						oSection3:Cell("PRDGCOMP" 	) :SetValue( ALLTRIM(aMOD[nM,5]) )
						oSection3:Cell("DESCGRPCOMP" ):SetValue( ALLTRIM(aMOD[nM,6]) )

						oSection3:Cell("B2_QUANT" 	) :SetValue(aEstSG1[nG,6] )
						oSection3:Cell("CUSTOM" 	) :SetValue(0 )
						oSection3:Cell("CUSTOTOT" 	) :SetValue(0 )
						oSection3:Cell("VALLIQ" 	) :SetValue(0 )

						//Calcula Custo da MOD
						nPosMod := aScan(aMods,{|x| x[1] == aMOD[nM,1] })
						if nPosMod > 0
							oSection3:Cell("CUSTOMOD" 	) :SetValue( aMods[nPosMod,7 ] * aEstSG1[nG,6] )

						Else
							oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )
						EndIF

						oSection3:PrintLine()

					Next nM

				EndIF

			Next nG

			(cAliasZ9F)->(dbSkip())

		ENDdO

		DbSelectArea(cAliasZ9F)
		(cAliasZ9F)->(dbCloseArea())

		oSection3:Cell("B1_COD" 	) :SetValue('' )
		oSection3:Cell("SERVICO"	) :SetValue('' )
		oSection3:Cell("G1_COD" 	) :SetValue('' )
		oSection3:Cell("DESCPAI"	) :SetValue('' )
		oSection3:Cell("TIPO" 		) :SetValue( '' )
		oSection3:Cell("NIVEL" 		) :SetValue( '' )
		oSection3:Cell("GRUPO" 		) :SetValue( '' )
		oSection3:Cell("SEGMENTO" 	) :SetValue( '' )
		oSection3:Cell("G1_COMP" 	) :SetValue(''  )
		oSection3:Cell("DESCCOMP"	) :SetValue(''	)
		oSection3:Cell("B2_QUANT" 	) :SetValue( 0 )
		oSection3:Cell("CUSTOM" 	) :SetValue( 0 )
		oSection3:Cell("CUSTOTOT" 	) :SetValue( 0 )
		oSection3:Cell("VALLIQ" 	) :SetValue( 0 )
		oSection3:Cell("PRDGPAI" 	) :SetValue( '' )
		oSection3:Cell("DESCGRPPAI" ) :SetValue( '' )
		oSection3:Cell("PRDGCOMP" 	) :SetValue( '' )
		oSection3:Cell("DESCGRPCOMP") :SetValue( '' )
		oSection3:Cell("CUSTOMOD" 	) :SetValue(0 )

		oSection3:PrintLine()

		//oReport:SkipLine(1)
		(cAliasSV)->(dbSkip())

	EndDo

	oSection3:Finish()

	DbSelectArea(cAliasSV)
	(cAliasSV)->(dbCloseArea())

	/* Bloco Custo MOD */

Return Nil

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫ Programa ≥ GRREMESSA∫ Autor ≥ Josuel Silva       ∫ Data ≥  19/11/2015 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫ Descricao≥ Busca as informacoes dos pedidos de Remessas atraves do    ≥±±
±±∫          ≥ pedido de servico informado.                               ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function GR426Remessa(cInforGov,cInforPay,dtFinal,oSection1)

	Local aParam 		:= {}
	Local cAliasRem	:= GetNextAlias()
	Local cFrom		:= ""
	Local cJoin		:= ""
	Local cWhere		:= ""
	Local aRet		:= {}

	Default cInforGov := ""
	Default cInforPay := ""

	IF !EmptY(cInforPay)
		//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
		//≥Converte Parametro em Array                                             ≥
		//≥ 1-Filial / 2-Cliente / 3-Loja / 4- Pedido / 5- Item                    ≥
		//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
		aParam 		:= strtokarr2(cInforPay,"|",.F.)

		cJoin := "%"
		cJoin += " INNER  JOIN ( "
		cJoin += " 	SELECT F.Z9F_FILIAL	,F.Z9F_PVREM	,	F.Z9F_CLIENT	,"
		cJoin += " 			F.Z9F_LOJA		,F.Z9F_CLIFAT	,	F.Z9F_LJFAT	,"
		cJoin += "				F.Z9F_ITREM	,F.Z9F_CODREM	,	F.Z9F_PVPSRV	,"
		cJoin += "				F.Z9F_ITPSRV	,	F.D_E_L_E_T_ "
		cJoin += " FROM "+ RetSqlName("Z9F") + " AS F "
		cJoin += " WHERE F.Z9F_FILIAL 	= '" + aParam[1] + "'"
		cJoin += " AND F.Z9F_PVPSRV 	= '" + aParam[4] 	+ "'"
		cJoin += " AND F.Z9F_ITPSRV 	= '" + aParam[5] 	+ "'"
		cJoin += " AND F.D_E_L_E_T_ 	= ' '					"
		cJoin += " GROUP BY F.Z9F_FILIAL,F.Z9F_PVREM,F.Z9F_CLIENT, "
		cJoin += " F.Z9F_LOJA,F.Z9F_CLIFAT,F.Z9F_LJFAT,F.Z9F_ITREM,F.Z9F_CODREM,F.Z9F_PVPSRV,F.Z9F_ITPSRV,F.D_E_L_E_T_ )"
		cJoin += " AS 	Z9F "
		cJoin += " ON		SD2.D2_FILIAL		=	Z9F.Z9F_FILIAL 	"
		cJoin += " AND 	SD2.D2_CLIENTE	=	Z9F.Z9F_CLIENT 	"
		cJoin += " AND 	SD2.D2_LOJA		= 	Z9F.Z9F_LOJA		"
		cJoin += " AND 	SD2.D2_COD			=	Z9F.Z9F_CODREM 	"
		cJoin += " AND 	SD2.D2_PEDIDO 	= 	Z9F.Z9F_PVREM		"
		cJoin += " AND 	SD2.D2_ITEMPV		=	Z9F.Z9F_ITREM 	"
		cJoin += " AND 	SD2.D_E_L_E_T_ 	= 	' '					"

		cJoin += "%"

		cWhere += "%"
		cWhere += " Z9F.Z9F_FILIAL 			= '" + aParam[1] 	+ "'"
		cWhere += " AND Z9F.Z9F_CLIFAT 		= '" + aParam[2] 	+ "'"
		cWhere += " AND Z9F.Z9F_LJFAT  		= '" + aParam[3] 	+ "'"
		cWhere += " AND Z9F.Z9F_PVPSRV 		= '" + aParam[4] 	+ "'"
		cWhere += " AND Z9F.Z9F_ITPSRV 		= '" + aParam[5] 	+ "'"
		cWhere += " AND Z9F.D_E_L_E_T_ 	= 	''"
		cWhere += " AND SD2.D2_EMISSAO <= '"+ dtFinal		+ "'"
		cWhere += "%"
	Else
		//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
		//≥Converte Parametro em Array                                             ≥
		//≥ 1-Filial / 2-Cliente / 3-Loja / 4- Pedido / 5-Produto / 6-Item Pedido  ≥
		//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
		aParam 		:= strtokarr2(cInforGov,"|",.F.)

		cJoin := "%"
		cJoin += " INNER JOIN  " + RetSqlName("SC6") + " AS SC6	"
		cJoin += " ON	SC6.C6_FILIAL	= SD2.D2_FILIAL "
		cJoin += " AND SC6.C6_NUM	= SD2.D2_PEDIDO "
		cJoin += " AND SC6.C6_ITEM	= SD2.D2_ITEMPV "
		cJoin += " AND SC6.C6_CLI	= SD2.D2_CLIENTE "
		cJoin += " AND SC6.C6_LOJA	= SD2.D2_LOJA "
		cJoin += " AND SC6.D_E_L_E_T_ 	= 	' ' "

		cJoin += "%"

		cWhere += "%"
		cWhere += " 	SD2.D2_FILIAL		= '" + aParam[1] 	+ "'"
		cWhere += " AND SD2.D2_CLIENTE 	= '" + aParam[2] 	+ "'"
		cWhere += " AND SD2.D2_LOJA 	= '" + aParam[3] + "'"
		cWhere += " AND SD2.D2_PEDIDO 	= '" + aParam[4] 	+ "'"
		cWhere += " AND SD2.D2_COD		= '" + aParam[5] 	+ "'"
		cWhere += " AND SD2.D2_ITEMPV 	= '" + aParam[6] + "'"
		cWhere += " AND SD2.D2_EMISSAO <= '"+ dtFinal		+ "'"
		cWhere += " AND SD2.D_E_L_E_T_ 	= 	' ' "
		cWhere += "%"

	EndiF

	BeginSql Alias cAliasRem
	%NoParser%
	SELECT D2_DOC,D2_SERIE,D2_ITEM,D2_COD,D2_QUANT,
	D2_PRCVEN,D2_TOTAL, D2_CUSTO1,D2_EMISSAO,D2_PEDIDO,D2_ITEMPV
	,(D2_CUSTO1 / D2_QUANT) AS CM1

	FROM %table:SD2% AS SD2
	%Exp:cJoin%
	WHERE %Exp:cWhere%
	ORDER BY SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_ITEM,SD2.D2_COD
	EndSql

	//MEMOWRITE("C:/TEMP/GRFAT426-"+ cAliasRem + ".SQL",GetLastQuery()[2])

	DbSelectArea("SB1")
	SB1->(dbSetOrder(1))

	DbSelectArea(cAliasRem)
	(cAliasRem)->(dbGoTop())

	//lPri := .F.

	While (cAliasRem)->(!Eof())

		SB1->(MsSeek(xFilial("SB1")+(cAliasRem)->D2_COD))

		oSection1:Cell("D2_DOCREM" 		) :SetValue((cAliasRem)->D2_DOC)
		oSection1:Cell("D2_SERIEREM" 	) :SetValue((cAliasRem)->D2_SERIE)
		oSection1:Cell("D2_ITEMREM" 	) :SetValue((cAliasRem)->D2_ITEM)
		oSection1:Cell("D2_CODREM"		) :SetValue((cAliasRem)->D2_COD)
		oSection1:Cell("B1_DESCREM" 	) :SetValue(ALLTRIM(SB1->B1_DESC))
		oSection1:Cell("B1_TIPOREM"		) :SetValue(SB1->B1_TIPO)

		oSection1:Cell("D2_QUANTREM" 	) :SetValue((cAliasRem)->D2_QUANT 	)
		oSection1:Cell("D2_PRCVENREM" 	) :SetValue((cAliasRem)->D2_PRCVEN	)
		oSection1:Cell("D2_TOTALREM" 	) :SetValue((cAliasRem)->D2_TOTAL	)
		oSection1:Cell("D2_CUSTO1REM" 	) :SetValue((cAliasRem)->D2_CUSTO1	)
		oSection1:Cell("B2_CM1REM" 		) :SetValue((cAliasRem)->CM1 		)
		oSection1:Cell("D2_PEDIDOREM" 	) :SetValue((cAliasRem)->D2_PEDIDO	)
		oSection1:Cell("D2_ITEMPVREM" 	) :SetValue((cAliasRem)->D2_ITEMPV	)

		oSection1:Cell("D2_EMISSAOREM" 	) :SetValue(DTOC(STOD((cAliasRem)->D2_EMISSAO)))
		oSection1:Cell("B1_GRPGDMREM" 	) :SetValue(SB1->B1_GRPGDM)
		oSection1:Cell("B1_DESCGRPREM" 	) :SetValue(SB1->B1_DESCGRP)
		oSection1:PrintLine()
		(cAliasRem)->(dbSkip())
	EndDo

	DbSelectArea("SB1")
	SB1->(dbCloseArea())

	DbSelectArea(cAliasRem)
	(cAliasRem)->(dbCloseArea())

Return oSection1

Static Function GR526MOD(cProduto,dDataAte)

	Local cAliasMO	:= GetNextAlias()
	Local aDados := {}

	BeginSql Alias cAliasMO
	%NoParser%
	SELECT D3_COD,B1_DESC,B1_TIPO,B1_GRUPO,B1_GRPGDM,B1_DESCGRP FROM %Table:SD3% AS SD3
	JOIN %Table:SB1% AS SB1 ON SB1.B1_FILIAL = %xFilial:SB1%
	AND SB1.B1_COD = SD3.D3_COD
	AND SB1.%NotDel%
	WHERE D3_FILIAL = %xFilial:SD3%
	AND D3_OP IN ( SELECT  MAX(D3_OP) AS MAXDTOP FROM %Table:SD3% AS SD3MAX
	INNER JOIN %Table:SC2% AS SC2 ON SC2.C2_FILIAL = SD3MAX.D3_FILIAL
	AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN  + SC2.C2_ITEMGRD = SD3MAX.D3_OP
	AND SC2.%NotDel%
	AND SC2.C2_DATRF <> ''
	AND SC2.C2_DATRF <= %Exp:dDataAte%
	WHERE SD3MAX.D3_FILIAL = %xFilial:SD3%
	AND SD3MAX.D3_OP <> ''
	AND SD3MAX.D3_ESTORNO = ''
	AND SD3MAX.%NotDel%
	AND SD3MAX.D3_COD = %Exp:cProduto%
	AND SD3MAX.D3_TM = '010'
	AND SD3MAX.D3_EMISSAO  <= %Exp:dDataAte% )
	AND SD3.D3_OP <> ''
	AND SD3.D3_ESTORNO = ''
	AND SD3.%NotDel%
	AND SD3.D3_TIPO = 'MO'

	GROUP BY D3_COD,B1_DESC,B1_TIPO,B1_GRUPO,B1_GRPGDM,B1_DESCGRP

	EndSql

	DbSelectArea(cAliasMO)
	(cAliasMO)->(dbGoTop())

	While (cAliasMO)->(!Eof())
		Aadd(aDados,{(cAliasMO)->D3_COD,;
		(cAliasMO)->B1_DESC,;
		(cAliasMO)->B1_TIPO,;
		(cAliasMO)->B1_GRUPO,;
		(cAliasMO)->B1_GRPGDM,;
		(cAliasMO)->B1_DESCGRP  })

		(cAliasMO)->(dbSkip())
	EndDo

	DbSelectArea(cAliasMO)
	(cAliasMO)->(dbCloseArea())

Return aDados

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫ Programa ≥ AtuSX1   ∫ Autor ≥ TOTVS Protheus     ∫ Data ≥  04/06/13   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫ Descricao≥ Atualizacao do SX1 - Perguntas                             ≥±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±≥ Uso      ≥ AtuSX1     - Gerado por EXPORDIC / Upd. V.4.10.7 EFS       ≥±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
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

	aEstrut := { "X1_GRUPO"  , "X1_ORDEM"  , "X1_PERGUNT", "X1_PERSPA" , "X1_PERENG" , "X1_VARIAVL", "X1_TIPO"   , ;
	"X1_TAMANHO", "X1_DECIMAL", "X1_PRESEL" , "X1_GSC"    , "X1_VALID"  , "X1_VAR01"  , "X1_DEF01"  , ;
	"X1_DEFSPA1", "X1_DEFENG1", "X1_CNT01"  , "X1_VAR02"  , "X1_DEF02"  , "X1_DEFSPA2", "X1_DEFENG2", ;
	"X1_CNT02"  , "X1_VAR03"  , "X1_DEF03"  , "X1_DEFSPA3", "X1_DEFENG3", "X1_CNT03"  , "X1_VAR04"  , ;
	"X1_DEF04"  , "X1_DEFSPA4", "X1_DEFENG4", "X1_CNT04"  , "X1_VAR05"  , "X1_DEF05"  , "X1_DEFSPA5", ;
	"X1_DEFENG5", "X1_CNT05"  , "X1_F3"     , "X1_PYME"   , "X1_GRPSXG" , "X1_HELP"   , "X1_PICTURE", ;
	"X1_IDFIL"   }

	aAdd( aDados, {cPerg,'01','Cliente de ?','Cliente de ?','Cliente de ?','MV_CH0','C',6,0,0,'G','','MV_PAR01','','','','','','','','','','','','','','','','','','','','','','','','','SA1','','','','',''} )
	aAdd( aDados, {cPerg,'02','Loja de ?','Loja de ?','Loja de ?','MV_CH0','C',2,0,0,'G','','MV_PAR02','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPerg,'03','Cliente Ate ?','Cliente Ate ?','Cliente Ate ?','MV_CH0','C',6,0,0,'G','','MV_PAR03','','','','','','','','','','','','','','','','','','','','','','','','','SA1','','','','',''} )
	aAdd( aDados, {cPerg,'04','Loja Ate ?','Loja Ate ?','Loja Ate ?','MV_CH0','C',2,0,0,'G','','MV_PAR04','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPerg,'05','Periodo de ?','Periodo de ?','Periodo de ?','MV_CH0','D',8,0,0,'G','','MV_PAR05','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPerg,'06','Period Ate ?','Periodo Ate ?','Periodo Ate ?','MV_CH0','D',8,0,0,'G','','MV_PAR06','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPerg,'07','Filial de ?','Filial de ?','Filial de ?','MV_CH0','C',02,0,0,'G','','MV_PAR07','','','','','','','','','','','','','','','','','','','','','','','','','SM0','','','','',''} )
	aAdd( aDados, {cPerg,'08','Filial Ate ?','Filial Ate ?','Filial Ate ?','MV_CH0','C',02,0,0,'G','','MV_PAR08','','','','','','','','','','','','','','','','','','','','','','','','','SM0','','','','',''} )
	// Atualizando dicion·rio
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


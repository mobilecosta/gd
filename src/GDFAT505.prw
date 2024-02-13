#Include "Protheus.ch"
#Include 'FWMBrowse.ch'
#INCLUDE 'FWMVCDEF.CH'
#include "topconn.ch"
#Include "RPTDEF.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"
#Include "AvPrint.ch"
#INCLUDE "rwmake.ch"

#DEFINE LINHAS 99999
#DEFINE GD_ENTER	CHR(13)+CHR(10)

/*
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GDFAT505  ³ Autor ³ Josuel Silva          ³ Data ³01/12/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina para realizar geracao de pedido de venda de retorno  ³±±
±±³          ³de material de terceiro utilizado na producao.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 								                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 								                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GDFAT505                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GDFAT505()

	Local cAlias  	:= "Z9A"
	Local oBrowse 	:= FWMBrowse():New()
	Private aRotina := MenuDef()
	Private cCadastro := OemtoAnsi("Material de Consumo - Poder de Terceiro")

	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAlias)
	//***********Adiciona Opção Filtros com Legendas*******
	oBrowse:AddLegend('Z9A->Z9A_STATUS == "1"'	, "GREEN"    ,"Pedido Gerado"    )
	oBrowse:AddLegend('Z9A->Z9A_STATUS == "2"'	, "YELLOW"   ,"Sem Pedido de Retorno")
	oBrowse:SetDescription(OemtoAnsi("Material de Consumo - Poder de Terceiro")	)
	oBrowse:DisableDetails()
	oBrowse:SetAmbiente(.F.)
	oBrowse:SetWalkThru(.F.)
	oBrowse:Activate()


Return NIL


Static Function MenuDef()

Local aRotina := {}

	ADD OPTION aRotina TITLE "Pesquisar"  			ACTION "PESQBRW"     	OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Visualizar" 			ACTION "U_GD505VIS('Z9A',RecNo(),2)" 	OPERATION 2 ACCESS 0 // Chama a Visualização pela Rotina GPEST444
	ADD OPTION aRotina TITLE "Gerar Pedidos"   		ACTION "MsgRun ( 'Aguarde... Processando...', '',{ || U_GD505ATU()})" 	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Imprimir	"   		ACTION "U_GD505IMP()" 	OPERATION 9 ACCESS 0
	ADD OPTION aRotina TITLE "Legenda	"  			ACTION "U_GD505LEG()"  	OPERATION 9 ACCESS 0

Return aRotina


User Function GD505LEG()

	Local aLegenda :={}

	aLegenda := {	{ "BR_VERDE"		,"Pedido Gerado" 			},;
					{ "BR_AMARELO"	,"Sem Pedido de Retorno"	}}


	BrwLegenda(cCadastro,"Legenda",aLegenda)

Return nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GD505ATU  ³ Autor ³Josuel Silva           ³ Data ³ 240/03/14³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina de Retorno de Material de Poder de Terceiros.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GDFAT505()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ .T. / .F.                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GDFAT505                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GD505ATU()

	Local cQrySD2   	:= ""

	Local cClienteDe
	Local cClienteAte
	Local cProdutoDe
	Local cProdutoAte
	Local cNfRemDe
	Local cNfRemAte
	Local cSerieNF

	Local cJoin		   	:= ""
	Local cWhere		:= ""
	Local cAliasSC9 	:= GetNextAlias()

	Private cPergSZ9		:= 'GDFAT505'
	Private cGrpTerceiro  := SUPERGETMV("GD_GRPTERC", .F., "CPTC/CTGC/CPTP/CTGP/CPTS/CTGS")  //Grupo de Terceiros para Considerar para Baixa de Terceiro
	Private cGrupos		:=  ''

	Private cNumeroOP 	:= ""
	Private cNumPV	  	:= ""
	PRivate cItemPV		:= ""
	Private cTesRetorno	:= ""
	Private dDtFatDe
	Private dDtFatAte
	Private dDatade
	Private dDataAte
	Private cMensPad	:= ""
	Private cTpFrete	:= ""
	Private cProdBlq	:= ""
	Private aProdBlq	:= {}


	cGrupos := "'"
	cGrupos +=  StrTran(cGrpTerceiro, "/", "','")
	cGrupos += "'"

	CHKFILE("Z9A")

	AtuSX1(cPergSZ9)
	If !Pergunte(cPergSZ9,.T.)
		Return
	Else
		dDatade		:= Dtos(mv_par01)
		dDataAte    	:= Dtos(mv_par02)
		cClienteDe		:= MV_PAR03
		cLojaDe		:= MV_PAR04
		cClienteAte	:= MV_PAR05
		cLojaAte		:= MV_PAR06
		cTesRetorno	:= MV_PAR07
		cNfRemDe		:= MV_PAR08
		cNfRemAte		:= MV_PAR09
		cSerieNF		:= ALLTRIM(MV_PAR10)
		cMensPad		:= ALLTRIM(MV_PAR11)
		cTpFrete		:= MV_PAR12
	EndIf

	IF ! MsgYesNo("Deseja gerar os Pedidos de Retorno de Materiais de Terceiros ?","::: Gerar Pedido de Terceiros :::")
		Return
	EndIF

	 cJoin += "%"
	 cJoin += "  JOIN " + RetSqlName("SC6") + " AS SC6 ON SC6.C6_FILIAL = '" + xFilial("SC6")	+ "' "
	 cJoin += "  AND SC6.C6_NUM = SD2.D2_PEDIDO  "
	 cJoin += "  AND SC6.C6_ITEM = SD2.D2_ITEMPV  "
	 cJoin += "  AND SC6.C6_CLI = SD2.D2_CLIENTE  "
	 cJoin += "  AND SC6.C6_LOJA = SD2.D2_LOJA  "
	 cJoin += "  AND SC6.C6_PRODUTO = SD2.D2_COD  "
	 cJoin += "  AND SC6.D_E_L_E_T_		= ''  "
	 cJoin += "  AND SC6.C6_NUMOP		<> ''  "
	 cJoin += "  AND SC6.C6_ITEMOP		<> ''  "
	 cJoin += "  JOIN " + RetSqlName("SC9") + " AS SC9 ON SC9.C9_FILIAL ='" + xFilial("SC9")	+ "' "
	 cJoin += "  AND SC9.C9_PEDIDO	= SD2.D2_PEDIDO  "
	 cJoin += "  AND SC9.C9_ITEM	= SD2.D2_ITEMPV  "
	 cJoin += "  AND SC9.C9_CLIENTE = SD2.D2_CLIENTE  "
	 cJoin += "  AND SC9.C9_LOJA	= SD2.D2_LOJA  "
	 cJoin += "  AND SC9.C9_PRODUTO = SD2.D2_COD  "
	 cJoin += "  AND SC9.D_E_L_E_T_ = ''  "
	 cJoin += "  AND SC9.C9_NFISCAL = SD2.D2_DOC "
	 cJoin += "  AND SC9.C9_SERIENF = SD2.D2_SERIE "
	 cJoin += "  AND SC9.C9_NUMSEQ	= SD2.D2_NUMSEQ  "
	 cJoin += "%"

	BeginSql Alias cAliasSC9
		SELECT 	C6_NUMOP
	 	FROM %table:SD2% SD2
	 	%Exp:cJoin%
	 	WHERE 	SD2.D2_FILIAL = %xFilial:SD2%
		AND 	SD2.D2_CLIENTE >= %exp:cClienteDe% AND SD2.D2_CLIENTE <= %exp:cClienteAte%
		AND 	SD2.D2_LOJA >= %exp:cLojaDe% 	AND SD2.D2_LOJA <= %exp:cLojaAte%
		AND 	SD2.D2_DOC >= %exp:cNfRemDe%   	AND SD2.D2_DOC <= %exp:cNfRemAte%
		AND 	SD2.D2_SERIE = %exp:cSerieNF%
		AND 	SD2.D2_EMISSAO >= %exp:dDatade%  AND SD2.D2_EMISSAO <= %exp:dDataAte%
		AND 	SD2.%NotDel%
   		GROUP BY SC6.C6_NUMOP
   		ORDER BY SC6.C6_NUMOP

	EndSql

	dbSelectArea(cAliasSC9)
	(cAliasSC9)->(DbGoTop())

	IF (cAliasSC9)->(Eof())
		dbSelectArea(cAliasSC9)
		(cAliasSC9)->(dbCloseArea())
		Return
	EndIF

	While !(cAliasSC9)->(Eof())
		cNumeroOP		:= (cAliasSC9)->C6_NUMOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Consulta Material Consumido de  Terceiro e Grava na Tabela Z9A ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_GD505SD3(cNumeroOP)

		(cAliasSC9)->(DBSKIP())
	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Rotina para atualizar Material Consumido com as NFs de Remessa ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	MsgRun ( "Aguarde... Atualizando informações - Z9A..", "",{ ||U_GD505Z9A(cClienteDe,cLojaDe,cClienteAte,cLojaAte,dDatade,dDataAte,cNfRemDe,cNfRemAte,cSerieNF)})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Rotina para Geracao dos Pedidos de Retorno de Materiais.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgRun ( "Aguarde... Gerando Pedidos de Vendas - Retorno de Materiais.", "",{ ||U_GD505PV(cClienteDe,cLojaDe,cClienteAte,cLojaAte,dDatade,dDataAte,cTesRetorno,cNfRemDe,cNfRemAte,cSerieNF)})

	dbSelectArea(cAliasSC9)
	(cAliasSC9)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GD505SD3  ºAutor³Josuel Silva-Sservice º Data ³  01/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar a consulta dos produtos     º±±
±±º          ³consumidos nas Ordens de Producao dos Pedidos de Vendas.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GDFAT505                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User  Function GD505SD3(cNumeroOP)

Local cProdSD3		:= ""
Local cJoin		   	:= ""
Local cWhere		:= ""
Local cAliasSD3 	:= GetNextAlias()

cJoin := "%"
cJoin += "  JOIN " + RetSqlName("SB1") + " SB1 "
cJoin += "  ON 	SB1.B1_FILIAL	= '" + xFilial("SB1")	+ "' "
cJoin += "  AND SB1.B1_COD = SD3.D3_COD "
cJoin += "  AND SB1.D_E_L_E_T_ ='' "
cJoin += "%"

cWhere += "%"
cWhere += " AND SD3.D3_ESTORNO <> 'S'	"
cWhere += " AND SD3.D3_TIPO <> 'MO' 	"
cWhere += " AND SD3.D3_TM <> '010' 		"
cWhere += " AND SB1.B1_GRUPO IN (" + cGrupos + ")		"
cWhere += "%"



	BeginSql Alias cAliasSD3
		SELECT 	D3_COD
				,D3_GRUPO
				,D3_QUANT
				,D3_OP
				,D3_NUMSEQ
				,D3_IDENT
				,D3_DOC
				,D3_EMISSAO
				,B1_DESC
				,B1_GRUPO
				,B1_CODCLI
				,B1_LOJA
	 	FROM %table:SD3% SD3
	 	%Exp:cJoin%
	 	WHERE 	SD3.D3_FILIAL = %xFilial:SD3%
		AND		SD3.D3_DOC = %exp:cNumeroOP%
		AND 	SD3.%NotDel%
				%Exp:cWhere%
		ORDER BY SD3.D3_OP,SD3.D3_QUANT,SD3.D3_NUMSEQ,SD3.D3_IDENT,SD3.D3_EMISSAO,SD3.R_E_C_N_O_,SB1.R_E_C_N_O_

	EndSql

	dbSelectArea(cAliasSD3)
	(cAliasSD3)->(DbGoTop())

	IF (cAliasSD3)->(Eof())
		dbSelectArea(cAliasSD3)
		(cAliasSD3)->(dbCloseArea())
		Return
	EndIF

	DbSelectArea("Z9A")
	Z9A->(DbSetOrder(1))

	DbSelectArea("SC2")
	SC2->(dbSetOrder(1))

	While (cAliasSD3)->(!Eof())
		If SC2->(dbSeek(xFilial("SC2")+(cAliasSD3)->D3_OP))
			cNumPV	:= SC2->C2_PEDIDO
			cItemPV	:= SC2->C2_ITEMPV
		EndIf

		IF (cAliasSD3)->B1_GRUPO == "CTEC"
			cProdSD3	:= U_BuscaProdCartao((cAliasSD3)->D3_COD)
		Else
			cProdSD3	:= (cAliasSD3)->D3_COD
		EndIF

		IF !(Z9A->(DBSEEK(xFilial("Z9A") + (cAliasSD3)->(D3_OP+D3_NUMSEQ+D3_IDENT+D3_DOC+D3_COD))))
			If RecLock("Z9A",.T.)
				Z9A->Z9A_FILIAL	:= xFilial("Z9A")
				Z9A->Z9A_OP		:= (cAliasSD3)->D3_OP
				Z9A->Z9A_PVREM	:= cNumPV  //PEDIDO DE VENDA
				Z9A->Z9A_ITPVRE	:= cItemPV //ITEM DO PEDIDO DE VENDA
				Z9A->Z9A_SEQFAT	:= '001'
				Z9A->Z9A_PRODUT	:= cProdSD3 //(cAliasSD3)->D3_COD
				Z9A->Z9A_GRUPO	:= (cAliasSD3)->D3_GRUPO
				Z9A->Z9A_CLIENT	:= (cAliasSD3)->B1_CODCLI
				Z9A->Z9A_LOJA	:= (cAliasSD3)->B1_LOJA
				Z9A->Z9A_QUANT	:= Ceiling((cAliasSD3)->D3_QUANT)
				Z9A->Z9A_NUMSEQ	:= (cAliasSD3)->D3_NUMSEQ
				Z9A->Z9A_IDTSD3	:= (cAliasSD3)->D3_IDENT
				Z9A->Z9A_DOCSD3	:= (cAliasSD3)->D3_DOC
				Z9A->Z9A_STATUS	:= '2' //NAO GERADO PV
				Z9A->Z9A_DATA	:= STOD((cAliasSD3)->D3_EMISSAO)
				Z9A->Z9A_DTINC	:= dDATABASE
				Z9A->Z9A_USER	:= Upper(cUserName)
				Z9A->(MsUnlock())
			EndIf
		EndIF

		(cAliasSD3)->(DBSKIP())
	EndDo

dbSelectArea(cAliasSD3)
(cAliasSD3)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GD505Z9A  ºAutor³Josuel Silva-Sservice º Data ³  01/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar a atualizacao na tabela     º±±
±±º          ³Z9A dos produtos que foram consumidos nas OPs.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GDFAT505                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GD505Z9A(cClienteDe,cLojaDe,cClienteAte,cLojaAte,dDatade,dDataAte,cNfRemDe,cNfRemAte,cSerieNF)
Local 	cLocal	:= "90"
Local 	cRecnoZ9A

Local cJoin		   	:= ""
Local cWhere		:= ""
Local cAliasZ9A 	:= GetNextAlias()

 cJoin += "%"
 cJoin += "  JOIN " + RetSqlName("SC6") + " AS SC6 ON SC6.C6_FILIAL = '" + xFilial("SC6")	+ "' "
 cJoin += "  AND SC6.C6_NUM = SD2.D2_PEDIDO  "
 cJoin += "  AND SC6.C6_ITEM = SD2.D2_ITEMPV  "
 cJoin += "  AND SC6.C6_CLI = SD2.D2_CLIENTE  "
 cJoin += "  AND SC6.C6_LOJA = SD2.D2_LOJA  "
 cJoin += "  AND SC6.C6_PRODUTO = SD2.D2_COD  "
 cJoin += "  AND SC6.D_E_L_E_T_		= ''  "
 cJoin += "  AND SC6.C6_NUMOP		<> ''  "
 cJoin += "  AND SC6.C6_ITEMOP		<> ''  "
 cJoin += "  JOIN " + RetSqlName("SC9") + " AS SC9 ON SC9.C9_FILIAL ='" + xFilial("SC9")	+ "' "
 cJoin += "  AND SC9.C9_PEDIDO	= SD2.D2_PEDIDO  "
 cJoin += "  AND SC9.C9_ITEM	= SD2.D2_ITEMPV  "
 cJoin += "  AND SC9.C9_CLIENTE = SD2.D2_CLIENTE  "
 cJoin += "  AND SC9.C9_LOJA	= SD2.D2_LOJA  "
 cJoin += "  AND SC9.C9_PRODUTO = SD2.D2_COD  "
 cJoin += "  AND SC9.D_E_L_E_T_ = ''  "
 cJoin += "  AND SC9.C9_NFISCAL = SD2.D2_DOC "
 cJoin += "  AND SC9.C9_SERIENF = SD2.D2_SERIE "
 cJoin += "  AND SC9.C9_NUMSEQ	= SD2.D2_NUMSEQ  "
 cJoin += "%"

	BeginSql Alias cAliasZ9A
		SELECT 	D2_DOC,D2_SERIE,D2_ITEM,D2_LOCAL,D2_QUANT
				,D2_PEDIDO,D2_ITEMPV,D2_CLIENTE,D2_LOJA,D2_EMISSAO
				,C6_NUM,C6_ITEM,C6_NOTA,C6_NUMOP,C6_ITEMOP
	 	FROM %table:SD2% SD2
	 	%Exp:cJoin%
	 	WHERE 	SD2.D2_FILIAL = %xFilial:SD2%
		AND 	SD2.D2_CLIENTE >= %exp:cClienteDe% AND SD2.D2_CLIENTE <= %exp:cClienteAte%
		AND 	SD2.D2_LOJA >= %exp:cLojaDe% 	AND SD2.D2_LOJA <= %exp:cLojaAte%
		AND 	SD2.D2_DOC >= %exp:cNfRemDe%   	AND SD2.D2_DOC <= %exp:cNfRemAte%
		AND 	SD2.D2_SERIE = %exp:cSerieNF%
		AND 	SD2.D2_EMISSAO >= %exp:dDatade%  AND SD2.D2_EMISSAO <= %exp:dDataAte%
		AND 	SD2.%NotDel%
		ORDER BY SC9.C9_PEDIDO,SC9.C9_ITEM,SC9.C9_NUMSEQ
	EndSql

	dbSelectArea(cAliasZ9A)
	(cAliasZ9A)->(DbGoTop())

	IF (cAliasZ9A)->(Eof())
		dbSelectArea(cAliasZ9A)
		(cAliasZ9A)->(dbCloseArea())
		Return
	EndIF

	DbSelectArea("Z9A")
	Z9A->(DbSetOrder(6))

	While !(cAliasZ9A)->(Eof())
		IF !Z9A->(DbSeek(xFilial("Z9A") + (cAliasZ9A)->D2_PEDIDO + (cAliasZ9A)->D2_ITEMPV ))
			(cAliasZ9A)->(DBSKIP())
			Loop
		Else
		   While !Z9A->(Eof()) .and. (cAliasZ9A)->(D2_PEDIDO+D2_ITEMPV) == Z9A->(Z9A_PVREM+Z9A_ITPVRE) .AND. !Empty(Z9A->Z9A_NFREM)
				Z9A->(DBSKIP())
		   EndDo
		EndIF

		cSeekZ9A := Z9A->(Z9A_PVREM+Z9A_ITPVRE+Z9A_NUMSEQ+Z9A_IDTSD3+Z9A_DOCSD3+Z9A_SEQFAT)
		While !Z9A->(Eof()) .and.	cSeekZ9A == Z9A->(Z9A_PVREM+Z9A_ITPVRE+Z9A_NUMSEQ+Z9A_IDTSD3+Z9A_DOCSD3+Z9A_SEQFAT)
			IF !Empty(Z9A->Z9A_NFREM)
				cSeekZ9A := Z9A->(Z9A_PVREM+Z9A_ITPVRE+Z9A_NUMSEQ+Z9A_IDTSD3+Z9A_DOCSD3+Z9A_SEQFAT)
				Z9A->(DBSKIP())
				Loop
			ElseiF EmptY(Z9A->Z9A_NFRET)
				IF  Z9A->Z9A_QUANT == (cAliasZ9A)->D2_QUANT
					If RecLock("Z9A",.F.)
						Z9A->Z9A_STATUS		:= '2'
						Z9A->Z9A_QTDREM		:= (cAliasZ9A)->D2_QUANT
						Z9A->Z9A_NFREM		:= (cAliasZ9A)->D2_DOC
						Z9A->Z9A_SERREM		:= (cAliasZ9A)->D2_SERIE
						Z9A->Z9A_DTREM		:= STOD((cAliasZ9A)->D2_EMISSAO)
						Z9A->Z9A_ALMOX		:= (cAliasZ9A)->D2_LOCAL
						Z9A->(MsUnlock())
					EndIF
				ELSEIF  (cAliasZ9A)->D2_QUANT <  Z9A->Z9A_QUANT
					nQuantZ9A	:= 	Z9A->Z9A_QUANT
					cRecnoZ9A	:= Z9A->(RECNO())

					If RecLock("Z9A",.F.)
						Z9A->Z9A_STATUS	:= '2'
						Z9A->Z9A_QUANT	:= (cAliasZ9A)->D2_QUANT
						Z9A->Z9A_QTDREM	:= (cAliasZ9A)->D2_QUANT
						Z9A->Z9A_NFREM	:= (cAliasZ9A)->D2_DOC
						Z9A->Z9A_SERREM	:= (cAliasZ9A)->D2_SERIE
						Z9A->Z9A_DTREM	:= STOD((cAliasZ9A)->D2_EMISSAO)
						Z9A->Z9A_ALMOX 	:= (cAliasZ9A)->D2_LOCAL
						Z9A->(MsUnlock())
					EndIF


					RegToMemory("Z9A",.F.,.F.)
									//Grava novo Registro
					If RecLock("Z9A",.T.)
						Z9A->Z9A_FILIAL		:= xFilial("Z9A")
						Z9A->Z9A_OP			:= M->Z9A_OP
						Z9A->Z9A_PRODUT		:= M->Z9A_PRODUT
						Z9A->Z9A_QUANT		:= nQuantZ9A - (cAliasZ9A)->D2_QUANT
						Z9A->Z9A_PEDIDO		:= M->Z9A_PEDIDO
						Z9A->Z9A_ITEMPV		:= M->Z9A_ITEMPV
						Z9A->Z9A_DOCSB6		:= M->Z9A_DOCSB6
						Z9A->Z9A_SERSB6		:= M->Z9A_SERSB6
						Z9A->Z9A_IDENT		:= M->Z9A_IDENT
						Z9A->Z9A_DATA		:= M->Z9A_DATA
						Z9A->Z9A_CLIENT		:= M->Z9A_CLIENT
						Z9A->Z9A_LOJA		:= M->Z9A_LOJA
						Z9A->Z9A_DTPV		:= M->Z9A_DTPV
						Z9A->Z9A_STATUS		:= '2'
						Z9A->Z9A_ALMOX		:= M->Z9A_ALMOX
						Z9A->Z9A_GRUPO		:= M->Z9A_GRUPO
						Z9A->Z9A_NUMSEQ		:= M->Z9A_NUMSEQ
						Z9A->Z9A_IDTSD3		:= M->Z9A_IDTSD3
						Z9A->Z9A_DOCSD3		:= M->Z9A_DOCSD3
						Z9A->Z9A_NFREM		:= '' //NF Remetida
						Z9A->Z9A_SERREM		:= '' //Serie NF Remetida
						Z9A->Z9A_PVREM		:= (cAliasZ9A)->C6_NUM
						Z9A->Z9A_ITPVRE		:= (cAliasZ9A)->C6_ITEM
						Z9A->Z9A_QTDREM		:= 0 //Quantidade da NF Remetida
						Z9A->Z9A_SEQFAT		:= Soma1(M->Z9A_SEQFAT) //Incrementa 1 para proxima sequencia de faturamento
						Z9A->Z9A_DTRET		:= M->Z9A_DTRET
						Z9A->Z9A_NFRET		:= M->Z9A_NFRET
						Z9A->Z9A_SERRET		:= M->Z9A_SERRET
						Z9A->Z9A_ITNFRE		:= M->Z9A_ITNFRE
						Z9A->Z9A_DTINC		:= M->Z9A_DTINC
						Z9A->Z9A_USER		:= M->Z9A_USER
						Z9A->(MsUnlock())

						Z9A->(dbGoto(cRecnoZ9A))
					EndIF

				ElseIF  (cAliasZ9A)->D2_QUANT >  Z9A->Z9A_QUANT
					If RecLock("Z9A",.F.)
						Z9A->Z9A_STATUS 	:= '2'
						Z9A->Z9A_QTDREM 	:= Z9A->Z9A_QUANT
						Z9A->Z9A_NFREM 		:= (cAliasZ9A)->D2_DOC
						Z9A->Z9A_SERREM 	:= (cAliasZ9A)->D2_SERIE
						Z9A->Z9A_DTREM 		:= STOD((cAliasZ9A)->D2_EMISSAO)
						Z9A->Z9A_ALMOX 		:= (cAliasZ9A)->D2_LOCAL
						Z9A->(MsUnlock())
					EndIF

					Z9A->(DBSKIP())
					cSeekZ9A := Z9A->(Z9A_PVREM+Z9A_ITPVRE+Z9A_NUMSEQ+Z9A_IDTSD3+Z9A_DOCSD3+Z9A_SEQFAT)
					Loop
				EndIf    //Final do Bloco
			EndiF
			cSeekZ9A := Z9A->(Z9A_PVREM+Z9A_ITPVRE+Z9A_NUMSEQ+Z9A_IDTSD3+Z9A_DOCSD3+Z9A_SEQFAT)
			Z9A->(DBSKIP())
		EndDo

		(cAliasZ9A)->(DBSKIP())
	EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GD505PV   ºAutor³Josuel Silva-Sservice º Data ³  01/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar a atualizacao na tabela     º±±
±±º          ³Z9A dos produtos que foram consumidos nas OPs.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GDFAT505                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GD505PV(cClienteDe,cLojaDe,cClienteAte,cLojaAte,dDatade,dDataAte,cTesRetorno,cNfRemDe,cNfRemAte,cSerieNF)

	Local nI			:= 0
	Local lOk    	:= .T.
	Local lPrimeiro	:= .T.
	Local aSC5 		:= {}
	Local cNumerosPV	:= ""
	Local cNumPv		:= ""
	Local cCondPag	:= ""
	Local cFrete		:= ""
	Local cQryZ9A 	:= ""
	Local cCliPV		:= ""
	Local cLojaPV 	:= ""
	Local cClientePV	:= ""
	Local cLjCliPV	:= ""
	Local cProduto	:= ""
	Local nQtdZ9A		:= 0
	Local cLocal		:= "90"
	Local aPvGerados	:= {}

	Local cJoin		   	:= ""
	Local cWhere		:= ""
	Local cAliasPV 		:= GetNextAlias()

	Private aSaldoSB6	:= {}
	Private aRecZ9A	:= {}
	Private cProdAnt	:= ""
	Private cProdFat	:= ""
	Private nRestSaldo	:= 0
	Private lMsErroAuto	:= .F.
	Private lMsHelpAuto	:= .F.

	Private aSC6 		:= {}

	Private cItem		:= "00"
	Private aLinha	:= {}
	Private aSC6Z9A	:= {}

	cJoin := "%"
	cJoin += "  JOIN " + RetSqlName("SB1") + " SB1 "
	cJoin += "  ON 	SB1.B1_FILIAL	= '" + xFilial("SB1")	+ "' "
	cJoin += "  AND SB1.B1_COD = Z9A.Z9A_PRODUT"
	cJoin += "  AND SB1.D_E_L_E_T_ ='' "
	cJoin += "%"

	cWhere += "%"
	cWhere += " AND Z9A_PEDIDO = '' AND Z9A_DOCSB6 =''	"
	cWhere += " AND Z9A_SERSB6 = '' AND Z9A_IDENT = ''	"
	cWhere += "%"

	BeginSql Alias cAliasPV
		SELECT 	Z9A.Z9A_CLIENT,Z9A.Z9A_LOJA, Z9A.Z9A_PRODUT,Z9A.Z9A_QUANT,Z9A.Z9A_QTDREM,
				Z9A.Z9A_DTINC,Z9A.Z9A_PVREM,Z9A.Z9A_ITPVRE,Z9A.Z9A_NFREM,
				Z9A.Z9A_SERREM,Z9A.R_E_C_N_O_ AS RECZ9A,
				SB1.B1_CODANT
	 	FROM %table:Z9A% Z9A
	 	%Exp:cJoin%
	 	WHERE 	Z9A.Z9A_FILIAL = %xFilial:SD2%
		AND 	Z9A.Z9A_CLIENT >= %exp:cClienteDe% AND Z9A.Z9A_CLIENT <= %exp:cClienteAte%
		AND 	Z9A.Z9A_LOJA >= %exp:cLojaDe% 	AND Z9A.Z9A_LOJA <= %exp:cLojaAte%
		AND 	Z9A.Z9A_NFREM >= %exp:cNfRemDe%   	AND Z9A.Z9A_NFREM <= %exp:cNfRemAte%
		AND 	Z9A.Z9A_SERREM = %exp:cSerieNF%
		AND 	Z9A.Z9A_DTREM >= %exp:dDatade%  AND Z9A.Z9A_DTREM <= %exp:dDataAte%
		AND 	Z9A.%NotDel%
				%Exp:cWhere%
		ORDER BY Z9A.Z9A_CLIENT,Z9A.Z9A_LOJA,Z9A.Z9A_PRODUT,Z9A.Z9A_PVREM,Z9A.Z9A_ITPVRE,Z9A.R_E_C_N_O_,SB1.R_E_C_N_O_

	EndSql

	dbSelectArea(cAliasPV)
	(cAliasPV)->(DbGoTop())

	IF (cAliasPV)->(Eof())
		dbSelectArea(cAliasPV)
		(cAliasPV)->(dbCloseArea())
		Aviso("Pedido de Venda","Não foram gerados Pedidos de Vendas com os parâmetros informados.",{"OK"},3)
		Return
	EndIF

	cCliPV := (cAliasPV)->Z9A_CLIENT
	cLojaPV := (cAliasPV)->Z9A_LOJA

	dbSelectArea("SB2")
	SB2->(dbsetorder(1))

	While (cAliasPV)->(!Eof())

		While (cAliasPV)->(!Eof()) .AND. cCliPV ==  (cAliasPV)->Z9A_CLIENT .and. cLojaPV == (cAliasPV)->Z9A_LOJA

			cProduto 	:= (cAliasPV)->Z9A_PRODUT
			cProdAnt	:= (cAliasPV)->B1_CODANT
			nQtdZ9A	:= 0

			If lPrimeiro
				lPrimeiro	:= .F.
				cClientePV	:= (cAliasPV)->Z9A_CLIENT
				cLjCliPV	:= (cAliasPV)->Z9A_LOJA
				cCondPag 	:= POSICIONE("SA1",1,xFilial("SA1")+cClientePV+cLjCliPV,"A1_COND")
			EndIF

			While (cAliasPV)->(!Eof()) .AND. cCliPV ==  (cAliasPV)->Z9A_CLIENT .and. cLojaPV == (cAliasPV)->Z9A_LOJA .and. cProduto == (cAliasPV)->Z9A_PRODUT
				nQtdZ9A := nQtdZ9A + (cAliasPV)->Z9A_QTDREM
				AADD(aRecZ9A,(cAliasPV)->RECZ9A)
				(cAliasPV)->(dbSkip())
			EndDo

			IF !Empty(cProdAnt)
				IF !(SB2->(DbSeek(xFilial("SB2")+  AvKey(cProdAnt,"B2_COD") + AvKey(cLocal,"B2_LOCAL"))))
					CriaSB2(cProdAnt,cLocal)
				EndIF

		   		nRet	:= GD505SB6(cCliPV,cLojaPV,cProdAnt,nQtdZ9A,cTesRetorno)
		 	Else
				IF !(SB2->(DbSeek(xFilial("SB2")+  AvKey(cProduto,"B2_COD") + AvKey(cLocal,"B2_LOCAL"))))
					CriaSB2(cProduto,cLocal)
				EndIF


			 	nRet	:= GD505SB6(cCliPV,cLojaPV,cProduto,nQtdZ9A,cTesRetorno)
			EndIF

			IF !Empty(cProdAnt) .and. nRet > 0
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Altera o Status dos Itens gerados Pedidos.                   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				GD505SB6(cCliPV,cLojaPV,cProduto,nQtdZ9A,cTesRetorno)
			EndIF
			aRecZ9A := {}
		Enddo

			IF Len(aProdBlq) > 0
				Aviso(".:: G&D - BLOQUEIO ::.","Os pedidos não serão gerados devido alguns produtos estarem bloqueados ou não autorizado o Uso. Favor verificar !" +  GD_ENTER +  cProdBlq, {'Ok'},3)
				Return
			EndiF

			cCliPV  := (cAliasPV)->Z9A_CLIENT
			cLojaPV := (cAliasPV)->Z9A_LOJA

			IF Empty(aSC6)
			  	nI := 0
				lPrimeiro	:= .T.
				aSC5 		:= {}
				aSC6 		:= {}
				aLinha		:= {}
				cItem		:= "00"
				cFrete		:= "C"
				cCliPV		:= (cAliasPV)->Z9A_CLIENT
				cLojaPV 	:= (cAliasPV)->Z9A_LOJA
				aRecZ9A	:= {}
				aSC6Z9A	:= {}
			   Loop
			Else
				cNumPv	:= GetSxeNum("SC5","C5_NUM")
				ConfirmSX8()

				IF cTpFrete == 1 //CIF
					cFrete := "C"
				ElseIF cTpFrete == 2 //FOB
					cFrete := "F"
				ElseIF cTpFrete == 3 //Por Conta de Terceiro
					cFrete := "T"
				ElseIF cTpFrete == 4 //4-Sem Frete
					cFrete := "S"
				Else
					cFrete	 := Posicione("SA1",1,xFilial("SA1")+cClientePV+cLjCliPV,"A1_TPFRET")
				EndIF

				aSC5 := {	{"C5_FILIAL"	,xFilial("SC5")	,Nil},;
							{"C5_NUM"		,cNumPv		,Nil},;
							{"C5_TIPO"   	,"N"			,Nil},;
							{"C5_CLIENTE"	,cClientePV	,Nil},;
							{"C5_LOJACLI"	,cLjCliPV		,Nil},;
							{"C5_EMISSAO"	,ddatabase		,Nil},;
							{"C5_CONDPAG"	,cCondPag		,Nil},;
							{"C5_MENPAD"	,cMensPad		,Nil},;
							{"C5_TIPLIB" 	,"1"			,Nil},;
							{"C5_TPFRETE"	,cFrete		,Nil},;
							{"C5_TPSRV"	,"N"			,Nil}}
			EndIF


		BeginTran()
		lMsErroAuto	:= .F.

		//Executa a rotina automatica de pedido de vendas

		aCloneSC6	:= aSC6
		MSExecAuto({|x,y,z| Mata410(x,y,z)},aSC5,aSC6,3)

		If lMsErroAuto
			MostraErro()
			DisarmTransaction()
			Return
		Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Altera o Status dos Itens gerados Pedidos.                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			GDFLAGZ9A(cNumPv,aSC6Z9A)
			EndTran()
		EndIf
			MsUnlockAll()

			nI := 0
			lPrimeiro	:= .T.
			aSC5 		:= {}
			aSC6 		:= {}
			aLinha		:= {}
			cItem		:= "00"
			cFrete		:= "C"
			cCliPV		:= (cAliasPV)->Z9A_CLIENT
			cLojaPV 	:= (cAliasPV)->Z9A_LOJA
			aRecZ9A	:= {}
			aSC6Z9A	:= {}

			cNumerosPV += cNumPv +  GD_ENTER

			AADD(aPvGerados,cNumPv)
	EndDo

		dbSelectArea(cAliasPV)
		(cAliasPV)->(dbCloseArea())

	if Empty(cNumerosPV)
		Aviso("Pedido de Venda","Não foram gerados Pedidos de Vendas com os parâmetros informados.",{"OK"},3)
	Else
		Aviso("Pedido de Venda","Foram incluídos os Pedidos de Vendas abaixo. " + GD_ENTER + cNumerosPV,{"OK"},3)
	EndIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GD505SB6  ºAutor³Josuel Silva-Sservice º Data ³  01/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar a atualizacao na tabela     º±±
±±º          ³Z9A dos produtos que foram consumidos nas OPs.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GDFAT505                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GD505SB6(cCliente,cLoja,cProduto,nQuantRet,cTesRetorno)
	Local cQrySB6 	:= ""
	Local lQuebra	:= .F.
	Local nRestSaldo:= nQuantRet
	Local nRetorno	:= 0
	Local cLocal	:= "90"


	cQrySB6 := " SELECT SB6.B6_DOC, SB6.B6_SERIE, SB6.B6_PRUNIT, SB6.B6_IDENT, SB6.B6_SALDO, SD1.D1_ITEM , SB6.B6_EMISSAO, "+ GD_ENTER
	cQrySB6 += " (B6_SALDO-B6_QULIB) - (SELECT COALESCE(SUM(C6_QTDVEN-C6_QTDENT),0) AS SALDOSC6 FROM " +RetSqlName('SC6') + " AS SC6 " + GD_ENTER
	cQrySB6 += " 	WHERE	SC6.C6_FILIAL = '" +xFilial("SC6")+ "'" + GD_ENTER
	cQrySB6 += " 			AND C6_CLI = B6_CLIFOR  "+ GD_ENTER
	cQrySB6 += " 			AND C6_LOJA = B6_LOJA "+ GD_ENTER
	cQrySB6 += " 			AND SC6.C6_NFORI = B6_DOC   "+ GD_ENTER
	cQrySB6 += " 			AND SC6.C6_SERIORI = B6_SERIE  "+ GD_ENTER
	cQrySB6 += " 			AND SC6.C6_IDENTB6 = B6_IDENT  "+ GD_ENTER
	cQrySB6 += " 			AND SC6.D_E_L_E_T_ = '') AS DISPSB6 "+ GD_ENTER
	cQrySB6 += " FROM  " +RetSqlName('SB6') + " AS SB6 " +  GD_ENTER
	cQrySB6 += " INNER JOIN " +RetSqlName('SD1') + " AS SD1 ON  SD1.D1_FILIAL = '"+xFilial("SD1")+"' "+ GD_ENTER
	cQrySB6 += " AND SD1.D1_DOC = B6_DOC "+ GD_ENTER
	cQrySB6 += " AND SD1.D1_SERIE = B6_SERIE "+ GD_ENTER
	cQrySB6 += " AND SD1.D1_FORNECE = B6_CLIFOR "+ GD_ENTER
	cQrySB6 += " AND SD1.D1_LOJA = B6_LOJA "+ GD_ENTER
	cQrySB6 += " AND SD1.D1_COD = B6_PRODUTO "+ GD_ENTER
	cQrySB6 += " AND SD1.D1_IDENTB6 = B6_IDENT "+ GD_ENTER
	cQrySB6 += " AND SD1.D_E_L_E_T_ = ' '  "+ GD_ENTER
	cQrySB6 += " WHERE SB6.B6_FILIAL = '"+xFilial("SB6")+"'" + GD_ENTER
	cQrySB6 += " AND SB6.B6_CLIFOR = '" +cCliente  + "'  "+ GD_ENTER
	cQrySB6 += " AND SB6.B6_LOJA = '" +cLoja + "'  "+ GD_ENTER
	cQrySB6 += " AND SB6.B6_PRODUTO = '" + cProduto +"' "+ GD_ENTER
	cQrySB6 += " AND SB6.B6_SALDO > 0  "+ GD_ENTER
	cQrySB6 += " AND SB6.B6_TPCF = 'C'  "+ GD_ENTER
	cQrySB6 += " AND SB6.D_E_L_E_T_ = ' '  "+ GD_ENTER
	cQrySB6 += " ORDER BY SB6.B6_EMISSAO "+ GD_ENTER

	cQrySB6 := ChangeQuery(cQrySB6)

	If Select('TMPSB6') > 0
		TMPSB6->( dbCloseArea() )
	Endif
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQrySB6 ), 'TMPSB6', .F., .T. )

	dbSelectArea('TMPSB6')
	TMPSB6->(dbGotop())

	dbSelectArea("SB1")
	SB1->(dbsetorder(1))


	//Verifica se o produto esta bloqueado.
	//Caso esteja, faz o desbloqueio para poder entrar no pedido de venda.
	//Pois poderá estar bloqueado mas com saldo em terceiro (SB6).
	IF TMPSB6->(!Eof())
		IF SB1->(DbSeek(xFilial("SB1")+  AvKey(cProduto,"B1_COD")))
			IF SB1->B1_MSBLQL == "1" .Or. SB1->B1_USO = 'N'

				if (ASCAN(aProdBlq,ALLTRIM(SB1->B1_COD)) == 0)
					cProdBlq += ALLTRIM(SB1->B1_COD) + '-' + ALLTRIM(SB1->B1_DESC) + GD_ENTER
					AADD(aProdBlq, ALLTRIM(SB1->B1_COD))
				EndIF
				//IF RecLock("SB1",.F.)
					//SB1->B1_MSBLQL := "2"
					//SB1->(MsUnlock())
				//EndIF
			EndIF
		EndIF
	EndIF

	While TMPSB6->(!Eof())
		If TMPSB6->DISPSB6 > 0
			aLinha		:= {}
			cItem		:= Soma1(cItem)

 			IF TMPSB6->DISPSB6 >= nRestSaldo	//.and. !lQuebra
				//nRestSaldo	:= nQuantRet - TMPSB6->DISPSB6
				nRetorno	:= 0
				aadd(aLinha,{"C6_FILIAL"	,xFilial("SC6")		,Nil})
				aadd(aLinha,{"C6_ITEM"		,cItem				,Nil})
				aadd(aLinha,{"C6_PRODUTO"	,cProduto			,Nil})
				aadd(aLinha,{"C6_LOCAL"		,cLocal				,Nil})
				aadd(aLinha,{"C6_QTDVEN"	,nRestSaldo		 	,Nil})
				aadd(aLinha,{"C6_PRCVEN"	,TMPSB6->B6_PRUNIT	,Nil})
				aadd(aLinha,{"C6_TES"		,cTesRetorno		,Nil})
				aadd(aLinha,{"C6_ENTREG"	,dDataBase+1		,Nil})
				aadd(aLinha,{"C6_NFORI"		,TMPSB6->B6_DOC		,Nil})
				aadd(aLinha,{"C6_SERIORI"	,TMPSB6->B6_SERIE	,Nil})
				aadd(aLinha,{"C6_IDENTB6"	,TMPSB6->B6_IDENT	,Nil})
				aadd(aLinha,{"C6_ITEMORI"	,TMPSB6->D1_ITEM	,Nil})
				aadd(aLinha,{"C6_PRUNIT"	,TMPSB6->B6_PRUNIT	,Nil})
				aadd(aLinha,{"C6_QTDLIB"	,nRestSaldo			,Nil})
				aAdd(aSC6,aLinha)

				AADD(aSC6Z9A,{aRecZ9A,;
								cItem,;
								cProduto,;
								nQuantRet,;
								TMPSB6->B6_DOC,;
								TMPSB6->B6_SERIE,;
								TMPSB6->B6_IDENT })
				EXIT
			ElseIF  nRestSaldo > 0
				nRestSaldo	:= nQuantRet - TMPSB6->DISPSB6
				nRetorno	:= nRestSaldo
				aadd(aLinha,{"C6_FILIAL"		,xFilial("SC6")		,Nil})
				aadd(aLinha,{"C6_ITEM"		,cItem				,Nil})
				aadd(aLinha,{"C6_PRODUTO"	,cProduto			,Nil})
				aadd(aLinha,{"C6_LOCAL"		,cLocal				,Nil})
				aadd(aLinha,{"C6_QTDVEN"		,TMPSB6->DISPSB6 	,Nil})
				aadd(aLinha,{"C6_PRCVEN"		,TMPSB6->B6_PRUNIT	,Nil})
				aadd(aLinha,{"C6_TES"		,cTesRetorno		,Nil})
				aadd(aLinha,{"C6_ENTREG"		,dDataBase+1		,Nil})
				aadd(aLinha,{"C6_NFORI"		,TMPSB6->B6_DOC		,Nil})
				aadd(aLinha,{"C6_SERIORI"	,TMPSB6->B6_SERIE	,Nil})
				aadd(aLinha,{"C6_IDENTB6"	,TMPSB6->B6_IDENT	,Nil})
				aadd(aLinha,{"C6_ITEMORI"	,TMPSB6->D1_ITEM	,Nil})
				aadd(aLinha,{"C6_PRUNIT"		,TMPSB6->B6_PRUNIT	,Nil})
				aadd(aLinha,{"C6_QTDLIB"		,TMPSB6->DISPSB6	,Nil})
				aAdd(aSC6,aLinha)
				AADD(aSC6Z9A,{aRecZ9A,;
								cItem,;
								cProduto,;
								TMPSB6->DISPSB6,;
								TMPSB6->B6_DOC,;
								TMPSB6->B6_SERIE,;
								TMPSB6->B6_IDENT })

		    EndIF
	   	EndIF
		TMPSB6->(dbSkip())
	Enddo

Return nRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GDFLAGZ9A ºAutor³Josuel Silva-Sservice º Data ³  01/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar a atualizacao na tabela     º±±
±±º          ³Z9A dos produtos que foram consumidos nas OPs.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GDFAT505                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GDFLAGZ9A(cNumPV,aSC6Z9A)
	Local aAreaZ9A	:= GetArea()
	Local nX

	dbSelectArea("Z89")
	For	nRecZ9A := 1 To Len(aSC6Z9A)
		nQItem := aSC6Z9A[nRecZ9A,4]
		For nX := 1 To Len(aSC6Z9A[nRecZ9A,1])
			IF nQItem > 0
				Z9A->(MsGoto(aSC6Z9A[nRecZ9A,1,nX]))//Posiciona no registro da tabela Z9A
				nQItem := nQItem - Z9A->Z9A_QTDREM
				IF RecLock("Z9A",.F.)
					Z9A->Z9A_PEDIDO	:= cNumPV
					Z9A->Z9A_ITEMPV	:= aSC6Z9A[nRecZ9A,2]
					Z9A->Z9A_DOCSB6	:= aSC6Z9A[nRecZ9A,5]
					Z9A->Z9A_SERSB6	:= aSC6Z9A[nRecZ9A,6]
					Z9A->Z9A_IDENT	:= aSC6Z9A[nRecZ9A,7]
					Z9A->Z9A_STATUS	:= "1"
					Z9A->(MsUnLock())
				EndIF
			EndIF
		Next nX
	Next nRecZ9A

	RestArea(aAreaZ9A)

Return




/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GD505VIS  ³ Autor ³ Josuel Silva-Sservices³ Data ³ 08/07/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa para Visualizacao dos Pedidos de Terceiros.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 								                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GDFAT505                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER Function GD505VIS(cAlias,nReg,nOpcx)

Local aArea      := GetArea()
Local nOpcA      := 0
Local oSize
Local oSize2
Local aButtons   := Nil
Local oDlg, oGet

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Walk-Thru                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local bSeekWhile := {} // Condicao While para montar o aCols
Local cSeek		 := ""
Local aAlter     := {""}
Local nUsado 	 := 0
Local aRecnos    := {}

Private nPosStatus
Private aButZ9A	:= {}
Private oZ9AGet
Private aTELA[0][0]
Private aGETS		:= {}

Private dZ9AData   	:= Z9A->Z9A_DATA
Private cNumPEDIDO   :=Z9A->Z9A_PEDIDO
Private cZ88Filial 	:= Z9A->Z9A_FILIAL
Private cCliente		:= Z9A->Z9A_CLIENT+'/'+Z9A->Z9A_LOJA +'- '+ ALLTRIM(Posicione("SA1",1,xFilial("SA1")+Z9A->(Z9A_CLIENT+Z9A_LOJA),"A1_NREDUZ"))
Private aHeader		:= {}
Private aCols		:= {}

Private oFont14N	:= TFont():New('Arial',,-14,.T.,.T.)

cAlias := 'Z9A'


	IF Empty(Z9A->Z9A_PEDIDO)
		MsgInfo("Registro selecioando não possui Pedido de  Retorno Gerado.")
		RestArea(aArea)
		Return .T.
	EndIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta aHeader e aCols utilizando a funcao FillGetDados   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSeek	   := cZ88Filial + cNumPEDIDO
	bSeekWhile := { || Z9A->Z9A_FILIAL + Z9A->Z9A_PEDIDO }


	Aadd(aHeader,{"  "                    ,     "Z9A_OK"              ,   "@BMP"                    ,     1,     0,"","",     "C","",""})
	nUsado:=nUsado+1

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta o cabecalho                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SX3")
		dbSetOrder(1)
		dbSeek(cAlias)
		While ( !Eof() .And. SX3->X3_ARQUIVO == cAlias )
			If ( X3USO(SX3->X3_USADO) .And. cNivel >= SX3->X3_NIVEL .And. !(AllTrim(x3_campo) $ "Z9A_FILIAL"))
				nUsado:=nUsado+1
				AADD(aHeader,{ AllTrim(X3Titulo()),;
								SX3->X3_CAMPO,;
								SX3->X3_PICTURE,;
								SX3->X3_TAMANHO,;
								SX3->X3_DECIMAL,;
								SX3->X3_VALID,;
								SX3->X3_USADO,;
								SX3->X3_TIPO,;
								SX3->X3_ARQUIVO,;
								SX3->X3_CONTEXT } )

			EndIf
			dbSkip()
		EndDo

	ADHeadRec("Z9A",aHeader)
	aCols	:={}
	aRecnos := {}
	dbSelectArea("Z9A")
	Z9A->(dbSetOrder(2))
	Z9A->(dbSeek(cSeek))
	While !eof().and. xFilial("Z9A") + Z9A->Z9A_PEDIDO == cZ88Filial + cNumPEDIDO
			aAdd(aCols, Array(Len(aHeader)+1))
			For nX:=1 to nUsado
				Aadd(aRecnos,{ Z9A->(Recno()),Len(aCols) })
				aCols[Len(aCols),nX]:=FieldGet(FieldPos(aHeader[nX,2]))
			Next nX
			aCols[Len(aCols)][Len(aHeader)-1] := "Z9A"
			aCols[Len(aCols)][Len(aHeader)]   := Z9A->(RecNo())
			aCols[Len(aCols),Len(aHeader)+1] := .F.
			Z9A->(dbSkip())
	Enddo



		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Tratamento para legenda no Acols							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		nPosStatus		:= Ascan(aHeader, { |x| alltrim(x[2]) == "Z9A_STATUS" })

	   	For Nx :=1 To Len(aCols)

	   		//Legenda Por linha de Status
	   		IF aCols[nX,nPosStatus] 	=="1"
				aCols[nX,1]:= LoaDbitmap( GetResources(), "BR_VERDE" )
			ElseIF aCols[nX,nPosStatus] =="2"
				aCols[nX,1]:= LoaDbitmap( GetResources(), "BR_AMARELO" )
			ElseIF aCols[nX,nPosStatus] =="4"
				aCols[nX,1]:= LoaDbitmap( GetResources(), "BR_LARANJA" )
			Elseif aCols[nX,nPosStatus] =="5"
				aCols[nX,1]:= LoaDbitmap( GetResources(), "BR_PINK" )
			EndiF
		Next Nx

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula dimensões                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSize := FwDefSize():New()
		oSize:AddObject( "CABECALHO",  100, 5, .T., .T. ) // Totalmente dimensionavel
		oSize:AddObject( "GETDADOS" ,  100, 85, .T., .T. ) // Totalmente dimensionavel

		oSize:lProp 	:= .T. // Proporcional
		oSize:aMargins 	:= { 3, 3, 3, 3 } // Espaco ao lado dos objetos 0, entre eles 3

		oSize:Process() // Dispara os calculos

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Divide cabeçalho                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSize2 := FwDefSize():New()

		oSize2:aWorkArea := oSize:GetNextCallArea( "CABECALHO" )

		oSize2:AddObject( "NUMERO"  ,  20, 100, .T., .T.) // Dimensionavel
		oSize2:AddObject( "DATA"    ,  20, 100, .T., .T.) // Dimensionavel

		oSize2:lLateral := .T.            //Calculo em Lateral
		oSize2:lProp := .T.               // Proporcional
		oSize2:aMargins := { 3, 3, 0, 0 } // Espaco ao lado dos objetos 0, entre eles 3

		oSize2:Process() // Dispara os calculos
		nOpcx := 2 //Visualizacao

		DEFINE MSDIALOG oDlg TITLE OemToAnsi("::: Visualização de Pedido de Terceiros ::: ") OF oMainWnd PIXEL;
											FROM oSize:aWindSize[1],oSize:aWindSize[2] TO oSize:aWindSize[3],oSize:aWindSize[4] OF oMainWnd PIXEL

		oSay1:= tSay():New(oSize2:GetDimension("NUMERO","LININI")+4,oSize2:GetDimension("NUMERO","COLINI"),{||'Pedido : ' + cNumPEDIDO	},oDlg,,oFont14N,,,,.T.,CLR_BLUE,CLR_WHITE,120,20)
		oSay2:= tSay():New(oSize2:GetDimension("NUMERO","LININI")+4,oSize2:GetDimension("NUMERO","COLINI")+100,{||'Cliente: ' + cCliente	},oDlg,,oFont14N,,,,.T.,CLR_RED,CLR_WHITE,200,20)
		oSay3:= tSay():New(oSize2:GetDimension("NUMERO","LININI")+4,oSize2:GetDimension("NUMERO","COLINI")+350,{||'Data de Inclusão : ' + Dtoc(dZ9AData)	},oDlg,,oFont14N,,,,.T.,CLR_BLUE,CLR_WHITE,120,20)

	   	oGet := MSGetDados():New(oSize:GetDimension("GETDADOS","LININI"),oSize:GetDimension("GETDADOS","COLINI"),;
								  oSize:GetDimension("GETDADOS","LINEND"),oSize:GetDimension("GETDADOS","COLEND"),;
								nOpcx,'AllwaysTrue','AllwaysTrue','',.F.,aAlter,NIL,NIL,LINHAS,,,,/*"A105DelIt"*/,oDlg)
		oZ9AGet := oGet
		ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||oDlg:End(),If(oGet:TudoOK(),nOpca:=1,nOpca:=0)},{||oDlg:End()},,aButZ9A)

RestArea(aArea)

Return(nOpca)




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GD505IMP    ³ Autor ³ Josuel Silva        ³ Data ³20/03/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao e gravacao da Solicitacao de NF.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GD505IMP()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ NIL                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function GD505IMP()

Local nMakeDir	:= 0
Local cPasta	:= ""
Local _nLinha 	:= 0
Local cNumPV	:= ""
Local lAdjustToLegacy := .F.
Local lDisableSetup  := .T.
Local _nQtd:=0
Local nQtdItens		:= 0
Private oPrint	:= Nil
Private cAlias	:= GetNextAlias()
//Fontes

Private oFont10		:= TFont():New('Verdana',,-10,.F.,.F.)
Private oFont12		:= TFont():New('Verdana',,-12,.F.,.F.)
Private oFont12		:= TFont():New('Verdana',,-12,.F.,.F.)
Private oFont10N	:= TFont():New('Verdana',,-10,.T.,.T.)
Private oFont20N	:= TFont():New('Verdana',,-20,.T.,.T.)

Private cTransp := ""
Private nVolume := ""
Private cEspecie := ""
Private nPBruto := ""
Private nPLiq := ""
Private cOBS := ""
Private  cNumSNF := Z9A->Z9A_PEDIDO


//Query para seleção das OPs
cAliasQry := GetNextAlias()
cQuery := ""
cQuery += " SELECT C5_NUM,C5_CLIENT,C5_LOJACLI,C5_NREDUZ,C5_TRANSP,C5_VOLUME1,C5_ESPECI1,C5_MENNOTA,C5_EMISSAO, " + GD_ENTER
cQuery += " C6_ITEM,C6_PRODUTO,C6_DESCRI,C6_TPENT,  " + GD_ENTER
cQuery += " Z9A_PEDIDO,Z9A_ITEMPV,Z9A_PRODUT,Z9A_OP,Z9A_QUANT " + GD_ENTER
cQuery += " FROM "+RetSqlName("SC5")+" AS SC5 " + GD_ENTER
cQuery += " JOIN "+RetSqlName("SC6")+" AS SC6 ON SC6.C6_FILIAL = '"+xFilial("SC6")+"' AND SC6.C6_NUM = SC5.C5_NUM " + GD_ENTER
cQuery += " AND SC6.C6_CLI = SC5.C5_CLIENT " + GD_ENTER
cQuery += " AND SC6.C6_LOJA = SC5.C5_LOJACLI " + GD_ENTER
cQuery += " AND SC6.D_E_L_E_T_ = '' " + GD_ENTER
cQuery += " JOIN "+RetSqlName("Z9A")+" AS Z9A ON Z9A.Z9A_FILIAL = '"+xFilial("Z9A")+"' " + GD_ENTER
cQuery += " AND Z9A.Z9A_PEDIDO = SC6.C6_NUM " + GD_ENTER
cQuery += " AND Z9A.Z9A_CLIENT = SC6.C6_CLI " + GD_ENTER
cQuery += " AND Z9A.Z9A_LOJA = SC6.C6_LOJA " + GD_ENTER
cQuery += " AND Z9A.Z9A_ITEMPV = SC6.C6_ITEM " + GD_ENTER
cQuery += " AND Z9A.D_E_L_E_T_ = '' " + GD_ENTER
cQuery += " WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"' AND SC5.C5_NUM  = '"+ Z9A->Z9A_PEDIDO + "' " + GD_ENTER
cQuery += " ORDER BY Z9A_PEDIDO,Z9A_ITEMPV  " + GD_ENTER

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

If (cAliasQry)->(Eof())
   	MsgInfo("Não foram encontrados registros para o parâmetros informados","Sem Registros")
   	dbSelectArea(cAliasQry)
	dbCloseArea()
   	Return
EndIf



IF ExistDir('C:\TEMP')
	cPasta := "C:\TEMP\"
Else
	cPasta := cGetFile('*.*','Selecione a Pasta',1,'C:\',.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.F.,.F.)
EndIF


nMakeDir := MAKEDIR(cPasta)
If nMakeDir == 0
	Aviso( "Importante", "O Diretório '" +cPasta+ "' foi criado",{"Ok"})
EndIf

DbSelectArea(cAliasQry)
(cAliasQry)->(DbGoTop())

oPrint := FWMSPrinter():New("SOLNF_PV_"+ cNumSNF, IMP_PDF, lAdjustToLegacy,cPasta, lDisableSetup, , , , , , .F., )
oPrint:SetResolution(72)
oPrint:SetPortrait()
oPrint:setPaperSize(9)
oPrint:cPathPDF 		:= cPasta

DbSelectArea(cAliasQry)
(cAliasQry)->(DbGoTop())
While (cAliasQry)->(!Eof())

	lInicio := .T.
	If AllTrim(cNumPV) <> AllTrim((cAliasQry)->(C5_NUM))

		IF !Empty(cNumPV)
			oPrint:Line(_nLinha-5,005,_nLinha-5,600)
			oPrint:Say(_nLinha+12,200,"                         Quantidade Total : " +Right(Transform(_nQtd,"@E 999,999,999.99"),14),oFont10N)
			nQtdItens := 0
			_nQtd :=0
			oPrint:EndPage()
		EndIF

		cNumPV := (cAliasQry)->(C5_NUM)
		_nLinha := ImpCabec(cNumSNF)
	EndIf

	_DescEsp := ALLTRIM((cAliasQry)->(C6_DESCRI))
	nTotLin 	:= MlCount(_DescEsp,55)

	For _nX := 1 To nTotLin
		_cTpEntrega := (cAliasQry)->(C6_TPENT)
		IF MOD(_nX,2)!= 0 .And. lInicio
			oPrint:Say(_nLinha,005," "+(cAliasQry)->Z9A_PEDIDO +" "+ (cAliasQry)->Z9A_ITEMPV+ "   " + (cAliasQry)->C6_PRODUTO + "  " + MemoLine (_DescEsp, 55, _nX)+ " " + Right(Transform((cAliasQry)->Z9A_QUANT,"@E 999,999,999.99"),14)+ "   "+_cTpEntrega +  "   " +  (cAliasQry)->Z9A_OP,oFont10)
																																																																			//+ "   "+ (cAlias)->Z93_SEQSC9 +"    "+_cTpEntrega +  "   " +  (cAlias)->Z93_OP,oFont10)
		Else
			oPrint:Say(_nLinha,005," "+Space(6) +"  "+ Space(2)+ " " + Space(Len((cAliasQry)->C6_PRODUTO)) + "   " + MemoLine (_DescEsp, 55, _nX),oFont10)
		EndIF
		_nLinha 	+= 14
		lInicio := .F.
		nQtdItens	+= 1
		IF nQtdItens = 48
			nQtdItens := 0
			oPrint:Line(_nLinha-5,005,_nLinha-5,600)
			oPrint:EndPage()
			_nLinha := ImpCabec(cNumSNF)
		EndIF

	Next

	_nQtd 		:= _nQtd + (cAliasQry)->Z9A_QUANT
	(cAliasQry)->(DbSkip())
EndDo


oPrint:Line(_nLinha-5,005,_nLinha-5,600)
oPrint:Say(_nLinha+12,200,"                         Quantidade Total : " +Right(Transform(_nQtd,"@E 999,999,999.99"),14),oFont10N)



oPrint:EndPage()
oPrint:SetViewPDF(.T.)
oPrint:Print()

FreeObj(oPrint)
oPrint := Nil

(cAliasQry)->(DbCloseArea())

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o   ³ ImpCabec   ³ Autor ³ Josuel Silva³ Data ³24/03/14³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o³ Imprime cabecalho de Solicitacao de NF.			³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/

Static Function ImpCabec(cNumSNF)

Local _nLinha 	:= 145
Local cTranport 	:= IIF(Empty(cTransp),"",cTransp +"-"+  AllTrim(Posicione("SA4",1,xFilial("SA4")+cTransp,"A4_NOME")))
Local UF			:= POSICIONE("SA1",1,xFILIAL("SA1")+(cAliasQry)->(C5_CLIENT+C5_LOJACLI),"A1_EST")
Local DescUF		:= POSICIONE("SX5",1,xFILIAL("SX5")+"12"+UF,"X5_DESCRI")

oPrint:StartPage()
oPrint:Say(040,120,"Solicitação de Nota Fiscal - Poder de Terceiro", oFont20N)
oPrint:Say(060,005,"Pedido de Venda   : "+(cAliasQry)->Z9A_PEDIDO, oFont10N)
oPrint:Say(060,360,"Data Emissão      :" +SubStr((cAliasQry)->C5_EMISSAO,7,2)+"/"+SubStr((cAliasQry)->C5_EMISSAO,5,2)+"/"+SubStr((cAliasQry)->C5_EMISSAO,1,4),oFont10N)
oPrint:Say(070,005,"Cliente           : "+(cAliasQry)->C5_CLIENT + "-"+(cAliasQry)->C5_LOJACLI +"/"+ ALLTRIM((cAliasQry)->C5_NREDUZ),oFont10N)
oPrint:Say(080,005,"UF Cliente        : "+ UF + " - " + ALLTRIM(DescUF),oFont10N)
oPrint:Say(090,005,"Transportadora    : "+cTranport,oFont10N)
oPrint:Say(100,005,"Volumes           : "+Right(Transform(nVolume,"@E 999,999,999.99"),14),oFont10N)
oPrint:Say(100,360,"Espécie           : "+cEspecie,oFont10N)
oPrint:Say(110,005,"Observação        : "+Alltrim(cOBS),oFont10N)
oPrint:Say(120,005,"Elaborado por     : " + Upper(cUserName),oFont10N)
oPrint:Line(135,05,135,600)


oPrint:Say(_nLinha,005,	" Pedido Item Código           Descrição                                                   Quantidade  TP.Ent Ord.Prod",oFont10N)
oPrint:Line(_nLinha+5,005,_nLinha+5,600)
_nLinha += 15

Return  _nLinha


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuSX1    ºAutor  ³ Josuel Silva       º Data ³  15/09/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualização do SX1 - Perguntas                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³GDFAT505                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AtuSX1(cPergSZ9)
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


	aAdd( aDados, {cPergSZ9,'01','Data de ?','Data de ?','Data de ?','MV_CH0','D',8,0,0,'G','','MV_PAR01','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPergSZ9,'02','Data ate ?','Data ate ?','Data ate ?','MV_CH0','D',8,0,0,'G','','MV_PAR02','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPergSZ9,'03','Do Cliente ?','Do Cliente ?','Do Cliente ?','MV_CH0','C',6,0,0,'G','','MV_PAR03','','','','','','','','','','','','','','','','','','','','','','','','','SA1','','','','',''} )
	aAdd( aDados, {cPergSZ9,'04','Da Loja ?','Da Loja ?','Da Loja ?','MV_CH0','C',2,0,0,'G','','MV_PAR04','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPergSZ9,'05','Ate o Cliente ?','Ate o Cliente ?','Ate o Cliente ?','MV_CH0','C',6,0,0,'G','','MV_PAR05','','','','','','','','','','','','','','','','','','','','','','','','','SA1','','','','',''} )
	aAdd( aDados, {cPergSZ9,'06','Ate a Loja ?','Ate a Loja ?','Ate a Loja ?','MV_CH0','C',2,0,0,'G','','MV_PAR06','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''} )
	aAdd( aDados, {cPergSZ9,'07','Tes de Retorno ?','Tes de Retorno ?','Tes de Retorno ?','MV_CH0','C',3,0,0,'G','','MV_PAR07','','','','','','','','','','','','','','','','','','','','','','','','','SF4','','','','',''} )

//
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

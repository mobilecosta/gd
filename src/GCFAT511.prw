#include "protheus.ch"
#include "apwizard.ch"
#INCLUDE "COLORS.CH"
#INCLUDE "topconn.ch"
#Include "CSSESTILOSGD.CH"
#INCLUDE 'FWMVCDEF.CH'
#DEFINE GD_ENTER	CHR(13)+CHR(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GCFAT511  ºAutor  ³Josuel Silva-SS     º Data ³  27/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Wizard para realizar a geracao dos Pedidos x Remessa.       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GCFAT511()

Local aCoors	:= FWGetDialogSize( oMainWnd )
Local nPanel

Local lWiz := .F.

Private lEspecifico := .F.
Private lTipo9	:= .F.
Private lGoverno	:= .F.

Private oWizard,oTableLeft	,oTableRight,oGetDados		,oQtdTotal	,oVlrTotal
Private oGetCliente,oGetLoja	,oCbxTpFat	,oGetDataDe	,oGetDataAte
Private oSayRazao
Private oBtnEnv	,oBtnRet	,oBtnEnvTd	,oBtnRetTd	,oSayTpEnv	,oCbxTpEnvio,oCbxBand,oBtnEnvCred,oBtnEnvDebi
Private oCbxPlast,aPlasticos,cPlastico,oCbxServ,cCbxServ,aCbxServ

Private oCliFat,oLjCliFat,oMenNota,oDtVenc

Private cCliFat		:= Criavar("C5_CLIENTE",.F.)
Private cLjCliFat	:= Criavar("C5_LOJACLI",.F.)

Private cCliente		:= Space(TamSX3("Z9D_CLIENT")[1])
Private cRazao		:= Space(TamSX3("Z9D_NREDUZ")[1])
Private cLoja		:= Space(TamSX3("Z9D_LOJA")[1])

Private cDataDe	:= CTOD("  /  /  ")
Private cDataAte	:= CTOD("  /  /  ")
Private cDtVencto:= CTOD("  /  /  ")

Private cTpFat		:= Criavar("Z9D_TPFAT",.F.)
Private cTpBandeira := Criavar("Z9D_TPFAT",.F.)

Private cTesServ	:= ""
Private cEmbed		:= ""
Private cCodEmbed	:= ""
Private aTpBandeira := {"T=Todos","E=ELO","M=Master","V=Visa"}
Private aHeader		:= {}
Private aCols		:= {}
Private aRotina 	:= {}
Private aTpFat	 	:= {}
Private aStruct 	:= {}
Private cCriaTrB,cCriaTrB2
Private nQtdTotal 	:= 0
Private nVlrTotal 	:= 0
Private lDelete		:= .T.
Private lCriaTMP	:= .F.

Private nQtdeTotal	:= 0
Private oTotal,oCliName,oCondPag,oMenPad,oFrete,oTpServ,oTpQuebra
Private cPedObs	:= "Faturamento de Serviços, referente aos Pedidos No. "

Private cMenPad		:= Criavar("C5_MENPAD",.F.)
Private cCondPag		:= Criavar("C5_CONDPAG",.F.)
Private cCliNome		:= Criavar("A1_NOME",.F.)
Private cMenNota		:= Criavar("C5_MENNOTA",.F.)
Private cTpQuebra	:= Space(01)

Private cFrete	:= Criavar("C5_TPFRETE",.F.)
Private cTpServ	:= Criavar("C5_TPSRV",.F.)

Private aTpServ 	:= {}
Private aFrete	:= {}



	//DEFINE FONT   oFont10N  SIZE 0, -12 BOLD
	DEFINE FONT   oFont10N NAME "Arial" SIZE 0, -10 BOLD
	DEFINE FONT   oFont12N NAME "Arial" SIZE 0, -12 BOLD
	DEFINE FONT   oFont14N NAME "Arial" SIZE 0, -14 BOLD

	AADD(aRotina,      { OemToAnsi("Pesquisar")		,"AxPesqui"    	,0, 1} )
	AADD(aRotina,      { OemToAnsi("Visualizar")		,"U_GPPCP500"   	,0, 2} )
	AADD(aRotina,      { OemToAnsi("Incluir")     	,"U_GPPCP500"   	,0, 3} )
	AADD(aRotina,      { OemToAnsi("Alterar")     	,"U_GPPCP500"   	,0, 4} )
	AADD(aRotina,      { OemToAnsi("Excluir")     	,"U_GPPCP500"		,0, 5} )
	AADD(aRotina,      { OemToAnsi("Legenda") 		,"U_GPPCP500"		,0, 7} )

		aPlasticos := {"O=Todos","B=Casas Bahia","C=CredMais","F=Fidelize","R=RushCard","T=Transporte","V=Visa BUXX"}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Criacao de Wizard e painel para Geracao dos Pedidos de Servicos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oWizard := APWizard():New( "Faturamento X Remessa",;
								 ''/*<chMsg>*/,;
								 "Faturamento X Remessa",;
								 "Assistende para geração de Pedido de Serviços através de arquivos bancários ou Pedidos Remetidos.",;
										  {|| .T. /*bNext*/ } , {||.T. /*bFinish */ } ,.T. /*lPanel*/,/*cResHead*/, /*bExecute*/ , .T. /*lNoFirst*/, {aCoors[1], aCoors[2],aCoors[3]-50, aCoors[4]})


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Painel 2 - Segunda Janela para selecao dos Parametros  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CREATE PANEL oWizard HEADER ".::Parâmetros::." MESSAGE "Informe os Parâmetros necessários para continuar" ;
		BACK {||lBack:=.T.,.F.} ; 								//Bloco de Codigo executado quando voltar para este Painel
		NEXT {||IIF(VldParam(cTpFat),.T.,.F.)}; 				//Bloco de Codigo executado quando ir para o proximo Painel
		EXEC {||oGetCliente:SetFocus(),.T.} ;								//Bloco de Codigo executado quando ativar este painel. //lTrata := .F.
		PANEL

		//Funcao para Criacao de tela
		PnlParam()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Painel 3 - Terceira Janela para seleção das Ops que sofrerao alteracao no codigo  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CREATE PANEL oWizard	HEADER "::: Pedidos de Serviços ::: "  MESSAGE "Selecione aqui os Produtos que serão gerados Pedidos de Serviços. Aqui poderá filtrar por Tipo de Bandeira." ;
		BACK {||GD511Clear()};
		NEXT {||VldItensFat(),.T.};
		EXEC {||.T.};
		PANEL

		nLargTable 	:= aCoors[4]/4
		nLargGETD	:= aCoors[4]/2 
		nAltura 	:= (aCoors[3]/2)-110


		//Funcao para cricao das tabelas
		PnlTable()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Painel 4 - Segunda Janela para selecao dos Parametros  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CREATE PANEL oWizard HEADER "::: Pedidos de Serviços ::: " MESSAGE "Informe aqui os dados necessários para geração do Pedido de Venda" ;
		BACK {||.T.} ;
		NEXT {||.T.} ;
		FINISH {||IIF(VldItensSC6(cCliFat,cLjCliFat),lWiz := .T.,.F.)};
		EXEC {||.T.};
		PANEL

		PnlPedido()
			
		IF CVERSAO >= "12"			
			oWizard:oDlg:oWnd:lEscClose 	:= .F.
		Else
			oWizard:oDlg:lEscClose 	:= .F.
		EndIF

		oWizard:SetPanel(2) //Seleciona Painel 2 (tela de Parametros) na abertura da Rotina
		oGetCliente:SetFocus()

		ACTIVATE WIZARD oWizard CENTER VALID {|| .T. }
		If lWiz	//Se Ok, executa a alteracao nos empenhos

			MsgRun('Aguarde... Gerando Pedidos.','::: Faturamento X Remessa :::',{||GD535PV()})


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Apaga arquivo temporario                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Select("TMPTRB") > 0
				DbSelectArea ("TMPTRB")
				TMPTRB->(dbclosearea())
				If File(cCriaTrB+GetDBExtension())
					Ferase(cCriaTrB+GetDBExtension())
				EndIf
			Endif
			If Select("TMPTRB2") > 0
				DbSelectArea ("TMPTRB2")
				TMPTRB2->(dbclosearea())
				If File(cCriaTrB2+OrdBagExt())
					Ferase(cCriaTrB2+OrdBagExt())
				EndIf
			Endif
		EndIf
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GD511ClearºAutor  ³Josuel Silva        º Data ³  17/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para redefinir variaves e campos.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GD511Clear()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa as Variaveis							     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cCliente		:= Space(TamSX3("Z9D_CLIENT")[1])
	cLoja			:= Space(TamSX3("Z9D_LOJA")[1])
	cRazao			:= Space(TamSX3("Z9D_NREDUZ")[1])
	cDataDe		:= CTOD("  /  /  ")
	cDataAte		:= CTOD("  /  /  ")
	cTpFat			:= Criavar("Z9D_TPFAT",.F.)
	cTpBandeira 	:= "T"
	cPlastico		:= 'O'
	nQtdeTotal		:= 0
	lEspecifico	:= .F.
	lCriaTMP		:= .T.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Apaga arquivo temporario                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Select("TMPTRB") > 0
		DbSelectArea ("TMPTRB")
		TMPTRB->(dbclosearea())
		If File(cCriaTrB+GetDBExtension())
			Ferase(cCriaTrB+GetDBExtension())
		EndIf
	Endif
	If Select("TMPTRB2") > 0
		DbSelectArea ("TMPTRB2")
		TMPTRB2->(dbclosearea())
		If File(cCriaTrB2+OrdBagExt())
			Ferase(cCriaTrB2+OrdBagExt())
		EndIf
	Endif

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldParam  ºAutor  ³Josuel Silva-SS     º Data ³  17/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para validar os parametros informados.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldParam(cTpFat)
	Local lValido 	:= .T.
	Local lRet		:= .T.


	If Empty(cCliente) .Or.  Empty(cLoja)
		MsgStop("Favor informar o Cliente e Loja corretamente prosseguir ! ")
		oGetCliente:SetFocus()
		Return .F.
	EndIf


	IF  Empty(cDataDe) .Or. Empty(cDataAte)
		MsgStop("Favor informar o Periodo inicial e final corretamente para prosseguir ! ")
		oGetDataDe:SetFocus()
		Return .F.
	EndIF

	lGoverno := IIF( ALLTRIM(Posicione("SA1",1,xFilial("SA1") + cCliente+ cLoja,"A1_GRPVEN")) $ "GO|ID",.T. ,.F.)

	IF lGoverno .And. cTpFat == "2"
		MsgStop("Para o tipo de Cliente GO-Governo, não é permitido busca por Arquivo Bancário ! ")
		Return .F.
	EndIF

	aCbxServ := {""}
	aAux := {}
	DbSelectArea("Z9E")
	Z9E->(dbSetOrder(1))
	IF Z9E->(DbSeek(xFilial("Z9E")+ cCliente + cLoja ))
		While Z9E->(!Eof()) .And. xFilial("Z9E") == Z9E->Z9E_FILIAL .And. Z9E->(Z9E_CLIENT+Z9E_LOJA) == cCliente + cLoja
		 if (ASCAN(aAux,ALLTRIM(Z9E->Z9E_PSRV)) == 0)
		 	AADD(aCbxServ, ALLTRIM(Z9E->Z9E_PSRV) +"=" + ALLTRIM(Posicione("SB1",1,xFilial("SB1")+Z9E->Z9E_PSRV,"B1_DESC"	)))
		 	AADD(aAux, ALLTRIM(Z9E->Z9E_PSRV))
		 EndiF
			Z9E->(DbSkip())
		EndDo
	EndIF

	ASORT(aCbxServ)
	oCbxServ:SetItems(aCbxServ)
	oCbxServ:Refresh()

	MsgRun('Aguarde... Buscando informações.','::: Faturamento X Remessa :::',{||lRet := BuscaInfo(cCliente,cLoja,cTpFat,cDataDe,cDataAte)})

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldCpos   ºAutor  ³Josuel Silva-SS     º Data ³  17/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para validar os parametros informados.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldCpos(cCliente)

	DbSelectArea("Z9D")
	Z9D->(DbSetOrder(1))
	If Z9D->(dbSeek(xFilial("Z9D")+cCliente))
		cLoja		:= IIF(Empty(cLoja),Z9D->Z9D_LOJA,cLoja)
		cTesServ  	:= Z9D->Z9D_TES
		cEmbed    := Z9D->Z9D_EMBED
		cCodEmbed	:= Z9D->Z9D_CODEMB
		cRazao		:= Z9D->Z9D_NREDUZ
		cTpFat		:= Z9D->Z9D_TPFAT
		oSayRazao	:Refresh()
	EndIF

		IF cCliente $ "000001#001111"
			oCbxPlast:Show()
			lEspecifico := .T.
		Else
			oCbxPlast:Hide()
		EndiF

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BuscaInfo ºAutor  ³Josuel Silva-SS     º Data ³  17/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para buscar as informacoes para geracao do Resumo    º±±
±±º          ³do que foi remetido em NF.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BuscaInfo(cCliente,cLoja,cTpFat,cDataDe,cDataAte)
Local cCli 		:= cCliente
Local cLj 		:= cLoja
Local cAliasSD2	:= GetNextAlias()
Local cTesRemessa := ALLTRIM (GetMv("GD_TESREM"))

IF cTpFat == "1"

		BeginSql Alias cAliasSD2
		%NoParser%

	SELECT  	SD4.D4_COD 		AS CARTAO,
				SB1SD4.B1_DESC 	AS DESCCARD,
				SB1SD4.B1_XBAND 	AS BANDEIRA,
				A1_NREDUZ	,
				A1_GRPVEN ,
				A1_EST		,
				A1_TABELA ,
	 FATURAMENTO.*

		FROM ( 	SELECT
				SD2.D2_COD 		AS PRODUTO
				,SD2.D2_LOCAL 	AS ALMOX
				,SD2.D2_QUANT 	AS C2D2QTDE
				,SD2.D2_UM 		AS UNIDADE
				,SD2.D2_PRCVEN 	AS PRECO
				,SD2.D2_TOTAL 	AS VLRTOTAL
				,SD2.D2_TES 		AS TES
				,SD2.D2_PEDIDO 	AS PEDIDO
				,SD2.D2_ITEMPV 	AS ITEMPV
				,SD2.D2_DOC 		AS NF
				,SD2.D2_SERIE 	AS SERIE
				,SD2.D2_EMISSAO	AS EMISSAO
				,SD2.D2_TPENT 	AS TPENT
				,SD2.D2_CLIENTE	AS CLIENTE
				,SD2.D2_LOJA 		AS LOJA
				,SB1.B1_DESC 		AS DESCPRO
				,RTRIM(Z86.Z86_ARQORI) AS ARQORIGEM
				,RTRIM(Z86.Z86_ARQPER) AS ARQPERSO
				,Z86_DATA 		AS DTARQUIVO
				,SD2.D2_ITEM 	AS ITEMNF
				,Z86.Z86_KIT 	AS KIT
				,Z86.Z86_PLASTI	AS PLASTICO
				,Z9F.Z9F_DOC 	AS DOCNF
				,Z9F.Z9F_SERIE 	AS SERIENF
				,SC6.C6_NUMOP 	AS OP
				,SC6.C6_ITEMOP 	AS ITEMOP
				,SD2.D2_TPENT 	AS TIPO_ENTREGA
				,''	AS 'VTRUSH'
				,''	AS 'CREDMAIS'
				,
				(SELECT MIN(SD4CARTAO.R_E_C_N_O_)
					FROM %table:SD4% AS SD4CARTAO
						WHERE 	SD4CARTAO.D4_FILIAL = %xfilial:SD4%
						AND 	SD4CARTAO.D4_OP 	= SC6.C6_NUMOP + SC6.C6_ITEMOP + '001  '
						AND 	SD4CARTAO.D4_XPICK 	<> ''
						AND 	SD4CARTAO.%notDel%) AS RECSD4

	FROM %table:SD2% AS SD2
		INNER JOIN %table:SB1% SB1
			ON 	SB1.B1_FILIAL  		= %xfilial:SB1%
				AND SB1.B1_COD 		= SD2.D2_COD
				AND SB1.%notDel%

		INNER JOIN %table:SC6% AS SC6
			ON 	SC6.C6_FILIAL			= %xfilial:SC6%
				AND SC6.C6_CLI		= SD2.D2_CLIENTE
				AND SC6.C6_LOJA		= SD2.D2_LOJA
				AND SC6.C6_NUM		= SD2.D2_PEDIDO
				AND SC6.C6_ITEM		= SD2.D2_ITEMPV
				AND SC6.%notDel%

		INNER JOIN %table:Z86% AS Z86
			ON 	Z86.Z86_FILIAL		= %xfilial:Z86%
				AND Z86.Z86_PEDIDO	= SC6.C6_NUM
				AND Z86.Z86_ITEMPV	= SC6.C6_ITEM
				AND Z86.%notDel%

	  	LEFT JOIN %table:Z9F% AS Z9F ON Z9F.Z9F_FILIAL = %xfilial:Z9F%
	  			AND Z9F_DOC  		= D2_DOC
			  	AND Z9F_ITEMNF 	= D2_ITEM
			  	AND Z9F_CLIENT 	= D2_CLIENTE
			  	AND Z9F_LOJA   	= D2_LOJA
			  	AND Z9F.%notDel%

		WHERE	SD2.D2_FILIAL  		= %xfilial:SD2%
			AND SD2.D2_CLIENTE 		= %exp:cCliente%
			AND SD2.D2_LOJA	  		= %exp:cLoja%
			AND SD2.D2_EMISSAO BETWEEN %exp:cDataDe% AND %exp:cDataAte%
			AND SD2.D2_TES IN (%exp:cTesRemessa%)
			AND SD2.%notDel%

			AND Z9F.Z9F_DOC IS NULL)  AS FATURAMENTO

		INNER JOIN %table:SD4% AS SD4 ON SD4.D4_FILIAL = %xfilial:SD4%
			AND SD4.D4_OP = FATURAMENTO.OP +FATURAMENTO.ITEMOP + '001  '
			AND SD4.D4_XPICK <> ''
			AND SD4.%notDel%
			AND SD4.R_E_C_N_O_ = FATURAMENTO.RECSD4

		INNER JOIN %table:SB1% AS SB1SD4 ON SB1SD4.B1_FILIAL = %xfilial:SB1%
			AND SB1SD4.B1_COD = SD4.D4_COD
			AND SB1SD4.%notDel%

		INNER JOIN %table:SA1%  AS SA1 ON SA1.A1_FILIAL =  %xfilial:SA1%
			AND SA1.A1_COD =	FATURAMENTO.CLIENTE
			AND SA1.A1_LOJA =	FATURAMENTO.LOJA
			AND SA1.%notDel%


		ORDER BY FATURAMENTO.PEDIDO,FATURAMENTO.ITEMPV,FATURAMENTO.NF,FATURAMENTO.SERIE,FATURAMENTO.ITEMNF

	EndSql


ElseIF cTpFat == "2"

	BeginSql Alias cAliasSD2
	%NoParser%

SELECT  	SD4.D4_COD 	   		AS CARTAO,
			SB1SD4.B1_DESC 		AS DESCCARD,
			SB1SD4.B1_XBAND 		AS BANDEIRA,
			A1_NREDUZ	,
			A1_GRPVEN,
			A1_EST		,
			A1_TABELA ,
 FATURAMENTO.*

	FROM ( 	SELECT
			SC2.C2_PRODUTO 	AS PRODUTO
			,SC2.C2_LOCAL 	AS ALMOX
			,SC2.C2_QUANT 	AS C2D2QTDE
			,SC2.C2_UM 		AS UNIDADE
			,SC6.C6_PRCVEN 	AS PRECO
			,SC6.C6_VALOR 	AS VLRTOTAL
			,SC6.C6_TES 		AS TES
			,SC2.C2_PEDIDO 	AS PEDIDO
			,SC2.C2_ITEMPV 	AS ITEMPV
			,'' 	AS NF
			,'' 	AS SERIE
			,SC2.C2_EMISSAO	AS EMISSAO
			,SC6.C6_TPENT 	AS TPENT
			,SC6.C6_CLI		AS CLIENTE
			,SC6.C6_LOJA 		AS LOJA
			,SB1.B1_DESC 		AS DESCPRO
			,RTRIM(Z86_ARQORI)	AS ARQORIGEM
			,RTRIM(Z86_ARQPER) 	AS ARQPERSO
			,Z86_DATA 				AS DTARQUIVO
			,'' 				AS ITEMNF
			,Z86.Z86_KIT 		AS KIT
			,Z86.Z86_PLASTI	AS PLASTICO
			,Z9F.Z9F_PVREM 	AS DOCNF
			,''				 	AS SERIENF
			,SC2.C2_NUM 		AS OP
			,SC2.C2_ITEM 		AS ITEMOP
			,SC2.C2_SEQUEN 	AS SEQUENCIAOP
			,SC6.C6_TPENT 	AS TIPO_ENTREGA
			,LEFT(Z86.Z86_ARQPER,2)			AS 'VTRUSH'
			,SUBSTRING(Z86.Z86_ARQPER,12,3)	AS 'CREDMAIS'
			,
			(SELECT MIN(SD4CARTAO.R_E_C_N_O_)
				FROM %table:SD4% AS SD4CARTAO
					WHERE 	SD4CARTAO.D4_FILIAL = %xfilial:SD4%
					AND 	SD4CARTAO.D4_OP 	= SC6.C6_NUMOP + SC6.C6_ITEMOP + '001  '
					AND 	SD4CARTAO.D4_XPICK 	<> ''
					AND 	SD4CARTAO.%notDel%) AS RECSD4

	FROM %table:Z86% AS Z86

	INNER JOIN %table:SC2% AS SC2
		ON SC2.C2_FILIAL  		= %xfilial:SC2%
			AND SC2.C2_PEDIDO 	= Z86.Z86_PEDIDO
			AND SC2.C2_ITEMPV		= Z86.Z86_ITEMPV
			AND SC2.C2_SEQUEN 	= '001'
			AND SC2.C2_ITEMGRD 	= '  '
			AND SC2.%notDel%

	INNER JOIN %table:SB1% AS SB1
		ON 	SB1.B1_FILIAL  		= %xfilial:SB1%
			AND SB1.B1_COD 		= SC2.C2_PRODUTO
			AND SB1.%notDel%

	INNER JOIN %table:SC6% AS SC6
		ON 	SC6.C6_FILIAL		= %xfilial:SC6%
			AND SC6.C6_NUM		= SC2.C2_PEDIDO
			AND SC6.C6_ITEM		= SC2.C2_ITEMPV
			AND SC6.C6_PRODUTO	= SC2.C2_PRODUTO
			AND SC6.%notDel%

  	LEFT JOIN %table:Z9F% AS Z9F ON Z9F.Z9F_FILIAL = %xfilial:Z9F%
  			AND Z9F.Z9F_PVREM  	= SC6.C6_NUM
		  	AND Z9F.Z9F_ITREM 	= SC6.C6_ITEM
		  	AND Z9F.Z9F_CODREM 	= SC6.C6_PRODUTO
		  	AND Z9F.Z9F_CLIENT 	= SC6.C6_CLI
		  	AND Z9F.Z9F_LOJA   	= SC6.C6_LOJA
		  	AND Z9F.%notDel%
	WHERE Z86.Z86_FILIAL 	= %xfilial:Z9F%
		AND SC2.C2_EMISSAO	BETWEEN %exp:cDataDe% AND %exp:cDataAte%
		AND SC6.C6_CLI 		= %exp:cCliente%
		AND SC6.C6_LOJA		= %exp:cLoja%
		AND SC6.C6_TES IN (%exp:cTesRemessa%)
		AND Z9F.Z9F_PVREM IS NULL
		)  AS FATURAMENTO
	INNER JOIN %table:SD4% AS SD4 ON SD4.D4_FILIAL = %xfilial:SD4%
		AND SD4.D4_OP = FATURAMENTO.OP +FATURAMENTO.ITEMOP + '001  '
		AND SD4.D4_XPICK <> ''
		AND SD4.%notDel%
		AND SD4.R_E_C_N_O_ = FATURAMENTO.RECSD4

	INNER JOIN %table:SB1%  AS SB1SD4 ON SB1SD4.B1_FILIAL = %xfilial:SB1%
		AND SB1SD4.B1_COD = SD4.D4_COD
		AND SB1SD4.%notDel%

	INNER JOIN %table:SA1%  AS SA1 ON SA1.A1_FILIAL =  %xfilial:SA1%
		AND SA1.A1_COD =	FATURAMENTO.CLIENTE
		AND SA1.A1_LOJA =	FATURAMENTO.LOJA
		AND SA1.%notDel%

	ORDER BY FATURAMENTO.PEDIDO,FATURAMENTO.ITEMPV

	EndSql

EndIF

	//MEMOWRITE("C:/TEMP/QRY_SD2_REMESSA+" + cCliente + ".SQL",GetLastQuery()[2])

	DbSelectArea(cAliasSD2)
	(cAliasSD2)->(dbGoTop())
	IF (cAliasSD2)->(Eof())
		MsgStop("Não foram localizados itens conforme os parâmetros informados!")
		Return .F.
	EndIF



	IF lCriaTMP
		cCriaTrB	 := CriaTrab(aStruct,.T.)
		dbUseArea(.T.,,cCriaTrB,"TMPTRB",.F.,.F.)
		cIndexTMP   :="PEDIDO+ITEMPV+NF+SERIE+PRODUTO"
		IndRegua("TMPTRB",cCriaTrB,cIndexTMP,,,"Selecionando Registros...")

		cCriaTrB2	 := CriaTrab(aStruct,.T.)
		dbUseArea(.T.,,cCriaTrB2,"TMPTRB2",.F.,.F.)
		IndRegua("TMPTRB2",cCriaTrB2,cIndexTMP,,,"Selecionando Registros...")
		lCriaTMP := .F.
	EndIF


	While (cAliasSD2)->(!Eof())
		RecLock("TMPTRB",.T.)
			TMPTRB->PRODUTO	:=	(cAliasSD2)->PRODUTO
			TMPTRB->DESCPRO	:=	(cAliasSD2)->DESCPRO
			TMPTRB->ALMOX		:=	(cAliasSD2)->ALMOX
			TMPTRB->C2D2QTDE	:= 	(cAliasSD2)->C2D2QTDE
			TMPTRB->UNIDADE	:= 	(cAliasSD2)->UNIDADE
			TMPTRB->PRECO		:= 	(cAliasSD2)->PRECO
			TMPTRB->VLRTOTAL 	:= 	(cAliasSD2)->VLRTOTAL
			TMPTRB->TES	   	:= 	(cAliasSD2)->TES
			TMPTRB->PEDIDO 	:= 	(cAliasSD2)->PEDIDO
			TMPTRB->ITEMPV 	:= 	(cAliasSD2)->ITEMPV
			TMPTRB->NF			:= 	(cAliasSD2)->NF
			TMPTRB->SERIE		:= 	(cAliasSD2)->SERIE
			TMPTRB->EMISSAO	:= 	STOD((cAliasSD2)->EMISSAO)
			TMPTRB->CARTAO	:= 	IIF(ALLTRIM((cAliasSD2)->A1_GRPVEN) $ 'GO/ID',(cAliasSD2)->PRODUTO ,(cAliasSD2)->CARTAO)
			TMPTRB->DESCCARD	:= 	IIF(ALLTRIM((cAliasSD2)->A1_GRPVEN) $ 'GO/ID',(cAliasSD2)->DESCPRO ,(cAliasSD2)->DESCCARD)
			TMPTRB->BANDEIRA	:= 	(cAliasSD2)->BANDEIRA
			TMPTRB->TPENT		:= 	(cAliasSD2)->TPENT
			TMPTRB->CLIENTE	:= 	(cAliasSD2)->CLIENTE
			TMPTRB->LOJA		:= 	(cAliasSD2)->LOJA
			TMPTRB->ARQORI	:= 	(cAliasSD2)->ARQORIGEM
			TMPTRB->ARQPERSO	:= 	(cAliasSD2)->ARQPERSO
			TMPTRB->ITEMNF	:= 	(cAliasSD2)->ITEMNF
			TMPTRB->PLASTICO	:= 	(cAliasSD2)->PLASTICO
			TMPTRB->KIT		:= 	(cAliasSD2)->KIT
			TMPTRB->DTARQUIVO	:= 	STOD((cAliasSD2)->DTARQUIVO)
			TMPTRB->VTRUSH	:= 	(cAliasSD2)->VTRUSH
			TMPTRB->CREDMAIS	:= 	(cAliasSD2)->CREDMAIS
			TMPTRB->UF			:= 	(cAliasSD2)->A1_EST
			TMPTRB->GRPVENDA	:= ALLTRIM((cAliasSD2)->A1_GRPVEN)
			TMPTRB->TABPRECO	:= 	(cAliasSD2)->A1_TABELA
			TMPTRB->CODPSRV	:= ""
			TMPTRB->FLAG		:= 	.F.

		TMPTRB->(MsUnlock())
		(cAliasSD2)->(dbSkip())
	EndDo
	DbSelectArea("TMPTRB")
	TMPTRB->(DbGoTop())

	oTableRight:Refresh()
	oTableLeft:Refresh()

	DbSelectArea(cAliasSD2)
	(cAliasSD2)->(dbCloseArea())

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EnvRight  ºAutor³Josuel Silva-Sservice º Data ³  10/02/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar o envio dos Itens para a    º±±
±±º          ³direita conforme parametros informados.                     º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³cTpBandeira -> Tipo de Bandeira (Elo / Visa / Master)       ³±±
±±³          ³cTpCartao -> Tipo de Cartao -                               ³±±
±±³          ³lRushCard -> Trata apenas itens RushCard ?                  ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


Static Function EnvRight(cTpBandeira,cTpCartao,cPlastico,cCbxServ)

Local cBandeira := RIGHT(cTpBandeira,1)
Local aNoPSRV	:= {}
Local cNoPsrv	:= ""
Local nNewZ9E := 2
Default cTpCartao 	:= ""
Default cPlastico	:= 'O'


DbSelectArea("Z9E")
Z9E->(dbSetOrder(2))


dbSelectArea("TMPTRB")
TMPTRB->(dbGoTop())
While  TMPTRB->(!EoF())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ RushCard = Tudo que for diferente de FB. 						 ³
	//³ Sendo assim, caso for igual a FB eu pulo para nao adicionar ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF lEspecifico
			Do Case
				Case cPlastico== "B" .and. !(ALLTRIM(TMPTRB->PLASTICO) $ SuperGetMv("GD_CSBAHIA"))
					TMPTRB->(dbSkip())
					Loop
				Case cPlastico== "R" .and. UPPER(TMPTRB->VTRUSH) == "FB"
					TMPTRB->(dbSkip())
					Loop
				Case cPlastico== "T" .and. UPPER(TMPTRB->VTRUSH) <> "VT"
					TMPTRB->(dbSkip())
					Loop
				Case cPlastico== "C" .and. UPPER(TMPTRB->CREDMAIS) <> "CMP"
					TMPTRB->(dbSkip())
					Loop
				Case cPlastico== "V" .and. ALLTRIM(TMPTRB->PLASTICO) <> "REMEMPABRA"
					TMPTRB->(dbSkip())
					Loop
				Case cPlastico== "F" .and. !(ALLTRIM(TMPTRB->PLASTICO) $ SuperGetMv("GD_XPLAFID"))
					TMPTRB->(dbSkip())
					Loop
			EndCase
		EndIF

		IF  cBandeira <> 'T' .AND. !(cBandeira $ Alltrim(TMPTRB->BANDEIRA))
			TMPTRB->(dbSkip())
			Loop
		EndIF

		IF !Empty(cTpCartao) .and. !(cTpCartao == LEFT(TMPTRB->BANDEIRA,1))
			TMPTRB->(dbSkip())
			Loop
		EndIF

		if !(EmptY(cCbxServ))
			lInclui := .F.
			IF Z9E->(DbSeek(xFilial("Z9E")+ TMPTRB->(CLIENTE+LOJA+CARTAO)))
				While Z9E->(!EoF()) .And. TMPTRB->(CLIENTE+LOJA+CARTAO) == Z9E->(Z9E_CLIENT + Z9E_LOJA + Z9E_CODREM)
					IF alltrim(Z9E->Z9E_PSRV) == alltrim(cCbxServ)
						lInclui := .T.
						Exit
					EndIF
					Z9E->(dbSkip())
				EndDo
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Adiciona no array para informar produtos que nao tem amarracao. ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF aScan(aNoPSRV,{ |x| Alltrim(x[1]) == AllTrim(TMPTRB->CARTAO)}) == 0
					AADD(aNoPSRV, {AllTrim(TMPTRB->CARTAO),Alltrim(TMPTRB->DESCCARD)})
					cNoPsrv += AllTrim(TMPTRB->CARTAO)+ "-" + Alltrim(TMPTRB->DESCCARD) + GD_ENTER
	         	EndIF

			EndIF

			IF !lInclui
				TMPTRB->(dbSkip())
				Loop
			EndIF
		Else

			IF !(Z9E->(DbSeek(xFilial("Z9E")+ TMPTRB->(CLIENTE+LOJA+CARTAO))))
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Adiciona no array para informar produtos que nao tem amarracao. ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF aScan(aNoPSRV,{ |x| Alltrim(x[1]) == AllTrim(TMPTRB->CARTAO)}) == 0
					AADD(aNoPSRV,{AllTrim(TMPTRB->CARTAO),Alltrim(TMPTRB->DESCCARD)})
					cNoPsrv += AllTrim(TMPTRB->CARTAO)+ "-" + Alltrim(TMPTRB->DESCCARD) + GD_ENTER
	         	EndIF

				TMPTRB->(dbSkip())
				Loop
			EndIF
		EndIF

			RecLock("TMPTRB2",.T.)
				TMPTRB2->PRODUTO		:=	TMPTRB->PRODUTO
				TMPTRB2->DESCPRO		:= 	TMPTRB->DESCPRO
				TMPTRB2->ALMOX		:=	TMPTRB->ALMOX
				TMPTRB2->C2D2QTDE		:= 	TMPTRB->C2D2QTDE
				TMPTRB2->UNIDADE		:= 	TMPTRB->UNIDADE
				TMPTRB2->PRECO		:= 	TMPTRB->PRECO
				TMPTRB2->VLRTOTAL		:= 	TMPTRB->VLRTOTAL
				TMPTRB2->TES			:= 	TMPTRB->TES
				TMPTRB2->PEDIDO 		:= 	TMPTRB->PEDIDO
				TMPTRB2->ITEMPV 		:= 	TMPTRB->ITEMPV
				TMPTRB2->NF			:= 	TMPTRB->NF
				TMPTRB2->SERIE		:= 	TMPTRB->SERIE
				TMPTRB2->EMISSAO		:= 	TMPTRB->EMISSAO
				TMPTRB2->CARTAO		:= 	TMPTRB->CARTAO
				TMPTRB2->DESCCARD		:= 	TMPTRB->DESCCARD
				TMPTRB2->BANDEIRA		:= 	TMPTRB->BANDEIRA
				TMPTRB2->TPENT		:= 	TMPTRB->TPENT
				TMPTRB2->CLIENTE		:= 	TMPTRB->CLIENTE
				TMPTRB2->LOJA			:= 	TMPTRB->LOJA
				TMPTRB2->ARQORI		:= 	TMPTRB->ARQORI
				TMPTRB2->ARQPERSO		:= 	TMPTRB->ARQPERSO
				TMPTRB2->ITEMNF		:= 	TMPTRB->ITEMNF
				TMPTRB2->PLASTICO		:=	TMPTRB->PLASTICO
				TMPTRB2->KIT			:=	TMPTRB->KIT
				TMPTRB2->DTARQUIVO	:=	TMPTRB->DTARQUIVO
				TMPTRB2->VTRUSH		:=	TMPTRB->VTRUSH
				TMPTRB2->CREDMAIS		:= 	TMPTRB->CREDMAIS
				TMPTRB2->UF			:= 	TMPTRB->UF
				TMPTRB2->GRPVENDA		:= 	TMPTRB->GRPVENDA
				TMPTRB2->TABPRECO		:= 	TMPTRB->TABPRECO
				TMPTRB2->CODPSRV		:= 	Z9E->Z9E_PSRV
				TMPTRB2->(MsUnlock())

				nQtdeTotal := nQtdeTotal + TMPTRB->C2D2QTDE

			If RecLock("TMPTRB",.F.)
				TMPTRB->(DbDelete())
				TMPTRB->(MsUnlock())
	    	EndIF
		TMPTRB->(dbSkip())

EndDo

	DbSelectArea("TMPTRB2")
	TMPTRB2->(DbGoTop())
	DbSelectArea("TMPTRB")
	TMPTRB->(DbGoTop())

	oTableRight:Refresh()
	oTableLeft:Refresh()
	oTotal:Refresh()

		IF !Empty(cNoPsrv)

			IF (MsgYesNo("Existem produtos sem cadastro de Produto de Serviço. Deseja imprimir ? " ;
						+ GD_ENTER + "Deseja Incluir agora ? "	,"Produtos sem Código de Seriçi"))

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Chama rotina para exportar para excel produtos sem amarracao. ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				MsgRun("Favor Aguardar.....", "Exportando para o Excel", {||GC511Excel(aNoPSRV)})

			EndIF
		EndIF

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EnvLeft   ºAutor³Josuel Silva-Sservice º Data ³  10/02/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por realizar o envio dos Itens para a    º±±
±±º          ³esquerda conforme parametros informados.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function EnvLeft(cTpBandeira)

Local cBandeira := RIGHT(cTpBandeira,1)

dbSelectArea("TMPTRB2")
TMPTRB2->(dbGoTop())
While  TMPTRB2->(!EoF())
	IF cBandeira <> 'T' .AND. !(cBandeira $ Alltrim(TMPTRB2->BANDEIRA))
		TMPTRB2->(dbSkip())
		Loop
	EndIF

		RecLock("TMPTRB",.T.)
			TMPTRB->PRODUTO	:=	TMPTRB2->PRODUTO
			TMPTRB->DESCPRO	:= 	TMPTRB2->DESCPRO
			TMPTRB->ALMOX		:=	TMPTRB2->ALMOX
			TMPTRB->C2D2QTDE	:= 	TMPTRB2->C2D2QTDE
			TMPTRB->UNIDADE	:= 	TMPTRB2->UNIDADE
			TMPTRB->PRECO		:= 	TMPTRB2->PRECO
			TMPTRB->VLRTOTAL	:= 	TMPTRB2->VLRTOTAL
			TMPTRB->TES		:= 	TMPTRB2->TES
			TMPTRB->PEDIDO 	:= 	TMPTRB2->PEDIDO
			TMPTRB->ITEMPV 	:= 	TMPTRB2->ITEMPV
			TMPTRB->NF			:= 	TMPTRB2->NF
			TMPTRB->SERIE		:= 	TMPTRB2->SERIE
			TMPTRB->EMISSAO	:= 	TMPTRB2->EMISSAO
			TMPTRB->CARTAO	:= 	TMPTRB2->CARTAO
			TMPTRB->DESCCARD	:= 	TMPTRB2->DESCCARD
			TMPTRB->BANDEIRA	:= 	TMPTRB2->BANDEIRA
			TMPTRB->TPENT		:= 	TMPTRB2->TPENT
			TMPTRB->CLIENTE	:= 	TMPTRB2->CLIENTE
			TMPTRB->LOJA		:= 	TMPTRB2->LOJA
			TMPTRB->ARQORI	:= 	TMPTRB2->ARQORI
			TMPTRB->ARQPERSO	:= 	TMPTRB2->ARQPERSO
			TMPTRB->ITEMNF	:= 	TMPTRB2->ITEMNF
			TMPTRB->PLASTICO	:=	TMPTRB2->PLASTICO
			TMPTRB->KIT		:=	TMPTRB2->KIT
			TMPTRB->DTARQUIVO	:=	TMPTRB2->DTARQUIVO
			TMPTRB->VTRUSH	:=	TMPTRB2->VTRUSH
			TMPTRB->CREDMAIS	:= 	TMPTRB2->CREDMAIS
			TMPTRB->UF			:= 	TMPTRB2->UF
			TMPTRB->GRPVENDA	:= 	TMPTRB2->GRPVENDA
			TMPTRB->TABPRECO	:= 	TMPTRB2->TABPRECO
			TMPTRB->CODPSRV	:= 	""
			TMPTRB->(MsUnlock())

			nQtdeTotal := nQtdeTotal - TMPTRB2->C2D2QTDE

		If RecLock("TMPTRB2",.F.)
			TMPTRB2->(DbDelete())
			TMPTRB2->(MsUnlock())
    	EndIF
		TMPTRB2->(dbSkip())

EndDo
	DbSelectArea("TMPTRB2")
	TMPTRB2->(DbGoTop())
	DbSelectArea("TMPTRB")
	TMPTRB->(DbGoTop())

	oTableRight:Refresh()
	oTableLeft:Refresh()
	oTotal:Refresh()

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldItensFat ºAutor  ³Josuel Silva-SS   º Data ³  17/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para validar os parametros informados.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldItensFat()
Local 		lContinua	:= .T.
Private 	lAgluBand	:= .F.

	DbSelectArea("TMPTRB2")
	TMPTRB2->(DbGoTop())
	IF TMPTRB2->(EoF())
		MsgStop("Não foram selecionado Itens para prosseguir com o Faturamento!")
		Return .F.
	EndiF


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se o tipo do Cliente for Governo           ³
	//³ nao terar separacao por tipo de Bandeira   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF lGoverno
		lAgluBand := .T.
	//Incluir tratamento para aglutinar servicos
	ElseIF MsgYesNo("Deseja aglutinar os Tipos de Bandeira  ?","::: Pedidos de Serviços ::: ")
		lAgluBand := .T.
	EndIF

	MsgRun('Aguarde... Gerando informações.','::: Faturamento X Remessa :::',{|| lContinua := GD511PV(lAgluBand)})

	IF !lContinua
		MsgStop("Favor realizar as amarrações necessárias para prosseguir com a Geração do Pedido de Venda")
	Else

		cCondPag 	:= POSICIONE("SA1",1,xFilial("SA1")+cCliente+cLoja,"A1_COND")
		cMenPad 	:= POSICIONE("SA1",1,xFilial("SA1")+cCliente+cLoja,"A1_XMENPA2")
		cCliNome 	:= cCliente+'-'+cLoja + ' / ' + ALLTRIM(POSICIONE("SA1",1,xFilial("SA1")+cCliente+cLoja,"A1_NREDUZ"))

		cTpServ 	:= IIF(lGoverno,'N','P')
		cFrete 	:= 'F'
		cCliFat	:= cCliente
		cLjCliFat	:= cLoja
		cDtVencto	:= CTOD("  /  /  ")

		oCliName:Refresh()
		oMenPad:Refresh()
		oCondPag:Refresh()

		oQtdTotal:Refresh()
		oVlrTotal:Refresh()
		oGetDados:Refresh()
	EndIF

Return lContinua

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GD511PV   ºAutor³Josuel Silva-Sservice º Data ³  10/02/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao responsavel por gerar Tela de informacao para dados  º±±
±±º          ³do pedido de venda.                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GD511PV(lAgluBand)
Local nPos		:=	0
Local nQtdSC6	:= 	0
Local nTotalEmb	:= 	0
Local cItemSC6	:= 	"00"
Local nPosProd	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_PSRV"	})
Local nPosBand	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_XBAND"	})

Local aPedOBS	:= {}
Local cAlmoxFat	:= ALLTRIM(SuperGetMV("GD_LOCFAT",.F.,"90"))//Almox Padrão 90
Local lContinua	:= .T.
Local nPrcVenda	:= 0
Local cPedGoverno := ""


	cPedObs		:= "Faturamento de Serviços, referente aos Pedidos No. "
	cPedGoverno 	:= cPedOBS

	aCols		:= {}

	DbSelectArea("Z9D")
	Z9D->(DbSetOrder(1))
	If Z9D->(dbSeek(xFilial("Z9D")+cCliente+cLoja))
		cTesServ  	:= Z9D->Z9D_TES
		cEmbed    := Z9D->Z9D_EMBED
		cCodEmbed	:= Z9D->Z9D_CODEMB
	EndIF

	DbSelectArea("TMPTRB2")
	TMPTRB2->(DbGoTop())
	DbSelectArea("Z9E")
	Z9E->(dbSetOrder(2))

	While TMPTRB2->(!EoF())
		nQtdSC6	 := 0
		IF lAgluBand
			cSeekZ9E :=	TMPTRB2->(CLIENTE+LOJA+CARTAO)
		Else
			cSeekZ9E :=	TMPTRB2->(CLIENTE+LOJA+CARTAO+BANDEIRA)
		EndIF

			IF lAgluBand
				nPos := aScan(aCols,{ |x| ALLTRIM(x[nPosProd]) == ALLTRIM(TMPTRB2->CODPSRV)})
			Else
				nPos := aScan(aCols,{ |x| ALLTRIM(x[nPosProd])+RIGHT(x[nPosBand],1) == ALLTRIM(TMPTRB2->CODPSRV)+RIGHT(TMPTRB2->BANDEIRA,1)})
			EndIF

			If nPos <> 0
				nQtdSC6		:= 	TMPTRB2->C2D2QTDE + aCols[nPos,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"	})]
				aCols[nPos,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"	})]:= nQtdSC6

				//Verifica se o pedido ja existe no Array para nao adicionar
				IF aScan(aPedOBS,{ |x| ALLTRIM(x) == TMPTRB2->PEDIDO }) == 0 .And. lGoverno
					AADD(aPedOBS,TMPTRB2->PEDIDO)
					cPedOBS += " | " + TMPTRB2->PEDIDO
					aCols[nPos,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC5_INSTRFA"	})]+=  " | " + TMPTRB2->PEDIDO
				EndIF

				TMPTRB2->(dbSkip())
				Loop
			Else

				IF aScan(aPedOBS,{ |x| ALLTRIM(x) == TMPTRB2->PEDIDO }) == 0 .And. lGoverno
					AADD(aPedOBS,TMPTRB2->PEDIDO)
					cPedOBS += " | " + TMPTRB2->PEDIDO
				EndIF

				cItemSC6 := Soma1(cItemSC6)
				aAdd(aCols, Array(Len(aHeader)+1))
				aCols[Len(aCols),1]	:= LoaDbitmap( GetResources(), "BR_VERMELHO" )
				nPrcVenda := GC511Preco(TMPTRB2->TABPRECO,TMPTRB2->CODPSRV,TMPTRB2->UF)


				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_ITEM"		})]:= cItemSC6
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_PSRV"		})]:= TMPTRB2->CODPSRV //Z9E->Z9E_PSRV
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_DESPSR"		})]:= Posicione("SB1",1,xFilial("SB1")+TMPTRB2->CODPSRV,"B1_DESC"	)
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_UM"			})]:= Posicione("SB1",1,xFilial("SB1")+TMPTRB2->CODPSRV,"B1_UM"	)
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"		})]:= nQtdSC6 + TMPTRB2->C2D2QTDE
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_PRCVEN"		})]:= nPrcVenda
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_VALOR"		})]:= nPrcVenda * (nQtdSC6 + TMPTRB2->C2D2QTDE)
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9D_TES"			})]:= cTesServ
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_LOCAL"		})]:= cAlmoxFat
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_XBAND"		})]:= IIF(lAgluBand,'OS',TMPTRB2->BANDEIRA)
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC5_MENNOTA"	})]:= Criavar("C5_MENNOTA",.F.)
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_EMB"		})]:= "N"
				aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC5_INSTRFA"	})]:= cPedGoverno + " | " + TMPTRB2->PEDIDO
				aCols[Len(aCols)][Len(aHeader)-1] 	:= "SC6"
				aCols[Len(aCols)][Len(aHeader)]   	:= 0
				aCols[Len(aCols),Len(aHeader)+1] 	:= .F.

			EndIf

		TMPTRB2->(dbSkip())

	EndDo

	IF cEmbed == "S" //Gera Pedido de Embeded ? Se Sim, faz a contagem das quantidades no aCols
		For nB := 1 To Len(aCols)
			nTotalEmb += aCols[nB,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"	})]
		Next nB

		cItemSC6 := Soma1(cItemSC6)
		aAdd(aCols, Array(Len(aHeader)+1))
		aCols[Len(aCols),1]	:= LoaDbitmap( GetResources(), "BR_VERMELHO" )
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_ITEM"		})]:= cItemSC6
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_PSRV"		})]:= cCodEmbed
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_DESPSR"		})]:= Posicione("SB1",1,xFilial("SB1")+cCodEmbed,"B1_DESC"	)
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_UM"	   		})]:= Posicione("SB1",1,xFilial("SB1")+cCodEmbed,"B1_UM" 	)
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"		})]:= nTotalEmb
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_PRCVEN"		})]:= 0
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_VALOR" 	})]:= 0
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9D_TES"			})]:= cTesServ
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_LOCAL"		})]:= cAlmoxFat
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_XBAND"		})]:= 'OS'
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC5_MENNOTA"	})]:= Criavar("C5_MENNOTA",.F.)
		aCols[Len(aCols),Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_EMB"		})]:= "S"
		aCols[Len(aCols)][Len(aHeader)-1] 	:= "SC6"
		aCols[Len(aCols)][Len(aHeader)]   	:= 0
		aCols[Len(aCols),Len(aHeader)+1] 	:= .F.
	EndIF


		DbSelectArea("TMPTRB2")
		TMPTRB2->(DbGoTop())

Return lContinua

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GP511DEL   ³ Autor ³ Josuel Silva-Sservices³ Data ³ 24/02/14³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Executa a Funcao de validacao do Campo de Preco do PSRV.   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GP511DEL()
Local lRet := .T.
Local nPosQuant := Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"	})
Local nPosValor	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_VALOR"	})

If lDelete
	IF aCols[n,nPosValor] > 0
		IF (aCols[n,Len(aCols[n])]) //Se estiver deletado
			nQtdTotal		:= nQtdTotal + 	aCols[n,nPosQuant]
			nVlrTotal   	:= nVlrTotal +	aCols[n,nPosValor]
		ElseIF !(aCols[n,Len(aCols[n])]) //Se não estiver deletado
			nQtdTotal		:= nQtdTotal - 	aCols[n,nPosQuant]
			nVlrTotal   	:= nVlrTotal -	aCols[n,nPosValor]
		EndIF
	EndIF

	oQtdTotal:Refresh()
	oVlrTotal:Refresh()
	oGetDados:Refresh()
	lDelete := .F.
Else
	lDelete := .T.
EndIF

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GP511PRC   ³ Autor ³ Josuel Silva-Sservices³ Data ³ 24/02/14³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Executa a Funcao de validacao do Campo de Preco do PSRV.   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GP511PRC()

Local lRet			:= .T.
Local nPosQuant 	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"})
Local nPosValor	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_VALOR"	})
Local nPosUM		:= Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_UM"		})
Local nPosTES		:= Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9D_TES"  	})
Local nPosLocal	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_LOCAL"  	})
Local nPosBand	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_XBAND"	})
Local nPosProd	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_PSRV"	})
Local cAlmoxFat	:= ALLTRIM(SuperGetMV("GD_LOCFAT",.F.,"90"))//Almox Padrão 90
Local nPosEmbed	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_EMB"	})
Local nPreco		:= &(READVAR())




	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Faz o gatilho dos campos Unidade de Medida,TES e Bandeira          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF( ReadVar() $ "M->Z9E_PSRV"  )
		aCols[n,	1				]	:= LoaDbitmap( GetResources(), "BR_VERMELHO" )
		aCols[n,	nPosUM			]	:= Posicione("SB1",1,xFilial("SB1")+ &(ReadVar()) ,"B1_UM" )
		aCols[n,	nPosTES		]	:= cTesServ
		aCols[n,	nPosLocal		]	:= cAlmoxFat
		aCols[n,	nPosBand		]	:= 'OS'
		aCols[n,	nPosEmbed		]	:= "N"
		aCols[n,Len(aHeader)-1	]	:= "SC6"

	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Valida preco informado para evitar que seja Zero e atualiza total. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (ReadVar() $ "M->GDC6_PRCVEN" )
		IF nPreco <= 0
			MsgAlert(" O preco do produto não pode ser menor ou igual a zero. !")
			Return  .F.
	 	EndiF

		IF nPreco > 0 .AND. !aCols[n,Len(aCols[n])]
			aCols[n,nPosValor]	:= aCols[n,nPosQuant] * nPreco
			aCols[n,		1]		:= LoaDbitmap(GetResources(), "BR_VERDE")
		EndIF
	EndIF

	nQtdTotal := 0
	nVlrTotal := 0
	For nY := 1 To Len(aCols)
		IF (aCols[nY,Len(aCols[nY])]) //Se estiver deletado
			Loop
		EndIF

		nQtdTotal		:= nQtdTotal + 	aCols[nY,nPosQuant]
		nVlrTotal   	:= nVlrTotal +	aCols[nY,nPosValor]

	Next nY

	oQtdTotal:Refresh()
	oVlrTotal:Refresh()
	oGetDados:Refresh()

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VldItensSC6³ Autor ³ Josuel Silva-Sservices³ Data ³ 24/02/14³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a Funcao de validacao do Campo de Preco do PSRV.   ³±±
±±³          ³ Valida se todos os itens estao com precos                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldItensSC6(cCliFat,cLjCliFat)

Local nPosPreco	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_PRCVEN"	})
Local lRet		:= .T.
Local nItens	:= 0
Local nZ


	IF Empty(cDtVencto) .And. lTipo9
		MsgAlert("Está sendo utilizado uma condição de pagamento Tipo 9, e não foi informado a data de Vencimento do Titulo.")
		oDtVenc:SetFocus()
		lRet := .F.
		Return lRet
	EndIF


	IF Empty(cCliFat) .Or. Empty(cLjCliFat)
		MsgAlert("Favor informar o Cliente / Loja corretos para Faturamento.")
		lRet := .F.
		Return lRet
	EndIF


	For nZ := 1 To Len(aCols)
		IF (aCols[nZ,Len(aCols[nZ])]) //Se estiver deletado
			Loop
		EndIF
		IF aCols[nZ,nPosPreco] <= 0
			MsgAlert("Alguns itens não possuem preços informados ! ")
			Return .F.
		EndIF
		nItens++
	Next nZ

	IF nItens == 0
		MsgAlert("Não há itens marcados para geração dos Pedidos Venda ! ")
		lRet := .F.
	ElseIF 	!(MsgYesNo("Confirma as informações abaixo e geração do Pedido de Venda para o Cliente -> " + cCliFat +'-'+cLjCliFat + ' / ' + ALLTRIM(POSICIONE("SA1",1,xFilial("SA1")+cCliFat+cLjCliFat,"A1_NREDUZ"))+ "?","::: Pedidos de Serviços ::: "))
		lRet := .F.
	EndIF

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GD511Z9F   ³ Autor ³ Josuel Silva-Sservices³ Data ³ 24/02/14³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Executa a Funcao para gravacao dos itens de remessa x PSRV.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GD511Z9F(cNumPVPSRV,cCliFat,cLjCliFat,cItemPV,cProdPSRV,cTpQuebra)

Local lRet	:= .T.
Local nK
Local cItemPSRV := "00"
Default cItemPV := "00"
Default cProdPSRV := ""

	DbSelectArea("TMPTRB2")
	TMPTRB2->(DbGoTop())

	While TMPTRB2->(!EoF())

		IF cTpQuebra == "S" .And. cProdPSRV <> TMPTRB2->CODPSRV
			TMPTRB2->(dbSkip())
			Loop
		EndIF
						////Busca o Item do Pedido do PSRV
		cItemPSRV :=  IIF(cItemPV=="00",aCols[aScan(aCols,{|x| x[3] == TMPTRB2->CODPSRV })][2], cItemPV)

		IF cItemPSRV == "00"
			TMPTRB2->(dbSkip())
			Loop
		EndIF

		IF RecLock("Z9F",.T.)
			Z9F->Z9F_FILIAL		:= xFilial("Z9F")
			Z9F->Z9F_PVPSRV		:= cNumPVPSRV
			Z9F->Z9F_DATA			:= dDatabase
			Z9F->Z9F_USER			:= Upper(cUserName)
			Z9F->Z9F_CLIFAT		:= cCliFat 	//Cliente informado para Faturamento
			Z9F->Z9F_LJFAT		:= cLjCliFat 	// Loja do Cliente informado para Faturamento
			Z9F->Z9F_CLIENT		:= TMPTRB2->CLIENTE
			Z9F->Z9F_LOJA			:= TMPTRB2->LOJA
			Z9F->Z9F_PVREM		:= TMPTRB2->PEDIDO
			Z9F->Z9F_ITREM		:= TMPTRB2->ITEMPV
			Z9F->Z9F_CODREM		:= TMPTRB2->PRODUTO
			Z9F->Z9F_CODPSR		:= TMPTRB2->CODPSRV
			Z9F->Z9F_ITPSRV		:= cItemPSRV
			Z9F->Z9F_QUANT		:= TMPTRB2->C2D2QTDE
			Z9F->Z9F_ARQORI		:= TMPTRB2->ARQORI
			Z9F->Z9F_ARQPER		:= TMPTRB2->ARQPERSO
			Z9F->Z9F_DOC			:= TMPTRB2->NF
			Z9F->Z9F_SERIE		:= TMPTRB2->SERIE
			Z9F->Z9F_ITEMNF		:= TMPTRB2->ITEMNF
			Z9F->Z9F_PLASTI		:= TMPTRB2->PLASTICO
			Z9F->Z9F_KIT			:= TMPTRB2->KIT
			Z9F->Z9F_DTARQ		:= TMPTRB2->DTARQUIVO
			Z9F->Z9F_CARTAO		:= TMPTRB2->CARTAO
			Z9F->(MsUnlock())
		EndIF

		If RecLock("TMPTRB2",.F.)
			TMPTRB2->(DbDelete())
			TMPTRB2->(MsUnlock())
    	EndIF

	TMPTRB2->(dbSkip())
	EndDo
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GC511Preco ³ Autor ³ Josuel Silva         ³ Data  ³15/04/16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Faz a busca do preco na tabela de preco DA1 para cliente GO³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GC511Preco(cTabela,cProdServ,cUF)
Local nPrecoServ := 0

	DbSelectArea("DA1")
	DA1->(dbsetorder(7))

	IF DA1->(DbSeek(xfilial("DA1") + cTabela + cProdServ + cUF ))
		nPrecoServ	:= DA1->DA1_PRCVEN
	EndIF

	DbSelectArea("DA1")
	DA1->(DbCloseArea())

Return nPrecoServ




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ¿±±
±±³Funcao   ³PnlParam    ³ Autor ³Josuel Silva ³ Data ³11/03/16³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄ´±±
±±³Descricao³Monta Painel de Tela de Paramentros.              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/

Static Function PnlParam()

		dbSelectArea("SX3")
		dbSetOrder(2)
		If dbSeek( "Z9D_TPFAT" )
			aTpFat := Separa(X3Cbox(),";",.T.)
		EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria campos para informacoes de Parametros  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oGetCliente		:= 	TGet():New(20,20, {|u|if(PCount()>0,cCliente:=u,cCliente	)},	oWizard:oMPanel[2],040,015,PesqPict("Z9D","Z9D_CLIENT"),;
							{||IIF(!Empty(cCliente),ExistCpo("Z9D",cCliente),.T.) .And. VldCpos(cCliente) },;
							0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,'Z9D','cCliente',,,,,,,"Cliente:",1,oFont12N,CLR_BLUE )


		oGetLoja		:= 	TGet():New(20,65, {|u|if(PCount()>0,cLoja:=u,cLoja	)},	oWizard:oMPanel[2],020,015,PesqPict("Z9D","Z9D_LOJA"),{||},;
							0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cLoja',,,,,,,'Loja',1,oFont12N,CLR_BLUE )

		oSayRazao		:= tSay():New( 030,090,	{||ALLTRIM(cRazao) },oWizard:oMPanel[2],,oFont14N,,,,.T.,CLR_BLUE,CLR_WHITE,200,20)

		oCbxTpEnt	:= tComboBox():New(060,020,{|u|if(PCount()>0,cTpFat:=u,cTpFat)} ,aTpFat	,100,035,oWizard:oMPanel[2],,{||},{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cTpFat',"Tipo de Faturamento ?",1 ,oFont12N,CLR_BLUE)


		oGetDataDe		:= 	TGet():New(90,20, {|u|if(PCount()>0,cDataDe:=u,cDataDe	)},	oWizard:oMPanel[2],040,015,"@!",{||},;
							0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cDataDe',,,,,,,'Periodo de ?',1,oFont12N,CLR_BLUE )

		oGetDataAte	:= 	TGet():New(120,20, {|u|if(PCount()>0,cDataAte:=u,cDataAte	)},	oWizard:oMPanel[2],040,015,"@!",{||},;
							0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cDataAte',,,,,,,'Periodo Ate?',1,oFont12N,CLR_BLUE )


		oGetCliente	:SetCss(GDSTYLETEXT	)
		oGetLoja		:SetCss(GDSTYLETEXT	)
		oSayRazao		:SetCss(GDSTYLESAY	)
		oGetDataDe		:SetCss(GDSTYLETEXT	)
		oGetDataAte	:SetCss(GDSTYLETEXT	)
		oCbxTpEnt		:SetCss(GDSTYLE_COMBOBOX	)
		oGetCliente:SetFocus()


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PnlTable  ºAutor³Josuel Silva          º Data ³  11/03/2016 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta tela Estrutura da Tabela Temporaria a ser usada.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PnlTable()

Local 	bRight 	:= {|| MsgRun("Buscando processando informações.","Favor aguarde...",{||EnvRight(@cTpBandeira,/*TipoCartao*/,cPlastico,cCbxServ )})}
Local 	bLeft		:= {||	MsgRun("Buscando processando informações.","Favor aguarde...",{||EnvLeft(@cTpBandeira/*TipoCartao*/,cPlastico,cCbxServ)})}
Local 	bRightAll	:= {||	MsgRun("Buscando processando informações.","Favor aguarde...",{||EnvRight("T",/*TipoCartao*/,/*cPlastico*/)})}
Local 	bCredito	:= {|| MsgRun("Buscando processando informações.","Favor aguarde...",{||EnvRight(@cTpBandeira,'C',cPlastico)})}
Local 	bDebito	:= {|| MsgRun("Buscando processando informações.","Favor aguarde...",{||EnvRight(@cTpBandeira,'D',cPlastico)})}
Local 	bLeftAll	:= {||	MsgRun("Buscando processando informações.","Favor aguarde...",{||EnvLeft("T",/*TipoCartao*/,/*cPlastico*/)})}
Local bCadZ9E		:= {|| GC511Z9E() }



		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define campos do MsSelect ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SX3")
		SX3->(dbSetOrder(1))
		aStruct := {}
		AADD(aStruct,{'PRODUTO'		,'C',TamSX3("D2_COD"			)[1] ,TamSX3("D2_COD"		)[2]})
		AADD(aStruct,{'DESCPRO'		,'C',TamSX3("B1_DESC"  		)[1] ,TamSX3("B1_DESC"		)[2]})
		AADD(aStruct,{'ALMOX'		,'C',TamSX3("D2_LOCAL" 		)[1] ,TamSX3("D2_LOCAL"		)[2]})
		AADD(aStruct,{'C2D2QTDE'		,'N',TamSX3("D2_QUANT" 		)[1] ,TamSX3("D2_QUANT"		)[2]})
		AADD(aStruct,{'UNIDADE'		,'C',TamSX3("D2_UM"	   		)[1] ,TamSX3("D2_UM"		)[2]})
		AADD(aStruct,{'PRECO'		,'N',TamSX3("D2_PRCVEN"		)[1] ,TamSX3("D2_PRCVEN"	)[2]})
		AADD(aStruct,{'VLRTOTAL'		,'N',TamSX3("D2_TOTAL" 		)[1] ,TamSX3("D2_TOTAL"		)[2]})
		AADD(aStruct,{'TES'			,'C',TamSX3("D2_TES"			)[1] ,TamSX3("D2_TES"		)[2]})
		AADD(aStruct,{'PEDIDO'		,'C',TamSX3("D2_PEDIDO"		)[1] ,TamSX3("D2_PEDIDO"	)[2]})
		AADD(aStruct,{'ITEMPV'		,'C',TamSX3("D2_ITEMPV"		)[1] ,TamSX3("D2_ITEMPV"	)[2]})
		AADD(aStruct,{'NF'	   		,'C',TamSX3("D2_DOC"			)[1] ,TamSX3("D2_DOC"		)[2]})
		AADD(aStruct,{'SERIE'		,'C',TamSX3("D2_SERIE"		)[1] ,TamSX3("D2_SERIE"		)[2]})
		AADD(aStruct,{'EMISSAO'		,'D',TamSX3("D2_EMISSAO"		)[1] ,TamSX3("D2_EMISSAO"	)[2]})
		AADD(aStruct,{'CARTAO'		,'C',TamSX3("G1_COMP"  		)[1] ,TamSX3("G1_COMP"		)[2]})
		AADD(aStruct,{'DESCCARD'		,'C',TamSX3("B1_DESC"		)[1] ,TamSX3("B1_DESC"		)[2]})
		AADD(aStruct,{'BANDEIRA'		,'C',TamSX3("Z9E_XBAND"		)[1] ,TamSX3("Z9E_XBAND"	)[2]})
		AADD(aStruct,{'TPENT'		,'C',TamSX3("D2_TPENT"		)[1] ,TamSX3("D2_TPENT"		)[2]})
		AADD(aStruct,{'CLIENTE'		,'C',TamSX3("D2_CLIENTE"		)[1] ,TamSX3("D2_CLIENTE"	)[2]})
		AADD(aStruct,{'LOJA'			,'C',TamSX3("D2_LOJA"  		)[1] ,TamSX3("D2_LOJA"		)[2]})
		AADD(aStruct,{'ARQORI'		,'C',TamSX3("Z86_ARQORI"		)[1] ,TamSX3("Z86_ARQORI"	)[2]})
		AADD(aStruct,{'ARQPERSO'		,'C',TamSX3("Z86_ARQPER"		)[1] ,TamSX3("Z86_ARQPER"	)[2]})
		AADD(aStruct,{'ITEMNF'		,'C',TamSX3("D2_ITEM"		)[1] ,TamSX3("D2_ITEM"		)[2]})
		AADD(aStruct,{'PLASTICO'		,'C',TamSX3("Z86_PLASTI"		)[1] ,TamSX3("Z86_PLASTI"	)[2]})
		AADD(aStruct,{'KIT'			,'C',TamSX3("Z86_KIT"		)[1] ,TamSX3("Z86_KIT"		)[2]})
		AADD(aStruct,{'DTARQUIVO'	,'D',TamSX3("Z86_DATA"		)[1] ,TamSX3("Z86_DATA"		)[2]})
		AADD(aStruct,{'VTRUSH'		,'C',TamSX3("D2_UM"	   		)[1] ,TamSX3("D2_UM"		)[2]})
		AADD(aStruct,{'CREDMAIS'		,'C',3	,0})
		AADD(aStruct,{'UF'			,'C',TamSX3("A1_EST"	   		)[1] ,TamSX3("A1_EST"		)[2]})
		AADD(aStruct,{'GRPVENDA'		,'C',TamSX3("A1_GRPVEN"	   	)[1] ,TamSX3("A1_GRPVEN"		)[2]})
		AADD(aStruct,{'TABPRECO'		,'C',TamSX3("A1_TABELA"	   	)[1] ,TamSX3("A1_TABELA"		)[2]})
		AADD(aStruct,{'CODPSRV'		,'C',TamSX3("D2_COD"	   		)[1] ,TamSX3("D2_COD"		)[2]})
		AADD(aStruct,{"FLAG","L",1,0})

		If Select("TMPTRB") > 0
			TMPTRB->(DbCloseArea())
		Endif

		If Select("TMPTRB2") > 0
			TMPTRB2->(DbCloseArea())
		Endif

		cCriaTrB	 := CriaTrab(aStruct,.T.)
		dbUseArea(.T.,,cCriaTrB,"TMPTRB",.F.,.F.)
		cIndexTMP   :="PEDIDO+ITEMPV+NF+SERIE+PRODUTO"
		IndRegua("TMPTRB",cCriaTrB,cIndexTMP,,,"Selecionando Registros...")

		cCriaTrB2	 := CriaTrab(aStruct,.T.)
		dbUseArea(.T.,,cCriaTrB2,"TMPTRB2",.F.,.F.)
		IndRegua("TMPTRB2",cCriaTrB2,cIndexTMP,,,"Selecionando Registros...")

		lCriaTMP := .F.

	//Tabela Principal Esquerda
	oTableLeft :=  MsSelBr():New(020,005,nLargTable-30,nAltura,;
								,,,oWizard:oMPanel[3],,,,,,,,,,,,.F.,"TMPTRB",.T.,,.F.,,, )

							oTableLeft:AddColumn(TCColumn():New('Pedido' 		,{||TMPTRB->PEDIDO 		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Item PV'		,{||TMPTRB->ITEMPV 		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Cartao' 		,{||TMPTRB->CARTAO 		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Descricao'	,{||TMPTRB->DESCCARD 	},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('NF'			,{||TMPTRB->NF 			},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Serie'		,{||TMPTRB->SERIE  		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Quant.'  	,{||TMPTRB->C2D2QTDE 	},,,,'RIGHT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Emissao'		,{||TMPTRB->EMISSAO 		},,,,'CENTER'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Bandeira'	,{||TMPTRB->BANDEIRA		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableLeft:AddColumn(TCColumn():New('Entrega'		,{||TMPTRB->TPENT			},,,,'LEFT'		,,.F.,.F.,,,,.F.,))

	oTableLeft:lHasMark 		:= .F.
	oTableLeft:lCanAllMark	:= .F.
	oTableLeft:lAllMark 		:= .F.

	//Tabela Auxiliar Direita
	oTableRight :=  MsSelBr():New(020,nLargTable+40,nLargTable-40,nAltura,;
								,,,oWizard:oMPanel[3],,,,,,,,,,,,.F.,"TMPTRB2",.T.,,.F.,,, )
							oTableRight:AddColumn(TCColumn():New('Pedido' 		,{||TMPTRB2->PEDIDO		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Item PV'		,{||TMPTRB2->ITEMPV		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Cartao' 		,{||TMPTRB2->CARTAO		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Descricao'		,{||TMPTRB2->DESCCARD 	},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('NF'				,{||TMPTRB2->NF			},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Serie'			,{||TMPTRB2->SERIE 		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Quant.'  		,{||TMPTRB2->C2D2QTDE 	},,,,'RIGHT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Emissao'		,{||TMPTRB2->EMISSAO 	},,,,'CENTER'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Bandeira'		,{||TMPTRB2->BANDEIRA	},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('Entrega'		,{||TMPTRB2->TPENT		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))
							oTableRight:AddColumn(TCColumn():New('PSRV'			,{||TMPTRB2->CODPSRV		},,,,'LEFT'		,,.F.,.F.,,,,.F.,))

	oTableRight:lHasMark 	:= .F.
	oTableRight:lCanAllMark := .F.
	oTableRight:lAllMark 	:= .F.


		oTotal	:= TGet():New(004, nLargTable+200 , {|u|if(PCount()>0,nQtdeTotal:=u,nQtdeTotal	)},	oWizard:oMPanel[3],60,10,PesqPict("SD2", "D2_TOTAL"),{||},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'nQtdeTotal',,,,,,,"Quantidade",2 ,oFont12N,CLR_RED)


		oCbxServ	:= 	tComboBox():New(002,nLargTable-150,	{|u|if(PCount()>0,cCbxServ:=u,cCbxServ)},aCbxServ,280,30,oWizard:oMPanel[3],,;
																{||},{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cCbxServ',"Código do Servico:",2 ,oFont10N,CLR_RED)

		oCbxBand	:= tComboBox():New(20,nLargTable-20,{|u|if(PCount()>0,cTpBandeira:=u,cTpBandeira)} ,aTpBandeira,55,20,oWizard:oMPanel[3],,;
																{||},{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cTpBandeira',"Bandeira",1 ,oFont12N,CLR_BLUE)

		oCbxPlast	:= tComboBox():New(45,nLargTable-20,{|u|if(PCount()>0,cPlastico:=u,cPlastico)} ,aPlasticos,55,20,oWizard:oMPanel[3],,;
																{||},{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cPlastico',"Plastico",1 ,oFont12N,CLR_BLUE)

		oBtnEnv		:= TButton():New(075	,nLargTable-20,"Enviar"			,oWizard:oMPanel[3],bRight		,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)
		oBtnRet		:= TButton():New(100	,nLargTable-20,"Retornar"			,oWizard:oMPanel[3],bLeft		,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)
		oBtnEnvTd	:= TButton():New(125	,nLargTable-20,"Envia Todos"		,oWizard:oMPanel[3],bRightAll	,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)
		oBtnEnvCred	:= TButton():New(150	,nLargTable-20,"Só Crédito"		,oWizard:oMPanel[3],bCredito	,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)
		oBtnEnvDebi	:= TButton():New(175	,nLargTable-20,"Só Débito"			,oWizard:oMPanel[3],bDebito		,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)
		oBtnRetTd	:= TButton():New(200	,nLargTable-20,"Ret.Todos"			,oWizard:oMPanel[3],bLeftAll	,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)

		oBtnCadZ9E	:= TButton():New(225	,nLargTable-20,"Amarr.PSRV"		,oWizard:oMPanel[3],bCadZ9E	,55,20,/*[ uParam8]*/,,.F.,.T.,.F.,,.F.,,,.F.)

		oCbxBand		:SetCss(GDSTYLE_COMBOBOX	)
		oCbxPlast		:SetCss(GDSTYLE_COMBOBOX	)
		oCbxServ		:SetCss(GDSTYLE_COMBOBOX	)

		oTotal		:SetCss(GDSTYLETEXT)
		oTotal		:Disable()

		oBtnEnv		:SETCSS( GDSTYLE_BTN_ADDOP	)
		oBtnRet		:SETCSS( GDSTYLE_BTN_SAIR	)
		oBtnEnvTd		:SETCSS( GDSTYLE_BTN_ADDOP	)
		oBtnEnvCred	:SETCSS( GDSTYLE_BTN_ADDOP	)
		oBtnEnvDebi	:SETCSS( GDSTYLE_BTN_ADDOP	)
		oBtnRetTd		:SETCSS( GDSTYLE_BTN_SAIR	)
		oBtnCadZ9E		:SETCSS( GDSTYLE_BTN_ADDPV	)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PnlPedido ºAutor³Josuel Silva          º Data ³  14/09/2016 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta tela para preenchimento e geracao dos Pedidos         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PnlPedido()

Local aAlter 	:=	{"Z9E_PSRV","GDC6_QTDVEN","GDC6_PRCVEN","Z9D_TES","C6_LOCAL","GDC5_MENNOTA","GDC5_INSTRFA"}
Local aCpoSC6	:=	{"GDC6_ITEM","Z9E_PSRV","Z9E_DESPSR","GDC6_UM","GDC6_QTDVEN","GDC6_PRCVEN","GDC6_VALOR","Z9D_TES","C6_LOCAL","Z9E_XBAND","GDC5_MENNOTA","GDC5_INSTRFA"}


	dbSelectArea("SX3")
	dbSetOrder(2)
	If dbSeek( "C5_TPSRV" )
		aTpServ := Separa(X3Cbox(),";",.T.)
	EndIf
	If dbSeek( "C5_TPFRETE" )
		aFrete := Separa(X3Cbox(),";",.T.)
	EndIf


	oCliName	:= TGet():New(005,010 , {|u|if(PCount()>0,cCliNome:=u,cCliNome	)},	oWizard:oMPanel[4],240,12,"@!",{||},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cCliNome',,,,,,,"Cliente/Nome:",1 ,oFont12N,CLR_BLUE)


	oCondPag	:= TGet():New(030,010 , {|u|if(PCount()>0,cCondPag:=u,cCondPag	)},	oWizard:oMPanel[4],40,12,PesqPict("SC5","C5_CONDPAG"	),{||ExistCpo("SE4"),GCVLDSE4(cCondPag)},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,'SE4','cCondPag',,,,,,,"Cond.Pagto:",1 ,oFont12N,CLR_BLUE)


	oMenPad	:= TGet():New(030,100 , {|u|if(PCount()>0,cMenPad:=u,cMenPad	)},	oWizard:oMPanel[4],40,12,PesqPict("SC5","C5_MENPAD"	),{||},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,'SM4','cMenPad',,,,,,,"Msg.Padrao:",1 ,oFont12N,CLR_BLUE)

	oDtVenc	:= TGet():New(030,160 , {|u|if(PCount()>0,cDtVencto:=u,cDtVencto	)},	oWizard:oMPanel[4],40,12,PesqPict("SC5","C5_DATA1"	),{||},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cDtVencto',,,,,,,"Vecto Titulo:",1 ,oFont12N,CLR_BLUE)
	oDtVenc:Hide() //Desabilita campo no Carregamento


	oFrete	:= tComboBox():New(055,010,{|u|if(PCount()>0,cFrete:=u,cFrete)} ,aFrete,80,20,oWizard:oMPanel[4],,;
																{||},{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cFrete',"Tipo de Frete:",1 ,oFont12N,CLR_BLUE)

	oTpServ	:= tComboBox():New(055,100,{|u|if(PCount()>0,cTpServ:=u,cTpServ)} ,aTpServ,100,20,oWizard:oMPanel[4],,;
																{||},{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cTpServ',"Tipo de Serviço:",1 ,oFont12N,CLR_BLUE)

	cTpQuebra := "N"
	oTpQuebra	:= tComboBox():New(080,010,{|u|if(PCount()>0,cTpQuebra:=u,cTpQuebra)} ,{"S=Sim","N=Nao"} ,80,20,oWizard:oMPanel[4],,;
																{|| IIF(cTpQuebra=="S",oMenNota:Hide(),oMenNota:Show()), IIF(cTpQuebra=="S",cMenNota:="" ,cMenNota := cMenNota) },{||},,/*CLR_WHITE*/,.T.,,,,,,,,,'cTpQuebra',"Gera Pedido por Item:",1 ,oFont12N,CLR_BLUE)

	oMenNota	:= TGet():New(080,100 , {|u|if(PCount()>0,cMenNota:=u,cMenNota	)},	oWizard:oMPanel[4],220,12,PesqPict("SC5","C5_MENNOTA"	),{||},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cMenNota',,,,,,,"Mensagem p/Nota:",1 ,oFont12N,CLR_BLUE)

	oCliFat	:= TGet():New(105,010 , {|u|if(PCount()>0,cCliFat:=u,cCliFat	)},	oWizard:oMPanel[4],55,12,PesqPict("SC5","C5_CLIENTE"	),{||IIF(!Empty(cCliFat),ExistCpo("SA1",cCliFat),.T.)},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,'SA1','cCliFat',,,,,,,"Cliente e Loja para Faturamento:",2 ,oFont12N,CLR_RED)

	oLjCliFat	:= TGet():New(105,160 , {|u|if(PCount()>0,cLjCliFat:=u,cLjCliFat	)},	oWizard:oMPanel[4],20,12,PesqPict("SC5","C5_LOJACLI"	),{||},;
											0,,,.F.,,.T.,,.F.,{||},.F.,.F.,,.F.,.F.,,'cLjCliFat',,,,,,,,1,oFont12N,CLR_RED)


	oQtdTotal	:= tSay():New(nAltura		,005		,{||"Quantidade Total:" + Transform(nQtdTotal,"@E 999,999,999.99")		},oWizard:oMPanel[4],,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,200,020)
   	oVlrTotal 	:= tSay():New(nAltura+10 	,005		,{||"Valor Total R$:" + Transform(nVlrTotal,"@E 999,999,999.99")		},oWizard:oMPanel[4],,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,200,020)


	oFrete		:SetCss(GDSTYLE_COMBOBOX	)
	oTpServ	:SetCss(GDSTYLE_COMBOBOX	)
	oTpQuebra	:SetCss(GDSTYLE_COMBOBOX)
	oCliName	:SetCss(GDSTYLETEXT)
	oCliName	:Disable()

	oCondPag	:SetCss(GDSTYLETEXT)

	oMenPad	:SetCss(GDSTYLETEXT)
	oMenNota	:SetCss(GDSTYLETEXT)
	oCliFat	:SetCss(GDSTYLETEXT)
	oLjCliFat	:SetCss(GDSTYLETEXT)
	oDtVenc	:SetCss(GDSTYLETEXT)



	//Monta GetDados do Pedido de Vendas
	aHeader	:= {}
	aCols		:= {}
	nUsado 	:= 0

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta o cabecalho                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Aadd(aHeader,{	"  "	,;
					  	"GDC6_OK"	,;
					  	"@BMP"	,;
					  	1		,;
					  	0		,;
					  	""		,;
					  	""		,;
					  	"C"		,;
					  	""		,;
					  	""})
		nUsado++

		dbSelectArea("SX3")
		dbSetOrder(2)
		For nA := 1 To Len(aCpoSC6)
			cSeekSX3 := IIF(LEFT(aCpoSC6[nA],2) == "GD", SubStr(aCpoSC6[nA],3),aCpoSC6[nA])
			If dbSeek(cSeekSX3)
				nUsado++
				AADD(aHeader,{AllTrim(X3Titulo()),;
								aCpoSC6[nA]		,;
								SX3->X3_PICTURE,;
								SX3->X3_TAMANHO,;
								SX3->X3_DECIMAL,;
								IIF(cSeekSX3=="C6_LOCAL",'ExistCpo("NNR")',Nil),; //SX3->X3_VALID
								SX3->X3_USADO,;
								SX3->X3_TIPO,;
								SX3->X3_ARQUIVO,;
								SX3->X3_CONTEXT	})
			EndIf
		Next nA
		//Flag de Tipo de PSRV
		Aadd(aHeader,{	"Embed"	,;
					  	"GDC6_EMB"	,;
					  	"@!"	,;
					  	1		,;
					  	0		,;
					  	""		,;
					  	""		,;
					  	"C"		,;
					  	""		,;
					  	""})
		nUsado++

   	ADHeadRec("Z9D",aHeader)

	oGetDados := MSGetDados():New(130,010,nAltura-10,nLargGETD-20,;
									4,'AllwaysTrue','AllwaysTrue',"+GDC6_ITEM",.T.,aAlter,NIL,NIL,999999,'U_GP511PRC',,,'U_GP511DEL',oWizard:oMPanel[4])

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GC511Z9E   ³ Autor ³ Josuel Silva          ³ Data ³ 16/09/16³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chama funcao para cadastro de Produtos sem amarracao.      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GCVLDSE4(cCondPag)
Local aArea     := GetArea()
Local aAreaSE4 	:= SE4->(GetArea())

	dbSelectArea("SE4")
	SE4->(dbSetOrder(1))
	MsSeek(xFilial("SE4")+ cCondPag)

	IF SE4->E4_TIPO=="9"
		lTipo9 := .T.
		oDtVenc:Show()
	Else
		lTipo9 := .F.
		oDtVenc:Hide()
	EndiF

SE4->(RestArea(aAreaSE4))
RestArea(aArea)
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³GC511Z9E   ³ Autor ³ Josuel Silva          ³ Data ³ 16/09/16³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Chama funcao para cadastro de Produtos sem amarracao.      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GC511Z9E()

	DbSelectArea("Z9D")
	Z9D->(DbSetOrder(1))
	if Z9D->(DbSeek(xFilial("Z9D")+ cCliente+cLoja ))
		FWExecView('Cadastro de PSRV',"VIEWDEF.GCFAT509",MODEL_OPERATION_UPDATE,,{|| .T. },,,,,,,)
	Else
		//Caso nao encontre faz a inclusao
		FWExecView("Cadastro de PSRV" + ' - Inclusao','VIEWDEF.GCFAT509', MODEL_OPERATION_INSERT,,{|| .T. },,,,,,,)
	EndiF


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GD535PV		 ³ Autor ³Josuel Silva           ³ Data ³23/03/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina para gerar os Pedidos de Vendas dos arquivos Importados.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GPPCP535                                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GD535PV()
Local lPrimeiro		:= .T.
Local aSC5 			:= {}
Local aSC6 			:= {}
Local cNumPv		:= ""
Local lGeraPV 	:= .T.
Local cNaturez	:= Criavar("C5_NATUREZ",.F.)
Local cItem		:= "00"
Local cCodPsrv	:= ""
Local cNumeros 	:= ""
Local cMensagem 	:= cMenNota
Local cMenGeral	:= cPedOBS

	cNaturez := POSICIONE("SA1",1,xFilial("SA1")+cCliente+cLoja,"A1_NATUREZ")


	For nI := 1 To Len(aCols)
		IF (aCols[nI,Len(aCols[nI])]) //Se estiver deletado
			Loop
		EndIF
			If lPrimeiro
				lPrimeiro := .F.

				IF cTpQuebra == "S"
					cMensagem := aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC5_MENNOTA"	})]
					cMenGeral	:= aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC5_INSTRFA"	})]
				EndIF

				cNumPv	:= GetSxeNum("SC5","C5_NUM")
				ConfirmSX8()

					AAdd( aSC5, {"C5_FILIAL"	,xFilial("SC5")				,Nil} )	//Filial
					AAdd( aSC5, {"C5_FILIAL"	,xFilial("SC5")				,Nil} )
					AAdd( aSC5, {"C5_NUM"		,cNumPv						,Nil} )
					AAdd( aSC5, {"C5_TIPO"   	,"N"							,Nil} )
					AAdd( aSC5, {"C5_CLIENTE"	,cCliFat						,Nil} )
					AAdd( aSC5, {"C5_LOJACLI"	,cLjCliFat						,Nil} )
					AAdd( aSC5, {"C5_EMISSAO"	,dDatabase						,Nil} )
					AAdd( aSC5, {"C5_CONDPAG"	,cCondPag						,Nil} )
					AAdd( aSC5, {"C5_TIPLIB" 	,"1"							,Nil} )
					AAdd( aSC5, {"C5_TPFRETE"	,cFrete						,Nil} )
					AAdd( aSC5, {"C5_MENPAD"		,cMenPad						,Nil} )
					AAdd( aSC5, {"C5_MENNOTA"	,cMensagem						,Nil} )
					AAdd( aSC5, {"C5_NATUREZ"	,cNaturez						,Nil} )
					AAdd( aSC5, {"C5_TPSRV"		,cTpServ						,Nil} )
					AAdd( aSC5, {"C5_LIBEROK"	,"S"							,Nil} )
					AAdd( aSC5, {"C5_ESTPRES"	,SM0->M0_ESTENT				,Nil} )

					if lTipo9
						AAdd( aSC5, {"C5_DATA1"	,cDtVencto 					,Nil} )
						AAdd( aSC5, {"C5_PARC1"	,100							,Nil} )
					EndIF

					AAdd( aSC5, {"C5_MUNPRES"	,SubStr(SM0->M0_CODMUN,3,5)	,Nil} )
					AAdd( aSC5, {"C5_DESCMUN"	,ALLTRIM(SM0->M0_CIDENT)		,Nil} )
					AAdd( aSC5, {"C5_INSTRFA"	,IIF(lGoverno,cMenGeral,"")	,Nil} )

			EndIF

				aLinha := {}
				aLinha := {{"C6_FILIAL"	,xFilial("SC6")												   		,Nil},;
							{"C6_NUM"		,cNumPv																,Nil},;
							{"C6_ITEM"		,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_ITEM" 		})]	,Nil},;
							{"C6_PRODUTO"	,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_PSRV" 		})]	,Nil},;
							{"C6_LOCAL"	,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_LOCAL"  		})]	,Nil},;
							{"C6_QTDVEN"	,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"		})]	,Nil},;
							{"C6_PRCVEN"	,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_PRCVEN"		})]	,Nil},;
							{"C6_TES"		,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9D_TES"			})]	,Nil},;
							{"C6_QTDLIB" 	,aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_QTDVEN"		})]	,Nil},;
							{"C6_ENTREG"	,dDatabase													   			,Nil}}

						IF cTpQuebra == "S"
							cItem 		:= aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_ITEM" 	})]
							cCodPsrv	:= aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "Z9E_PSRV" 	})]
						EndIF

		aAdd(aSC6,aLinha)
		lGeraPV := .T.

		IF cTpQuebra == "N" .And. nI < Len(aCols)
			Loop
		EndIF

		IF lGeraPV
				BeginTran()
				lMsErroAuto	:= .F.

				//Executa a rotina automatica de pedido de vendas
				MSExecAuto({|x,y,z| Mata410(x,y,z)},aSC5,aSC6,3)

				If lMsErroAuto
					MostraErro()
					DisarmTransaction()
				Else
					EndTran()
					cNumeros += SC5->C5_NUM + GD_ENTER

					if cTpQuebra == "N"
						GD511Z9F(SC5->C5_NUM,cCliFat,cLjCliFat,cItem,cCodPsrv,cTpQuebra)
					ElseIF aCols[nI,Ascan(aHeader,{|x| Alltrim(x[2]) == "GDC6_EMB"	})] == "N"
						GD511Z9F(SC5->C5_NUM,cCliFat,cLjCliFat,cItem,cCodPsrv,cTpQuebra)
					EndIF
				EndIf
			cNumPv	:= ""
			aSC5	:= {}
			aSC6	:= {}

			lPrimeiro := .T.
		EndIF

	Next nI

	Aviso("Pedido de Venda"," Pedidos de Venda Gerados  : " + GD_ENTER + cNumeros ,{"OK"},3)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GC511ExcelºAutor  ³Josuel Silva        º Data ³  16/09/2016 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gerar excel com produto sem amarracao.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GC511Excel(aItensExcel)

Local oReport := nil
	oReport := ReportDef(aItensExcel)
	oReport :Print()

Return Nil


/*/

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Josuel Silva           ³ Data ³21/09/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³GCFAT511                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportDef(aItensExcel)

	Local oReport 	:= Nil
	Local oSection1	:= Nil
	Local 	cTitulo 	:= 'Produtos sem Amarrcao'
	Local 	cArqXML 	:= GetNextAlias()     //Pega o nome para o relatório a ser gerado.
	Local 	cCaminho	:= "C:\TEMP\"


	oReport := TReport():New('Produtos',"Relatório Produtos sem Amarração",/*cPerg*/,{|oReport| ReportPrint(oReport,aItensExcel)},"Imprime a relação de Produtos sem Amarração")

	oReport:SetDevice(4)
	oReport:SetEnvironment(2)
	oReport:lParamPage 		:= .F.
	oReport:lUserInfo			:= .F.
	oReport:lPreview			:= .T.
	oReport:lHeaderVisible 	:= .T.
	oReport:lEdit 			:= .F.
	oReport:lXlsHeader 		:= .F.
	oReport:lXlsTable 		:= .T.
	oReport:CFONTBODY 		:= "Arial"
	oReport:lBold				:= .F.
	oReport:nFontBody			:= 9
	oReport:lEmptyLineExcel := .T.

	//Se não existir a pasta, criar a pasta de destino do Excel.
	MAKEDIR(cCaminho)
	oReport:cDir 		:=	cCaminho//xlsx
	oReport:CREPORT 	:= 	cCaminho+cCliente + "-" +cArqXML +".xml"
	oReport:CFILE 	:= 	cCaminho+cCliente + "-" +cArqXML +".xml"

	oReport:SetPortrait()
	oReport:SetTotalInLine(.F.)
	oReport:DisableOrientation()

	oSection1:= TRSection():New(oReport, "Produtos", {"SB1"})

	oSection1:SetTotalInLine(.F.)
	oSection1:SetEdit(.T.)
	oSection1:SetEditCell(.T.)
	oSection1:lHeaderVisible = .F.
	oSection1:SetBorder('')
	oSection1:SetBorder("ALL",,,.T.)

	TRCell():New(oSection1,"PRODUTO"		,"SB1","Produto"  	,PesqPict('SB1',"B1_COD"		),TamSX3("B1_COD"		)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )
	TRCell():New(oSection1,"DESCRICAO"  	,"SB1","Descricao"	,PesqPict('SB1',"B1_DESC"	),TamSX3("B1_DESC"	)[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/	,/*lLineBreak*/	, /*cHeaderAlign*/	,/*lCellBreak*/	,/*nColSpace*/	,.T. /*lAutoSize*/	,/*nClrBack*/	,/*nClrFore*/,.F. /*lBold*/ )

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PrintReport ³ Autor ³Josuel Silva         ³ Data ³21/09/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GCFAT511                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport,aItensExcel)
Local oSection1 := oReport:Section(1)


	oSection1:Init()
	oSection1:SetHeaderSection(.T.)

	For nZ := 1 To Len(aItensExcel)
		oSection1:Cell("PRODUTO"		):SetValue(aItensExcel[nZ,1]	)
		oSection1:Cell("DESCRICAO"	):SetValue(aItensExcel[nZ,2]	)
		oSection1:PrintLine()
	Next nZ

oSection1:Finish()

Return
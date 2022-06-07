<cfprocessingdirective suppresswhitespace="Yes">
<!--- 
<cf_papers paper_type="order">
Description : Papers custom tag -- Otomatik olarak oluşturulan belge numarasini geri dondurur ve kontrolünü yapar.
Return Variables : 
		paper_code -- string partion//Bunu buraya yazan güzel kardeşim.Açıklama yazıyorsun madem ne diye TURKCE yazmıyorsun!!!!!
		paper_number -- number partion
		paper_full -- total code
		paper_type2 : offer ve order için eklendi EK20031103
		paper_code_type : ship,revenue_receipt ve invoice icin eklendi. bu islemler icin tanımlanan belge nosunun calısana mı yoksa yazıcıya gore mi olusturuldugunu gosterir OZDEN20070717
	Created XXX
	Modify EK20031103-20040117-20070717
	Modify BK20071226 attributes.paper_type degerinin offer,order olarak gelmesine kontrol eklenmedi. Hepsi querylerde mevcut o yuzden gerek duyulmadi.
--->
<cfif isDefined("session.pp.userid")>
	<cfset user_id = session.pp.userid>
<cfelseif isDefined("session.pda.userid")>
	<cfset user_id = session.pda.userid>
</cfif>
<cftry>
	<cfswitch expression="#attributes.paper_type#">
		<cfcase value="offer,order">
			<cfif not isDefined("attributes.paper_type2")>
            	<cf_get_lang_main no="2024.Eksik">
<!---				<cfoutput>Eksik Parametre paper_type2!</cfoutput>--->
				<cfabort>
			</cfif>
			<cfquery name="GET_GEN_PAPER" datasource="#CALLER.DSN3#">
				SELECT 
					*
				FROM
					GENERAL_PAPERS 
				WHERE 
					ZONE_TYPE = <cfif isDefined("user_id") and Len(user_id)>0<cfelse>1</cfif> AND
					PAPER_TYPE = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.paper_type2#">
			</cfquery>
			<cfset paper_code = evaluate('get_gen_paper.#attributes.paper_type#_no')>
			<cfset paper_number = evaluate('get_gen_paper.#attributes.paper_type#_number')+1>
		</cfcase>
		<cfcase value="campaign,promotion,catalog,support,opportunity,service_app,prod_order,cat_prom,target_market,stock_fis,subscription,production_result,ship_fis,credit,credit_revenue,credit_payment,pro_material,internal_demand,cari_to_cari,debit_claim,cash_to_cash,cash_payment,virman,incoming_transfer,outgoing_transfer,purchase_doviz,sale_doviz,creditcard_revenue,creditcard_payment,expense_cost,income_cost,production_lot,budget_plan,expenditure_request,correspondence,quality_control,production_quality_control,creditcard_debit_payment,securefund,creditcard_cc_bank_action,buying_securities,securities_sale">
			<cfquery name="GET_GEN_PAPER" datasource="#CALLER.DSN3#">
				SELECT * FROM GENERAL_PAPERS WHERE PAPER_TYPE IS NULL
			</cfquery>
			<cfset paper_code = evaluate('get_gen_paper.#attributes.paper_type#_no')>
			<cfset paper_number = evaluate('get_gen_paper.#attributes.paper_type#_number') +1>
		</cfcase>
		<cfcase value="ship,revenue_receipt,invoice,e_invoice">
			<cfquery name="GET_PAPER" datasource="#caller.dsn3#">
				SELECT * FROM PAPERS_NO WHERE EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> ORDER BY PAPER_ID DESC 
			</cfquery>
			<cfif not (len(evaluate('get_paper.#attributes.paper_type#_NO')) and len(evaluate('get_paper.#attributes.paper_type#_number')))>
				<cfquery name="GET_PAPER" datasource="#CALLER.DSN3#">
					SELECT
						*
					FROM
						PAPERS_NO PN,
						#caller.dsn_alias#.SETUP_PRINTER_USERS SPU
					WHERE
						PN.PRINTER_ID = SPU.PRINTER_ID AND
						SPU.PRINTER_EMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
					ORDER BY
						PAPER_ID DESC 
				</cfquery>
				<cfset paper_printer_code = get_paper.printer_id>
			</cfif>
			<cfif len(evaluate('get_paper.#attributes.paper_type#_NO')) and len(evaluate('get_paper.#attributes.paper_type#_number'))>
				<cfset paper_code = evaluate('get_paper.#attributes.paper_type#_no')>
				<cfset paper_number = evaluate('get_paper.#attributes.paper_type#_number') +1>
			<cfelse>
				<cfset paper_code = ''>
				<cfset paper_number = ''>
			</cfif>
		</cfcase>
		<cfcase value="employee,emp_app,g_service_app,asset,fixtures,employee_healty,emp_notice,asset_failure">
			<cfquery name="GET_MAIN_PAPER" datasource="#CALLER.DSN#">
				SELECT * FROM GENERAL_PAPERS_MAIN WHERE EMPLOYEE_NUMBER IS NOT NULL
			</cfquery>
			<cfset paper_code = evaluate('get_main_paper.#attributes.paper_type#_no')>
			<cfset paper_number = evaluate('get_main_paper.#attributes.paper_type#_number') +1>
		</cfcase>		
		<cfdefaultcase>
			<font face="Verdana" color="ff0000" size="1"><cfoutput>#caller.getLang('main',2171)#</cfoutput>...</font><cfabort>
		</cfdefaultcase>
	</cfswitch>
	<cfset caller.paper_code = paper_code>
	<cfset caller.paper_number = paper_number>
	<cfset caller.paper_full = '#paper_code#-#paper_number#'>
	<cfif isdefined('paper_printer_code')>
		<cfset caller.paper_printer_code = paper_printer_code>
	</cfif>
	<cfcatch>
		<cfset caller.paper_code = ''>
		<cfset caller.paper_number = ''>
		<cfset caller.paper_full = ''>
	</cfcatch>
</cftry>
</cfprocessingdirective>

<!--- 
	Islem Kategorileri
	OZDEN20070711 islem kategorilerine action file ekleme
	SM20071018 islem kategorilerine display file ekleme
	SM20080514 process_type_info parametresi eklendi. fuseactiona baglı olmadan belli process_type ların işlem kategorilerini getirebilmek icin
	MER 20081231 onay ve uyarilar eklendi
	FBS 20120620 queryler cfcye cevrildi, sadece ep ve pda kullanimi icin kontrol eklenmis, diger sessionlarla ilgili kosullar kaldirildi
	FBS 20121108 Uyarilarin standart olarak gelmesi icin action_table,action_column eklendi ve query get_workcube_process.cfc den alinacak sekilde duzenlendi
	
	Kullanilan Parametreler;
	onclick_function			: (Display) Selectbox click icin
	slct_width					: (Display) Selectbox genişliği
	*process_cat				: (Action/Display) Update sayfalari icin
	action_file_name			: (Action) Include edilecek dosya adı
	is_template_action_file		: (Action) sisteme kayıtlı (process/files klasorundeki) template ise '1' , documents klasorune upload edilmis bir dosya ise '0'
	is_upd						: ? Guncelleme sayfalarında default islem tipinin seçili gelmemesi için 1 olarak gönderdik. Default değeri 0
	ct_process_type_#xx#		: (Display) hidden valuedan elemanin islem cat id sini ogrenmek icin (fire fisi cikis depo scriptde sorun yasandi) xx=process_cat_id
	process_cat_function_#xx#	: (Display) Display file kullanimlarinda kullanilacak fonksiyon ismi bu sekilde olmalidir, xx=process_cat_id
	action_db_type				: (Action) transaction içinde kullanılacaksa, transactionda kullanılan datasource name bu parametreye gonderilir.
	action_id					: (Action) islem kategorilerinin ilgili oldugu islemin_idsi, orn. fatura eklemede icin kaydedilen faturanın invoice_idsi
	action_table				: (Action) Ilgili sayfada, hangi tablonun oldugu bilgisi gonderilir, buna gore uyarilarda kullanilir
	action_column				: (Action) Ilgili sayfada, hangi tablonun, id kolonunun oldugu bilgisi gonderilir, buna gore uyarilarda kullanilir

	Ornek Kullanimlar;
	<cf_workcube_process_cat onclick_function="check_process_is_sale();" process_cat="#get_sale_det.process_cat#" slct_width="140">
	<cf_workcube_process_cat 
		process_cat="#form.process_cat#"
		is_action_file="1"
		action_file_name="#get_process_type.action_file_name#"
		action_db_type="#dsn2#"
		is_template_action_file="#get_process_type.action_file_from_template#"
		action_table="INVOICE"
		action_column="INVOICE_ID"
		action_id="#get_invoice_id.max_id#"
		action_page="#request.self#?fuseaction=#listgetat(attributes.fuseaction,1,'.')#.detail_invoice_sale&iid=#get_invoice_id.max_id#">
 --->

<cfif isDefined("session.pda")>
	<cfset my_userid = session.pda.userid>
	<cfset my_position_code = session.pda.position_code>
	<cfset my_our_company_id = session.pda.our_company_id>
	<cfset my_period_id = session.pda.period_id>
	<cfset lang = session.pda.language>
<cfelseif isDefined("session.ww.userid")>
	<cfset my_userid = session.ww.userid>
	<cfset my_position_code = ''>
	<cfset my_our_company_id = session.ww.our_company_id>
	<cfset my_period_id = session.ww.period_id>
	<cfset lang = session.ww.language>
<cfelse>
	<cfset my_userid = session.ep.userid>
	<cfset my_position_code = session.ep.position_code>
	<cfset my_our_company_id = session.ep.company_id>
	<cfset my_period_id = session.ep.period_id>
	<cfset lang = session.ep.language>
</cfif>

<cfparam name="attributes.slct_width" default="150">
<cfparam name="attributes.process_cat" default="">
<cfparam name="attributes.is_upd" default="0">
<cfparam name="attributes.process_type_info" default="">
<cfparam name="attributes.onclick_function" default="">
<cfparam name="attributes.is_action_file" default="">
<cfparam name="attributes.action_file_name" default="">
<cfparam name="attributes.is_template_action_file" default="">
<cfparam name="attributes.action_id" default="">
<cfparam name="attributes.action_db_type" default="#caller.dsn3#">
<cfparam name="attributes.kontrol_parameter" default="">
<cfparam name="attributes.form_name" default="">
<cfparam name="attributes.alert_message" default="">
<cfparam name="attributes.warning_description" default=""><!--- Bu Deger Gonderildiginde Uyarilarda Gorunur --->
<cfparam name="attributes.action_table" default="">
<cfparam name="attributes.action_column" default="">
<cfparam name="attributes.action_id" default="">
<cfparam name="attributes.action_page" default=""><!--- Bu değer gönderilirse Onay ve Uyarı Eklenecek Demektir! --->
<cfparam name="attributes.module_id" default="">
<cfparam name="attributes.is_default" default="1">

<cfif attributes.action_db_type eq caller.dsn><cfset process_db = ""><cfelse><cfset process_db = caller.dsn_alias&"."></cfif><!--- Transaction Icin dsn Tanimi --->
<cfif attributes.action_db_type eq caller.dsn3><cfset process_db3 = ""><cfelseif not isdefined("attributes.process_db3")><cfset process_db3 = caller.dsn3_alias&"."><cfelse><cfset process_db3 = attributes.process_db3&"."></cfif><!--- Transaction Icin dsn3 Tanimi --->

<cfset Cmp = createObject("component","CustomTags.cfc.get_workcube_process_cat") />
<cfset Cmp.process_db = process_db />
<cfset Cmp.process_db3 = process_db3 />
<cfset Cmp.action_db_type = attributes.action_db_type />

<cfif attributes.is_action_file eq 1 and Len(attributes.action_file_name)><!--- query sayfalarında çalışması için yapılırken sadece action_file varsa girilsin denilmiş o sebeble burda OR ifadesi ile bakıyoruz...Daha sonradan düzeltilmesi lazım..M.ER --->
	<!--- Action File Eklenmisse --->
	<cfif attributes.is_template_action_file eq 1>
		<cfinclude template="#caller.dir_seperator#v16#caller.dir_seperator#process#caller.dir_seperator#files#caller.dir_seperator##attributes.action_file_name#">
	<cfelse>
		<cfinclude template="#caller.file_web_path#settings#caller.dir_seperator##attributes.action_file_name#">
	</cfif>
<cfelseif not Len(attributes.action_page)>
	<!--- Display File Ise --->
	<cfsetting enablecfoutputonly="yes"><cfprocessingdirective suppresswhitespace="Yes">
	<cfif Len(attributes.module_id)>
		<!--- Ozel Raporlardan Islem Kategorileri Cagrilmak Istendiginde Module Report Olarak Gordugu Icin Eklendi FBS20121123 --->
		<cfset module_id = attributes.module_id>
	<cfelse>
		<cfscript>
		switch (caller.fusebox.circuit)
		{
			case "project" : module_id = 1; break;
			case "content" : module_id = 2; break;
			case "hr" : module_id = 3; break;
			case "member" : module_id = 4; break;
			case "product" : module_id = 5; break;
			case "agenda" : module_id = 6; break;
			case "settings" : module_id = 7; break;
			case "asset" : module_id = 8; break;
			case "training" : module_id = 9; break;
			case "forum" : module_id = 10; break;
			case "sales" : module_id = 11; break;
			case "purchase" : module_id = 12; break;
			case "stock" : module_id = '13,14,32,50'; break;// gercek module_id:13
			case "service" : module_id = '14,13'; break;
			case "campaign" : module_id = 15; break;
			case "finance" : module_id = '4,16,32,19'; break;
			case "contract" : module_id = 17; break;
			case "cash" : module_id = '18,32'; break;// gercek module_id:18
			case "bank" : module_id = '19,32'; break;// gercek module_id:19
			case "invoice" : module_id = '20,32'; break;// gercek module_id:20
			case "cheque" : module_id = '21,32'; break;// gercek module_id:21
			case "account" : module_id = 22; break;
			case "ch" : module_id = '23,32'; break;// gercek module_id:23
			case "fintab" : module_id = 24; break;
			case "defin" : module_id = 25; break;
			case "prod" : module_id = 26; break;
			case "call" : module_id = 27; break;
			case "webhaber" : module_id = 28; break;
			case "correspondence" : module_id = 29; break;
			case "process" : module_id = 30; break;
			case "invent" : module_id = 31; break;
			case "store" : module_id = '32,20,21,19,18,13,23,47,50,16,4'; break;// gercek module_id:32
			case "report" : module_id = '33,23,19'; break;// gercek module_id:33
			case "training_management" : module_id = 34; break;
			case "production" : module_id = '35,26'; break;
			case "executive" : module_id = 36; break;
			case "worknet" : module_id = 37; break;
			case "video_conf" : module_id = 38; break;
			case "webmail" : module_id = 39; break;
			case "assetcare" : module_id = 40; break;
			case "salesplan" : module_id = 41; break;
			case "dev" : module_id = 42; break;
			case "rule" : module_id = 43; break;
			case "addressbook" : module_id = 44; break;
			case "help" : module_id = 45; break;
			case "budget" : module_id = 46; break;
			case "objects" : module_id = '47,21,32,40'; break;// gercek module_id:47
			case "ehesap" : module_id = 48; break;
			case "cost" : module_id = '49,47'; break;
			case "pos" : module_id = 50; break;
			case "credit" : module_id = 51; break;
			case "crm" : module_id = 52; break;
			case "pda" : module_id = '13,35,26'; break;
		}
	</cfscript>
	</cfif>
	
	<cfset is_check_all_control = 0><!--- Hem fuseaction hem process_type kontrol edilmek istendiginden eklendi FBS 20141209 --->
	<cfif isDefined("attributes.fuseaction") and Len(attributes.fuseaction) and isDefined("attributes.process_type_info") and Len(attributes.process_type_info)><cfset is_check_all_control = 1></cfif>
	
	
    
	<cfset get_User_Process_Cat = Cmp.get_User_Process_Cat(
		position_code: my_position_code,
		module_id: module_id,
		process_type_info: IIf(isDefined("attributes.process_type_info") and Len(attributes.process_type_info),de(attributes.process_type_info),de('')),
		fuseaction: caller.attributes.fuseaction,
		is_check_all_control : is_check_all_control
		) />
	<cfif Len(attributes.process_cat)>
		 <cfset get_Old_Process_Cat = Cmp.get_Old_Process_Cat(
			process_cat	: attributes.process_cat
			) />
		<cfoutput>
		<cfif get_Old_Process_Cat.recordcount>
			<input type="hidden" name="old_process_type" id="old_process_type" value="#get_old_process_cat.process_type#">
            <input type="hidden" name="old_process_multi_type" id="old_process_multi_type" value="#get_old_process_cat.multi_type#">
			<input type="hidden" name="old_process_cat_id" id="old_process_cat_id" value="#get_old_process_cat.process_cat_id#">
		<cfelse>
			<cfset get_Check_Process_Cat_Id = Cmp.get_Check_Process_Cat_Id(
				process_cat	: attributes.process_cat,
				module_id: module_id
				) />
			<cfif not get_Check_Process_Cat_Id.recordcount>
				<!--- 791.İşlem Kategorisi Ayarlardan Kritik Olarak Değişmiş veya Silinmiş  --->
				<script type="text/javascript">
					//alertObject({message: "<cf_get_lang_main no='791.İşlem Kategorisi Ayarlardan Kritik Olarak Değişmiş veya Silinmiş'>!"});
					alert("<cf_get_lang_main no='791.İşlem Kategorisi Ayarlardan Kritik Olarak Değişmiş veya Silinmiş'>");
					history.back();
				</script>		
			<cfelse>
				<!--- 566.Bu İşlem Tipine Yetkiniz Yok ! --->
				<script type="text/javascript">
					//alertObject({message: "<cf_get_lang_main no='566.Bu İşlem Tipine Yetkiniz Yok'>!"});
					alert("<cf_get_lang_main no='566.Bu İşlem Tipine Yetkiniz Yok'>");
					history.back();
				</script>		
			</cfif>
			<cfabort>
		</cfif>
		</cfoutput>
	</cfif>
	</cfprocessingdirective><cfsetting enablecfoutputonly="no">
	<select name="process_cat" id="process_cat" style="width:<cfoutput>#attributes.slct_width#</cfoutput>px;"<cfif len(attributes.onclick_function)>onChange="<cfoutput>#attributes.onclick_function#</cfoutput>;"</cfif><cfif len(attributes.kontrol_parameter)>onClick="kontrol_line('<cfoutput>#attributes.kontrol_parameter#</cfoutput>','<cfoutput>#attributes.form_name#</cfoutput>','<cfoutput>#attributes.alert_message#</cfoutput>');"</cfif>>
		<option value=""><cfoutput><cf_get_lang_main no='388.İşlem Tipi'></cfoutput></option>
		<cfoutput query="get_user_process_cat">
			<option value="#process_cat_id#" <cfif attributes.process_cat eq process_cat_id>selected<cfelseif (not len(attributes.process_cat)) and attributes.is_upd eq 0 and IS_DEFAULT eq 1 and attributes.is_default neq 0>selected</cfif>>#process_cat#</option>
		</cfoutput>
	</select>
 	<cfoutput query="get_user_process_cat">
		<input type="hidden" name="ct_process_type_#process_cat_id#" id="ct_process_type_#process_cat_id#" value="#process_type#">
        <input type="hidden" name="ct_process_multi_type_#process_cat_id#" id="ct_process_multi_type_#process_cat_id#" value="#multi_type#">
		<cfif len(display_file_name)>
			<cfif display_file_from_template eq 1>
				<cfinclude template="#caller.dir_seperator#v16#caller.dir_seperator#process#caller.dir_seperator#files#caller.dir_seperator##display_file_name#">
			<cfelse>
				<cfinclude template="#caller.file_web_path#settings#caller.dir_seperator##display_file_name#">
			</cfif>
		</cfif>
	</cfoutput>
	<div align="left" id="process_cat_1" ></div>
	<!--- 565.Seçilen Üyenin Muhasebe Hesap Kod Bilgisi Eksik ! --->
	<script type="text/javascript">
	var process_cat_array = new Array();var process_cat_project_based_acc = new Array();process_cat_dept_based_acc = new Array();var process_cat_inventory_acc = new Array();var process_cat_lotno = new Array();var process_type_array = new Array();var process_file_array = new Array();var process_catid_array = new Array();var process_cat_stock_array = new Array();
	process_cat_array[0] = '';process_type_array[0] = '-1';/*slct box in seciniz ifadeleri icin default kondu*/
	<cfoutput query="get_user_process_cat">
		process_cat_array[#currentrow#] = '#is_account#';process_type_array[#currentrow#] = '#process_type#';
		process_catid_array[#currentrow#] = '#process_cat_id#';process_file_array[#currentrow#] = '#display_file_name#';
		process_cat_stock_array[#currentrow#] = '#is_zero_stock_control#';
		process_cat_project_based_acc[#currentrow#] = '#is_project_based_acc#';
		process_cat_dept_based_acc[#currentrow#] = '#is_dept_based_acc#';
		process_cat_inventory_acc[#currentrow#] = '#is_add_inventory#';
		process_cat_lotno[#currentrow#] = '#is_lot_no#';
	</cfoutput>
	function check_accounts(myForm)
	{
		temp_field1 = eval(myForm+'.process_cat');
		temp_field2 = eval(myForm+'.member_account_code');
		if ( (process_cat_array[temp_field1.selectedIndex] == 1) && ( (!temp_field2.value.length) || (temp_field2.value == '') || (temp_field2.value == ' ') ) ) /*muhasebeci kontrolü yapılmalı*/
		{
		alert("<cfoutput>#caller.getLang('main',565)#</cfoutput>");
		return false;
		}
		return true;
	}
	function check_display_files(myForm)
	{
		temp_field3 = eval(myForm+'.process_cat');
		if (process_file_array[temp_field3.selectedIndex] != '')
			return eval("process_cat_function_"+process_catid_array[temp_field3.selectedIndex])();
		else
			return true;
	}
	function kontrol_line(myInput,formname,message)
	{
		temp_field3 = eval(formname+'.'+myInput);
		if(temp_field3.value > 0)
		{
			alert(message);	
		}
	}
	function check_stock_action(myForm)
	{
		temp_field1 = eval(myForm+'.process_cat');
		if(process_cat_stock_array[temp_field1.selectedIndex] == 1)
			return true;
		else
			return false;
	}
	function check_inventory(myForm)
	{
		temp_field1 = eval(myForm+'.process_cat');
		if(process_cat_inventory_acc[temp_field1.selectedIndex] == 1)
			return true;
		else
			return false;
	}
	function check_lotno(myForm)
	{
		temp_field1 = eval(myForm+'.process_cat');
		if(process_cat_lotno[temp_field1.selectedIndex] == 1)
			return true;
		else
			return false;
	}
	</script>
</cfif>

<!--- Action_Page Varsa Uyari Gonderim Kontrolleri Calissin Seklinde Kullaniliyor --->
<cfif Len(attributes.action_page)>
	<cfset get_Process_Cat_Emp_Cau = Cmp.get_Process_Cat_Emp_Cau(
		process_cat	: attributes.process_cat
		) />
	<cfif get_Process_Cat_Emp_Cau.recordcount>
		<cfset get_Process_Cat_Name = Cmp.get_Process_Cat_Name(
			process_cat	: attributes.process_cat
			) />
		
		<!--- Onay ve Uyarilar workcube_process.cfm/get_workcube_process.cfc dosyalarindan kullaniliyor --->
		<cfset Cmp_Type = createObject("component","CustomTags.cfc.get_workcube_process") />
		<cfset Cmp_Type.data_source = attributes.action_db_type />
		<cfset Cmp_Type.process_db = caller.dsn_alias&"." />
		<cfset Cmp_Type.module_type = "e" />
		<cfset Cmp_Type.my_our_company_id_ = my_our_company_id />
		<cfset Cmp_Type.lang = lang />
		<cfoutput query="get_Process_Cat_Emp_Cau">
		  <cfset max_warning_date = now()>
			<cfset warning_description_ = get_Process_Cat_Name.Process_Cat>
			<cfif Len(attributes.warning_description)><cfset warning_description_ = warning_description_ & " - " & attributes.warning_description></cfif>

			<cfset add_Page_Warnings = Cmp_Type.add_Page_Warnings(
				action_page			: attributes.action_page,
				warning_head 		: get_Process_Cat_Name.Process_Cat,
				process_row_id 		: attributes.process_cat,
				warning_description	: warning_description_,
				warning_date 		: max_warning_date,
				record_date 		: now(),
				record_member 		: my_userid,
				position_code 		: get_Process_Cat_Emp_Cau.Position_Code,
				our_company_id 		: my_our_company_id,
				period_id 			: my_period_id,
				action_table 		: attributes.action_table,
				action_column 		: attributes.action_column,
				action_id 			: attributes.action_id,
				action_stage 		: attributes.process_cat,
				is_confirm			: ""
				) />
		</cfoutput>
	</cfif>
</cfif>
<!--- //Action_Page Varsa Uyari Gonderim Kontrolleri Calissin Seklinde Kullaniliyor --->
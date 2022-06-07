<!--- 
	Süreç Yönetimi - Tufan Çakiroglu - 12/10/2004
	FBS 20100706 iliskili sirket kontrolleri eklendi.
	FBS 20120607 query ve cfclerde duzenleme-iyilestirme yapildi.
	FBS 20120928 session duzenlemeleri yapildi, schedule kullanimlarinda session yerine tanimlanan ifadeler nedeniyle sayfada direkt session degeri kullanmayiniz
	
	Kullanilan Parametreler;
	data_source				: (Action) Sayfadan gonderilen data_source degeri sayesinde surecler transaction icerisinde kullanilabilir.
	action_page				: (Action) Surecten giden onay/uyarilardaki link bu parametre ile action sayfasindan gonderilir.
	action_id				: (Action) Surecten giden onay/uyarilardaki id bu parametre ile action sayfasindan gonderilir.
	action_column			: (Action) Surecten giden onay/uyarilardaki ilgili tablonun ID adi bu parametre ile action sayfasindan gonderilir.
	action_table			: (Action) Surecten giden onay/uyarilardaki ilgili TABLO adi bu parametre ile action sayfasindan gonderilir.
	new_comp_id				: (Action) Surecten giden onay/uyarilardaki company_id bu parametre ile action sayfasindan gonderilir.
	fusepath				: (Display) Surecin fuseactionu manuel gonderilmek istendiginde kullanilir
	onclick_function		: (Display) Sureclerin formlarda geldigi selectbox icin fonksiyon eklenmesini saglar.
	tabindex				: (Display) Sureclerin formlarda geldigi selectbox icin tabindex eklenmesini saglar.
	process_cat_width		: (Display) Sureclerin formlarda geldigi selectbox icin width eklenmesini saglar.
	select_value			: (Display) Belgenin guncelleme sayfasi olmasi durumunda bulundugu asamayi getirir.
	extra_process_row_id	: (Display) Cekilen icerik gelen belirli Id ler ile cekilir.(Project.addwork)
	* is_upd				: (Action/Display) Surecin action mu yoksa form sayfasından mi calistigini gösterir; 0 ise form 1, ise query anlamina gelir.
	* is_detail				: (Action/Display) Ekleme yada guncelleme sayfası oldugunu gösterir; 0 ekleme, 1 guncelleme anlamina gelir.
	* process_stage			: (Action) Belgede surecin bulundugu asamayi getirir.
	* old_process_line		: (Action) Belgede surecin bir onceki asamasinin LINE_NUMBER bilgisini getirir. (Ayni asamadaki filelarin calismamasi kontrollerinde kullanilir)
	* record_member			: (Action) Surecten giden onay/uyarilardaki kaydeden bu parametre ile action sayfasindan gonderilir.
	* record_date			: (Action) Surecten giden onay/uyarilardaki tarih bu parametre ile action sayfasindan gonderilir.
	* warning_description	: (Action) Surecten giden onay/uyarilardaki aciklama bu parametre ile action sayfasindan gonderilir.
	get_faction_recordcount	: (Action/Display) Surecteki toplam asama sayisini getirir, ilgili formdan cekilebilir. (get_faction_recordcount eq 1 vb)

	Ornek Kullanimlar;
	<cf_workcube_process is_upd='0' select_value='#get_order_detail.order_stage#' process_cat_width='125' is_detail='1'>
	<cf_workcube_process
		is_upd="1"
		data_source="#dsn#"
		old_process_line="#attributes.old_process_line#"
		process_stage="#attributes.process_stage#"
		record_member="#session.ep.userid#"
		record_date="#now()#"
		action_table="ORDERS"
		action_column="ORDER_ID"
		action_id="#attributes.order_id#"
		action_page="#request.self#?fuseaction=#listgetat(attributes.fuseaction,1,'.')#.detail_order&order_id=#attributes.order_id#"
		warning_description="Sipariş : #paper_full#">
--->
<cfif not isdefined("attributes.extra_process_row_id")><cfset attributes.extra_process_row_id = "-1"></cfif><!--- Is Sureclerinde Kullaniliyor --->
<cfif not isdefined("fuseaction")><cfset fuseaction = caller.attributes.pageinfo></cfif>
<cfparam name="attributes.data_source" default="#caller.dsn#">
<cfparam name="attributes.fusepath" default="#fuseaction#">
<cfparam name="attributes.extra_process_id" default="">
<cfparam name="attributes.action_table" default="">
<cfparam name="attributes.action_column" default="">
<cfparam name="attributes.action_id" default="">
<cfparam name="attributes.action_page" default="">
<cfparam name="attributes.onclick_function" default="">
<cfparam name="attributes.tabindex" default="">

<cfif attributes.data_source eq caller.dsn><cfset process_db = ""><cfelse><cfset process_db = caller.dsn_alias&"."></cfif><!--- Transaction Icin dsn Tanimi --->

<cfset session_position_code = "">
<cfset session_partner_id = "">
<!--- Session tanimlari --->
<cfif isdefined('session.ep')>
	<cfset module_type = "e">
	<cfset my_our_company_id_ = session.ep.company_id>
	<cfset lang = session.ep.language>
	<cfset session_position_code = session.ep.position_code>
	<cfset session_period_id = session.ep.period_id>
	<cfset my_our_company_name_ = session.ep.company>
	<cfset my_our_company_email_ = session.ep.company_email>
	<cfset session_time_zone = session.ep.time_zone>
<cfelseif isdefined('session.pda')>
	<cfset module_type = "e">
	<cfset my_our_company_id_ = session.pda.our_company_id>
	<cfset lang = session.pda.language>
	<cfset session_position_code = session.pda.position_code>
	<cfset session_period_id = session.pda.period_id>
	<cfset my_our_company_name_ = "">
	<cfset my_our_company_email_ = "">
	<cfset session_time_zone = session.pda.time_zone>
<cfelseif isdefined('session.pp')>
	<cfset module_type = "p">
	<cfset my_our_company_id_ = session.pp.our_company_id>
	<cfset lang = session.pp.language>
	<cfset session_partner_id = session.pp.userid>
	<cfset session_period_id = session.pp.period_id>
	<cfset my_our_company_name_ = session.pp.our_name>
	<cfset my_our_company_email_ = session.pp.our_company_email>
	<cfset session_time_zone = session.pp.time_zone>
<cfelseif isdefined('session.ww')>
	<cfset module_type = "w">
	<cfset my_our_company_id_ = session.ww.our_company_id>
	<cfset lang = session.ww.language>
    <cfif isdefined('session.ww.userid')>
		<cfset session_partner_id = session.ww.userid>
    <cfelse>
		<cfset session_partner_id = ''>    
	</cfif>
	<cfset session_period_id = session.ww.period_id>
    <cfif isdefined('session.ww.userid')>
		<cfset my_our_company_name_ = session.ww.our_name>
		<cfset my_our_company_email_ = session.ww.our_company_email>
    <cfelse>
		<cfset my_our_company_name_ = ''> 
		<cfset my_our_company_email_ = ''>  
	</cfif>
	<cfset session_time_zone = session.ww.time_zone>
<cfelseif isdefined('session.wp')>
	<cfset module_type = "w">
	<cfset my_our_company_id_ = session.wp.our_company_id>
	<cfset lang = session.wp.language>
	<cfset session_period_id = session.wp.period_id>
	<cfset my_our_company_name_ = session.wp.company>
	<cfset my_our_company_email_ = session.wp.our_company_email>
	<cfset session_time_zone = session.wp.time_zone>
<cfelse>
	<cfset module_type = "w">
	<cfset my_our_company_id_ = caller.my_our_company_id_>
	<cfset lang = caller.lang>
	<cfset session_position_code = caller.session_position_code>
	<cfset session_period_id = caller.period_id>
	<cfset my_our_company_name_ = caller.my_our_company_name_>
	<cfset my_our_company_email_ = caller.my_our_company_email_>
	<cfset session_time_zone = caller.session_time_zone>
</cfif>
<cfif isdefined('attributes.new_comp_id')><cfset my_our_company_id_ = attributes.new_comp_id></cfif><!--- Siparisler Sureclerinde kullanılıyor --->
<!--- //Session tanimlari --->

<cfset Cmp = createObject("component","CustomTags.cfc.get_workcube_process") />
<cfset Cmp.data_source = attributes.data_source />
<cfset Cmp.process_db = process_db />
<cfset Cmp.module_type = module_type />
<cfset Cmp.my_our_company_id_ = my_our_company_id_ />
<cfset Cmp.lang = lang />
<cfif not (isDefined("attributes.select_value") and Len(attributes.select_value))><cfset attributes.select_value = 0></cfif>
<cfif attributes.is_upd eq 0>
	<!--- Surec Formdan Calisiyorsa --->
	
	<!--- (PROCESS_TYPE,PROCESS_TYPE_OUR_COMPANY) Sureclerin Aktiflik ve Sirket Yetkilerine Gore Gelip Gelmemesi Kontrol Edilir- Fuseactiona Bakilarak --->
	<cfset get_ProcessType = Cmp.get_ProcessType(
		our_company_id	: my_our_company_id_,
		fuseaction		: attributes.fusepath,
		extra_process_id : attributes.extra_process_id
		) />
	
	<cfset get_Faction = Cmp.get_Faction(
		extra_process_row_id: attributes.extra_process_row_id,
		fuseaction			: attributes.fusepath,
		position_code		: session_position_code,
		partner_id			: session_partner_id
		) />
<cfset caller.get_faction_recordcount = get_faction.recordcount>
	<cfif attributes.is_detail eq 0><cfset attributes.select_value = 0></cfif><!--- Ekleme ise deger 0 olur --->
	<!--- Asamada Display_File Burada Çalisacak - Include --->
	<cfset get_File_Name = Cmp.get_File_Name(
		select_value	: attributes.select_value
		) />
	<script type="text/javascript">
		function process_cat_dsp_function()
		{
			return true;
		}
	</script>
	<!--- Buradaki faction list parametresini, bir belgede birden fazla surec varsa sadece yetkili olduklarimiz gelsin diye ekledik, aksi taktirde butun surecler dokuluyor fbs 20140805 --->
	<cfset get_Main_Files = Cmp.get_ProcessType(
		our_company_id	: my_our_company_id_,
		fuseaction		: attributes.fusepath,
		select_value	: attributes.select_value,
		extra_process_id : attributes.extra_process_id,
		faction_list	: ValueList(get_Faction.process_row_id)
		) />
	<cfif get_Main_Files.is_main_action_file eq 1>
		<cfif len(get_main_files.main_action_file)>
			<cfinclude template="#caller.dir_seperator#v16#caller.dir_seperator#process#caller.dir_seperator#files#caller.dir_seperator##get_main_files.main_action_file#">
		</cfif>
	<cfelse>
		<cfif len(get_Main_Files.main_action_file)>
			<!--- use_script_on_process ifadesi parama eklendi, musterilerin kullanimlari farklilik gosterdigi icin tanima gore sekillenmesi saglandi FBS 20120420 --->
			<cfif (isDefined("caller.use_script_on_process") and caller.use_script_on_process eq 1) or not isDefined("caller.use_script_on_process")>
			<!----	<script type="text/javascript" src="<cfoutput>#request.self#?fuseaction=home.emptypopup_process_functions&get_procees_file=#caller.file_web_path#settings#caller.dir_seperator##get_main_files.main_action_file#</cfoutput>"></script> ------->
			<cfelse>
				<!---  Bu kisim gerekli olan musterilerde yukaridaki satirin yerine kullanilacak (script duzenlemeleri yapilmamis musteriler icin) --->
			<!----	<cfinclude template="#caller.file_web_path#settings#caller.dir_seperator##get_main_files.main_action_file#">---->
			</cfif>
		</cfif>
	</cfif>
	<!-------<cfif len(get_file_name.display_file_name)>
		<cfif get_file_name.is_display_file_name eq 1>
			<cfinclude template="#caller.dir_seperator#v16#caller.dir_seperator#process#caller.dir_seperator#files#caller.dir_seperator##get_file_name.display_file_name#">
		<cfelse>
			<cfinclude template="#caller.file_web_path#settings#caller.dir_seperator##get_file_name.display_file_name#">
		</cfif>
	</cfif>-------->
	<cfif attributes.is_detail eq 0>
		<!--- Ekleme sayfasi ise --->
		<cfif get_faction.recordcount>
        	<select class="form-control" name="process_stage" id="process_stage" <cfif isdefined("attributes.process_cat_width")>style="width:<cfoutput>#attributes.process_cat_width#</cfoutput>px;"</cfif> <cfif len(attributes.onclick_function)>onChange="<cfoutput>#attributes.onclick_function#</cfoutput>;"</cfif> <cfif len(attributes.tabindex)>tabindex="<cfoutput>#attributes.tabindex#</cfoutput>"</cfif>>
				<cfoutput query="get_faction">
					<option value="#process_row_id#" <cfif isdefined("attributes.select_value") and (process_row_id eq attributes.select_value)>selected</cfif>><cfif Len(stage_code)>#stage_code# - </cfif>#stage#</option>
				</cfoutput>
			</select>
		<cfelse>
			<select class="form-control" name="process_stage" id="process_stage" <cfif isdefined("attributes.process_cat_width")>style="width:<cfoutput>#attributes.process_cat_width#</cfoutput>px;"</cfif> <cfif len(attributes.tabindex)>tabindex="<cfoutput>#attributes.tabindex#</cfoutput>"</cfif>>
				<option value="">Yetkisiz</option><!--- 561.Yetkisiz --->
		   </select>
		   <script language="javascript">
				alert("Lütfen Süreçlerinizi Tanımlayınız ve/veya Tanımlanan Süreçler Üzerinde Yetkiniz Yok");
			</script>			
		</cfif>
		<cfset is_Main_Display_Include = get_faction.is_Display>
	<cfelse>
		<!--- Update sayfasi ise --->
		<cfif get_faction.recordcount>
			<cfset get_Line_Number = Cmp.get_Line_Number(
				select_value	: attributes.select_value
				) />
			<input type="hidden" name="old_process_line" id="old_process_line" value="<cfoutput>#get_line_number.line_number#</cfoutput>">
			<!--- get_line_number.is_stage_back degerine gore LINE_NUMBER where kosuluna girer yada girmez (Aşamalar Geriye Dönebilir olayi) --->
			<cfset get_Select_Line0 = Cmp.get_Select_Line0(
				extra_process_row_id: attributes.extra_process_row_id,
				fuseaction			: attributes.fusepath,
				position_code		: session_position_code,
				partner_id			: session_partner_id,
				select_value		: attributes.select_value
				) />
			
			<cfset get_Select_Line1 = Cmp.get_Select_Line1(
				select_value	: attributes.select_value
				) />

			<cfset get_Select_Line = Cmp.get_Select_Line() />
			<cfif get_Select_Line1.recordcount>
				<!--- get_select_line halini kaldirdim, cunku asamasi olmayan bir islem detayinda yetkili oldugum asamalardan biri geliyordu-yanlis-, sorun yaratirsa detayli bakilacak fbs20120918 --->
				<cfoutput query="get_select_line">
					<input type="hidden" name="line_stage_number#process_row_id#" id="line_stage_number#process_row_id#" value="#line_number#">
					<input type="hidden" name="is_continue#process_row_id#"  id="is_continue#process_row_id#"value="#get_select_line.is_continue#">
				</cfoutput>
				<select name="process_stage" id="process_stage" <cfif isdefined("attributes.process_cat_width")>style="width:<cfoutput>#attributes.process_cat_width#</cfoutput>px;"</cfif> <cfif isdefined("attributes.select_value")>onChange="process_cat_kontrol_first()"<cfelse><cfif len(attributes.onclick_function)>onChange="<cfoutput>#attributes.onclick_function#</cfoutput>;"</cfif></cfif> <cfif len(attributes.tabindex)>tabindex="<cfoutput>#attributes.tabindex#</cfoutput>"</cfif>>
					<!--- select_value ifadesinin degeri kontrol ediliyor. selectbox un secili gelmemesi adina  --->
					<cfif get_select_line.recordcount>
						<cfoutput query="get_select_line">
							<option value="#process_row_id#" <cfif isdefined("attributes.select_value") and (process_row_id eq attributes.select_value)>selected</cfif>><cfif Len(stage_code)>#stage_code# - </cfif>#stage#</option>
						</cfoutput>
					<cfelse>
						<option value=""><cfoutput>#caller.getLang('main',2018)#</cfoutput></option><!--- 2018.Aşamasız --->
						<cfoutput query="get_select_line">
							<option value="#process_row_id#" <cfif isdefined("attributes.select_value") and (process_row_id eq attributes.select_value)>selected</cfif>><cfif Len(stage_code)>#stage_code# - </cfif>#stage#</option>
						</cfoutput>
					</cfif>
				</select>
			<cfelse>
				<select class="form-control" name="process_stage" id="process_stage" <cfif isdefined("attributes.process_cat_width")>style="width:<cfoutput>#attributes.process_cat_width#</cfoutput>px;"</cfif> <cfif len(attributes.onclick_function)>onChange="<cfoutput>#attributes.onclick_function#</cfoutput>;"</cfif> <cfif len(attributes.tabindex)>tabindex="<cfoutput>#attributes.tabindex#</cfoutput>"</cfif>>
				<cfif get_Line_Number.recordcount>
					<cfoutput query="get_Line_Number">
						<option value="#process_row_id#"><cfif Len(stage_code)>#stage_code# - </cfif>#stage#</option>
					</cfoutput>
				<cfelse>
					<option value=""><cfoutput>#caller.getLang('main',2018)#</cfoutput></option><!--- 2018.Aşamasız --->
					<cfif get_select_line.recordcount>
						<cfoutput query="get_select_line">
							<option value="#process_row_id#" <cfif isdefined("attributes.select_value") and (process_row_id eq attributes.select_value)>selected</cfif>><cfif Len(stage_code)>#stage_code# - </cfif>#stage#</option>
						</cfoutput>
					<cfelseif get_faction.recordcount>
						<cfoutput query="get_faction">
							<option value="#process_row_id#" <cfif isdefined("attributes.select_value") and (process_row_id eq attributes.select_value)>selected</cfif>><cfif Len(stage_code)>#stage_code# - </cfif>#stage#</option>
						</cfoutput>
					</cfif>
				</cfif>
				</select>
			</cfif>
		<cfelse>
			<cfset get_Line_Number = Cmp.get_Line_Number(
				select_value	: attributes.select_value
				) />
			<input type="hidden" name="old_process_line" id="old_process_line"value="<cfoutput>#get_line_number.line_number#</cfoutput>">
			<input type="hidden" name="is_continue" id="is_continue" value="<cfoutput>#get_line_number.is_continue#</cfoutput>">
			<select class="form-control" name="process_stage" id="process_stage" <cfif isdefined("attributes.process_cat_width")>style="width:<cfoutput>#attributes.process_cat_width#</cfoutput>px;"</cfif> <cfif len(attributes.tabindex)>tabindex="<cfoutput>#attributes.tabindex#</cfoutput>"</cfif>>
				<option value=""><cfoutput>#caller.getLang('main',561)#</cfoutput></option>
			</select>
		</cfif>
		<cfset is_Main_Display_Include = get_Line_Number.is_Display>
	</cfif>

	<cfif not (isdefined("attributes.is_mobile") and attributes.is_mobile eq 1)><!---Mobil projede include ettigim için js kısmını kapatıyorum py 061212 --->
		<cfif isdefined("attributes.select_value")>
            <!--- 562.Onay Süreci Geriye Dogru Döndürülemez ! --->
            <script type="text/javascript">
                function process_cat_kontrol_first()
                {
                    if(eval('document.all.line_stage_number'+document.getElementById("process_stage").value) < <cfoutput>#attributes.select_value#</cfoutput>)
                    {
						alertObject({message: "562.Onay Süreci Geriye Dogru Döndürülemez!"});
                        document.getElementById("process_stage").value = <cfoutput>#attributes.select_value#</cfoutput>;
                    }
                    <cfif len(attributes.onclick_function)>
                        <cfoutput>#attributes.onclick_function#</cfoutput>;
                    </cfif>
                }
            </script>
        </cfif>
    
        <!--- 563.Süreci Bir Sonraki Asamaya Getirmediniz. Emin misiniz? Bir Sonraki Asama :  --->
        <!--- 564.Lütfen Süreçlerinizi Tanimlayiniz ve/veya Tanimlanan Süreçler Üzerinde Yetkiniz Yok ! --->
        <script type="text/javascript">		
			function process_cat_control()
			{
				//Guncelleme ise
				<cfif attributes.is_detail eq 1>
					if((document.all.process_stage.length > 1) && (document.all.process_stage.selectedIndex < document.all.process_stage.length) && (document.all.process_stage.value == <cfoutput>#attributes.select_value#</cfoutput>))				
					{
						value_is_continue = eval('document.all.is_continue'+document.all.process_stage.value);
						if(value_is_continue.value == 1)
						{
							if (confirm("<cfoutput>#caller.getLang('main',563)#</cfoutput>" + document.all.process_stage[document.all.process_stage.selectedIndex+1].text));
							return false;
						}
					}
				</cfif>
				if(document.getElementById("process_stage").value == "")
				{
					if(document.all.process_stage.length > 1){
						alertObject({message: "Lütfen Süreç-Aşama Seçiniz!"});
					}
					else{
						alertObject({message: "Lütfen Süreçlerinizi Tanimlayiniz ve/veya Tanimlanan Süreçler Üzerinde Yetkiniz Yok !"});
					}
					return false;
				}
				else
					return process_cat_dsp_function();
			}
        </script>
    </cfif>
	
<cfelseif attributes.is_upd eq 1>
	<!--- Surec Queryden Calisiyorsa --->
	<cfset get_Process_Type_1 = Cmp.get_Process_Type_1(
		process_stage	: attributes.process_stage
		) />
	<cfset attributes.record_date = createdatetime(year(attributes.record_date), month(attributes.record_date), day(attributes.record_date), hour(attributes.record_date), minute(attributes.record_date), second(attributes.record_date))>
	
	<!--- Asama Action File Calistiriliyor - Surec Degismis ise Calisir --->
	<cfif get_Process_Type_1.Line_Number neq attributes.Old_Process_Line>
		<cfif len(get_Process_Type_1.file_name)>
			<cfif get_Process_Type_1.is_file_name eq 1>
				<cfinclude template="#caller.dir_seperator#v16#caller.dir_seperator#process#caller.dir_seperator#files#caller.dir_seperator##get_process_type_1.file_name#">
			<cfelse>
				<cfinclude template="#caller.dir_seperator#documents#caller.dir_seperator#settings#caller.dir_seperator##get_process_type_1.file_name#">
			</cfif>
		</cfif>
	</cfif>
	<!--- //Asama Action File Calistiriliyor - Surec Degismis ise Calisir --->
	
	<!--- Main Action File Çalistiriliyor - Main Action File Include Et Secili ise Calisir --->
	<cfset get_Main_File = Cmp.get_Main_File(
		process_stage	: attributes.process_stage
		) />
	<cfif get_Main_File.is_main_file eq 1>
		<cfif len(get_Main_File.main_file) and (get_Main_File.is_action eq 1)>
			<cfinclude template="#caller.dir_seperator#v16#caller.dir_seperator#process#caller.dir_seperator#files#caller.dir_seperator##get_main_file.main_file#">
		</cfif>
	<cfelse>
		<cfif len(get_Main_File.main_file) and (get_Main_File.is_action eq 1)>
			<cfinclude template="#caller.file_web_path#settings#caller.dir_seperator##get_main_file.main_file#">
		</cfif>
	</cfif>
	<!--- //Main Action File Çalistiriliyor - Main Action File Include Et Secili ise Calisir --->

	<cfif get_Process_Type_1.Line_Number neq attributes.Old_Process_Line>
		<!--- Surec Degismis ise Uyari, Mail, Online Mesaj, Sms vb Gonderilebilir --->
		
		<!--- Action_Table,Action_Id Varsa ve Belge Baska Bir Asamada Guncellenmisse Eski Uyarilar Pasife Aliniyor --->
		<cfif Len(attributes.action_table) and Len(attributes.action_id)>
			<cfset upd_Page_Warnings = Cmp.upd_Page_Warnings(
				our_company_id 		: my_our_company_id_,
				period_id 			: session_period_id,
				action_table 		: attributes.action_table,
				action_column 		: attributes.action_column,
				action_id 			: attributes.action_id
				) />
		</cfif>

		<cfset get_Employee_WorkGroup = Cmp.get_Employee_WorkGroup(
			process_stage	: attributes.process_stage,
			position_code 	: session_position_code,
			partner_id 		: session_partner_id
			) />
		<cfif get_employee_workgroup.recordcount>
			<cfset value_workgroup_id = ValueList(GET_EMPLOYEE_WORKGROUP.WORKGROUP_ID,',')>
			<cfset value_mainworkgroup_id = ValueList(GET_EMPLOYEE_WORKGROUP.MAINWORKGROUP_ID,',')>
		<cfelse>
			<cfset value_workgroup_id = 0>
			<cfset value_mainworkgroup_id = 0>
		</cfif>
		<cfset get_Inf_Position_Type = Cmp.get_Inf_Position_Type(
			process_stage			: attributes.process_stage,
			value_workgroup_id 		: value_workgroup_id,
			value_mainworkgroup_id 	: value_mainworkgroup_id,
			is_consumer 			: get_process_type_1.is_consumer
			) />
		<cfset get_Cau_Position_Type = Cmp.get_Cau_Position_Type(
			process_stage			: attributes.process_stage,
			value_workgroup_id 		: value_workgroup_id,
			value_mainworkgroup_id 	: value_mainworkgroup_id,
			is_consumer 			: get_process_type_1.is_consumer
			) />
		<cfset get_General_Positions = Cmp.get_General_Positions() />
		<cfif caller.fusebox.process_tree_control eq 1><!--- eger agacli yapi var ise buna bagli olarak kisi izinde iken onun onaylari yedegine duser --->
			<cfset get_General_Positions_All = Cmp.get_General_Positions() />
			
			<cfset GET_GENERAL_POSITIONS = QueryNew("PRO_POSITION_ID,EMPLOYEE_NAME,EMPLOYEE_SURNAME,EMPLOYEE_EMAIL,EMPLOYEE_ID,MOBILCODE,MOBILTEL,POSITION_CODE,TYPE","Integer,VarChar,VarChar,VarChar,Integer,VarChar,VarChar,Integer,Integer")>				
			<cfset ROW_OF_QUERY = 0>
			<cfoutput query="GET_GENERAL_POSITIONS_ALL">
				<cfset get_Real_Izin = Cmp.get_Real_Izin(
					employee_id	: get_General_Positions_All.Employee_Id,
					record_date	: now()
					) />
				<cfif get_real_izin.recordcount>
					<cfset get_StandBys = Cmp.get_StandBys(
						position_code	: get_General_Positions_All.Position_Code
						) />
					
					<cfset gercek_yaz = 0>
					<cfset yedek_1_yaz = 0>
					<cfset yedek_2_yaz = 0>
					<cfset yedek_3_yaz = 0>
					
					<cfif get_standbys.recordcount>
						<cfif len(get_standbys.candidate_pos_1)>
							<cfset get_yedek_1 = Cmp.get_Yedek(
								position_code	: get_standbys.candidate_pos_1
								) />
							<cfset get_real_izin_1 = Cmp.get_Real_Izin(
								position_code	: get_standbys.candidate_pos_1,
								record_date		: now()
								) />
							<cfif not get_real_izin_1.recordcount><cfset yedek_1_yaz = 1></cfif>
						</cfif>
						<cfif yedek_1_yaz eq 0 and len(get_standbys.candidate_pos_2)>
							<cfset get_yedek_2 = Cmp.get_Yedek(
								position_code	: get_standbys.candidate_pos_2
								) />
							<cfset get_real_izin_2 = Cmp.get_Real_Izin(
								position_code	: get_standbys.candidate_pos_2,
								record_date		: now()
								) />
							<cfif not get_real_izin_2.recordcount><cfset yedek_2_yaz = 1></cfif>
						</cfif>
						<cfif yedek_1_yaz eq 0 and yedek_2_yaz eq 0 and len(get_standbys.candidate_pos_3)>
							<cfset get_yedek_3 = Cmp.get_Yedek(
								position_code	: get_standbys.candidate_pos_3
								) />
							<cfset get_real_izin_3 = Cmp.get_Real_Izin(
								position_code	: get_standbys.candidate_pos_3,
								record_date		: now()
								) />
							<cfif not get_real_izin_3.recordcount><cfset yedek_3_yaz = 1></cfif>
						</cfif>
					<cfelse>
						<cfset gercek_yaz = 1>
					</cfif>
				<cfelse>
					<cfset gercek_yaz = 1>
				</cfif>
				
				<cfif gercek_yaz eq 0 and yedek_1_yaz eq 0 and yedek_2_yaz eq 0 and yedek_3_yaz eq 0><cfset gercek_yaz = 1></cfif>
				
				<cfif gercek_yaz eq 1>
					<cfscript>
						YAZILACAK_PRO_POSITION_ID = PRO_POSITION_ID;
						YAZILACAK_EMPLOYEE_NAME = EMPLOYEE_NAME;
						YAZILACAK_EMPLOYEE_SURNAME = EMPLOYEE_SURNAME;
						YAZILACAK_EMPLOYEE_EMAIL = EMPLOYEE_EMAIL;
						YAZILACAK_EMPLOYEE_ID = EMPLOYEE_ID;
						YAZILACAK_MOBILCODE = MOBILCODE;
						YAZILACAK_MOBILTEL = MOBILTEL;
						YAZILACAK_POSITION_CODE = POSITION_CODE;
					</cfscript>
				<cfelseif yedek_1_yaz eq 1>
					<cfscript>
						YAZILACAK_PRO_POSITION_ID = get_yedek_1.PRO_POSITION_ID;
						YAZILACAK_EMPLOYEE_NAME = get_yedek_1.EMPLOYEE_NAME;
						YAZILACAK_EMPLOYEE_SURNAME = get_yedek_1.EMPLOYEE_SURNAME;
						YAZILACAK_EMPLOYEE_EMAIL = get_yedek_1.EMPLOYEE_EMAIL;
						YAZILACAK_EMPLOYEE_ID = get_yedek_1.EMPLOYEE_ID;
						YAZILACAK_MOBILCODE = get_yedek_1.MOBILCODE;
						YAZILACAK_MOBILTEL = get_yedek_1.MOBILTEL;
						YAZILACAK_POSITION_CODE = get_yedek_1.POSITION_CODE;
					</cfscript>
				<cfelseif yedek_2_yaz eq 1>
					<cfscript>
						YAZILACAK_PRO_POSITION_ID = get_yedek_2.PRO_POSITION_ID;
						YAZILACAK_EMPLOYEE_NAME = get_yedek_2.EMPLOYEE_NAME;
						YAZILACAK_EMPLOYEE_SURNAME = get_yedek_2.EMPLOYEE_SURNAME;
						YAZILACAK_EMPLOYEE_EMAIL = get_yedek_2.EMPLOYEE_EMAIL;
						YAZILACAK_EMPLOYEE_ID = get_yedek_2.EMPLOYEE_ID;
						YAZILACAK_MOBILCODE = get_yedek_2.MOBILCODE;
						YAZILACAK_MOBILTEL = get_yedek_2.MOBILTEL;
						YAZILACAK_POSITION_CODE = get_yedek_2.POSITION_CODE;
					</cfscript>
				<cfelseif yedek_3_yaz eq 1>
					<cfscript>
						YAZILACAK_PRO_POSITION_ID = get_yedek_3.PRO_POSITION_ID;
						YAZILACAK_EMPLOYEE_NAME = get_yedek_3.EMPLOYEE_NAME;
						YAZILACAK_EMPLOYEE_SURNAME = get_yedek_3.EMPLOYEE_SURNAME;
						YAZILACAK_EMPLOYEE_EMAIL = get_yedek_3.EMPLOYEE_EMAIL;
						YAZILACAK_EMPLOYEE_ID = get_yedek_3.EMPLOYEE_ID;
						YAZILACAK_MOBILCODE = get_yedek_3.MOBILCODE;
						YAZILACAK_MOBILTEL = get_yedek_3.MOBILTEL;
						YAZILACAK_POSITION_CODE = get_yedek_3.POSITION_CODE;
					</cfscript>
				<cfelse>
					<cfscript>
						YAZILACAK_PRO_POSITION_ID = PRO_POSITION_ID;
						YAZILACAK_EMPLOYEE_NAME = EMPLOYEE_NAME;
						YAZILACAK_EMPLOYEE_SURNAME = EMPLOYEE_SURNAME;
						YAZILACAK_EMPLOYEE_EMAIL = EMPLOYEE_EMAIL;
						YAZILACAK_EMPLOYEE_ID = EMPLOYEE_ID;
						YAZILACAK_MOBILCODE = MOBILCODE;
						YAZILACAK_MOBILTEL = MOBILTEL;
						YAZILACAK_POSITION_CODE = POSITION_CODE;
					</cfscript>
				</cfif>	
				
				<cfscript>
					ROW_OF_QUERY = ROW_OF_QUERY + 1;
					QueryAddRow(GET_GENERAL_POSITIONS,1);
					QuerySetCell(GET_GENERAL_POSITIONS,"PRO_POSITION_ID",YAZILACAK_PRO_POSITION_ID,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"EMPLOYEE_NAME",YAZILACAK_EMPLOYEE_NAME,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"EMPLOYEE_SURNAME",YAZILACAK_EMPLOYEE_SURNAME,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"EMPLOYEE_EMAIL",YAZILACAK_EMPLOYEE_EMAIL,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"EMPLOYEE_ID",YAZILACAK_EMPLOYEE_ID,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"MOBILCODE",YAZILACAK_MOBILCODE,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"MOBILTEL",YAZILACAK_MOBILTEL,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"POSITION_CODE",YAZILACAK_POSITION_CODE,ROW_OF_QUERY);
					QuerySetCell(GET_GENERAL_POSITIONS,"TYPE",GET_GENERAL_POSITIONS_ALL.TYPE,ROW_OF_QUERY);
				</cfscript>
			</cfoutput>
		</cfif>

		<cfif Len(attributes.action_page)><!--- Bu kontrol silme sayfalarindan calistiginda uyari/sms mail vb gitmemesi icin eklendi, defaultta durum degismeyecek FBS 20120302 --->
			<cfif get_general_positions.recordcount>
				<cfoutput query="get_general_positions">
					<cfif get_Process_Type_1.is_email eq 1>
						<!--- Email --->
						<cfif len(get_general_positions.employee_email)>
							<cfif Len(my_our_company_email_)>
								<cfset attributes.mail_content_from ='#my_our_company_name_#<#my_our_company_email_#>'>
								<cfset attributes.start_date=DateFormat(dateadd('h',session_time_zone,now()), 'DD/MM/YYYY') & " " & TimeFormat(dateadd('h',session_time_zone,now()), 'HH:MM')>
							</cfif>
							<cfset attributes.mail_content_to = '#get_general_positions.employee_email#'>
							<cfif get_general_positions.type eq 0>
								<cfset attributes.mail_content_subject = 'Onay Süreci - #get_Process_Type_1.process_name#'>
							<cfelse>
								<cfset attributes.mail_content_subject = 'Bilgi Süreci - #get_Process_Type_1.process_name#'>
							</cfif>
							
							<cfset attributes.mail_content_additor = '#employee_name# #employee_surname#'>
							<cfset attributes.mail_content_info2='#attributes.warning_description#'>
							<cfif attributes.old_process_line eq 0>
								<cfset attributes.mail_record_emp = attributes.record_member>
								<cfset attributes.mail_record_date = DateFormat(dateadd('h',session_time_zone,attributes.record_date), 'DD/MM/YYYY') & " " & TimeFormat(dateadd('h',session_time_zone,attributes.record_date), 'HH:MM')> 
							<cfelse>
								<cfset attributes.mail_update_emp = attributes.record_member>
								<cfset attributes.mail_update_date = DateFormat(dateadd('h',session_time_zone,attributes.record_date), 'DD/MM/YYYY') & " " & TimeFormat(dateadd('h',session_time_zone,attributes.record_date), 'HH:MM')> 
							</cfif>
							<cfif isdefined("caller.attributes.project_id") and len(caller.attributes.project_id) and isdefined("caller.attributes.project_head") and len(caller.attributes.project_head)>
								<cfset attributes.project_id = caller.attributes.project_id>
								<cfset attributes.project_head = caller.attributes.project_head>
							</cfif>
							<cfsavecontent variable="attributes.mail_content_info">Süreç Takip Kaydı</cfsavecontent>
							<cfif cgi.server_port eq 443>
								<cfset user_domain = "https://#cgi.server_name#">
							<cfelse>
								<cfset user_domain = "http://#cgi.server_name#">
							</cfif>
							<cfset attributes.mail_content_link = '#user_domain#/#attributes.action_page#'><!--- 'http://#user_domain#/#attributes.action_page#' --->
							<cfset attributes.process_stage_info = attributes.process_stage>
							<cfinclude template="../design/template/info_mail/mail_content.cfm">
						</cfif>
					</cfif>
					<cfif get_Process_Type_1.is_online eq 1>
						<!--- Online Mesaj --->
						<cfset add_Wrk_Message = Cmp.add_Wrk_Message(
							employee_id		: get_general_positions.employee_id,
							record_member 	: attributes.record_member,
							record_date 	: attributes.record_date,
							message 		: "#get_Process_Type_1.process_name# - #get_Process_Type_1.stage# - #attributes.warning_description#"
							) />
					</cfif>
					<cfif get_Process_Type_1.is_sms eq 1>
						<!--- SMS --->
						<cfif len(MobilCode) eq 3 and len(MobilTel) eq 7>
							<cfset attributes.mobil_phone = "#MobilCode##MobilTel#">
							<cfset attributes.sms_body = Left("#get_Process_Type_1.process_name# - #get_Process_Type_1.stage# - #attributes.warning_description#",462)>
							<cfset attributes.member_type = "employee">
							<cfset attributes.member_id = Employee_Id>
							<cfset attributes.paper_id = attributes.action_id>
							<cfset attributes.sms_template_id = -1>
							<cfset callcenter_include = 1>
							<cfinclude template="/v16/objects/query/add_send_sms.cfm">
						</cfif>
					</cfif>
				</cfoutput>
			</cfif>
			<!--- BURADA SORUN OLABILIR, AGACLI YAPIDA CALISAN IZINDEYKEN MAIL VE ONLINE MESAJ GONDERIMI YEDEGE YAPILIYOR ANCAK ONAY (PAGE_WARNINGS) YINE IZINDEKI CALISANA YAPILIYOR INCELENECEK, FBS 20120619 --->
			<cfif get_Process_Type_1.is_warning eq 1>
				<cfif get_cau_position_type.recordcount>
					<cfoutput query="get_cau_position_type">
						<cfset max_warning_date = attributes.record_date>
						<cfif len(get_Process_Type_1.answer_hour)>
							<cfset max_warning_date = dateadd("h", get_Process_Type_1.answer_hour,max_warning_date)>
						</cfif>
						<cfif len(get_Process_Type_1.answer_minute)>
							<cfset max_warning_date = dateadd("n", get_Process_Type_1.answer_minute,max_warning_date)>
						</cfif>
						<cfset warning_description_ = attributes.warning_description>
						<cfif Len(get_Process_Type_1.detail)><cfset warning_description_ = warning_description_ & " - " & get_Process_Type_1.detail></cfif>
	
						<cfset add_Page_Warnings = Cmp.add_Page_Warnings(
							action_page			: attributes.action_page,
							warning_head 		: "#get_Process_Type_1.process_name# - #get_Process_Type_1.stage#",
							process_row_id 		: get_Process_Type_1.process_row_id,
							warning_description	: warning_description_,
							warning_date 		: max_warning_date,
							record_date 		: attributes.record_date,
							record_member 		: attributes.record_member,
							position_code 		: get_cau_position_type.position_code,
							our_company_id 		: my_our_company_id_,
							period_id 			: session_period_id,
							action_table 		: attributes.action_table,
							action_column 		: attributes.action_column,
							action_id 			: attributes.action_id,
							action_stage 		: attributes.process_stage,
							is_confirm 			: IIf(Len(get_Process_Type_1.confirm_request),1,De(""))
							) />
					</cfoutput>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>


<!--- 
	SM 20080725 Kullanılan sayfada kullanıcının yetkili olduğu aşamaların idlerini liste olarak döndürür.
	process_rowid_list : Oluşturduğu liste
	Kullanımı:
		<cf_workcube_process_info> Herhangi bir parametre almaz , sadece listeyi oluşturur.
		FBS 20110912	fusepath parametresi eklendi, sayfada baska bir sayfanin surecini cagirmak icin fuseaction gonderilebilir.
		FBS 20110912	workcube_process uzerindeki querylerden guncelleme yapildi, eklenen sirket, aktif vb kontrolleri burada yoktu, eklendi.
		FBS 20120619	workcube_process uzerindeki tablolarla ortak kullanilmak uzere cfc den alindi, boylece ayni kosullar gerceklesecek.
 --->
<cfif not isdefined("attributes.extra_process_row_id")><cfset attributes.extra_process_row_id = "-1"></cfif><!--- Is Sureclerinde Kullaniliyor --->
<cfif not isdefined("attributes.fuseaction")><cfset attributes.fuseaction = caller.attributes.fuseaction></cfif>
<cfparam name="attributes.fusepath" default="#attributes.fuseaction#">
<cfparam name="attributes.data_source" default="#caller.dsn#">
<cfif attributes.data_source eq caller.dsn><cfset process_db = ""><cfelse><cfset process_db = caller.dsn_alias&"."></cfif><!--- Transaction Icin dsn Tanimi --->

<cfset session_position_code = "">
<cfset session_partner_id = "">
<!--- Session tanimlari --->
<cfif isdefined('session.ep')>
	<cfset module_type = "e">
	<cfset my_our_company_id_ = session.ep.company_id>
	<cfset lang = session.ep.language>
	<cfset session_position_code = session.ep.position_code>
<cfelseif isdefined('session.pda')>
	<cfset module_type = "e">
	<cfset my_our_company_id_ = session.pda.company_id>
	<cfset lang = session.pda.language>
	<cfset session_position_code = session.pda.position_code>
<cfelseif isdefined('session.pp')>
	<cfset module_type = "p">
	<cfset my_our_company_id_ = session.pp.our_company_id>
	<cfset lang = session.pp.language>
	<cfset session_partner_id = session.pp.userid>
<cfelseif isdefined('session.ww.userid')>
	<cfset module_type = "w">
	<cfset my_our_company_id_ = session.ww.our_company_id>
	<cfset lang = session.ww.language>
	<cfset session_partner_id = session.ww.userid>
<cfelseif isdefined('session.wp')>
	<cfset module_type = "w">
	<cfset my_our_company_id_ = session.wp.our_company_id>
	<cfset lang = session.wp.language>
<cfelse>
	<cfset module_type = "">
	<cfset my_our_company_id_ = caller.default_company_id_>
	<cfset lang = "">
</cfif>
<cfif isdefined('attributes.new_comp_id')><cfset my_our_company_id_ = attributes.new_comp_id></cfif><!--- Siparisler Sureclerinde kullanılıyor --->
<!--- //Session tanimlari --->

<cfset Cmp = createObject("component","CustomTags.cfc.get_workcube_process") />
<cfset Cmp.data_source = attributes.data_source />
<cfset Cmp.process_db = process_db />
<cfset Cmp.module_type = module_type />
<cfset Cmp.my_our_company_id_ = my_our_company_id_ />
<cfset Cmp.lang = lang />

<!--- (PROCESS_TYPE,PROCESS_TYPE_OUR_COMPANY) Sureclerin Aktiflik ve Sirket Yetkilerine Gore Gelip Gelmemesi Kontrol Edilir --->
<cfset get_ProcessType = Cmp.get_ProcessType(
		our_company_id	: my_our_company_id_,
		fuseaction		: attributes.fusepath
		) />

<cfset get_Faction = Cmp.get_Faction(
	extra_process_row_id: attributes.extra_process_row_id,
	fuseaction			: attributes.fusepath,
	position_code		: session_position_code,
	userid				: session_partner_id
	) />

<cfif get_Faction.recordcount>
	<cfset caller.Process_RowId_List = valuelist(get_Faction.Process_Row_Id)>
<cfelse>
	<cfset caller.Process_RowId_List = 0>
</cfif>

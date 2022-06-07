<!-----------------------------------------------------------------------

*************************************************************************
		Copyright Katalizör Bilgi Teknolojileri Hizmetleri A.Ş www.workcube.com
*************************************************************************

Application	: 	W O R K C U B E    C A T A L Y S T
Motto		:	e-business Now!
Version		:	Cloud Edition New Generation

Version Leader		:	Omer Turhan
Development Team	:	Fatih Ayık, M.Emin Yaşartürk, Cemil Durgan, Emrah Kumru, Semih Akartuna ve tüm yazılım ekibi

Description			:
		Workcube is an e-business platform for corporates.
*************************************************************************
------------------------------------------------------------------------->
<cfcomponent displayname="Application" output="true" hint="Uygulamayı yönetir.">	
	<cfscript>
		this.name = hash(getCurrentTemplatePath()) & 'WORKCUBE';
		this.siteName = 'b2b.bursateknikkimya.com.tr';
		this.sessionManagement = True;
		this.sessionTimeout = CreateTimeSpan(0,2,0,0);
		this.clientManagement = True;
		this.setClientCookies = True;
		this.secureJSON = "True";
		this.secureJSONPrefix = "//";
		this.customtagpaths = '';
      	this.customtagpaths = ListAppend(this.customtagpaths,getDirectoryFromPath(getCurrentTemplatePath()) & "customtags");
		this.customtagpaths = ListAppend(this.customtagpaths,getDirectoryFromPath(getCurrentTemplatePath()) & "Utility/customtag");
	</cfscript>
    <cfset Request.self="index.cfm">
    <!--- Sayfa request özellikleri --->
	<cfsetting requesttimeout="99999" showdebugoutput="false" enablecfoutputonly="false" />
    
	<!------------------------ on Application Start -------------------------
        Functions:params, objects, langs, functions, workcube_app
	------------------------------------------------------------------------>
	<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Uygulama başladığı anda çalıştırılacak kodlar. Tek defa çalıştırır.">
		<cfset application.systemParam = createObject("component", "cfc.settings")>
        <cfset structAppend(variables,application.systemParam.params())/>
        <cfset application.systemFunctions = createObject("component", "cfc.functions")>
  
		<cfreturn true />
	</cffunction>
    
	<!---
	*************************************************************************
		OnSessionStart
	*************************************************************************
		Description : ColdFusion'a ilk istek geldiği anda çalışır. CFID,CFTOKEN, SESSIONID gibi değerler burada otomatik oluşur. Kullanıcı giriş ekranından giriş yaptığı zaman oluşan session ile alakası yoktur.
	--->
	<cffunction name="OnSessionStart" access="public" returntype="void" output="false" hint="Kullanıcı oturumu başladığında çalıştırılacak kodlar.">
		<cfreturn/>
	</cffunction>

    <!---
	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Fires at first part of page processing.">
		<cfargument name="TargetPage" type="string" required="true" />
 
		<cfreturn true />
	</cffunction>
	--->
    
    <!---
		*************************************************************************
			onRequest
		*************************************************************************
			Description : En yoğun kullanılan kısımdır. Sayfa isteğinde bulunulduğunda bu kısım çalışır. OnRequestStart fonksiyonu ajax isteklerinde sorun yaratabildiği için geneli buraya toplanmıştır. Ana amacı genel kontroller yaptıktan sonra index.cfm'e yönlenmektir.
			Başlarında yer alan structAppend işleminin amacı application tarafında tutulan parametrik değerlerin, fonksiyonların sistem içersinde kullanılış şeklini değiştirmemektir. Yazılmadığı takdirde örneğin DSN atamalarının application.dsn şekline dönüştürülmesi gerekirdi.
			Index öncesi gelen kontroller sırasıyla şu şekildedir. 
			Session kontrolü (wmo\w3cfsession.cfm) : Kullanıcı sistemden düşmüştür. Başka bir browser'da oturum açmıştır. Bunlar kontrol ediliyor.
			cf_xml_pers_settings_reader : Kullanıcı XML'i okunur. Açık kapalı gelmesini istediği alanlar burada tutulur. 
			secure : Saldırı girişimleri burada yakalanır.
			control_time_cost : Haftalık zaman harcaması kontrolü
			sessionParams : Session'a özgü parametreler yüklenir. Örneğin dsn_2
			getDeniedPages : Yasaklı-Kısıtlı sayfa kontrolleri
	--->
	<cffunction name="onRequest" returnType="void">
		<cfargument name="targetPage" type="string" required="true" /><!--- Burası index.cfm gelir. Ulaşılmak istenen dosya index.cfm içerisindeki wrkTemplate'tir. --->
<!---
			<cfscript>
                OnApplicationStart();
            </cfscript>
--->
	<cfsetting showdebugoutput="no">
			<cfset application.systemParam = createObject("component", "cfc.settings")>
            <cfset structAppend(variables,application.systemParam.params())/>
            <cfset application.systemFunctions = createObject("component", "cfc.functions")>
       		<cfset structAppend(variables,application.systemFunctions)/>
            
			<cfscript>
                attributes=structNew();
                StructAppend(attributes, url, "no");
                StructAppend(attributes, form, "no");
            </cfscript>

            <cfinclude template="#ARGUMENTS.targetPage#" />

		<cfreturn />
	</cffunction>


    <!---
		*************************************************************************
			OnRequestEnd
		*************************************************************************
			Description : İstek bittiği anda çalışır. Ajax sayfalarda sorunlar yaratabiliyor. Log kayıtları için kullanılabilir. Fakat bu durumda da dataları buraya taşımak için network meşgul edilecektir. Bu yüzden log kayıtlarını isteğin sonunda tutuyoruz.
	--->
	<cffunction name="OnRequestEnd" access="public" returntype="void" output="true" hint="Request sonrası çalışır.">
 		<cfreturn />
	</cffunction>
    
    <!---
		*************************************************************************
			OnSessionEnd
		*************************************************************************
			Description : ColdFusion session'ı son bulduğunda kullanılabilir. Catalyst'te herhangi bir şekilde ihtiyaç duyulmuyor. Sistemden çıkışlarda kullanıcın sistem session'ı silinir. Buradaki session CF tarafında tutulan session'dır. Kullanıcı sistemde belirtilen süre boyunca işlem yapmadığında otomatik olarak sonlandırılır. 
	--->
    <cffunction name="OnSessionEnd" access="public" returntype="void" output="false" hint="Session kapanırken çalışır.">
		<cfargument name="SessionScope" type="struct" required="true" />
		<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#"	/>
		<cfreturn />
	</cffunction>

    <!---
		*************************************************************************
			OnApplicationEnd
		*************************************************************************
			Description : Application durduğunda çalışır. Kullanılmıyor. Burada da log atılabilir. Fakat manuel application sonlandırmada çalışmaz
	--->
	<cffunction name="OnApplicationEnd" access="public" returntype="void" output="false" hint="Uygulama sonlandığında çalışır.">
 		<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#" 	/>
		<cfreturn />
	</cffunction>

    <!---
		*************************************************************************
			OnError
		*************************************************************************
			Description : Hata durumlarında devreye girer. error.cfc ile bütünleşiktir. Error.cfc içinde tanımlı olan hatalarda dile bağlı olarak hata ekranları oluşturur. Development mod için detay içerir. Hatalarla Geliştirilecek. 
	--->
    <cffunction name="OnError" access="public" returntype="void" output="true" hint="Hataları raporlar.">
		<cfargument name="Exception" type="any" required="true" />
 		<cfargument name="EventName" type="string" required="false" default="" 	/>
        <cfdump var="#Exception#">
		<cfreturn/>
	</cffunction>    
    
</cfcomponent>

<!--- FBS 20120904 addressbook CustomTagi icin olusturulmustur --->
<cfcomponent>
		
	<!--- Ekleme --->
	<cffunction name="add_AddressBook" access="public" returntype="any">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="active" type="any" required="no" default="1">
		<cfargument name="type" type="numeric" required="no" default="0">
		<cfargument name="type_id" type="numeric" required="no" default="0">
		<cfargument name="name" type="string" required="yes" default="">
		<cfargument name="surname" type="string" required="yes" default="">
		<cfargument name="sector_id" type="numeric" required="no" default="0">
		<cfargument name="company_name" type="string" required="no" default="">
		<cfargument name="title" type="string" required="no" default="">
		<cfargument name="email" type="string" required="no" default="">
		<cfargument name="telcode" type="string" required="no" default="">
		<cfargument name="telno" type="string" required="no" default="">
		<cfargument name="telno2" type="string" required="no" default="">
		<cfargument name="faxno" type="string" required="no" default="">
		<cfargument name="mobilcode" type="string" required="no" default="">
		<cfargument name="mobilno" type="string" required="no" default="">
		<cfargument name="web" type="string" required="no" default="">
		<cfargument name="postcode" type="string" required="no" default="">
		<cfargument name="address" type="string" required="no" default="">
		<cfargument name="semt" type="string" required="no" default="">
		<cfargument name="county_id" type="numeric" required="no" default="0">
		<cfargument name="county_name" type="string" required="no" default="">
		<cfargument name="city_id" type="numeric" required="no" default="0">
		<cfargument name="city_name" type="string" required="no" default="">
		<cfargument name="country_id" type="numeric" required="no" default="0">
		<cfargument name="country_name" type="string" required="no" default="">
		<cfargument name="info" type="string" required="no" default="">
		<cfargument name="special_emp" type="numeric" required="no" default="0">
		
		<cfquery name="add_AddressBook" datasource="#this.data_source#">
			INSERT INTO 
				#process_db#ADDRESSBOOK
			(
				IS_ACTIVE,
				IS_SYS_MEMBER,
				<cfif arguments.type eq 1>
					EMPLOYEE_ID,
				<cfelseif arguments.type eq 2>
					PARTNER_ID,
				<cfelseif arguments.type eq 3>
					CONSUMER_ID,
				</cfif>
				AB_NAME,
				AB_SURNAME,
				AB_SECTOR_ID,
				AB_COMPANY,
				AB_TITLE,
				AB_EMAIL,
				AB_TELCODE,
				AB_TEL1,
				AB_TEL2,
				AB_FAX,
				AB_MOBILCODE,
				AB_MOBIL,
				AB_WEB,
				AB_POSTCODE,
				AB_ADDRESS,
				AB_SEMT,
				AB_COUNTY_ID,
				AB_COUNTY,
				AB_CITY_ID,
				AB_CITY,
				AB_COUNTRY_ID,
				AB_COUNTRY,
				AB_INFO,
				SPECIAL_EMP,
				RECORD_DATE,
				RECORD_EMP,
				RECORD_IP
			)
			VALUES
           (
				<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.active#">,
				<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.type#">,
				<cfif arguments.type eq 1>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">,
				<cfelseif arguments.type eq 2>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">,
				<cfelseif arguments.type eq 3>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">,
				</cfif>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" null="#not Len(arguments.name)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.surname#" null="#not Len(arguments.surname)#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#not Len(arguments.sector_id)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company_name#" null="#not Len(arguments.company_name)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#" null="#not Len(arguments.title)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#" null="#not Len(arguments.email)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.telcode#" null="#not Len(arguments.telcode)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.telno#" null="#not Len(arguments.telno)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.telno2#" null="#not Len(arguments.telno2)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.faxno#" null="#not Len(arguments.faxno)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobilcode#" null="#not Len(arguments.mobilcode)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobilno#" null="#not Len(arguments.mobilno)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.web#" null="#not Len(arguments.web)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.postcode#" null="#not Len(arguments.postcode)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address#" null="#not Len(arguments.address)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.semt#" null="#not Len(arguments.semt)#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.county_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.county_name#" null="#not Len(arguments.county_name)#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.city_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city_name#" null="#not Len(arguments.city_name)#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.country_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country_name#" null="#not Len(arguments.country_name)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.info#" null="#not Len(arguments.info)#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.special_emp#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
				<cfif isDefined("session.ep")>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.userid#">,
				<cfelseif isDefined("session.pp")>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">,
				<cfelseif isDefined("session.ww")>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#session.ww.userid#">,
				<cfelse>
					NULL,
				</cfif>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#">
			)
		</cfquery>
	</cffunction>
	
	<!--- Guncelleme --->
	<cffunction name="upd_AddressBook" access="public" returntype="any">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="active" type="any" required="no" default="1">
		<cfargument name="type" type="numeric" required="no" default="0">
		<cfargument name="type_id" type="numeric" required="no" default="0">
		<cfargument name="id" type="numeric" required="yes" default="0">
		<cfargument name="name" type="string" required="yes" default="">
		<cfargument name="surname" type="string" required="yes" default="">
		<cfargument name="sector_id" type="numeric" required="no" default="0">
		<cfargument name="company_name" type="string" required="no" default="">
		<cfargument name="title" type="string" required="no" default="">
		<cfargument name="email" type="string" required="no" default="">
		<cfargument name="telcode" type="string" required="no" default="">
		<cfargument name="telno" type="string" required="no" default="">
		<cfargument name="telno2" type="string" required="no" default="">
		<cfargument name="faxno" type="string" required="no" default="">
		<cfargument name="mobilcode" type="string" required="no" default="">
		<cfargument name="mobilno" type="string" required="no" default="">
		<cfargument name="web" type="string" required="no" default="">
		<cfargument name="postcode" type="string" required="no" default="">
		<cfargument name="address" type="string" required="no" default="">
		<cfargument name="semt" type="string" required="no" default="">
		<cfargument name="county_id" type="numeric" required="no" default="0">
		<cfargument name="county_name" type="string" required="no" default="">
		<cfargument name="city_id" type="numeric" required="no" default="0">
		<cfargument name="city_name" type="string" required="no" default="">
		<cfargument name="country_id" type="numeric" required="no" default="0">
		<cfargument name="country_name" type="string" required="no" default="">
		<cfargument name="info" type="string" required="no" default="">
		<cfargument name="special_emp" type="numeric" required="no" default="0">
		
		<cfquery name="upd_AddressBook" datasource="#this.data_source#">
			UPDATE
				#process_db#ADDRESSBOOK
			SET
				IS_ACTIVE = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.active#">,
				IS_SYS_MEMBER = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.type#">,
				<!--- 
				<cfif Len(arguments.type_id) and arguments.type_id neq 0>
					<cfif arguments.type eq 1>
						EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">,
					<cfelseif arguments.type eq 2>
						PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">,
					<cfelseif arguments.type eq 3>
						CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">,
					</cfif>
				</cfif>
				 --->
				AB_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" null="#not Len(arguments.name)#">,
				AB_SURNAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.surname#" null="#not Len(arguments.surname)#">,
				AB_SECTOR_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sector_id#">,
				AB_COMPANY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company_name#" null="#not Len(arguments.company_name)#">,
				AB_TITLE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#" null="#not Len(arguments.title)#">,
				AB_EMAIL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#" null="#not Len(arguments.email)#">,
				AB_TELCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.telcode#" null="#not Len(arguments.telcode)#">,
				AB_TEL1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.telno#" null="#not Len(arguments.telno)#">,
				AB_TEL2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.telno2#" null="#not Len(arguments.telno2)#">,
				AB_FAX = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.faxno#" null="#not Len(arguments.faxno)#">,
				AB_MOBILCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobilcode#" null="#not Len(arguments.mobilcode)#">,
				AB_MOBIL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobilno#" null="#not Len(arguments.mobilno)#">,
				AB_WEB = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.web#" null="#not Len(arguments.web)#">,
				AB_POSTCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.postcode#" null="#not Len(arguments.postcode)#">,
				AB_ADDRESS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address#" null="#not Len(arguments.address)#">,
				AB_SEMT = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.semt#" null="#not Len(arguments.semt)#">,
				AB_COUNTY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.county_id#">,
				AB_COUNTY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.county_name#" null="#not Len(arguments.county_name)#">,
				AB_CITY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.city_id#">,
				AB_CITY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city_name#" null="#not Len(arguments.city_name)#">,
				AB_COUNTRY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.country_id#">,
				AB_COUNTRY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country_name#" null="#not Len(arguments.country_name)#">,
				AB_INFO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.info#" null="#not Len(arguments.info)#">,
				SPECIAL_EMP = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.special_emp#">,
				UPDATE_DATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
				<cfif isDefined("session.ep")>
					UPDATE_EMP = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.userid#">,
				<cfelseif isDefined("session.pp")>
					UPDATE_EMP = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">,
				<cfelseif isDefined("session.ww")>
					UPDATE_EMP = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ww.userid#">,
				</cfif>
				UPDATE_IP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#">
			WHERE
				<cfif arguments.type eq 1>
					EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">
				<cfelseif arguments.type eq 2>
					PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">
				<cfelseif arguments.type eq 3>
					CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.type_id#">
				<cfelse>
					AB_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
				</cfif>
		</cfquery>
	</cffunction>
	
	<!--- Goruntuleme --->
	<cffunction name="get_AddressBook" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="active" type="any" required="no" default="1">
		<cfargument name="type" type="numeric" required="no" default="0">
		<cfargument name="type_id" type="numeric" required="no" default="0">
		<cfargument name="id" type="numeric" required="no" default="0">
		<cfargument name="name" type="string" required="yes" default="">
		<cfargument name="surname" type="string" required="yes" default="">
		<cfargument name="sector_id" type="numeric" required="no" default="0">
		<cfargument name="company_name" type="string" required="no" default="">
		<cfargument name="title" type="string" required="no" default="">
		<cfargument name="email" type="string" required="no" default="">
		<cfargument name="telcode" type="string" required="no" default="">
		<cfargument name="telno" type="string" required="no" default="">
		<cfargument name="telno2" type="string" required="no" default="">
		<cfargument name="faxno" type="string" required="no" default="">
		<cfargument name="mobilcode" type="string" required="no" default="">
		<cfargument name="mobilno" type="string" required="no" default="">
		<cfargument name="web" type="string" required="no" default="">
		<cfargument name="postcode" type="string" required="no" default="">
		<cfargument name="address" type="string" required="no" default="">
		<cfargument name="semt" type="string" required="no" default="">
		<cfargument name="county_id" type="numeric" required="no" default="0">
		<cfargument name="county_name" type="string" required="no" default="">
		<cfargument name="city_id" type="numeric" required="no" default="0">
		<cfargument name="city_name" type="string" required="no" default="">
		<cfargument name="country_id" type="numeric" required="no" default="0">
		<cfargument name="country_name" type="string" required="no" default="">
		<cfargument name="info" type="string" required="no" default="">
		<cfargument name="special_emp" type="numeric" required="no" default="0">
		<cfquery name="get_AddressBook" datasource="#this.data_source#">
			SELECT
				AB_ID,
				IS_ACTIVE,
				IS_SYS_MEMBER,
				EMPLOYEE_ID,
				PARTNER_ID,
				CONSUMER_ID,
				AB_NAME,
				AB_SURNAME,
				AB_SECTOR_ID,
				AB_COMPANY,
				AB_TITLE,
				AB_EMAIL,
				AB_TELCODE,
				AB_TEL1,
				AB_TEL2,
				AB_FAX,
				AB_MOBILCODE,
				AB_MOBIL,
				AB_WEB,
				AB_POSTCODE,
				AB_ADDRESS,
				AB_SEMT,
				AB_COUNTY_ID,
				AB_COUNTY,
				AB_CITY_ID,
				AB_CITY,
				AB_COUNTRY_ID,
				AB_COUNTRY,
				AB_INFO,
				SPECIAL_EMP,
				RECORD_DATE,
				RECORD_EMP,
				RECORD_IP,
				UPDATE_DATE,
				UPDATE_EMP,
				UPDATE_IP
			FROM
				#process_db#ADDRESSBOOK
			WHERE
				<cfif Len(arguments.id) and arguments.id gt 0>
					AB_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#"> AND
				</cfif>
				<cfif Len(arguments.special_emp) and arguments.special_emp gt 0>
					(SPECIAL_EMP = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.special_emp#"> OR ISNULL(SPECIAL_EMP,0) = 0) AND
				</cfif>
				1 = 1
		</cfquery>
		<cfreturn get_AddressBook>
	</cffunction>
	
	<!--- Silme --->
	<cffunction name="del_AddressBook" access="public" returntype="any">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="id" type="numeric" required="yes" default="0">
		<cfquery name="del_AddressBook" datasource="#this.data_source#">
			DELETE FROM
				#process_db#ADDRESSBOOK
			WHERE
				AB_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
	</cffunction>
</cfcomponent>

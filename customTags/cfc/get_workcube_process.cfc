<!--- FBS 20120615 workcube_process ve workcube_process_info tagleri icin olusturulmustur --->
<cfcomponent>
	<cfset dsn = "w3Partner">
    <cfset database_type = "MSSQL">
	<cfif isdefined('onesignal_appID') and len(onesignal_appID)>
		<cfset onesignal_appID = application.systemParam.systemParam().onesignal_appID>
		<cfset onesignal = application.systemParam.systemParam().onesignal>
	</cfif>
	<!--- Form --->
	<cffunction name="get_ProcessType" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="our_company_id" type="numeric" required="no" default="#this.my_our_company_id_#">
		<cfargument name="fuseaction" type="string" required="no" default="">
		<cfargument name="select_value" type="numeric" required="no" default="0">
		<cfargument name="extra_process_id" type="string" required="no" default="">
		<cfargument name="faction_list" type="string" required="no" default="">
		<!--- Sirketlere Bagli Surec Yetkileri --->
		<cfquery name="get_ProcessType" datasource="#this.data_source#">
			SELECT
				PT.PROCESS_ID,
				PT.PROCESS_NAME,
				PT.IS_STAGE_BACK,
				PT.MAIN_FILE,
				PT.IS_MAIN_FILE,
				PT.MAIN_ACTION_FILE,
				PT.IS_MAIN_ACTION_FILE
			FROM
				#process_db#PROCESS_TYPE PT,
				#process_db#PROCESS_TYPE_OUR_COMPANY PTOC
			WHERE
				<cfif Len(arguments.select_value) and arguments.select_value neq 0>
					PT.PROCESS_ID IN (SELECT PTR.PROCESS_ID FROM #process_db#PROCESS_TYPE_ROWS PTR WHERE PTR.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">) AND
				<cfelse>
					<cfif Len(faction_list)>
						PT.PROCESS_ID IN (SELECT PTR.PROCESS_ID FROM #process_db#PROCESS_TYPE_ROWS PTR WHERE PTR.PROCESS_ROW_ID IN (#faction_list#)) AND
					</cfif>
					PT.IS_ACTIVE = 1 AND
				</cfif>
				PT.PROCESS_ID = PTOC.PROCESS_ID AND
				PTOC.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#our_company_id#"> AND
				<cfif len(arguments.extra_process_id)>
					PT.PROCESS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.extra_process_id#">
				<cfelse>
					CAST(PT.FACTION AS <cfif database_type is 'MSSQL'>NVARCHAR(2500))+<cfelse>VARGRAPHIC(2500))||</cfif>',' LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.fuseaction#,%">
				</cfif>
			ORDER BY
				PTOC.OUR_COMPANY_ID,
				PT.PROCESS_ID
		</cfquery>
		<cfreturn get_ProcessType>
	</cffunction>
	
	<cffunction name="get_Faction" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="extra_process_row_id" type="string" required="no" default="">
		<cfargument name="position_code" type="any" required="no" default="">
		<cfargument name="partner_id" type="any" required="no" default="">
		<cfif get_ProcessType.RecordCount><cfset Process_Id_List = ValueList(get_ProcessType.Process_Id)><cfelse><cfset Process_Id_List = 0></cfif>
		<!--- Asama Yetkileri --->
		<cfquery name="get_Faction" datasource="#this.data_source#">
			<!--- Yetkili Pozisyonlar / Yetkili Partnerlar / Yetkili Consumerlar --->
			SELECT DISTINCT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER LINE_NUMBER,
				PTR.IS_DISPLAY,
				PTR.DISPLAY_FILE_NAME
			FROM
				#process_db#PROCESS_TYPE_ROWS PTR,
				#process_db#PROCESS_TYPE_ROWS_POSID PTRP
			WHERE
				PTR.PROCESS_ROW_ID = PTRP.PROCESS_ROW_ID AND
				PTR.PROCESS_ID IN (#Process_Id_List#) 
				<cfif Len(arguments.extra_process_row_id) and arguments.extra_process_row_id neq -1>
					AND PTR.PROCESS_ROW_ID IN (#arguments.extra_process_row_id#) 
				<cfelseif arguments.extra_process_row_id neq -1>
					AND 1 = 0 
				</cfif>
				<cfif arguments.module_type is "e">
					AND PTRP.PRO_POSITION_ID IN 
					(	SELECT
							POSITION_ID
						FROM
							#process_db#EMPLOYEE_POSITIONS EP
						WHERE
							EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#">
					) AND
					PTR.IS_EMPLOYEE = 0
				<cfelseif arguments.module_type is "p">
					AND PTRP.PRO_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.partner_id#"> AND
					PTR.IS_PARTNER = 0
				<cfelseif arguments.module_type is "w">
					AND PTR.IS_CONSUMER = 0
				</cfif>
		UNION
			<!--- Tum Calisanlar/ Tum Kurumsal Uyeler / Tum Bireysel Uyeler --->
			SELECT DISTINCT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER LINE_NUMBER,
				PTR.IS_DISPLAY,
				PTR.DISPLAY_FILE_NAME
			FROM
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE
				PTR.PROCESS_ID IN (#Process_Id_List#) 
				<cfif Len(arguments.extra_process_row_id) and arguments.extra_process_row_id neq -1>
					AND PTR.PROCESS_ROW_ID IN (#arguments.extra_process_row_id#)
				<cfelseif arguments.extra_process_row_id neq -1>
					AND 1 = 0 
				 </cfif>
				<cfif arguments.module_type is "e">
	                AND PTR.IS_EMPLOYEE = 1
				<cfelseif arguments.module_type is "p">
					AND PTR.IS_PARTNER = 1
				<cfelseif arguments.module_type is "w">
					AND PTR.IS_CONSUMER = 1
				</cfif>
		UNION
			<!--- Tum Surec Gruplari --->
			SELECT DISTINCT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER LINE_NUMBER,
				PTR.IS_DISPLAY,
				PTR.DISPLAY_FILE_NAME
			FROM 	
				#process_db#PROCESS_TYPE_ROWS PTR,
				#process_db#PROCESS_TYPE_ROWS_POSID PTRP,
				#process_db#PROCESS_TYPE_ROWS_WORKGRUOP PTRW
			WHERE
				PTR.PROCESS_ID IN (#Process_Id_List#) AND
				PTRW.PROCESS_ROW_ID = PTR.PROCESS_ROW_ID  AND 
				PTRW.MAINWORKGROUP_ID IS NOT NULL AND 
				PTRW.MAINWORKGROUP_ID = PTRP.WORKGROUP_ID  
				<cfif Len(arguments.extra_process_row_id) and arguments.extra_process_row_id neq -1>
					AND PTR.PROCESS_ROW_ID IN (#arguments.extra_process_row_id#) 
				<cfelseif arguments.extra_process_row_id neq -1>
					AND 1 = 0
				</cfif>
				<cfif arguments.module_type is "e">
					AND PTRP.PRO_POSITION_ID IN 
					(	SELECT
							POSITION_ID
						FROM
							#process_db#EMPLOYEE_POSITIONS EP
						WHERE
							EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#">
					)
				<cfelseif arguments.module_type is "p">
					AND ( PTR.IS_PARTNER = 1 OR PTRP.PRO_PARTNER_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.partner_id#">) )
				<cfelseif arguments.module_type is "w">
					AND PTR.IS_CONSUMER = 1
				</cfif>
			ORDER BY 
				LINE_NUMBER
		</cfquery>
		<cfreturn get_Faction>
	</cffunction>
	
	<cffunction name="get_File_Name" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="select_value" type="numeric" required="no" default="0">
		<cfif get_ProcessType.RecordCount><cfset Process_Id_List = ValueList(get_ProcessType.Process_Id)><cfelse><cfset Process_Id_List = 0></cfif>

		<!--- Asama Display File Kontrolu, Eklemede Ilk Asamaya, Guncellemede Bulundugu Asamaya Bakar --->
		<cfquery name="get_File_Name" datasource="#this.data_source#">
			SELECT
				PTR.IS_DISPLAY,
				PTR.DISPLAY_FILE_NAME,
				PTR.IS_DISPLAY_FILE_NAME 
			FROM 
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE 
				PTR.PROCESS_ID IN (#Process_Id_List#) AND
				<cfif Len(arguments.select_value) and arguments.select_value neq 0>
					PTR.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">
				<cfelse>
					<cfif get_Faction.RecordCount>
						PTR.PROCESS_ROW_ID IN (#ValueList(get_Faction.Process_Row_Id,',')#) AND
					</cfif>
					PTR.LINE_NUMBER = 1
				</cfif>
		</cfquery>
		<cfreturn get_File_Name>
	</cffunction>
	
	<cffunction name="get_Line_Number" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="select_value" type="numeric" required="yes" default="0">
		<cfif get_ProcessType.RecordCount><cfset Process_Id_List = ValueList(get_ProcessType.Process_Id)><cfelse><cfset Process_Id_List = 0></cfif>

		<cfquery name="get_Line_Number" datasource="#this.data_source#">
			SELECT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				(SELECT IS_STAGE_BACK FROM #process_db#PROCESS_TYPE PT WHERE PT.PROCESS_ID = PTR.PROCESS_ID) IS_STAGE_BACK,
				PTR.IS_CONTINUE,
				PTR.IS_DISPLAY,
				PTR.PROCESS_ID,
				PTR.LINE_NUMBER
			FROM 
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE 
				PTR.PROCESS_ID IN (#Process_Id_List#) AND
				PTR.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">
		</cfquery>
		<cfreturn get_Line_Number>
	</cffunction>
	
	<cffunction name="get_Select_Line0" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="extra_process_row_id" type="string" required="no" default="">
		<cfargument name="position_code" type="any" required="no" default="">
		<cfargument name="partner_id" type="any" required="no" default="">
		<cfargument name="select_value" type="numeric" required="no" default="0">
		<cfif get_ProcessType.RecordCount><cfset Process_Id_List = ValueList(get_ProcessType.Process_Id)><cfelse><cfset Process_Id_List = 0></cfif>

		<cfquery name="get_Select_Line0" datasource="#this.data_source#">
			SELECT DISTINCT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER LINE_NUMBER,
				PTR.IS_CONTINUE
			FROM
				#process_db#PROCESS_TYPE_ROWS PTR,
				#process_db#PROCESS_TYPE_ROWS_POSID PTRP
			WHERE
				PTR.PROCESS_ID IN (#Process_Id_List#) AND
				<cfif get_Line_Number.Is_Stage_Back eq 0>
					PTR.LINE_NUMBER >= ( SELECT PTR2.LINE_NUMBER FROM PROCESS_TYPE_ROWS PTR2 WHERE PTR2.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">) AND 
					PTR.PROCESS_ID = #get_Line_Number.Process_Id# AND 
				</cfif>
				<cfif Len(arguments.extra_process_row_id) and arguments.extra_process_row_id neq -1>
					PTR.PROCESS_ROW_ID IN (#arguments.extra_process_row_id#) AND
				<cfelseif arguments.extra_process_row_id neq -1>
					1 = 0 AND
				</cfif>
				<cfif arguments.module_type is "e">
					PTRP.PRO_POSITION_ID IN 
					(	SELECT
							POSITION_ID
						FROM
							#process_db#EMPLOYEE_POSITIONS EP
						WHERE
							EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#"> 
					) AND
					PTR.IS_EMPLOYEE = 0 AND
				<cfelseif arguments.module_type is "p">
					(PTR.IS_PARTNER = 1 OR PTRP.PRO_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.partner_id#">) AND
				</cfif>
				PTRP.PROCESS_ROW_ID = PTR.PROCESS_ROW_ID
		UNION
			SELECT DISTINCT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER LINE_NUMBER,
				PTR.IS_CONTINUE
			FROM
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE
				PTR.PROCESS_ID IN (#Process_Id_List#) AND
				<cfif get_Line_Number.Is_Stage_Back eq 0>
					PTR.LINE_NUMBER >= ( SELECT PTR2.LINE_NUMBER FROM PROCESS_TYPE_ROWS PTR2 WHERE PTR2.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">) AND 
					PTR.PROCESS_ID = #get_Line_Number.Process_Id# AND 
				</cfif>
				<cfif Len(arguments.extra_process_row_id) and arguments.extra_process_row_id neq -1>
					PTR.PROCESS_ROW_ID IN (#arguments.extra_process_row_id#) AND
				<cfelseif arguments.extra_process_row_id neq -1>
					1 = 0 AND
				</cfif>
				<cfif arguments.module_type is "e">
					PTR.IS_EMPLOYEE  = 1
				<cfelseif arguments.module_type is "p">
					PTR.IS_PARTNER  = 1
				<cfelseif arguments.module_type is "w">
					PTR.IS_CONSUMER = 1
				<cfelse>
					1 = 0
				</cfif>
		<!--- Grupları çekiyor. --->
		UNION 
			SELECT DISTINCT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER LINE_NUMBER,
				PTR.IS_CONTINUE
			FROM 	
				#process_db#PROCESS_TYPE_ROWS PTR,
				#process_db#PROCESS_TYPE_ROWS_WORKGRUOP PTRW,
				#process_db#PROCESS_TYPE_ROWS_POSID PTRP
			WHERE 
				PTR.PROCESS_ID IN (#Process_Id_List#) AND
				<cfif get_Line_Number.Is_Stage_Back eq 0>
					PTR.LINE_NUMBER >= ( SELECT PTR2.LINE_NUMBER FROM PROCESS_TYPE_ROWS PTR2 WHERE PTR2.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">) AND 
					PTR.PROCESS_ID = #get_Line_Number.Process_Id# AND 
				</cfif>
				<cfif arguments.module_type is "e">
					PTRP.PRO_POSITION_ID IN 
					(	SELECT
							POSITION_ID
						FROM
							#process_db#EMPLOYEE_POSITIONS EP
						WHERE
							EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#"> 
					) AND
				<cfelseif arguments.module_type is "p">
					( PTR.IS_PARTNER = 1 OR PTRP.PRO_PARTNER_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.partner_id#">) ) AND
				</cfif>
				<cfif Len(arguments.extra_process_row_id) and arguments.extra_process_row_id neq -1>
					PTR.PROCESS_ROW_ID IN (#arguments.extra_process_row_id#) AND
				<cfelseif arguments.extra_process_row_id neq -1>
					1 = 0 AND
				</cfif>
				 PTRW.PROCESS_ROW_ID = PTR.PROCESS_ROW_ID  AND 
				 PTRW.MAINWORKGROUP_ID IS NOT NULL AND 
				 PTRW.MAINWORKGROUP_ID = PTRP.WORKGROUP_ID
			ORDER BY 
				LINE_NUMBER
		</cfquery>
		<cfreturn get_Select_Line0>
	</cffunction>
	
	<cffunction name="get_Select_Line1" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="select_value" type="numeric" required="yes" default="0">

		<cfquery name="get_Select_Line1" datasource="#this.data_source#">
			SELECT
				PTR.PROCESS_ROW_ID,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.LINE_NUMBER,
				PTR.IS_CONTINUE
			FROM 
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE 
				PTR.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.select_value#">
		</cfquery>
		<cfreturn get_Select_Line1>
	</cffunction>
	
	<cffunction name="get_Select_Line" access="public" returntype="query">
		<cfquery name="get_Select_Line" dbtype="query">
			SELECT * FROM GET_SELECT_LINE0 UNION SELECT * FROM GET_SELECT_LINE1 ORDER BY LINE_NUMBER
		</cfquery>
		<cfreturn get_Select_Line>
	</cffunction>
	<!--- //Form --->
	
	<!--- Query --->
	<cffunction name="get_Process_Type_1" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="process_stage" type="numeric" required="yes" default="0">

		<cfquery name="get_Process_Type_1" datasource="#this.data_source#">
			SELECT
				(SELECT PT.PROCESS_NAME FROM #process_db#PROCESS_TYPE PT WHERE PT.PROCESS_ID = PTR.PROCESS_ID) PROCESS_NAME,
				PTR.PROCESS_ROW_ID,
				PTR.IS_WARNING,
				PTR.IS_SMS,
				PTR.IS_EMAIL,
				PTR.IS_ONLINE,
				PTR.STAGE_CODE,
				#dsn#.#dsn#.Get_Dynamic_Language(PTR.PROCESS_ROW_ID,'#this.lang#','PROCESS_TYPE_ROWS','STAGE',NULL,NULL,STAGE) AS STAGE,
				PTR.IS_CONFIRM,
				PTR.CONFIRM_REQUEST,
				PTR.ANSWER_HOUR,
				PTR.ANSWER_MINUTE,
				PTR.IS_FILE_NAME,
				PTR.DETAIL,
				PTR.LINE_NUMBER,
				PTR.FILE_NAME,
				PTR.RECORD_EMP,
				PTR.UPDATE_EMP,
				PTR.RECORD_DATE,
				PTR.UPDATE_DATE,
				PTR.IS_CONSUMER
			FROM 
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE 
				PTR.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#">
		</cfquery>
		<cfreturn get_Process_Type_1>
	</cffunction>

	<cffunction name="get_Employee_WorkGroup" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="process_stage" type="numeric" required="yes" default="0">
		<cfargument name="position_code" type="any" required="no" default="">
		<cfargument name="partner_id" type="any" required="no" default="">

		<cfquery name="get_Employee_WorkGroup" datasource="#this.data_source#">
			SELECT
				PTRW.WORKGROUP_ID,
				0 MAINWORKGROUP_ID
			FROM
				#process_db#PROCESS_TYPE_ROWS_WORKGRUOP PTRW,
				#process_db#PROCESS_TYPE_ROWS_POSID PTRP
			WHERE
				PTRW.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#"> AND
				<cfif arguments.module_type is 'e'>
					PTRP.PRO_POSITION_ID IN 
					(	SELECT
							POSITION_ID
						FROM
							#process_db#EMPLOYEE_POSITIONS EP
						WHERE
							EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#"> 
					) AND
				<cfelseif arguments.module_type is 'p'>
					PTRP.PRO_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.partner_id#"> AND
				</cfif>
				PTRW.WORKGROUP_ID = PTRP.WORKGROUP_ID
		UNION
			SELECT DISTINCT
				0 WORKGROUP_ID,
				PTRW.MAINWORKGROUP_ID MAINWORKGROUP_ID
			FROM
				#process_db#PROCESS_TYPE_ROWS_WORKGRUOP PTRW,
				#process_db#PROCESS_TYPE_ROWS PTR,
				#process_db#PROCESS_TYPE_ROWS_POSID PTRP
			WHERE
				PTRW.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#"> AND 
				<cfif arguments.module_type is 'e'>
					PTRP.PRO_POSITION_ID IN 
					(	SELECT
							POSITION_ID
						FROM
							#process_db#EMPLOYEE_POSITIONS EP
						WHERE
							EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#"> 
					) AND
				<cfelseif arguments.module_type is 'p'>
					PTRP.PRO_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.partner_id#"> AND
				</cfif>
				PTRW.MAINWORKGROUP_ID = PTRP.WORKGROUP_ID AND
				PTRW.PROCESS_ROW_ID = PTR.PROCESS_ROW_ID AND 
				PTRW.MAINWORKGROUP_ID IS NOT NULL
		</cfquery>
		<cfreturn get_Employee_WorkGroup>
	</cffunction>
	
	<cffunction name="get_Inf_Position_Type" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
        <cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="process_stage" type="numeric" required="yes" default="0">
		<cfargument name="value_workgroup_id" type="string" required="no" default="0">
		<cfargument name="value_mainworkgroup_id" type="string" required="no" default="0">

		<cfquery name="get_Inf_Position_Type" datasource="#this.data_source#">
			SELECT 
				PTRI.INF_POSITION_ID PRO_POSITION_ID,
				E.EMPLOYEE_NAME EMPLOYEE_NAME,
				E.EMPLOYEE_SURNAME EMPLOYEE_SURNAME,
				E.EMPLOYEE_EMAIL EMPLOYEE_EMAIL,
				EP.EMPLOYEE_ID EMPLOYEE_ID,
				E.MOBILCODE MOBILCODE,
				E.MOBILTEL MOBILTEL,
				EP.POSITION_CODE,
				1 TYPE 
			FROM 
				#process_db#PROCESS_TYPE_ROWS_INFID PTRI,
				#process_db#EMPLOYEES E,
				#process_db#EMPLOYEE_POSITIONS EP
			WHERE 
				PTRI.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#"> AND
				<cfif arguments.is_consumer eq 0 or (arguments.is_consumer eq 1 and module_type eq 'e')>
					PTRI.WORKGROUP_ID IN (#arguments.value_workgroup_id#) AND
				</cfif>
				E.EMPLOYEE_STATUS = 1 AND
				EP.EMPLOYEE_ID = E.EMPLOYEE_ID AND
				EP.POSITION_ID = PTRI.INF_POSITION_ID
		<cfif arguments.is_consumer eq 0 or (arguments.is_consumer eq 1 and module_type eq 'e')>
			UNION 
				SELECT 
					PTRI.INF_POSITION_ID PRO_POSITION_ID,
					E.EMPLOYEE_NAME EMPLOYEE_NAME,
					E.EMPLOYEE_SURNAME EMPLOYEE_SURNAME,
					E.EMPLOYEE_EMAIL EMPLOYEE_EMAIL,
					EP.EMPLOYEE_ID EMPLOYEE_ID,
					E.MOBILCODE MOBILCODE,
					E.MOBILTEL MOBILTEL,
					EP.POSITION_CODE,
					1 TYPE 
				FROM 					
					#process_db#PROCESS_TYPE_ROWS_WORKGRUOP PTRW,
					#process_db#PROCESS_TYPE_ROWS_INFID PTRI,
					#process_db#EMPLOYEE_POSITIONS EP,
					#process_db#EMPLOYEES E
				WHERE 
					PTRW.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#"> AND 
					PTRW.MAINWORKGROUP_ID IN (#arguments.value_mainworkgroup_id#) AND
					PTRI.WORKGROUP_ID=PTRW.MAINWORKGROUP_ID AND
					E.EMPLOYEE_STATUS = 1 AND
					EP.POSITION_ID = PTRI.INF_POSITION_ID AND
					EP.EMPLOYEE_ID = E.EMPLOYEE_ID
		</cfif>
		</cfquery>
		<cfreturn get_Inf_Position_Type>
	</cffunction>
	
	<cffunction name="get_Cau_Position_Type" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
        <cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="process_stage" type="numeric" required="yes" default="0">
		<cfargument name="value_workgroup_id" type="string" required="no" default="0">
		<cfargument name="value_mainworkgroup_id" type="string" required="no" default="0">

		<cfquery name="get_Cau_Position_Type" datasource="#this.data_source#">
			SELECT 
				PTRC.CAU_POSITION_ID PRO_POSITION_ID,
				E.EMPLOYEE_NAME EMPLOYEE_NAME,
				E.EMPLOYEE_SURNAME EMPLOYEE_SURNAME,
				E.EMPLOYEE_EMAIL EMPLOYEE_EMAIL,
				EP.EMPLOYEE_ID EMPLOYEE_ID,
				E.MOBILCODE MOBILCODE,
				E.MOBILTEL MOBILTEL,
				EP.POSITION_CODE,
				0 TYPE 
			FROM 
				#process_db#PROCESS_TYPE_ROWS_CAUID PTRC,
				#process_db#EMPLOYEES E,
				#process_db#EMPLOYEE_POSITIONS EP
			WHERE 
				PTRC.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#"> AND
				<cfif arguments.is_consumer eq 0 or (arguments.is_consumer eq 1 and module_type eq 'e')>
					PTRC.WORKGROUP_ID IN (#arguments.value_workgroup_id#) AND
				</cfif>
				E.EMPLOYEE_STATUS = 1 AND
				EP.EMPLOYEE_ID = E.EMPLOYEE_ID AND
				EP.POSITION_ID = PTRC.CAU_POSITION_ID
		<cfif arguments.is_consumer eq 0 or (arguments.is_consumer eq 1 and module_type eq 'e')>
			UNION 
				SELECT 
					PTRC.CAU_POSITION_ID PRO_POSITION_ID,
					E.EMPLOYEE_NAME EMPLOYEE_NAME,
					E.EMPLOYEE_SURNAME EMPLOYEE_SURNAME,
					E.EMPLOYEE_EMAIL EMPLOYEE_EMAIL,
					EP.EMPLOYEE_ID EMPLOYEE_ID,
					E.MOBILCODE MOBILCODE,
					E.MOBILTEL MOBILTEL,
					EP.POSITION_CODE,
					0 TYPE 
				FROM 					
					#process_db#PROCESS_TYPE_ROWS_WORKGRUOP PTRW,
					#process_db#PROCESS_TYPE_ROWS_CAUID PTRC,
					#process_db#EMPLOYEE_POSITIONS EP,
					#process_db#EMPLOYEES E
				WHERE 
					PTRW.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#"> AND 
					PTRW.MAINWORKGROUP_ID IN (#arguments.value_mainworkgroup_id#) AND
					PTRC.WORKGROUP_ID=PTRW.MAINWORKGROUP_ID AND
					E.EMPLOYEE_STATUS = 1 AND
					EP.POSITION_ID = PTRC.CAU_POSITION_ID AND
					EP.EMPLOYEE_ID = E.EMPLOYEE_ID
			</cfif>
		</cfquery>
		<cfreturn get_Cau_Position_Type>
	</cffunction>

	<cffunction name="get_General_Positions" access="public" returntype="query">
		<cfquery name="get_General_Positions" dbtype="query">
			SELECT * FROM get_Inf_Position_Type UNION ALL SELECT * FROM get_Cau_Position_Type
		</cfquery>
		<cfreturn get_General_Positions>
	</cffunction>
	
	<cffunction name="get_Real_Izin" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="employee_id" type="numeric" required="no" default="0">
		<cfargument name="position_code" type="numeric" required="no" default="0">
		<cfargument name="record_date" type="date" required="no" default="">
		<cfquery name="get_Real_Izin" datasource="#this.data_source#">
			SELECT 
				EMPLOYEE_ID 
			FROM 
				#process_db#OFFTIME 
			WHERE 
				<cfif Len(arguments.employee_id) and arguments.employee_id neq 0>
					EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.employee_id#"> AND
				<cfelse>
					EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM #process_db#EMPLOYEE_POSITIONS WHERE POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#">) AND
				</cfif>
				(
					( STARTDATE >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.record_date#"> AND STARTDATE <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.record_date#"> ) OR
					( STARTDATE <= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.record_date#"> AND FINISHDATE >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.record_date#"> )
				) AND
				VALID = 1
		</cfquery>
		<cfreturn get_Real_Izin>
	</cffunction>
	
	<cffunction name="get_StandBys" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="position_code" type="numeric" required="yes" default="0">
		<cfquery name="get_StandBys" datasource="#this.data_source#">
			SELECT
				CANDIDATE_POS_1,
				CANDIDATE_POS_2,
				CANDIDATE_POS_3
			FROM
				#process_db#EMPLOYEE_POSITIONS_STANDBY
			WHERE
				POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#">
		</cfquery>
		<cfreturn get_StandBys>
	</cffunction>
	
	<cffunction name="get_Yedek" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="position_code" type="numeric" required="yes" default="0">
		<cfquery name="get_Yedek" datasource="#this.data_source#">
			SELECT
				EP.POSITION_ID PRO_POSITION_ID,
				E.EMPLOYEE_NAME EMPLOYEE_NAME,
				E.EMPLOYEE_SURNAME EMPLOYEE_SURNAME,
				E.EMPLOYEE_EMAIL EMPLOYEE_EMAIL,
				EP.EMPLOYEE_ID EMPLOYEE_ID,
				E.MOBILCODE MOBILCODE,
				E.MOBILTEL MOBILTEL,
				EP.POSITION_CODE
			FROM
				#process_db#EMPLOYEE_POSITIONS EP,
				#process_db#EMPLOYEES E
			WHERE
				E.EMPLOYEE_STATUS = 1 AND
				EP.EMPLOYEE_ID = E.EMPLOYEE_ID AND
				EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#">
		</cfquery>
		<cfreturn get_Yedek>
	</cffunction>
	
	<cffunction name="add_Wrk_Message" access="public" returntype="any">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="employee_id" type="numeric" required="yes" default="0">
		<cfargument name="record_member" type="numeric" required="yes" default="0">
		<cfargument name="record_date" type="date" required="no" default="">
		<cfargument name="message" type="string" required="no" default="">
		<cfquery name="add_Wrk_Message" datasource="#this.data_source#">
			INSERT INTO 
				#process_db#WRK_MESSAGE
			(
				RECEIVER_ID,
				RECEIVER_TYPE,
				SENDER_ID,
				SENDER_TYPE,
				MESSAGE,
				SEND_DATE
			)
			VALUES
			(
				#arguments.employee_id#,
				0,
				#arguments.record_member#,
				<cfif arguments.module_type eq 'e'>0<cfelseif arguments.module_type eq 'p'>1<cfelseif arguments.module_type eq 'w'>2</cfif>,
				'#arguments.message#',
				#arguments.record_date#
			)
		</cfquery>
		<cfif isdefined('onesignal_appID') and len(onesignal_appID)>
			<script type="text/javascript">
				cont_message = "<cfoutput>#message#</cfoutput>";
				receiver_id = "<cfoutput>#arguments.employee_id#</cfoutput>";
				gonderen_isim ="Workcube'de adınıza yapılmış bir Süreç Takip Kaydı bulunmaktadır!";
				onesignal_appID = "<cfoutput>#onesignal_appID#</cfoutput>";	
				onesignal = "<cfoutput>#onesignal#</cfoutput>";
				var jsonBody = { 
						app_id: onesignal_appID,
						included_segments : "All",
						headings : {
							en: gonderen_isim
						},
						contents :{
							en: cont_message
						},
						data : {
							foo: "bar"
						},
						filters : [
							{"field": "tag", "key": "emp_id", "relation": "=", "value": receiver_id}
						]
				}; 
				var request = $.ajax({
					url: "https://onesignal.com/api/v1/notifications",
					headers: {
							'Authorization':onesignal,
							'Content-Type':'application/json'
							
						},
					type: "POST",
					data: JSON.stringify(jsonBody),
					dataType: "json",
					success: function (msg) {  
						console.log("success");
					},
					error: function (jqXHR, textStatus) 
					{
						console.log('CODE:8 please, try again..'+textStatus);
						return false; 
					}
				});
				console.log(request); 
			</script>
		</cfif>
	</cffunction>
	
	<cffunction name="add_Page_Warnings" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="action_page" type="string" required="no" default="">
		<cfargument name="warning_head" type="string" required="no" default="">
		<cfargument name="process_row_id" type="numeric" required="yes" default="0">
		<cfargument name="warning_description" type="string" required="no" default="">
		<cfargument name="warning_date" type="date" required="no" default="">
		<cfargument name="record_date" type="date" required="no" default="">
		<cfargument name="record_member" type="numeric" required="no" default="0">
		<cfargument name="position_code" type="numeric" required="no" default="0">
		<cfargument name="our_company_id" type="numeric" required="no" default="0">
		<cfargument name="period_id" type="numeric" required="no" default="0">
		<cfargument name="action_table" type="string" required="no" default="">
		<cfargument name="action_column" type="string" required="no" default="">
		<cfargument name="action_id" type="numeric" required="no" default="0">
		<cfargument name="action_stage" type="numeric" required="no" default="0">
		<cfargument name="is_confirm" type="string" required="no" default="">
		
		<cfquery name="add_Page_Warnings" datasource="#this.data_source#">
			INSERT INTO
				#process_db#PAGE_WARNINGS
			(
				URL_LINK,
				WARNING_HEAD,
				SETUP_WARNING_ID,
				WARNING_DESCRIPTION,
				SMS_WARNING_DATE,
				EMAIL_WARNING_DATE,
				LAST_RESPONSE_DATE,
				RECORD_DATE,
				IS_ACTIVE,
				IS_PARENT,
				RESPONSE_ID,
				RECORD_IP,
				<cfif module_type eq 'e'>RECORD_EMP<cfelseif module_type eq 'p'>RECORD_PAR<cfelseif module_type eq 'w'>RECORD_CON</cfif>,
				POSITION_CODE,
				WARNING_PROCESS,
				OUR_COMPANY_ID,
				PERIOD_ID,
				ACTION_TABLE,
				ACTION_COLUMN,
				ACTION_ID,
				ACTION_STAGE_ID,
				IS_CONFIRM
			)
		VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.action_page#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.warning_head#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_row_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(arguments.warning_description,1000)#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.warning_date#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.warning_date#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.warning_date#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.record_date#">,
				1,
				1,
				0,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.record_member#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#">,
				1,
				<cfif len(arguments.our_company_id)><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.our_company_id#"><cfelse>NULL</cfif>,
				<cfif len(arguments.period_id)><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.period_id#"><cfelse>NULL</cfif>,
				<cfif Len(arguments.action_table)><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.action_table#"><cfelse>NULL</cfif>,
				<cfif Len(arguments.action_column)><cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.action_column#"><cfelse>NULL</cfif>,
				<cfif Len(arguments.action_id)><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#"><cfelse>NULL</cfif>,
				<cfif Len(arguments.action_stage)><cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_stage#"><cfelse>NULL</cfif>,
				<cfif len(arguments.is_confirm)><cfqueryparam cfsqltype="cf_sql_smallint" value="#arguments.is_confirm#"><cfelse>NULL</cfif>
			)
		</cfquery>
		<cfquery name="Get_Max_Warnings" datasource="#this.data_source#">
			SELECT MAX(W_ID) MAX FROM #process_db#PAGE_WARNINGS
		</cfquery>
		<cfquery name="Upd_Warnings" datasource="#this.data_source#">
			UPDATE #process_db#PAGE_WARNINGS SET PARENT_ID = #Get_Max_Warnings.Max# WHERE W_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Max_Warnings.Max#">
		</cfquery>
		<cfreturn Get_Max_Warnings>
	</cffunction>
	
	<cffunction name="Upd_Page_Warnings" access="public" returntype="boolean">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="module_type" type="string" required="no" default="#this.module_type#">
		<cfargument name="our_company_id" type="numeric" required="no" default="0">
		<cfargument name="period_id" type="numeric" required="no" default="0">
		<cfargument name="action_table" type="string" required="no" default="">
		<cfargument name="action_column" type="string" required="no" default="">
		<cfargument name="action_id" type="numeric" required="no" default="0">

		<cfquery name="Upd_Page_Warnings" datasource="#this.data_source#">
			UPDATE
				#process_db#PAGE_WARNINGS
			SET
				IS_ACTIVE = 0
			WHERE
				<cfif len(arguments.our_company_id)>OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.our_company_id#"> AND</cfif>
				<cfif len(arguments.period_id)>PERIOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.period_id#"> AND</cfif>
				ACTION_TABLE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.action_table#"> AND
				ACTION_COLUMN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.action_column#"> AND
				ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
		</cfquery>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="get_Main_File" access="public" returntype="query">
		<cfargument name="process_db" type="string" required="no" default="#this.process_db#">
		<cfargument name="process_stage" type="numeric" required="yes" default="0">

		<cfquery name="get_Main_File" datasource="#this.data_source#">
			SELECT
				(SELECT PT.MAIN_FILE FROM #process_db#PROCESS_TYPE PT WHERE PT.PROCESS_ID = PTR.PROCESS_ID) MAIN_FILE,
				(SELECT PT.IS_MAIN_FILE FROM #process_db#PROCESS_TYPE PT WHERE PT.PROCESS_ID = PTR.PROCESS_ID) IS_MAIN_FILE,
				PTR.IS_ACTION
			FROM 
				#process_db#PROCESS_TYPE_ROWS PTR
			WHERE 
				PTR.PROCESS_ROW_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#">
		</cfquery>
		<cfreturn get_Main_File>
	</cffunction>
	<!--- //Query --->
</cfcomponent>

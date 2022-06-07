<!--- FBS 20120615 workcube_process ve workcube_process_info tagleri icin olusturulmustur --->
<cfcomponent>
	<cfset dsn = application.systemParam.systemParam().dsn>
	
	<cffunction name="get_Process_Cat_Emp_Cau" access="public" returntype="query">
		<cfargument name="process_cat" type="numeric" required="no" default="0">
	  <cfquery name="get_Process_Cat_Emp_Cau" datasource="#this.action_db_type#">
            SELECT
            	DISTINCT
                EP.POSITION_CODE,
                EP.EMPLOYEE_NAME,
                EP.EMPLOYEE_SURNAME,
                EP.POSITION_NAME
            FROM 
                #this.process_db3#SETUP_PROCESS_CAT_ROWS_CAUID SPCR,
                #this.process_db#EMPLOYEE_POSITIONS EP
            WHERE
                EP.POSITION_ID = SPCR.CAU_POSITION_CODE
                AND SPCR.PROCESS_CAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_cat#">
        </cfquery>
		<cfreturn get_Process_Cat_Emp_Cau>
	</cffunction>
	
	<cffunction name="get_Process_Cat_Name" access="public" returntype="query">
		<cfargument name="process_cat" type="numeric" required="no" default="0">
		 <cfquery name="get_Process_Cat_Name" datasource="#this.action_db_type#">
			SELECT PROCESS_CAT FROM #this.process_db3#SETUP_PROCESS_CAT SPC WHERE SPC.PROCESS_CAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_cat#">
		</cfquery>
		<cfreturn get_Process_Cat_Name>
	</cffunction>
		
	<cffunction name="get_User_Process_Cat" access="public" returntype="query">
		<cfargument name="position_code" type="numeric" required="no" default="0">
		<cfargument name="module_id" type="string" required="no" default="">
		<cfargument name="process_type_info" type="string" required="no" default="">
		<cfargument name="fuseaction" type="string" required="no" default="">
		<cfargument name="is_check_all_control" type="numeric" required="no" default="0">
		 <cfquery name="get_User_Process_Cat" datasource="#this.action_db_type#">
			SELECT
				DISTINCT
				SPC.PROCESS_CAT_ID,
				SPC.PROCESS_CAT,
				SPC.PROCESS_TYPE,
				SPC.IS_ACCOUNT,
				SPC.IS_ZERO_STOCK_CONTROL,
				SPC.IS_DEFAULT,
				SPC.IS_PROJECT_BASED_ACC,
				SPC.IS_DEPT_BASED_ACC,
				SPC.DISPLAY_FILE_NAME,
				SPC.DISPLAY_FILE_FROM_TEMPLATE,
				SPC.IS_ADD_INVENTORY,
                SPC.IS_LOT_NO,
                SPC.MULTI_TYPE
			FROM
				#this.process_db3#SETUP_PROCESS_CAT_ROWS AS SPCR,
				#this.process_db3#SETUP_PROCESS_CAT_FUSENAME AS SPCF,
				#this.process_db#EMPLOYEE_POSITIONS AS EP,
				#this.process_db3#SETUP_PROCESS_CAT SPC
			WHERE
				SPC.PROCESS_CAT_ID = SPCR.PROCESS_CAT_ID AND
				SPC.PROCESS_CAT_ID = SPCF.PROCESS_CAT_ID AND
				<cfif Len(arguments.module_id)>	
					SPC.PROCESS_MODULE IN (#arguments.module_id#) AND
				</cfif>
				EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_code#"> AND
				(
					SPCR.POSITION_CODE = EP.POSITION_CODE OR
					SPCR.POSITION_CAT_ID = EP.POSITION_CAT_ID
				) AND
				<cfif arguments.is_check_all_control eq 1>
					SPC.PROCESS_TYPE IN (#arguments.process_type_info#) AND
					','+SPCF.FUSE_NAME+',' LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%,#arguments.fuseaction#,%">
				<cfelseif Len(arguments.process_type_info)>
					SPC.PROCESS_TYPE IN (#arguments.process_type_info#) 
				<cfelse>
					','+SPCF.FUSE_NAME+',' LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%,#arguments.fuseaction#,%">
				</cfif>
				ORDER BY
					SPC.PROCESS_CAT
		</cfquery>
		<cfreturn get_User_Process_Cat>
	</cffunction>
	
	<cffunction name="get_Old_Process_Cat" access="public" returntype="query">
		<cfargument name="process_cat" type="numeric" required="no" default="0">
		 <cfquery name="get_Old_Process_Cat" dbtype="query">
			SELECT PROCESS_CAT_ID, PROCESS_TYPE, MULTI_TYPE FROM get_User_Process_Cat WHERE PROCESS_CAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_cat#">
		</cfquery>
		<cfreturn get_Old_Process_Cat>
	</cffunction>
	
	<cffunction name="get_Check_Process_Cat_Id" access="public" returntype="query">
		<cfargument name="process_cat" type="numeric" required="no" default="0">
		<cfargument name="module_id" type="string" required="no" default="">
		<cfquery name="get_Check_Process_Cat_Id" datasource="#this.action_db_type#">
			SELECT PROCESS_CAT_ID FROM #this.process_db3#SETUP_PROCESS_CAT WHERE PROCESS_CAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_cat#">  AND PROCESS_MODULE IN (#arguments.module_id#)
		</cfquery>
		<cfreturn get_Check_Process_Cat_Id>
	</cffunction>
	
</cfcomponent>

<cfcomponent>
	<cfset dsn = application.systemParam.params().dsn>
    
    <!--- Genel --->
    <cffunction name="GET_COMPONENTS" access="remote" returntype="query">
        <cfquery name="GET_COMPONENTS" datasource="#DSN#">
            SELECT
                BC.PATH,
                BP.PAGE_HEAD
            FROM
            	B2B2C_SITES AS BS
                LEFT JOIN B2B2C_PAGES AS BP ON BS.SITE_ID = BP.SITE_ID
                LEFT JOIN B2B2C_COMPONENTS AS BC ON BP.PAGE_ID = BC.PAGE_ID
            WHERE
                BP.PAGE_FRIENDLY_URL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pageInfo#">
                AND BS.SITE_NAME =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.HTTP_HOST#">
        </cfquery>
        <cfreturn GET_COMPONENTS>
    </cffunction>
    <cffunction name="GET_ASSET_CAT" access="remote" returntype="query">
        <cfquery name="GET_ASSET_CAT" datasource="#DSN#">
            SELECT 
                ASSETCAT_ID,
                ASSETCAT
            FROM 
                ASSET_CAT
        </cfquery>
        <cfreturn GET_ASSET_CAT>
    </cffunction>
    <cffunction name="GET_CONTENT_PROPERTY" access="remote" returntype="query">
        <cfquery name="GET_CONTENT_PROPERTY" datasource="#dsn#">
            SELECT 
                CONTENT_PROPERTY_ID,
                NAME
            FROM 
                CONTENT_PROPERTY
            ORDER BY
                NAME
        </cfquery>
       <cfreturn GET_CONTENT_PROPERTY>
    </cffunction>
    <cffunction name="GET_APPCAT_SUB" access="remote" returntype="any" returnFormat="json">
        <cfquery name="GET_APPCAT_SUB" datasource="#DSN#">
            SELECT 
                SERVICE_SUB_CAT_ID,
                SERVICE_SUB_CAT
            FROM 
                G_SERVICE_APPCAT_SUB
            WHERE 
                ','+OUR_COMPANY_ID+',' LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%,#session.pp.our_company_id#,%"> AND
                SERVICECAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments['data']#">
        </cfquery>
        <cfreturn Replace(SerializeJSON(GET_APPCAT_SUB),'//','')>
    </cffunction>
    <cffunction name="GET_APPCAT_SUB_TREE" access="remote" returntype="any" returnFormat="json">
        <cfquery name="GET_APPCAT_SUB_TREE" datasource="#DSN#">
            SELECT 
            	SERVICE_SUB_STATUS_ID,                
                SERVICE_SUB_STATUS 
			FROM 
            	G_SERVICE_APPCAT_SUB_STATUS
			WHERE
                SERVICE_SUB_CAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments['data']#">
        </cfquery>
        <cfreturn Replace(SerializeJSON(GET_APPCAT_SUB_TREE),'//','')>
    </cffunction>
    <cffunction name="GET_ONLINE_USERS" access="remote" returntype="query">
		<cfquery name="GET_ONLINE_USERS" datasource="#DSN#">
            SELECT 
                WS.NAME + ' ' + WS.SURNAME AS EMPLOYEE,
                E.PHOTO
            FROM 
                WRK_SESSION AS WS
                LEFT JOIN EMPLOYEES AS E ON WS.USERID = E.EMPLOYEE_ID
                LEFT JOIN WORKGROUP_EMP_PAR AS WEP ON WS.USERID = WEP.EMPLOYEE_ID
            WHERE 
                WEP.PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
        </cfquery>
        <cfreturn GET_ONLINE_USERS>
    </cffunction>
	<cffunction name="GET_CURRENCY" access="remote" returntype="query">
        <cfquery name="GET_CURRENCY" datasource="#DSN#">
            SELECT
                PTR.STAGE,
                PTR.PROCESS_ROW_ID 
            FROM
                PROCESS_TYPE_ROWS PTR
                LEFT JOIN PROCESS_TYPE AS PT ON PT.PROCESS_ID = PTR.PROCESS_ID
                LEFT JOIN PROCESS_TYPE_OUR_COMPANY AS PTO ON PT.PROCESS_ID = PTO.PROCESS_ID
            WHERE
                PT.IS_ACTIVE = 1 AND
                PTO.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.our_company_id#"> AND
                PT.FACTION LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.fuse#%">
            ORDER BY
                PTR.LINE_NUMBER
        </cfquery>
        <cfreturn GET_CURRENCY>
    </cffunction>
    <cffunction name="GET_PROJECTS_AUTH" access="remote" returntype="string">
        <cfquery name="get_query_projects" datasource="#dsn#">
            SELECT
                DISTINCT(PP.PROJECT_ID)
            FROM
                WORK_GROUP AS WG
                LEFT JOIN WORKGROUP_EMP_PAR AS WEP ON WG.WORKGROUP_ID = WEP.WORKGROUP_ID,
                PRO_PROJECTS AS PP
            WHERE
                (
                    PP.PROJECT_ID = WG.PROJECT_ID OR 
                    WG.PROJECT_ID IS NULL 
                ) AND (
                PP.OUTSRC_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                PP.OUTSRC_CMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#"> OR
                PP.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#"> OR
                PP.UPDATE_PAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                PP.RECORD_PAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                WEP.PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                WEP.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">)
        </cfquery>
        <cfset arguments.project_id = valuelist(get_query_projects.project_id)>
        <cfreturn arguments.project_id>
    </cffunction>
	<cffunction name="GETNOTES" access="remote" returntype="query">
        <cfquery name="GETNOTES" datasource="#DSN#">
            SELECT
                N.ACTION_ID,
                N.NOTE_ID,
                'comment' AS HEAD,
                N.NOTE_BODY AS BODY,
                N.RECORD_DATE,
                N.RECORD_EMP,
                N.COMPANY_ID,
                N.PERIOD_ID,
                E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                E.PHOTO,
                CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS COMPANY_PARTNER
            FROM
                NOTES AS N
                LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = N.RECORD_EMP
                LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = N.RECORD_PAR
            WHERE
                N.ACTION_SECTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.action_section)#">
                AND N.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
				<cfif isdefined("arguments.company_id") and len(arguments.company_id)>
                    AND N.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">
                </cfif>
				<cfif isDefined('arguments.period_id') and len(arguments.period_id)>
                    AND N.PERIOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.period_id#">
                 </cfif>
            ORDER BY
                N.RECORD_DATE
        </cfquery>
        <cfreturn GETNOTES>
    </cffunction>
    <cffunction name="SAVENOTES" returntype="any" returnformat="json" access="remote">
        <cfquery name="SAVENOTES" datasource="#DSN#" result="MAXID">
            INSERT INTO
            	NOTES
            (
            	ACTION_SECTION,
                ACTION_ID,
                NOTE_HEAD,
                NOTE_BODY,
                RECORD_DATE,
                <cfif isdefined("session.pp.our_company_id")>
                	COMPANY_ID,
                    RECORD_PAR
                <cfelse>
               		COMPANY_ID,
                    RECORD_EMP
                </cfif>
            )
            VALUES
            (
            	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.actionSection#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.actionId#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.noteHead#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.noteBody#">,
                #now()#,
                <cfif isdefined("session.pp.our_company_id")>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">
                <cfelse>
               		<cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.company_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.userid#">
                </cfif>
            )
        </cfquery>
        <cfif listlen(arguments.fileSystemNameList)>
        	<cfloop from="1" to="#listlen(arguments.fileSystemNameList)#" index="ind">
            	<cfquery name="INSERT_ASSET" datasource="#DSN#">
                	INSERT INTO ASSET
                    	(
                        	MODULE_NAME,
                            IS_ACTIVE,
                            ACTION_ID,
                            ACTION_SECTION,
                            RECORD_DATE,
                            ASSET_NAME,
                            ASSET_FILE_NAME,
                            RECORD_PAR,
                            ASSETCAT_ID,
                            PROPERTY_ID,
                            ASSET_DESCRIPTION,
                            ASSET_DETAIL
                        )
                    VALUES
                    	(
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="note">,
                            1,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#MAXID.identityCol#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.actionSection#">,
                            #now()#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#listGetAt(arguments.fileRealNameList,ind,',')#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#listGetAt(arguments.fileSystemNameList,ind,',')#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.assetCatId#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.propertyId#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.assetDescription#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.assetDetail#">
                        )
                </cfquery>
            </cfloop>
        </cfif>
        <cfquery name="GET_DATA" datasource="#DSN#">
        	SELECT
            	N.ACTION_ID,
                N.NOTE_ID,
                'comment' AS HEAD,
                N.NOTE_BODY AS BODY,
                CONVERT(VARCHAR(5),DATEADD(hh,#session.pp.time_zone#,N.RECORD_DATE),108) + ' - ' + CONVERT(VARCHAR(10),N.RECORD_DATE,105) AS RECORD_DATE,
                N.RECORD_EMP,
                N.COMPANY_ID,
                N.PERIOD_ID,
                CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS COMPANY_PARTNER,
                STUFF(REPLACE((SELECT '##!' + LTRIM(RTRIM(A.ASSET_NAME)) AS 'data()' FROM ASSET AS A WHERE N.NOTE_ID = A.ACTION_ID AND A.ACTION_SECTION = 'NOTE' FOR XML PATH('')),' ##!',', '), 1, 2, '') AS DOCUMENTS,
				STUFF(REPLACE((SELECT '##!' + LTRIM(RTRIM(A.ASSET_FILE_NAME)) AS 'data()' FROM ASSET AS A WHERE N.NOTE_ID = A.ACTION_ID AND A.ACTION_SECTION = 'NOTE' FOR XML PATH('')),' ##!',', '), 1, 2, '') AS DOCUMENTS_PATH
           	FROM
            	NOTES AS N
                LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = N.RECORD_PAR
			WHERE
            	N.NOTE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#MAXID.identityCol#">
        </cfquery>
        <cfreturn Replace(SerializeJSON(GET_DATA),'//','')>
    </cffunction>
	<cffunction name="GETDOCUMENTS" access="remote" returntype="query">
        <cfquery name="GETDOCUMENTS" datasource="#DSN#">
            SELECT
                A.ASSET_NAME,
                'notes/'+A.ASSET_FILE_NAME AS PATH
            FROM
                ASSET AS A
            WHERE
                A.ACTION_SECTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.action_section)#">
                AND A.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
            ORDER BY
                A.RECORD_DATE
        </cfquery>
        <cfreturn GETDOCUMENTS>
    </cffunction>
	<cffunction name="GET_FILE_UPLOAD" access="remote" returntype="any" returnFormat="json">
    	<cfset uploadFolder = application.systemParam.params().uploadFolder>
        <cfset arguments.files = []>
        <cffile action="uploadAll" source="#arguments[1]#" destination="#uploadFolder#\notes\">
        <cfloop from="1" to="#arrayLen(cffile.uploadall_results)#" index="i">  
              <cfset file = cffile.uploadall_results[i]>  
              <cfset arguments.files[i]['fileName'] = file['UPLOADALL_RESULTS'][i]['SERVERFILENAME']>
              <cfset arguments.files[i]['ext'] = file['UPLOADALL_RESULTS'][i]['SERVERFILEEXT']>
              <cfset arguments.files[i]['systemName'] = createUUID()&'.'&arguments.files[i]['ext']>
              <cffile action="rename" source="#file['UPLOADALL_RESULTS'][i]['SERVERDIRECTORY']#\#file['UPLOADALL_RESULTS'][i]['SERVERFILE']#" destination="#file['UPLOADALL_RESULTS'][i]['SERVERDIRECTORY']#\#arguments.files[i]['systemName']#">
         </cfloop>
        <cfreturn Replace(SerializeJSON(arguments.files),'//','')>
    </cffunction>
    <cffunction name="getCallCenterDashboard" access="remote" returntype="struct">
	
        <cfquery name="GetProjects" datasource="#dsn#">
          select  * from PRO_PROJECTS where PROJECT_STATUS=1 and COMPANY_ID =#session.pp.company_id#
          
        </cfquery>
        <cfset arguments.project_id = valuelist(GetProjects.project_id)>
        <cfquery name="getCallCenterDashboardAll" datasource="#DSN#">
            SELECT
                ISNULL(COUNT(SERVICE_ID),0) AS COUNT
            FROM 
                G_SERVICE AS GS
            WHERE
                GS.SERVICE_COMPANY_ID IN (#session.pp.company_id#)
		</cfquery>
        <cfquery name="getCallCenterDashboardOpen" datasource="#DSN#">
            SELECT
                ISNULL(COUNT(SERVICE_ID),0) AS COUNT
            FROM 
                G_SERVICE AS GS
            WHERE
                GS.SERVICE_COMPANY_ID IN (#session.pp.company_id#)
                AND GS.SERVICE_STATUS_ID IN (10)
		</cfquery>
        <cfquery name="getWorkAll" datasource="#DSN#">
            SELECT
                ISNULL(COUNT(WORK_ID),0) AS COUNT
            FROM 
                PRO_WORKS AS PW
            WHERE
                PW.PROJECT_ID IN (#arguments.project_id#)
		</cfquery>
        <cfquery name="getWorkOpen" datasource="#DSN#">
            SELECT
                ISNULL(COUNT(WORK_ID),0) AS COUNT
            FROM 
                PRO_WORKS AS PW
            WHERE
                  PW.PROJECT_ID IN (#arguments.project_id#)
                AND WORK_CURRENCY_ID IN (26,90,91,92,94,111) 
		</cfquery>
        <cfscript>
        // WORK_CURRENCY_ID IN (26,90,91,92,94,111) 
			data 					= StructNew();
			data['callCenterAll'] 	= getCallCenterDashboardAll.COUNT;
			data['callCenterOpen'] 	= getCallCenterDashboardOpen.COUNT;
			data['project']	 		= listlen(arguments.project_id);
			data['workAll']	 		= getWorkAll.COUNT;
			data['workOpen'] 		= getWorkOpen.COUNT;
		</cfscript>

        <cfloop from="1" to="#listLen(arguments.project_id,',')#" index="ind">
            <cfquery name="getWorkSubAll" datasource="#DSN#">
                SELECT
                    COUNT(WORK_ID) AS COUNT,
                    PP.PROJECT_HEAD
                FROM
                	PRO_PROJECTS AS PP
                    LEFT JOIN PRO_WORKS AS PW ON PW.PROJECT_ID = PP.PROJECT_ID
                WHERE
                    PP.PROJECT_ID = #listGetAt(arguments.project_id,ind,',')#
                GROUP BY
                	PROJECT_HEAD
            </cfquery>
            <cfquery name="getWorkSubOpen" datasource="#DSN#">
                SELECT
                    ISNULL(COUNT(WORK_ID),0) AS COUNT
                FROM 
                    PRO_WORKS AS PW
                WHERE
                    PW.PROJECT_ID = #listGetAt(arguments.project_id,ind,',')#
                    AND WORK_CURRENCY_ID IN (26,90,91,92,94,111) 
            </cfquery>
            <cfscript>
				data['works'][listGetAt(arguments.project_id,ind,',')]['projectHead'] 	= getWorkSubAll.PROJECT_HEAD;
				data['works'][listGetAt(arguments.project_id,ind,',')]['all']		 	= getWorkSubAll.COUNT;
				data['works'][listGetAt(arguments.project_id,ind,',')]['open']		 	= getWorkSubOpen.COUNT;
			</cfscript>
        </cfloop>
        <cfreturn data>
    </cffunction>
    
    <!--- Genel --->
    
    <!--- Proje --->
	<cffunction name="projects" access="remote" returntype="query">
        <cfquery name="GET_PROJECTS" datasource="#DSN#">
            SELECT 
                DISTINCT(PP.PROJECT_ID),
                PP.PROJECT_HEAD,
                PP.CONSUMER_ID,
                PP.COMPANY_ID,
                PP.PARTNER_ID,
                PP.PROJECT_EMP_ID,
                PP.PRO_PRIORITY_ID,
                PP.PROCESS_CAT,
                PP.PROJECT_NUMBER,
                PP.WORKGROUP_ID,
                PP.OUTSRC_PARTNER_ID,
                PP.TARGET_FINISH,
                PP.TARGET_START,
                PP.PRO_CURRENCY_ID,
                SP.COLOR,
                SP.PRIORITY,
                EMPLOYEE_NAME +' '+ EMPLOYEE_SURNAME AS PRO_EMPLOYEE,
                PTR.STAGE,
                C.FULLNAME
            FROM 
                WORK_GROUP WG
                LEFT JOIN WORKGROUP_EMP_PAR AS WEP ON WG.WORKGROUP_ID = WEP.WORKGROUP_ID,
                PRO_PROJECTS PP
                LEFT JOIN SETUP_PRIORITY AS SP ON PP.PRO_PRIORITY_ID = SP.PRIORITY_ID
                LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = PP.PROJECT_EMP_ID
                LEFT JOIN PROCESS_TYPE_ROWS AS PTR ON PP.PRO_CURRENCY_ID = PTR.PROCESS_ROW_ID
                LEFT JOIN COMPANY AS C ON C.COMPANY_ID = PP.COMPANY_ID
                <cfif isdefined("arguments.keyword") and len(arguments.keyword)>
                    ,PRO_HISTORY
                </cfif>
            WHERE
                (	
                    PP.PROJECT_ID = WG.PROJECT_ID OR 
                    WG.PROJECT_ID IS NULL 
                )
               AND
                (	
                    PP.OUTSRC_PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                    PP.OUTSRC_CMP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#"> OR
                    PP.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#"> OR
                    PP.UPDATE_PAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                    PP.RECORD_PAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                    WEP.PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#"> OR
                    WEP.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">
                )
                <cfif len(arguments.keyword) gt 1>
                    AND PP.PROJECT_ID=PRO_HISTORY.PROJECT_ID
                    AND (
                            PP.PROJECT_HEAD LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"> OR
                            PP.PROJECT_DETAIL LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%">
                        )
                <cfelseif len(arguments.keyword) eq 1>
                    AND PP.PROJECT_ID = PRO_HISTORY.PROJECT_ID
                    AND PP.PROJECT_HEAD LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%">
                </cfif>
                <cfif len(arguments.currency)>
                    AND PP.PRO_CURRENCY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currency#">
                </cfif>
                <cfif len(arguments.priority_cat)>
                    AND PP.PRO_PRIORITY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.priority_cat#"> 
                </cfif>
                <cfif arguments.project_status eq "1">
                    AND PP.PROJECT_STATUS = 1
                <cfelseif arguments.project_status eq "-1">
                    AND PP.PROJECT_STATUS = 0 
                <cfelseif arguments.project_status eq "0">
                    AND (PP.PROJECT_STATUS = 0 OR PP.PROJECT_STATUS=1)
                <cfelse><!--- default secim --->
                    AND PP.PROJECT_STATUS=1
                </cfif>
        </cfquery>
        <cfreturn GET_PROJECTS>
    </cffunction>
    <cffunction name="PROJECT_DETAIL" access="remote" returntype="query">
        <cfquery name="PROJECT_DETAIL" datasource="#DSN#">
            SELECT 
                p.*,
                (
                    (
                        SELECT
                            SUM(ISNULL(TO_COMPLETE,0))
                        FROM
                            PRO_WORKS PW
                        WHERE
                            PW.PROJECT_ID = P.PROJECT_ID
                    )/
                    (
                        SELECT
                            COUNT(WORK_ID)
                        FROM
                            PRO_WORKS PW2
                        WHERE
                            PW2.PROJECT_ID = P.PROJECT_ID
                    )
                ) COMPLETE_RATE,
                CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS COMPANY_PARTNER,
                C.CONSUMER_NAME + ' ' + CONSUMER_SURNAME AS CONSUMER,
                C2.FULLNAME,             
                E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                CP2.COMPANY_PARTNER_NAME + ' ' + CP2.COMPANY_PARTNER_SURNAME AS COMPANY_PARTNER2,
                PTR.STAGE,
                SP.PRIORITY,
                P2.PROJECT_HEAD AS PROJECT_HEAD2,
                E2.EMPLOYEE_NAME + ' ' + E2.EMPLOYEE_SURNAME AS RECORD_EMPLOYEE,
                E3.EMPLOYEE_NAME + ' ' + E3.EMPLOYEE_SURNAME AS UPDATE_EMPLOYEE
            FROM
                PRO_PROJECTS AS P
                LEFT JOIN SETUP_MONEY AS SM ON P.BUDGET_CURRENCY = SM.MONEY
                LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = P.PARTNER_ID
                LEFT JOIN CONSUMER AS C ON C.CONSUMER_ID = P.CONSUMER_ID
                LEFT JOIN COMPANY AS C2 ON C2.COMPANY_ID = P.COMPANY_ID
                LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = P.PROJECT_EMP_ID
                LEFT JOIN COMPANY_PARTNER AS CP2 ON P.OUTSRC_PARTNER_ID = CP2.PARTNER_ID
                LEFT JOIN PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID = P.PRO_CURRENCY_ID 
                LEFT JOIN SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = P.PRO_PRIORITY_ID     
                LEFT JOIN PRO_PROJECTS AS P2 ON P2.PROJECT_ID = P.RELATED_PROJECT_ID
                LEFT JOIN EMPLOYEES AS E2 ON E2.EMPLOYEE_ID = P.RECORD_EMP
                LEFT JOIN EMPLOYEES AS E3 ON E3.EMPLOYEE_ID = P.UPDATE_EMP                                       
            WHERE
                <cfif isDefined('session.pp.userid')>
                    SM.PERIOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.period_id#"> AND   
                </cfif>
                <cfif isDefined('arguments.project_id')>
                    P.PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
                <cfelseif isDefined('arguments.id')>
                    P.PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">        
                </cfif>
            ORDER BY 
                P.RECORD_DATE
        </cfquery>
        <cfreturn PROJECT_DETAIL>
    </cffunction>
    <cffunction name="GET_PRIORITY" access="remote" returntype="query">
        <cfquery name="GET_CATS" datasource="#DSN#">
            SELECT PRIORITY_ID, PRIORITY FROM SETUP_PRIORITY
        </cfquery>
        <cfreturn GET_CATS>
    </cffunction>
    <cffunction name="GET_EMPS" access="remote" returntype="any">
		<cfquery name="GET_PROJECT_WORKGROUP" datasource="#DSN#" maxrows="1">
            SELECT WORKGROUP_ID FROM WORK_GROUP WHERE PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
        </cfquery>
        <cfif GET_PROJECT_WORKGROUP.recordcount>
            <cfquery name="GET_EMPS" datasource="#DSN#">
                SELECT 
                    EP.EMPLOYEE_NAME + ' ' + EP.EMPLOYEE_SURNAME AS EMPLOYEE,
                    SPR.PROJECT_ROLES,
                    E.PHOTO
                 FROM 
                    EMPLOYEE_POSITIONS AS EP
                    LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = EP.EMPLOYEE_ID
                    LEFT JOIN WORKGROUP_EMP_PAR AS W ON W.EMPLOYEE_ID = EP.EMPLOYEE_ID
                    LEFT JOIN SETUP_PROJECT_ROLES AS SPR ON SPR.PROJECT_ROLES_ID = W.ROLE_ID
                 WHERE 
                    EP.POSITION_STATUS = 1 AND
                    W.WORKGROUP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_project_workgroup.workgroup_id#">
            </cfquery>
		<cfelse>
        	<cfset GET_EMPS = QueryNew('EMPLOYEE')>
        </cfif>
        <cfreturn GET_EMPS>
    </cffunction>
    <cffunction name="GET_PARS" access="remote" returntype="query">
		<cfquery name="GET_PROJECT_WORKGROUP" datasource="#DSN#" maxrows="1">
            SELECT WORKGROUP_ID FROM WORK_GROUP WHERE PROJECT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
        </cfquery>
        <cfif GET_PROJECT_WORKGROUP.recordcount>
            <cfquery name="GET_PARS" datasource="#DSN#">
                SELECT 
                    CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS PARTNER,
                    SPR.PROJECT_ROLES
                FROM 
                    COMPANY_PARTNER AS CP
                    LEFT JOIN WORKGROUP_EMP_PAR AS W ON W.PARTNER_ID = CP.PARTNER_ID
                    LEFT JOIN SETUP_PROJECT_ROLES AS SPR ON SPR.PROJECT_ROLES_ID = W.ROLE_ID
                 WHERE 
                    CP.COMPANY_PARTNER_STATUS = 1 AND
                    W.WORKGROUP_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_project_workgroup.workgroup_id#">
            </cfquery>
		<cfelse>
        	<cfset GET_PARS = QueryNew('PARTNER')>
        </cfif>
        <cfreturn GET_PARS>
    </cffunction>
    <cffunction name="GET_ASSET" access="remote" returntype="query">
		<cfquery name="GET_ASSET" datasource="#DSN#">
            SELECT
                A.ASSET_FILE_NAME,
                A.ASSET_NAME,
                CP.NAME
            FROM
                ASSET A
                LEFT JOIN CONTENT_PROPERTY AS CP ON A.PROPERTY_ID = CP.CONTENT_PROPERTY_ID
                LEFT JOIN ASSET_SITE_DOMAIN AS ASD ON ASD.ASSET_ID = A.ASSET_ID
            WHERE
                A.ACTION_SECTION = 'PROJECT_ID' AND
                A.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
            ORDER BY 
                A.RECORD_DATE DESC
        </cfquery>
        <cfreturn GET_ASSET>
    </cffunction>
    <cffunction name="UpdCallStatus" access="remote" returntype="any">
		<cfquery name="GET_ASSET" datasource="#DSN#">
           update w3Partner.G_SERVICE set SERVICE_STATUS_ID=10 ,UPDATE_MEMBER=1 where SERVICE_ID=  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">
        </cfquery>
        <cfreturn "A">
    </cffunction>
    <cffunction name="GET_RELATED_EVENTS" access="remote" returntype="query">
		<cfquery name="GET_RELATED_EVENTS" datasource="#DSN#">
            SELECT
                ER.*,
                E.STARTDATE,
                E.EVENT_HEAD
            FROM
                EVENTS_RELATED ER
                LEFT JOIN EVENT AS E ON ER.EVENT_ID = E.EVENT_ID
            WHERE
                ER.ACTION_SECTION = 'PROJECT_ID' AND
                ER.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
                <cfif isdefined("arguments.company_id") and len(arguments.company_id)>
                    AND ER.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.company_id#">
                </cfif>	
            ORDER BY 
                E.STARTDATE DESC
        </cfquery>
        <cfreturn GET_RELATED_EVENTS>
    </cffunction>
    <cffunction name="GET_RELATED_DOCUMENTS" access="remote" returntype="query">
		<cfquery name="GET_RELATED_DOCUMENTS" datasource="#DSN#">
            SELECT
                A.ASSET_NAME
            FROM
                ASSET AS A
            WHERE
                A.ACTION_SECTION = 'PROJECT_ID' AND
                ER.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
                <cfif isdefined("arguments.company_id") and len(arguments.company_id)>
                    AND ER.COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.company_id#">
                </cfif>	
            ORDER BY 
                E.STARTDATE DESC
        </cfquery>
        <cfreturn GET_RELATED_DOCUMENTS>
    </cffunction> 
    <cffunction name="GET_CONTENT_RELATION" access="remote" returntype="query">
		<cfquery name="GET_CONTENT_RELATION" datasource="#DSN#">
            SELECT 
                C.CONTENT_ID,
                C.CONT_HEAD,
                C.USER_FRIENDLY_URL,
                C.CONTENT_PROPERTY_ID
            FROM 
                CONTENT_RELATION CR
                LEFT JOIN CONTENT AS C ON CR.CONTENT_ID = C.CONTENT_ID
            WHERE 
                C.CONTENT_STATUS = 1 AND
                C.STAGE_ID = 1 AND 
                CR.ACTION_TYPE = 'PROJECT_ID' AND
                CR.ACTION_TYPE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project_id#">
        </cfquery>
        <cfreturn GET_CONTENT_RELATION>
    </cffunction>
	<cffunction name="GET_PRO_WORK" access="remote" returntype="query">
        <cfquery name="getProj" datasource="#dsn#">
    SELECT * FROM w3Partner.WORK_GROUP WHERE WORKGROUP_ID IN (SELECT WORKGROUP_ID FROM w3Partner.WORKGROUP_EMP_PAR WHERE PARTNER_ID=#session.pp.userid#)
    </cfquery>
    <cfset projlist=0>
    <cfif getProj.recordcount>
    <cfset projlist=valueList(getProj.PROJECT_ID)>
    </cfif>
        <cfquery name="GET_PRO_WORK" datasource="#DSN#">
            SELECT
                WORK_ID,
                TYPE,
                MILESTONE_WORK_ID,
                COLOR,
                WORK_HEAD,
                PROJECT_ID,
                EMPLOYEE,
                WORK_PRIORITY_ID,
                PRIORITY,
                STAGE,
                TO_COMPLETE,
                TARGET_FINISH,
                TARGET_START
            FROM
            (
                SELECT
                    CASE 
                        WHEN IS_MILESTONE = 1 THEN WORK_ID
                        WHEN IS_MILESTONE <> 1 THEN ISNULL(MILESTONE_WORK_ID,0)
                    END AS NEW_WORK_ID,
                    CASE 
                        WHEN IS_MILESTONE = 1 THEN 0
                        WHEN IS_MILESTONE <> 1 THEN 1
                    END AS TYPE,
                    PW.IS_MILESTONE,
                    PW.MILESTONE_WORK_ID,
                    PW.WORK_ID,
                    PW.WORK_HEAD,
                    PW.PROJECT_ID,
                    PW.ESTIMATED_TIME,
                    (SELECT PTR.STAGE FROM PROCESS_TYPE_ROWS PTR WHERE PTR.PROCESS_ROW_ID= PW.WORK_CURRENCY_ID) STAGE,
                    PW.WORK_PRIORITY_ID,
                    CASE 
                        WHEN PW.PROJECT_EMP_ID IS NOT NULL THEN (SELECT E.EMPLOYEE_NAME +' '+ E.EMPLOYEE_SURNAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = PW.PROJECT_EMP_ID)
                        WHEN PW.OUTSRC_PARTNER_ID IS NOT NULL THEN (SELECT C2.NICKNAME+' - '+ CP2.COMPANY_PARTNER_NAME + ' ' + CP2.COMPANY_PARTNER_SURNAME NAME FROM COMPANY_PARTNER CP2,COMPANY C2 WHERE C2.COMPANY_ID = CP2.COMPANY_ID AND CP2.PARTNER_ID = PW.OUTSRC_PARTNER_ID)
                    END AS EMPLOYEE,
                    PW.TARGET_FINISH,
                    PW.TARGET_START,
                    PW.REAL_FINISH,
                    PW.REAL_START,
                    PW.TO_COMPLETE,
                    PW.UPDATE_DATE,
                    PW.RECORD_DATE,
                    SP.PRIORITY,
                    SP.COLOR,
                    (SELECT PRO_MATERIAL.PRO_MATERIAL_ID FROM PRO_MATERIAL WHERE PRO_MATERIAL.WORK_ID = PW.WORK_ID) PRO_MATERIAL_ID
                FROM
                    PRO_WORKS AS PW
                    LEFT JOIN SETUP_PRIORITY AS SP ON PW.WORK_PRIORITY_ID = SP.PRIORITY_ID
                WHERE
                    PW.PROJECT_ID IN (
                       #projlist#
                       )
                    <cfif len(arguments.keyword)>
                        AND 
                        (
                            <cfif isNumeric(arguments.keyword)>
                                PW.WORK_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.keyword#"> OR 
                            </cfif>
                            PW.WORK_HEAD LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%">
                        )
                    </cfif>
                    <cfif len(arguments.priority_cat)>
                        AND PW.WORK_PRIORITY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.priority_cat#">
                    </cfif>
                    <cfif len(arguments.currency)>
                        AND PW.WORK_CURRENCY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currency#">
                    </cfif>
                    <cfif isDefined('arguments.service_id') and len(arguments.service_id)>
                        AND PW.SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">
                    </cfif>
                    <cfif isDefined('arguments.subscription_id') and len(arguments.subscription_id)>
                        AND PW.SUBSCRIPTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.subscription_id#">
                    </cfif>
                    <cfif arguments.work_status eq -1>
                        AND PW.WORK_STATUS = 0<!---  OR PW.IS_MILESTONE = 1 --->
                    <cfelseif arguments.work_status eq 1>
                        AND PW.WORK_STATUS = 1 <!--- OR PW.IS_MILESTONE = 1 --->
                    </cfif>
                    
            )T1
            WHERE
                1=1 
                <cfif arguments.work_milestones eq 0>
                    AND IS_MILESTONE <> 1
                </cfif>
            ORDER BY
                <cfif isdefined("arguments.ordertype") and arguments.ordertype eq 2>
                    ISNULL(UPDATE_DATE,RECORD_DATE) DESC
                <cfelseif isdefined("arguments.ordertype") and arguments.ordertype eq 3>
                    TARGET_START DESC
                <cfelseif isdefined("arguments.ordertype") and arguments.ordertype eq 4>
                    TARGET_START
                <cfelseif isdefined("arguments.ordertype") and arguments.ordertype eq 5>
                    TARGET_FINISH DESC
                <cfelseif isdefined("arguments.ordertype") and arguments.ordertype eq 6>
                    TARGET_FINISH
                <cfelseif isdefined("arguments.ordertype") and arguments.ordertype eq 7>
                    WORK_HEAD
                <cfelse>
                    WORK_ID DESC
                </cfif>
        </cfquery>
        <cfreturn GET_PRO_WORK>
	</cffunction>
    <!--- Proje --->
    
    <!--- CallCenter --->
    <cffunction name="GET_SERVICE_APPCAT" access="remote" returntype="query">
        <cfquery name="GET_SERVICE_APPCAT" datasource="#DSN#">
            SELECT 
                SERVICECAT_ID,
                SERVICECAT 
            FROM 
                G_SERVICE_APPCAT 
            WHERE 
                IS_INTERNET = 1 AND 
                IS_STATUS = 1 AND 
                ','+OUR_COMPANY_ID+',' LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%,#session.pp.our_company_id#,%"> 
            ORDER BY 
                SERVICECAT 
        </cfquery>
        <cfreturn GET_SERVICE_APPCAT>
    </cffunction>
    <cffunction name="GET_SUBSCRIPTION" access="remote" returntype="query">
        <cfquery name="GET_SUBSCRIPTION" datasource="#DSN#">
            SELECT
                SUBSCRIPTION_ID,			
                SUBSCRIPTION_NO
            FROM
                SUBSCRIPTION_CONTRACT
            WHERE
                SUBSCRIPTION_NO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.workcube_id#"> 
        </cfquery>
        <cfreturn GET_SUBSCRIPTION>
    </cffunction>
    <cffunction name="GET_SERVICE" access="remote" returntype="query">

    <cfquery name="getProj" datasource="#dsn#">
    SELECT * FROM w3Partner.WORK_GROUP WHERE WORKGROUP_ID IN (SELECT WORKGROUP_ID FROM w3Partner.WORKGROUP_EMP_PAR WHERE PARTNER_ID=#session.pp.userid#)
    </cfquery>
    <cfset projlist=0>
    <cfif getProj.recordcount>
    <cfset projlist=valueList(getProj.PROJECT_ID)>
    </cfif>
        <cfquery name="GET_SERVICE" datasource="#DSN#">
            SELECT	
                SERVICE.OUR_COMPANY_ID,		
                SERVICE.SERVICE_ID,
                SERVICE.ISREAD,
                SERVICE.SERVICE_COMPANY_ID,
                SERVICE.APPLICATOR_NAME,
                SERVICE.SERVICE_PARTNER_ID,
                SERVICE.SERVICE_CONSUMER_ID,
                SERVICE.SERVICE_EMPLOYEE_ID,
                SERVICE.SERVICE_STATUS_ID,
                SERVICE.SERVICE_NO,
                SERVICE.APPLY_DATE,
                SERVICE.SERVICE_HEAD,
                SERVICE.SERVICE_DETAIL,
                SERVICE.RECORD_MEMBER,
                SERVICE.RECORD_DATE,
                SERVICE.RECORD_PAR,
                SERVICE.RECORD_CONS,
                SERVICE.SERVICE_BRANCH_ID,
                SERVICE_APPCAT.SERVICECAT,
                SERVICE.SERVICECAT_ID,
                SCM.COMMETHOD,
                SP.PRIORITY,
                SP.COLOR,
                PROCESS_TYPE_ROWS.STAGE,
                C.FULLNAME,
                C.MEMBER_CODE,
                CP.COMPANY_PARTNER_NAME + ' ' +  CP.COMPANY_PARTNER_SURNAME AS PARTNER,
                C1.CONSUMER_NAME + ' ' + C1.CONSUMER_SURNAME AS CONSUMER,
                C1.MEMBER_CODE AS CONSUMER_CODE,
                E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                '' AS IS_MAIL
                <!---
                GSAS.SERVICE_SUB_CAT,
                GSASS.SERVICE_SUB_STATUS,
				
                GP.IS_MAIL --->          
            FROM
                G_SERVICE AS SERVICE
                LEFT JOIN G_SERVICE_APPCAT AS SERVICE_APPCAT ON SERVICE.SERVICECAT_ID = SERVICE_APPCAT.SERVICECAT_ID
                LEFT JOIN SETUP_COMMETHOD AS SCM ON SCM.COMMETHOD_ID = SERVICE.COMMETHOD_ID
                LEFT JOIN SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = SERVICE.PRIORITY_ID
                LEFT JOIN PROCESS_TYPE_ROWS AS PROCESS_TYPE_ROWS ON PROCESS_TYPE_ROWS.PROCESS_ROW_ID = SERVICE.SERVICE_STATUS_ID
                LEFT JOIN COMPANY AS C ON SERVICE.SERVICE_COMPANY_ID = C.COMPANY_ID
                LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = SERVICE.SERVICE_PARTNER_ID
                LEFT JOIN CONSUMER AS C1 ON SERVICE.SERVICE_CONSUMER_ID = C1.CONSUMER_ID
                LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = SERVICE.SERVICE_EMPLOYEE_ID
                <!---
                LEFT JOIN G_SERVICE_APPCAT_SUB AS GSAS ON GSAS.SERVICECAT_ID = SERVICE_APPCAT.SERVICECAT_ID
                LEFT JOIN G_SERVICE_APPCAT_SUB_STATUS AS GSASS ON GSASS.SERVICE_SUB_CAT_ID = GSAS.SERVICE_SUB_CAT_ID
				
                LEFT JOIN G_SERVICE_PLUS AS GP ON GP.SERVICE_ID = SERVICE.SERVICE_ID--->
            WHERE
                <cfif len(arguments.keyword)>
                    (
                        SERVICE.SERVICE_DETAIL LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"> OR
                        SERVICE.SERVICE_HEAD LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"> OR
                        SERVICE.SERVICE_NO LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%">
                    ) AND
                </cfif>
                <cfif arguments.is_only_me eq 1>
               SERVICE.SERVICE_PARTNER_ID =#session.pp.userid# AND
                </cfif>
                 SERVICE.PROJECT_ID IN (#projlist#) AND
                <cfif len(arguments.start_date_)>
                    SERVICE.APPLY_DATE >= #arguments.start_date_# AND
                </cfif>
                <cfif len(arguments.finish_date_)>
                    SERVICE.APPLY_DATE < #DateAdd('d',1,arguments.finish_date_)# AND
                </cfif>
                <cfif len(arguments.subscription_id) and len(arguments.subscription_no)>
                    SERVICE.SUBSCRIPTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.subscription_id#"> AND
                </cfif>
                <cfif len(arguments.process_stage)>
                    SERVICE.SERVICE_STATUS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#">  AND
                </cfif>
                
                    SERVICE.SERVICE_ID IN (
                                            SELECT 
                                                SERVICE_ID 
                                            FROM 
                                                G_SERVICE_APP_ROWS 
                                            WHERE 
                                                SERVICE_ID IS NOT NULL 
                                                <cfif len(arguments.appcat_id)>
                                                	AND SERVICECAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appcat_id#">
                                                </cfif>
                                                <!---
                                                <cfif len(arguments.appcat_sub_id)>
                                                	AND SERVICE_SUB_CAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appcat_sub_id#">
                                                </cfif>
                                                <cfif len(arguments.appcat_sub_tree_id)>
                                                	AND SERVICE_SUB_STATUS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appcat_sub_tree_id#">
                                                </cfif>
												--->
                                            ) AND
                <cfif len(arguments.company_id) and len(arguments.company_name)>
                    SERVICE.SERVICE_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#"> AND
                </cfif> 
                <cfif len(arguments.consumer_id) and len(arguments.company_name)>
                    SERVICE.SERVICE_CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.consumer_id#"> AND
                </cfif>
                (
                        SERVICE.SERVICE_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#"> OR
                        SERVICE.SERVICE_COMPANY_ID IN (SELECT COMPANY_ID FROM COMPANY WHERE HIERARCHY_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">) OR
                        SERVICE.SERVICE_CONSUMER_ID IN (SELECT CONSUMER_ID FROM CONSUMER WHERE HIERARCHY_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">)
                )
                AND SERVICE_ACTIVE=1
            ORDER BY
                SERVICE.RECORD_DATE DESC
        </cfquery> 
        <cfreturn GET_SERVICE>
    </cffunction>
    <cffunction name="GET_G_SERVICE_ASSETS" access="remote" returntype="query">
        <cfquery name="GET_G_SERVICE_ASSETS" datasource="#DSN#">
            SELECT
                A.ACTION_ID,
                A.ASSET_FILE_NAME,
                A.MODULE_NAME,
                A.ASSET_ID,
                A.ASSETCAT_ID,
                A.ASSET_NAME,
                A.IMAGE_SIZE,
                A.ASSET_FILE_SERVER_ID,
                A_C.ASSETCAT,
                A_C.ASSETCAT_PATH,
                CP.NAME,
                A.RECORD_PAR,
                A.RECORD_PUB,
                A.ASSET_DESCRIPTION 
            FROM
                ASSET A
                LEFT JOIN ASSET_SITE_DOMAIN AS ASD ON A.ASSET_ID = ASD.ASSET_ID
                LEFT JOIN CONTENT_PROPERTY AS CP ON CP.CONTENT_PROPERTY_ID = A.PROPERTY_ID
                LEFT JOIN ASSET_CAT AS A_C ON A.ASSETCAT_ID = A_C.ASSETCAT_ID 
            WHERE
                ASD.SITE_DOMAIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.HTTP_HOST#"> AND
                A.ACTION_SECTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="G_SERVICE_ID"> AND
                A.IS_SPECIAL = 0 AND
                A.IS_INTERNET = 1 AND 
                A.ACTION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
            ORDER BY 
                A.RECORD_DATE DESC 
        </cfquery>
        <cfreturn GET_G_SERVICE_ASSETS>
    </cffunction>
	<cffunction name="GETCALLCENTER" access="remote" returntype="query">
    	<cfif len(arguments.service_id)>
            <cfquery name="GETCALLCENTER" datasource="#DSN#">
                SELECT 
                    GS.SERVICE_NO,
                    GS.APPLY_DATE,
                    GS.START_DATE,
                    GS.FINISH_DATE,
                    GS.SERVICE_HEAD,
                    GS.ISREAD,
                    GS.SERVICE_DETAIL,
                    PTR.STAGE,
                    '' AS IS_MAIL,
                    <!---GP.IS_MAIL,--->
                    C.FULLNAME,
                    C.MEMBER_CODE,
                    CP.COMPANY_PARTNER_NAME + ' ' +  CP.COMPANY_PARTNER_SURNAME AS PARTNER,
                    C1.CONSUMER_NAME + ' ' + C1.CONSUMER_SURNAME AS CONSUMER,
                    C1.MEMBER_CODE AS CONSUMER_CODE,
                    E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                    GS.SERVICE_COMPANY_ID,
                    GS.APPLICATOR_NAME,
                    GS.SERVICE_PARTNER_ID,
                    GS.SERVICE_CONSUMER_ID,
                    GS.SERVICE_EMPLOYEE_ID,
                    SC.COMMETHOD,
                    SP.PRIORITY,
                    GSA.SERVICECAT,
                    PP.PROJECT_HEAD
                FROM 
                    G_SERVICE AS GS
                    LEFT JOIN PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID = GS.SERVICE_STATUS_ID
                    <!---LEFT JOIN G_SERVICE_PLUS AS GP ON GP.SERVICE_ID = GS.SERVICE_ID--->
                    LEFT JOIN COMPANY AS C ON GS.SERVICE_COMPANY_ID = C.COMPANY_ID
                    LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = GS.SERVICE_PARTNER_ID
                    LEFT JOIN CONSUMER AS C1 ON GS.SERVICE_CONSUMER_ID = C1.CONSUMER_ID
                    LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = GS.SERVICE_EMPLOYEE_ID
                    LEFT JOIN SETUP_COMMETHOD AS SC ON GS.COMMETHOD_ID = SC.COMMETHOD_ID
                    LEFT JOIN SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = GS.PRIORITY_ID
                    LEFT JOIN G_SERVICE_APPCAT AS GSA ON GSA.SERVICECAT_ID = GS.SERVICECAT_ID
                    LEFT JOIN PRO_PROJECTS AS PP ON PP.PROJECT_ID = GS.PROJECT_ID       
                WHERE 
                    GS.SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">
            </cfquery>
		<cfelse>
        	<cfscript>
				columnList = 'SERVICE_NO,APPLY_DATE,START_DATE,FINISH_DATE,SERVICE_HEAD,SERVICE_DETAIL,STAGE,IS_MAIL,FULLNAME,MEMBER_CODE,PARTNER,CONSUMER,CONSUMER_CODE,EMPLOYEE,SERVICE_COMPANY_ID,APPLICATOR_NAME,SERVICE_PARTNER_ID,SERVICE_CONSUMER_ID,SERVICE_EMPLOYEE_ID,COMMETHOD,PRIORITY,SERVICECAT,PROJECT_HEAD';
				GETCALLCENTER = QueryNew("#columnList#");
				QueryAddRow(GETCALLCENTER,1);
				for(i=1;i<listlen(columnList,',');i++)
					QuerySetCell(GETCALLCENTER,listGetAt(columnList,i,','),"",1);
			</cfscript>
        </cfif>
        <cfreturn GETCALLCENTER>
    </cffunction>
    
	<cffunction name="GETCALLCENTERPLUS" access="remote" returntype="query">
		<cfif not isdefined("arguments.service_id")>
        	<cfset arguments.service_id = arguments.service_id_new>
        	<cfset arguments.top = 1>
        </cfif>
        <cfquery name="GETCALLCENTERPLUS" datasource="#DSN#">
            SELECT
            	<cfif isdefined("arguments.top") and len(arguments.top)>
                	TOP 1
                </cfif>
                GSP.COMMETHOD_ID,
                GSP.PLUS_DATE,
                GSP.SUBJECT,
                GSP.RECORD_EMP,							
                GSP.RECORD_PAR,							
                GSP.RECORD_DATE,
                GSP.PLUS_CONTENT,
                E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS PARTNER,
                E.PHOTO,
                CP.PHOTO AS PHOTO_CP
            FROM 
                G_SERVICE_PLUS AS GSP
                LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = GSP.RECORD_EMP
                LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = GSP.RECORD_PAR
            WHERE   
                GSP.SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">
                <cfif isDefined("arguments.service_plus_id")>
                    AND SERVICE_PLUS_ID =  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_plus_id#">
                </cfif>	
            ORDER BY
                GSP.SERVICE_PLUS_ID <cfif isdefined("arguments.top") and len(arguments.top)>DESC<cfelse>ASC</cfif>
        </cfquery>
        <cfreturn GETCALLCENTERPLUS>
    </cffunction>
	<cffunction name="INSERTCALLCENTERPLUS" access="remote" returntype="any" returnFormat="json">
        <cfquery name="GETLASTCALLCENTERPLUS" datasource="#DSN#">
            SELECT
            	TOP 1
            	COMMETHOD_ID,
                PLUS_DATE,
                SUBJECT
			FROM
            	G_SERVICE_PLUS
			WHERE
            	SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">
			ORDER BY
            	SERVICE_PLUS_ID DESC
        </cfquery>
        <cfquery name="INSERTCALLCENTERPLUS" datasource="#DSN#">
            INSERT INTO 
            	G_SERVICE_PLUS
            (SERVICE_ID,COMMETHOD_ID,PLUS_DATE,SUBJECT,PLUS_CONTENT,RECORD_DATE,RECORD_PAR,RECORD_IP,UPDATE_DATE,UPDATE_IP,IS_MAIL,SERVICE_ZONE)
            VALUES
            (
            	<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">,
            	<cfif len(GETLASTCALLCENTERPLUS.COMMETHOD_ID)><cfqueryparam cfsqltype="cf_sql_integer" value="#GETLASTCALLCENTERPLUS.COMMETHOD_ID#"><cfelse>NULL</cfif>,
                <cfif len(GETLASTCALLCENTERPLUS.PLUS_DATE)><cfqueryparam cfsqltype="cf_sql_date" value="#GETLASTCALLCENTERPLUS.PLUS_DATE#"><cfelse>NULL</cfif>,
                <cfif len(GETLASTCALLCENTERPLUS.SUBJECT)><cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLASTCALLCENTERPLUS.SUBJECT#"><cfelse>NULL</cfif>,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.plus_content#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                0,
                0
            )
        </cfquery>
        <cfreturn Replace(serializeJSON(GETCALLCENTERPLUS(service_id_new:arguments.service_id)),'//','')>
    </cffunction>

    <!--- CallCenter --->
    
    <!--- Agenda --->    
	<cffunction name="GET_QUERY_AGENDA" access="remote" returntype="query">
		<cfif not isdefined("arguments.project_id")>
			<cfset arguments.project_id = GET_PROJECTS_AUTH()>
        </cfif>
        <cfquery name="GET_QUERY_AGENDA" datasource="#dsn#">
            SELECT
                E.EVENT_HEAD,
                E.STARTDATE,
                E.FINISHDATE,
                E.EVENT_ID,
                EC.COLOUR
            FROM 
                EVENT AS E
                LEFT JOIN EVENT_CAT AS EC ON E.EVENTCAT_ID = EC.EVENTCAT_ID
            WHERE
                E.PROJECT_ID IN ( select PROJECT_ID from PRO_PROJECTS where COMPANY_ID=#session.pp.COMPANY_ID#)
        </cfquery>
        <cfreturn get_query_agenda>
    </cffunction>
    <cffunction name="GET_AGENDA" access="remote" returntype="query">
        <cfquery name="GET_AGENDA" datasource="#dsn#">
            SELECT
                E.EVENT_HEAD,
                E.STARTDATE,
                E.FINISHDATE,
                E.EVENT_ID,
                E.EVENT_DETAIL,
                E.EVENT_TO_POS,
                E.EVENT_TO_PAR,
                E.EVENT_TO_CON,
                E.EVENT_CC_POS,
                E.EVENT_CC_PAR,
                E.EVENT_CC_CON,
                E.RECORD_DATE,
                E.UPDATE_DATE,
                EC.EVENTCAT,
                (SELECT EMPLOYEE_NAME+' '+EMPLOYEE_SURNAME FROM EMPLOYEES WHERE EMPLOYEE_ID= E.RECORD_EMP) AS RECORD,
                (SELECT EMPLOYEE_NAME+' '+EMPLOYEE_SURNAME FROM EMPLOYEES WHERE EMPLOYEE_ID= E.UPDATE_EMP) AS UPD,
                PTR.STAGE
            FROM 
                EVENT AS E
                LEFT JOIN PROCESS_TYPE_ROWS AS PTR ON E.EVENT_STAGE = PTR.PROCESS_ROW_ID
                LEFT JOIN EVENT_CAT AS EC ON EC.EVENTCAT_ID = E.EVENTCAT_ID
                  
            WHERE
                E.EVENT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eventId#">
        </cfquery>
        <cfreturn GET_AGENDA>
    </cffunction>
	<cffunction name="GET_SPESIFIC_DATA" access="remote" returntype="string">
        <cfquery name="local.GET_SPESIFIC_DATA" datasource="#dsn#">
            SELECT
                CAST(-1 AS VARCHAR) + #arguments.column# + CAST(-1 AS VARCHAR) AS DATA
            FROM 
                EVENT AS E
            WHERE
                E.EVENT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eventId#">
        </cfquery>
        <cfreturn local.GET_SPESIFIC_DATA.DATA>
    </cffunction>
    <cffunction name="GET_AGENDA_TO" access="remote" returntype="query">
    	<cfscript>
			get_employee = GET_SPESIFIC_DATA(column:'EVENT_TO_POS',eventId:arguments.eventId);
			get_consumer = GET_SPESIFIC_DATA(column:'EVENT_TO_CON',eventId:arguments.eventId);
			get_company_partner = GET_SPESIFIC_DATA(column:'EVENT_TO_PAR',eventId:arguments.eventId);
		</cfscript>
        <cfquery name="GET_AGENDA_TO" datasource="#dsn#">
        	<cfif len(get_employee) or len(get_consumer) or len(get_company_partner)>
				<cfif len(get_employee)>
                    SELECT
                        1 AS TYPE,
                        E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                        POSITION_NAME AS FULLNAME
                    FROM 
                        EMPLOYEES AS E
                        LEFT JOIN EMPLOYEE_POSITIONS AS EP ON E.EMPLOYEE_ID = EP.EMPLOYEE_ID AND IS_MASTER = 1
                    WHERE
                        E.EMPLOYEE_ID IN (#get_employee#)
                </cfif>
                <cfif len(get_consumer)>
                    <cfif len(get_employee)>UNION</cfif>
                    SELECT
                        2 AS TYPE,
                        CONSUMER_NAME + ' ' + CONSUMER_SURNAME AS EMPLOYEE,
                        COMPANY AS FULLNAME
                    FROM 
                        CONSUMER AS C
                    WHERE
                        C.CONSUMER_ID IN (#get_consumer#)
                </cfif>
                <cfif len(get_company_partner)>
                    <cfif len(get_employee) or len(get_consumer)>UNION</cfif>
                    SELECT
                        3 AS TYPE,
                        COMPANY_PARTNER_NAME + ' ' + COMPANY_PARTNER_SURNAME AS EMPLOYEE,
                        CMP.FULLNAME
                    FROM 
                        COMPANY_PARTNER AS CP
                        LEFT JOIN COMPANY AS CMP ON CP.COMPANY_ID = CMP.COMPANY_ID
                    WHERE
                        CP.PARTNER_ID IN (#get_company_partner#)
                </cfif>
                ORDER BY
                    TYPE
            <cfelse>
            	SELECT EMPLOYEE_NAME FROM EMPLOYEES WHERE 1 = 0
			</cfif>
        </cfquery>
        <cfreturn GET_AGENDA_TO>
    </cffunction>
    <cffunction name="GET_AGENDA_CC" access="remote" returntype="query">
    	<cfscript>
			get_employee = GET_SPESIFIC_DATA(column:'EVENT_CC_POS',eventId:arguments.eventId);
			get_consumer = GET_SPESIFIC_DATA(column:'EVENT_CC_CON',eventId:arguments.eventId);
			get_company_partner = GET_SPESIFIC_DATA(column:'EVENT_CC_PAR',eventId:arguments.eventId);
		</cfscript>
		<cfquery name="GET_AGENDA_CC" datasource="#dsn#">
			<cfif len(get_employee) or len(get_consumer) or len(get_company_partner)>
				<cfif len(get_employee)>
                    SELECT
                        1 AS TYPE,
                        E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                        POSITION_NAME AS FULLNAME
                    FROM 
                        EMPLOYEES AS E
                        LEFT JOIN EMPLOYEE_POSITIONS AS EP ON E.EMPLOYEE_ID = EP.EMPLOYEE_ID AND IS_MASTER = 1
                    WHERE
                        E.EMPLOYEE_ID IN (#get_employee#)
                    </cfif>
                <cfif len(get_consumer)>
                    <cfif len(get_employee)>UNION</cfif>
                    SELECT
                        2 AS TYPE,
                        CONSUMER_NAME + ' ' + CONSUMER_SURNAME AS EMPLOYEE,
                        COMPANY AS FULLNAME
                    FROM 
                        CONSUMER AS C
                    WHERE
                        C.CONSUMER_ID IN (#get_consumer#)
                </cfif>
                <cfif len(get_company_partner)>
                    <cfif len(get_employee) or len(get_consumer)>UNION</cfif>
                    SELECT
                        3 AS TYPE,
                        COMPANY_PARTNER_NAME + ' ' + COMPANY_PARTNER_SURNAME AS EMPLOYEE,
                        CMP.FULLNAME
                    FROM 
                        COMPANY_PARTNER AS CP
                        LEFT JOIN COMPANY AS CMP ON CP.COMPANY_ID = CMP.COMPANY_ID
                    WHERE
                        CP.PARTNER_ID IN (#get_company_partner#)
                </cfif>
                ORDER BY
                    TYPE
            <cfelse>
                SELECT EMPLOYEE_NAME FROM EMPLOYEES WHERE 1 = 0
            </cfif>
		</cfquery>
        <cfreturn GET_AGENDA_CC>
    </cffunction>
    <!--- Agenda --->
    
    <!--- Service --->
	<cffunction name="GET_SERVICE_KATALIZOR" access="remote" returntype="query">
    	<cfargument name="ourCompany" default="1">
        <cfquery name="GET_SERVICE" datasource="#dsn#_#arguments.ourCompany#">
   			WITH CTE1 AS(
                SELECT
                    ISNULL((SELECT SUM(AMOUNT) FROM SERVICE_OPERATION SO WHERE SO.SERVICE_ID = S.SERVICE_ID),0) TOPLAM_SAAT,
                    S.SERVICE_STATUS_ID,
                    S.SERVICE_ID SERVICE_ID,
                    S.SERVICE_HEAD,
                    S.START_DATE,
                    S.FINISH_DATE,
                    S.APPLY_DATE APPLY_DATE,
                    S.SERVICE_DETAIL,
                    S.SERVICE_NO,
                    S.DOC_NO,
                    S_A.SERVICECAT,
                    E.EMPLOYEE_NAME,
                    E.EMPLOYEE_SURNAME,
                    P_T_R.STAGE
                FROM
                    SERVICE AS S
                    LEFT JOIN #dsn#.EMPLOYEES AS E ON E.EMPLOYEE_ID = S.RECORD_MEMBER
                    LEFT JOIN SERVICE_APPCAT AS S_A ON S_A.SERVICECAT_ID = S.SERVICECAT_ID
                    LEFT JOIN #dsn#.PROCESS_TYPE_ROWS AS P_T_R ON P_T_R.PROCESS_ROW_ID = S.SERVICE_STATUS_ID
                WHERE 
                	S.SERVICE_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">
                    <!---
                    AND S.SERVICE_STATUS_ID IN(#arguments.process_stage_list#)
					--->
                    <cfif len(arguments.category)>
                        AND S.SERVICECAT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.category#">
                    </cfif>	
                    <cfif len(arguments.keyword)>
                        AND
                        (
                            S.SERVICE_DETAIL LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"> OR
                            S.SERVICE_HEAD LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"> OR
                            S.SERVICE_NO LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%">
                        )
                    </cfif> 
                    <cfif len(arguments.start_date)>
                        AND S.APPLY_DATE >= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.start_date#">
                    </cfif>
                    <cfif len(arguments.finish_date)>
                        AND S.APPLY_DATE < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateAdd("d",1,arguments.finish_date)#">
                    </cfif>
                    <cfif len(arguments.process_stage)>
                        AND S.SERVICE_STATUS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.process_stage#">
                    </cfif>
					
            ),
            CTE2 AS 
                (
                    SELECT
                        CTE1.*,
                        ROW_NUMBER() OVER (ORDER BY APPLY_DATE DESC, SERVICE_ID DESC) AS RowNum,(SELECT COUNT(*) FROM CTE1) AS QUERY_COUNT
                    FROM
                        CTE1
                )
                SELECT
                    CTE2.*
                FROM
                    CTE2
                WHERE
                    RowNum BETWEEN #arguments.startrow# and #arguments.startrow#+(#arguments.maxrows#-1)
        </cfquery>
        <cfreturn GET_SERVICE>
    </cffunction>
    <cffunction name="GET_SERVICE_APPCAT_SERVICE" access="remote" returntype="query">
    	<cfargument name="ourCompany" default="1">
        <cfquery name="GET_SERVICE_APPCAT" datasource="#dsn#_#arguments.ourCompany#">
            SELECT 
                SERVICECAT_ID,
                SERVICECAT
            FROM 	
                SERVICE_APPCAT
            ORDER BY
                SERVICE_APPCAT.SERVICECAT 
        </cfquery>
        <cfreturn GET_SERVICE_APPCAT>
    </cffunction>
    <cffunction name="GET_APPCAT" access="remote" returntype="query">
    	<cfargument name="ourCompany" default="1">
        <cfquery name="GET_APPCAT" datasource="#dsn#_#arguments.ourCompany#">
            SELECT 
                S_A.SERVICECAT 
            FROM 
                SERVICE_APPCAT AS S_A
                LEFT JOIN SERVICE AS S ON S_A.SERVICECAT_ID = S.SERVICECAT_ID
            ORDER BY 
                S_A.SERVICECAT 
        </cfquery>
        <cfreturn GET_APPCAT>
    </cffunction>
    <cffunction name="GET_SERVICE_WORKS" access="remote" returntype="query">
        <cfquery name="GET_SERVICE_WORKS" datasource="#DSN#">
            SELECT
                WORK_ID,
                SERVICE_ID,
                PROJECT_ID
            FROM
                PRO_WORKS
            WHERE
                SERVICE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.service_id#">
                AND OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.our_company_id#">
        </cfquery>
        <cfreturn GET_SERVICE_WORKS>
    </cffunction>
    <cffunction name="GET_SERVICE_SUBSTATUS" access="remote" returntype="query">
    	<cfargument name="ourCompany" default="1">
        <cfquery name="GET_SERVICE_SUBSTATUS" datasource="#dsn#_#arguments.ourCompany#">
            SELECT SERVICE_SUBSTATUS_ID,SERVICE_SUBSTATUS FROM SERVICE_SUBSTATUS
        </cfquery>
        <cfreturn GET_SERVICE_SUBSTATUS>
    </cffunction> 
    <!--- Service --->
    
    <!--- Extre --->    
	<cffunction name="GET_MONEY" access="remote" returntype="query">
        <cfquery name="GET_MONEY" datasource="#dsn#">
            SELECT 
                MONEY,
                RATE2,
                RATE1 
            FROM 
                SETUP_MONEY 
            WHERE 
                PERIOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.PERIOD_ID#"> 
                AND MONEY_STATUS = 1
            UNION ALL
            SELECT TOP 1
                'YTL',1,1
            FROM
                SETUP_MONEY
        </cfquery>
        <cfreturn GET_MONEY>
    </cffunction>
	<cffunction name="GET_PROJECT_FOR_EXTRE" access="remote" returntype="query">
        <cfquery name="GET_PROJECT_EXTRE" datasource="#dsn#">
            SELECT 
                PROJECT_ID,
                PROJECT_HEAD 
            FROM 
                PRO_PROJECTS 
            WHERE 
                COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.company_id#">
        </cfquery>
        <cfreturn GET_PROJECT_EXTRE>
    </cffunction>
    <cffunction name="getCompenentFunction">
		<cfargument name="our_company_id" required="no" type="string" default="#session.pp.our_company_id#">
		<cfargument name="is_purchase" required="no" type="string" default="0">
		<cfquery name="get_open_order_ships" datasource="#dsn#">
				SELECT 
					ISNULL(SUM(ORDER_TOTAL),0) ORDER_TOTAL,
					ISNULL(SUM(SHIP_TOTAL),0) SHIP_TOTAL  
				<cfif len(session.pp.money2)>
					,ISNULL(SUM(ORDER_TOTAL2),0) ORDER_TOTAL2
					,ISNULL(SUM(SHIP_TOTAL2),0) SHIP_TOTAL2
				</cfif>
				FROM 
				(
					<cfset count = 0>
					<cfloop list="#arguments.our_company_id#" index="kk">
						<cfset count = count + 1>
						<cfquery name="CHECK_COMPANY_RISK_TYPE" datasource="#DSN#">
							SELECT 
								ISNULL(IS_DETAILED_RISK_INFO,0) IS_DETAILED_RISK_INFO 
							FROM 
								OUR_COMPANY_INFO 
							WHERE 
								COMP_ID = #kk#
						</cfquery>
						<cfset dsn_alias = "#dsn#">
						<cfset dsn3 = "#dsn#_#kk#">
						<cfset dsn3_alias = "#dsn#_#kk#">
						<cfset dsn2_alias = "#dsn#_#session.pp.period_year#_#kk#">
                        <cfset dsn2 = "#dsn#_#session.pp.period_year#_#kk#">
						<cfif check_company_risk_type.IS_DETAILED_RISK_INFO eq 1><!--- Detaylı risk takibi yapılıyor ise --->
							SELECT 
								((ORD_ROW.QUANTITY - ISNULL(ORD_ROW.CANCEL_AMOUNT,0) - ISNULL(ORD_ROW.DELIVER_AMOUNT,0)) * (((1- (O.SA_DISCOUNT)/#dsn_alias#.IS_ZERO(((O.NETTOTAL)-O.TAXTOTAL+O.SA_DISCOUNT),1)) * (ORD_ROW.NETTOTAL) + (((((1- (O.SA_DISCOUNT)/#dsn_alias#.IS_ZERO((O.NETTOTAL-O.TAXTOTAL+O.SA_DISCOUNT),1))*( ORD_ROW.NETTOTAL)*ORD_ROW.TAX)/100))))/ORD_ROW.QUANTITY)) ORDER_TOTAL,
								<cfif len(session.pp.money2)>
									((ORD_ROW.QUANTITY - ISNULL(ORD_ROW.CANCEL_AMOUNT,0) - ISNULL(ORD_ROW.DELIVER_AMOUNT,0)) * (((1- (O.SA_DISCOUNT)/#dsn_alias#.IS_ZERO(((O.NETTOTAL)-O.TAXTOTAL+O.SA_DISCOUNT),1)) * (ORD_ROW.NETTOTAL) + (((((1- (O.SA_DISCOUNT)/#dsn_alias#.IS_ZERO((O.NETTOTAL-O.TAXTOTAL+O.SA_DISCOUNT),1))*( ORD_ROW.NETTOTAL)*ORD_ROW.TAX)/100))))/RATE2/ORD_ROW.QUANTITY)) ORDER_TOTAL2
								<cfelse>
									0 ORDER_TOTAL2
								</cfif>,
								0 SHIP_TOTAL,
								0 SHIP_TOTAL2
							FROM 
								#dsn3_alias#.ORDERS O,
								#dsn3_alias#.ORDER_ROW ORD_ROW
								<cfif len(session.pp.money2)>
									,#dsn3_alias#.ORDER_MONEY
								</cfif>
							WHERE 
								ISNULL(O.IS_MEMBER_RISK,1) = 1 AND 
								O.ORDER_STATUS = 1 AND 
								O.ORDER_ID = ORD_ROW.ORDER_ID AND
								((O.NETTOTAL)-O.TAXTOTAL+O.SA_DISCOUNT) > 0 AND 
								ORD_ROW.ORDER_ROW_CURRENCY NOT IN(-8,-9,-10,-3)
							<cfif arguments.is_purchase eq 1>
								AND O.PURCHASE_SALES=0
							<cfelse>
								AND ((O.PURCHASE_SALES=1 
								AND O.ORDER_ZONE=0) OR (O.PURCHASE_SALES=0 AND O.ORDER_ZONE=1)) 
							</cfif>
							AND IS_PAID<>1 
							<cfif isdefined("arguments.company_id") and len(arguments.company_id)>
								AND O.COMPANY_ID = #arguments.company_id#
							<cfelseif isdefined("arguments.consumer_id") and len(arguments.consumer_id)>
								AND O.CONSUMER_ID = #arguments.consumer_id#
							<cfelseif isdefined("arguments.employee_id") and len(arguments.employee_id)>
								AND O.EMPLOYEE_ID = #arguments.employee_id#
							</cfif>
							<cfif len(session.pp.money2)>
								AND O.ORDER_ID = ORDER_MONEY.ACTION_ID
								AND ORDER_MONEY.MONEY_TYPE = '#session.pp.money2#'
							</cfif>
							UNION ALL
							SELECT
								0 ORDER_TOTAL,
								0 ORDER_TOTAL2,
								((SR.AMOUNT - (SELECT ISNULL(SUM(IR.AMOUNT),0) FROM #dsn3_alias#.GET_ALL_INVOICE_ROW IR WHERE IR.WRK_ROW_RELATION_ID = SR.WRK_ROW_ID))) * (SR.GROSSTOTAL/#dsn_alias#.IS_ZERO(SR.AMOUNT,1)) SHIP_TOTAL,
							<cfif len(session.pp.money2)>
								((SR.AMOUNT - (SELECT ISNULL(SUM(IR.AMOUNT),0) FROM #dsn3_alias#.GET_ALL_INVOICE_ROW IR WHERE IR.WRK_ROW_RELATION_ID = SR.WRK_ROW_ID))) * (SR.GROSSTOTAL/#dsn_alias#.IS_ZERO(SR.AMOUNT,1)/RATE2) SHIP_TOTAL2
							<cfelse>
								0 SHIP_TOTAL2
							</cfif>
							FROM
								#dsn2_alias#.SHIP S,
								#dsn2_alias#.SHIP_ROW SR
							<cfif len(session.pp.money2)>
								,#dsn2_alias#.SHIP_MONEY SM
							</cfif>
							WHERE
								S.SHIP_ID = SR.SHIP_ID AND 
								ISNULL(S.SHIP_STATUS,0) = 1 AND 
								S.IS_WITH_SHIP = 0 AND 
								ISNULL(S.IS_SHIP_IPTAL,0) = 0 AND 
								(SR.AMOUNT - (SELECT ISNULL(SUM(IR.AMOUNT),0) FROM #dsn3_alias#.GET_ALL_INVOICE_ROW IR WHERE IR.WRK_ROW_RELATION_ID = SR.WRK_ROW_ID)) > 0
							<cfif arguments.is_purchase eq 1>
								AND S.PURCHASE_SALES = 0
							<cfelse>
								AND S.PURCHASE_SALES = 1
							</cfif>
							<cfif isdefined("arguments.company_id") and len(arguments.company_id)>
								AND S.COMPANY_ID = #arguments.company_id#
							<cfelseif isdefined("arguments.consumer_id") and len(arguments.consumer_id)>
								AND S.CONSUMER_ID = #arguments.consumer_id#
							<cfelseif isdefined("arguments.employee_id") and len(arguments.employee_id)>
								AND S.EMPLOYEE_ID = #arguments.employee_id#
							</cfif>
							<cfif len(session.pp.money2)>
								AND S.SHIP_ID = SM.ACTION_ID
								AND SM.MONEY_TYPE = '#session.pp.money2#'
							</cfif>
						<cfelse>
							SELECT 
								ISNULL(SUM(NETTOTAL),0) ORDER_TOTAL
							<cfif len(session.pp.money2)>
								,SUM(NETTOTAL/RATE2) ORDER_TOTAL2
							</cfif>,
								0 SHIP_TOTAL,
								0 SHIP_TOTAL2
							FROM 
								#dsn3_alias#.ORDERS ORDERS
							<cfif len(session.pp.money2)>
								,#dsn3_alias#.ORDER_MONEY ORDER_MONEY
							</cfif>
							WHERE 
								ISNULL(IS_MEMBER_RISK,1) = 1 AND 
								ORDER_ID NOT IN (SELECT ORDER_ID FROM #dsn3_alias#.ORDERS_INVOICE) AND 
								ORDER_ID NOT IN (SELECT ORDER_ID FROM #dsn3_alias#.ORDERS_SHIP) AND 
								ORDER_STATUS = 1 AND 
								IS_PAID <> 1 
							<cfif arguments.is_purchase eq 1>
								AND ORDERS.PURCHASE_SALES=0
							<cfelse>
								AND ((ORDERS.PURCHASE_SALES=1 AND ORDERS.ORDER_ZONE=0) OR (ORDERS.PURCHASE_SALES=0 AND ORDERS.ORDER_ZONE=1)) 
							</cfif>
							<cfif isdefined("arguments.company_id") and len(arguments.company_id)>
								AND ORDERS.COMPANY_ID = #arguments.company_id#
							<cfelseif isdefined("arguments.consumer_id") and len(arguments.consumer_id)>
								AND ORDERS.CONSUMER_ID = #arguments.consumer_id#
							<cfelseif isdefined("arguments.employee_id") and len(arguments.employee_id)>
								AND ORDERS.EMPLOYEE_ID = #arguments.employee_id#
							</cfif>
							<cfif len(session.pp.money2)>
								AND ORDERS.ORDER_ID = ORDER_MONEY.ACTION_ID
								AND ORDER_MONEY.MONEY_TYPE = '#session.pp.money2#'
							</cfif>
							UNION ALL
							SELECT 
								0 ORDER_TOTAL,
								0 ORDER_TOTAL2,
								SUM(SR.GROSSTOTAL) SHIP_TOTAL
							<cfif len(session.pp.money2)>
								,SUM(SR.GROSSTOTAL/RATE2) SHIP_TOTAL2
							</cfif>
							FROM 
								#dsn2_alias#.SHIP S,
								#dsn2_alias#.SHIP_ROW SR 
							<cfif len(session.pp.money2)>
								,#dsn2_alias#.SHIP_MONEY AS SHIP_MONEY
							</cfif>
							WHERE 
								S.SHIP_ID = SR.SHIP_ID AND
								S.IS_WITH_SHIP = 0 AND 
								ISNULL(S.IS_SHIP_IPTAL,0) = 0 AND 
								S.SHIP_ID NOT IN (SELECT SHIP_ID FROM #dsn2_alias#.INVOICE_SHIPS)
							<cfif arguments.is_purchase eq 1>
								AND S.PURCHASE_SALES = 0
							<cfelse>
								AND S.PURCHASE_SALES = 1
							</cfif>
							<cfif isdefined("arguments.company_id") and len(arguments.company_id)>
								AND S.COMPANY_ID = #arguments.company_id#
							<cfelseif isdefined("arguments.consumer_id") and len(arguments.consumer_id)>
								AND S.CONSUMER_ID = #arguments.consumer_id#
							<cfelseif isdefined("arguments.employee_id") and len(arguments.employee_id)>
								AND S.EMPLOYEE_ID = #arguments.employee_id#
							</cfif>
							<cfif len(session.pp.money2)>
								AND S.SHIP_ID = SHIP_MONEY.ACTION_ID
								AND SHIP_MONEY.MONEY_TYPE = '#session.pp.money2#'
							</cfif>
						</cfif>
						<cfif count neq listlen(arguments.our_company_id)>UNION ALL</cfif>
					</cfloop>
				) AS A1
		</cfquery>
		<cfreturn get_open_order_ships>
	</cffunction>
    <!--- Extre --->
    
    <!--- İş --->    
	<cffunction name="GET_WORK" access="remote" returntype="query">
    	<cfargument name="now" default="#Replace(Replace(now(),"{ts '",""),"'}","")#">
        <cfquery name="GET_WORK" datasource="#dsn#">
            SELECT 
            	PW.G_SERVICE_ID,
                PW.WORK_HEAD,
                PW.ESTIMATED_TIME,
                PW.TERMINATE_DATE,
                PW.TARGET_START,
                PW.PREDICTED_START,
                PW.PREDICTED_FINISH,
                PW.REAL_START,
                PW.REAL_FINISH,
                PWH.WORK_DETAIL,
                DATEDIFF(MINUTE,'#arguments.now#',TERMINATE_DATE) KALAN_TERMIN,
                DATEDIFF(MINUTE,TARGET_START,'#arguments.now#') KULLANILAN_TERMIN,
                DATEDIFF(MINUTE,TARGET_START,TERMINATE_DATE) FULL_TERMIN,
                E.PHOTO,
                ED.SEX AS GENDER,
                E.EMPLOYEE_NAME + ' ' + E.EMPLOYEE_SURNAME AS EMPLOYEE,
                E2.EMPLOYEE_NAME + ' ' + E2.EMPLOYEE_SURNAME AS DELEGE,
                EP.POSITION_NAME AS POSITION,
                PWC.WORK_CAT,
                SA.ACTIVITY_NAME AS ACTIVITY,
                SP.PRIORITY,
                PTR.STAGE,
                GS.SERVICE_HEAD,
                GS.SERVICE_NO,
                C.NICKNAME,
                CP.COMPANY_PARTNER_NAME + ' ' + CP.COMPANY_PARTNER_SURNAME AS PARTNER,
                PWH2.TOTAL_SPEND_HOUR
            FROM 
                PRO_WORKS AS PW
                LEFT JOIN G_SERVICE AS GS ON PW.G_SERVICE_ID = GS.SERVICE_ID
                LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID = PW.PROJECT_EMP_ID
                LEFT JOIN EMPLOYEES_DETAIL AS ED ON E.EMPLOYEE_ID = ED.EMPLOYEE_ID
                LEFT JOIN EMPLOYEE_POSITIONS AS EP ON E.EMPLOYEE_ID = EP.EMPLOYEE_ID
                LEFT JOIN PRO_WORK_CAT AS PWC ON PWC.WORK_CAT_ID = PW.WORK_CAT_ID
                LEFT JOIN SETUP_ACTIVITY AS SA ON SA.ACTIVITY_ID = PW.ACTIVITY_ID
                LEFT JOIN SETUP_PRIORITY AS SP ON SP.PRIORITY_ID = PW.WORK_PRIORITY_ID
                LEFT JOIN PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID = PW.WORK_CURRENCY_ID
                OUTER APPLY
                (
                    SELECT
                        SUM((ISNULL(TOTAL_TIME_HOUR,0)*60)+(ISNULL(TOTAL_TIME_MINUTE,0))) AS TOTAL_SPEND_HOUR
                    FROM 
                        PRO_WORKS_HISTORY AS PWH
                    WHERE 
                        PW.WORK_ID = PWH.WORK_ID
                ) AS PWH2
                OUTER APPLY
                (
                    SELECT
                        TOP 1
                        UPDATE_AUTHOR,
                        WORK_DETAIL
                    FROM 
                        PRO_WORKS_HISTORY AS PWH
                    WHERE 
                        PW.WORK_ID = PWH.WORK_ID
                    ORDER BY
                        HISTORY_ID DESC
                ) AS PWH
                LEFT JOIN EMPLOYEES AS E2 ON E2.EMPLOYEE_ID = PWH.UPDATE_AUTHOR
                LEFT JOIN COMPANY_PARTNER AS CP ON CP.PARTNER_ID = PW.COMPANY_PARTNER_ID
                OUTER APPLY
                (
                    SELECT
                        TOP 1
                        NICKNAME
                    FROM 
                        COMPANY AS C
                    WHERE 
                        C.COMPANY_ID = CP.COMPANY_ID
                ) AS C
            WHERE 
                PW.WORK_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.workId#"> 
        </cfquery>
        <cfreturn GET_WORK>
    </cffunction>
    <!--- İş --->
    
</cfcomponent>
<!--- json_type parametresi 1 : tab menü, 2: page bar, null : page designer 
	objectID parametresi gelirse pageBar duzenleniyor
--->
	
<cfcomponent>
	<cfset dsn = application.systemParam.params().dsn>
	<cffunction name="checkLogin" access="remote" returntype="any" returnFormat="json">
		<cfset fullData = UrlDecode(arguments.data,'utf-8') />
        <cfset str = StructNew()>
        <cfloop index = "ListElement" list = "#fullData#" delimiters = "&">
        	<cfset str['#listFirst(ListElement,"=")#'] = listLast(ListElement,"=")> 
        </cfloop>
		<cfscript>
            temp = str['password'];
            cryptedPassword = hash(temp);
			str['password'] = cryptedPassword;
        </cfscript>
      
        <cfquery name="GET_LIST" datasource="#dsn#">
            SELECT
                C.NICKNAME,
                C.FULLNAME,
                C.COMPANY_ID,
                CP.PARTNER_ID, 
                MSP.TIME_ZONE,
                MSP.LANGUAGE_ID,
                MSP.LOGIN_TIME,
                MSP.MAXROWS,
                MSP.TIMEOUT_LIMIT,
                CP.COMPANY_PARTNER_NAME,
                CP.COMPANY_PARTNER_SURNAME,
                CP.COMPANY_PARTNER_USERNAME,
                CP.COMPANY_PARTNER_PASSWORD,
                SP.PERIOD_ID,
                SP.PERIOD_YEAR,
                SP.OUR_COMPANY_ID,
                SP.OTHER_MONEY,
                SP.STANDART_PROCESS_MONEY,
                OC.COMPANY_NAME,
                OC.EMAIL,
                OC.NICK_NAME,
                OCI.SPECT_TYPE,
                OCI.IS_USE_IFRS,
                OCI.RATE_ROUND_NUM,
                ISNULL((SELECT TOP 1 WRK_MESSAGE.RECEIVER_ID FROM WRK_MESSAGE WHERE WRK_MESSAGE.RECEIVER_ID = CP.PARTNER_ID AND WRK_MESSAGE.RECEIVER_TYPE = 1),0) AS CONTROL_MESSAGE,
                SM.MONEY,
                ISNULL(CP2.PERIOD_DATE,ISNULL(SP.PERIOD_DATE,SP.START_DATE)) AS PERIOD_DATE,
                CP.COMPANY_PARTNER_EMAIL
            FROM 
                COMPANY_PARTNER AS CP
                LEFT JOIN COMPANY AS C ON C.COMPANY_ID = CP.COMPANY_ID
                LEFT JOIN COMPANY_PERIOD AS CP2 ON CP2.COMPANY_ID = C.COMPANY_ID
                LEFT JOIN MY_SETTINGS_P AS MSP ON MSP.PARTNER_ID = CP.PARTNER_ID
                LEFT JOIN SETUP_PERIOD AS SP ON SP.PERIOD_ID = CP2.PERIOD_ID
                LEFT JOIN SETUP_MONEY AS SM ON SM.PERIOD_ID = SP.PERIOD_ID
                LEFT JOIN OUR_COMPANY AS OC ON OC.COMP_ID = SP.OUR_COMPANY_ID
                LEFT JOIN OUR_COMPANY_INFO AS OCI ON OCI.COMP_ID = OC.COMP_ID
            WHERE
                CP.COMPANY_PARTNER_USERNAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#str['username']#"> AND
                CP.COMPANY_PARTNER_PASSWORD = <cfqueryparam cfsqltype="cf_sql_varchar" value="#str['password']#"> AND
                CP.COMPANY_PARTNER_STATUS = 1 AND
                C.COMPANY_STATUS = 1 AND
                C.ISPOTANTIAL = 0 AND
                C.MEMBER_CODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#str['usercode']#"> AND
                SP.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="1"> AND
                
                SM.RATE1 = SM.RATE2
                order by sp.PERIOD_YEAR desc
        </cfquery>
        
        <cfif GET_LIST.recordcount>
            <cfscript>
                session.pp = StructNew();
                session.pp.userid = GET_LIST.partner_id;
                session.pp.username = GET_LIST.company_partner_username;
                session.pp.money = GET_LIST.money;
                session.pp.money2 = GET_LIST.other_money;
                if(len(GET_LIST.standart_process_money))
                    session.pp.other_money = GET_LIST.standart_process_money;
                else
                    session.pp.other_money = GET_LIST.other_money;
                session.pp.company_id = GET_LIST.company_id;
                session.pp.company = GET_LIST.fullname;
                session.pp.company_nick = GET_LIST.nickname;
                session.pp.name = GET_LIST.company_partner_name;
                session.pp.surname = GET_LIST.company_partner_surname;
                session.pp.our_name = GET_LIST.company_name;
                session.pp.our_company_email = GET_LIST.email;
                session.pp.our_nick = GET_LIST.nick_name;
                session.pp.our_company_id = GET_LIST.our_company_id;
                session.pp.time_zone = GET_LIST.time_zone;
                session.pp.language = GET_LIST.language_id;
                session.pp.period_id = GET_LIST.period_id;
                session.pp.period_year = GET_LIST.period_year;
                session.pp.maxrows = GET_LIST.maxrows;
                //session.pp.workcube_id = listlast(cgi.http_cookie,'='); cookie ler karıstıgı icin asagıdaki gibi kullanilmalidir FA
                if(isDefined("session.SESSIONID"))
                    session.pp.workcube_id = session.SESSIONID;
                else
                    session.pp.workcube_id = cookie.JSESSIONID;
                session.pp.our_company_info = StructNew();
                session.pp.our_company_info.spect_type = GET_LIST.spect_type;
                session.pp.our_company_info.is_ifrs = GET_LIST.is_use_ifrs;
                session.pp.our_company_info.rate_round_num = GET_LIST.rate_round_num;
                session.pp.timeout_min = GET_LIST.timeout_limit;
                session.pp.menu_id = '';
                /*session.pp.desing_id = get_p_menu.MENU_STYLE;
                session.pp.server_machine = fusebox.server_machine;*/
                session.pp.is_order_closed = 0;//siparişin ödemesi kontrolu içim eklendi
                session.pp.period_date = dateFormat(GET_LIST.PERIOD_DATE,'yyyy-mm-dd');
				session.pp.mailAddress = GET_LIST.COMPANY_PARTNER_EMAIL;
            </cfscript>
            
            <cfset session_base = session.pp>
            
            <cfquery name="ADD_WRK_SESSION_TO_DB" datasource="#DSN#">
                INSERT INTO 
                    WRK_SESSION
                (
                    CFID,
                    CFTOKEN,
                    WORKCUBE_ID,
                    USERID,
                    USER_TYPE,
                    USERNAME,
                    NAME,
                    SURNAME,
                    POSITION_CODE,
                    MONEY,
                    TIME_ZONE,
                    POSITION_NAME,
                    LANGUAGE_ID,
                    DESIGN_ID,
                    MENU_ID,
                    DESIGN_COLOR,
                    COMPANY_ID,
                    COMPANY,
                    COMPANY_EMAIL,
                    COMPANY_NICK,
                    EHESAP,
                    MAXROWS,
                    USER_LOCATION,
                    PERIOD_ID,
                    PERIOD_YEAR,
                    IS_INTEGRATED,
                    USER_LEVEL,
                    WORKCUBE_SECTOR,
                    IS_PAPER_CLOSER,
                    IS_COST,
                    IS_COST_LOCATION,
                    ERROR_TEXT,
                    SESSIONID,
                    OUR_COMPANY_ID,
                    OUR_COMPANY,
                    OUR_COMPANY_NICK,
                    COMPANY_CATEGORY,
                    ADMIN_STATUS,
                    POWER_USER,
                    POWER_USER_LEVEL_ID,
                    PERIOD_DATE,
                    PROCESS_DATE,
                    TIMEOUT_MIN,
                    ACTION_PAGE,
                    FUSEACTION,
                    PARTNER_OR_CONSUMER,
                    USER_IP,
                    IS_GUARANTY_FOLLOWUP,
                    IS_PROJECT_FOLLOWUP,
                    IS_ASSET_FOLLOWUP,
                    IS_SALES_ZONE_FOLLOWUP,
                    IS_SMS,
                    IS_UNCONDITIONAL_LIST,
                    AUTHORITY_CODE_HR,
                    IS_SUBSCRIPTION_CONTRACT,
                    MONEY2,
                    SPECT_TYPE,
                    SERVER_MACHINE,
                    DOMAIN_NAME,
                    IS_IFRS,
                    RATE_ROUND_NUM,
                    DISCOUNT_VALID,
                    PRICE_DISPLAY_VALID,
                    COST_DISPLAY_VALID,
                    RATE_VALID,
                    PRICE_VALID,
                    DUEDATE_VALID,
                    CONSUMER_PRIORITY,
                    IS_MAXROWS_CONTROL_OFF,
                    ACTION_DATE,
                    IS_LOCATION_FOLLOW,
                    PURCHASE_PRICE_ROUND_NUM,
                    SALES_PRICE_ROUND_NUM,
                    IS_PROD_COST_TYPE,
                    IS_PROJECT_GROUP,
                    SPECIAL_MENU_FILE,
                    MEMBER_VIEW_CONTROL,
                    IS_ADD_INFORMATIONS,
                    IS_EFATURA,
                    EFATURA_DATE,
                    IS_EDEFTER,
                    IS_LOT_NO,
                    START_DATE,
                    FINISH_DATE,
                    IS_EARCHIVE,
                    EARCHIVE_DATE
                )
                VALUES
                (
                    '#CFID#',
                    '#CFTOKEN#',
                    '#trim(session_base.workcube_id)#',
                    #session_base.userid#,
                    1,
                    '#session_base.username#',
                    '#session_base.name#',
                    '#session_base.surname#',
                    <cfif isdefined("session_base.position_code")>#session_base.position_code#<cfelse>NULL</cfif>,
                    '#session_base.money#',
                    #session_base.time_zone#,
                    <cfif isdefined("session_base.position_name")>'#session_base.position_name#'<cfelse>NULL</cfif>,
                    '#session_base.language#',
                    <cfif isdefined("session_base.design_id")>#session_base.design_id#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.menu_id") and len(session_base.menu_id)>#session_base.menu_id#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.design_color")>#session_base.design_color#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.company_id")>#session_base.company_id#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.company")>'#left(session_base.company,200)#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.company_email")>'#left(session_base.company_email,50)#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.company_nick")>'#left(session_base.company_nick,75)#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.ehesap")>#session_base.ehesap#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.maxrows")>#session_base.maxrows#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.user_location")>'#session_base.user_location#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.period_id")>#session_base.period_id#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.period_year")>#session_base.period_year#<cfelse>#year(now())#</cfif>,
                    <cfif isdefined("session_base.period_is_integrated") and len(session_base.period_is_integrated)>#session_base.period_is_integrated#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.user_level")>'#session_base.user_level#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.our_company_info.workcube_sector")>'#session_base.our_company_info.workcube_sector#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_paper_closer") and len(session_base.our_company_info.is_paper_closer)>#session_base.our_company_info.is_paper_closer#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_cost") and len(session_base.our_company_info.is_cost)>#session_base.our_company_info.is_cost#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_cost_location") and len(session_base.our_company_info.is_cost_location)>#session_base.our_company_info.is_cost_location#<cfelse>0</cfif>,
                    '',
                    <cfif isDefined("session.sessionid")>
                    '#session.sessionid#',
                    <cfelse>
                    '#cookie.jsessionid#',
                    </cfif>
                    <cfif isdefined("session_base.our_company_id")>'#session_base.our_company_id#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.our_name")>'#session_base.our_name#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.our_nick")>'#session_base.our_nick#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.company_category")>'#session_base.our_company_id#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.admin") and len(session_base.admin)>#session_base.admin#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.power_user") and len(session_base.power_user)>#session_base.power_user#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.power_user_level_id") and len(session_base.power_user_level_id)>'#session_base.power_user_level_id#'<cfelse>''</cfif>,
                    <cfif isdefined("session_base.period_date") and len(session_base.period_date)>#createodbcdatetime(session_base.period_date)#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.process_date") and len(session_base.process_date)>#createodbcdatetime(session_base.process_date)#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.timeout_min") and len(session_base.timeout_min)>#session_base.timeout_min#<cfelse>30</cfif>,
                    NULL,
                    NULL,
                    <cfif isdefined("session_base.partner_or_consumer") and len(session_base.partner_or_consumer)>'#session_base.partner_or_consumer#'<cfelse>NULL</cfif>,
                    '#cgi.remote_addr#',
                    <cfif isdefined("session_base.our_company_info.guaranty_followup") and len(session_base.our_company_info.guaranty_followup)>#session_base.our_company_info.guaranty_followup#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.project_followup") and len(session_base.our_company_info.project_followup)>#session_base.our_company_info.project_followup#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.asset_followup") and len(session_base.our_company_info.asset_followup)>#session_base.our_company_info.asset_followup#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.sales_zone_followup") and len(session_base.our_company_info.sales_zone_followup)>#session_base.our_company_info.sales_zone_followup#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.sms") and len(session_base.our_company_info.sms)>#session_base.our_company_info.sms#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.unconditional_list") and len(session_base.our_company_info.unconditional_list)>#session_base.our_company_info.unconditional_list#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.authority_code_hr")>'#session_base.authority_code_hr#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.our_company_info.subscription_contract") and len(session_base.our_company_info.subscription_contract)>#session_base.our_company_info.subscription_contract#<cfelse>0</cfif>,
                    '#session_base.money2#',
                    #session_base.our_company_info.spect_type#,
                    <cfif isdefined("session_base.server_machine")>#session_base.server_machine#<cfelse>NULL</cfif>,
                    '#cgi.http_host#',
                    <cfif isdefined("session_base.our_company_info.is_ifrs")>#session_base.our_company_info.is_ifrs#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.rate_round_num")>#session_base.our_company_info.rate_round_num#<cfelse>4</cfif>,
                    <cfif isdefined("session_base.discount_valid") and len(session_base.discount_valid)>#session_base.discount_valid#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.price_display_valid") and len(session_base.price_display_valid)>#session_base.price_display_valid#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.cost_display_valid") and len(session_base.cost_display_valid)>#session_base.cost_display_valid#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.rate_valid") and len(session_base.rate_valid)>#session_base.rate_valid#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.price_valid") and len(session_base.price_valid)>#session_base.price_valid#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.duedate_valid") and len(session_base.duedate_valid)>#session_base.duedate_valid#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.consumer_priority") and len(session_base.consumer_priority)>#session_base.consumer_priority#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_maxrows_control_off") and len(session_base.our_company_info.is_maxrows_control_off)>#session_base.our_company_info.is_maxrows_control_off#<cfelse>0</cfif>,
                    #now()#,
                    <cfif isdefined("session_base.our_company_info.is_location_follow") and len(session_base.our_company_info.is_location_follow)>#session_base.our_company_info.is_location_follow#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.purchase_price_round_num") and len(session_base.purchase_price_round_num)>#session_base.purchase_price_round_num#<cfelse>4</cfif>,
                    <cfif isdefined("session_base.sales_price_round_num") and len(session_base.sales_price_round_num)>#session_base.sales_price_round_num#<cfelse>2</cfif>,
                    <cfif isdefined("session_base.is_prod_cost_type") and len(session_base.is_prod_cost_type)>#session_base.is_prod_cost_type#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.is_project_group") and len(session_base.is_project_group)>#session_base.is_project_group#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.special_menu_file") and len(session_base.special_menu_file)>'#session_base.special_menu_file#'<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.member_view_control") and len(session_base.member_view_control)>1<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_add_informations") and len(session_base.our_company_info.is_add_informations)>#session_base.our_company_info.is_add_informations#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_efatura") and len(session_base.our_company_info.is_efatura)>#session_base.our_company_info.is_efatura#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.efatura_date") and len(session_base.our_company_info.efatura_date)>#createodbcdatetime(session_base.our_company_info.efatura_date)#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_edefter") and len(session_base.our_company_info.is_edefter)>#session_base.our_company_info.is_edefter#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_lot_no") and len(session_base.our_company_info.is_lot_no)>#session_base.our_company_info.is_lot_no#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.period_start_date") and len(session_base.period_start_date)>#createodbcdatetime(session_base.period_start_date)#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.period_finish_date") and len(session_base.period_finish_date)>#createodbcdatetime(session_base.period_finish_date)#<cfelse>NULL</cfif>,
                    <cfif isdefined("session_base.our_company_info.is_earchive") and len(session_base.our_company_info.is_earchive)>#session_base.our_company_info.is_earchive#<cfelse>0</cfif>,
                    <cfif isdefined("session_base.our_company_info.earchive_date") and len(session_base.our_company_info.earchive_date)>#createodbcdatetime(session_base.our_company_info.earchive_date)#<cfelse>NULL</cfif>
                )
            </cfquery>
        </cfif>
        <cfreturn Replace(SerializeJSON(GET_LIST),'//','')>
    </cffunction>
    
    <cffunction name="logOut" access="remote" returntype="any">
    
        <cfquery name="DEL_WRK_SESSION" datasource="#dsn#">
            DELETE FROM WRK_SESSION WHERE USERID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.pp.userid#">
        </cfquery>
        <cfloop collection="#session#" item="key_field">
            <cfscript>
            if ((key_field neq 'error_text') and (key_field neq 'sessionid') and (key_field neq 'urltoken'))
                StructDelete(session,key_field);
            </cfscript>
        </cfloop>
        
	    <cfreturn 1>    
    </cffunction>
    <cffunction name="yetkiveral" access="remote" returntype="any" returnFormat="json">
        <cfargument name="pageinfo">
        <cfargument name="PARTNER_ID">
        <cfargument name="islem">
        <cfset durum=0>
        <cfif arguments.islem eq 1>
        
            <cfquery name="upddenied" datasource="#dsn#">
                UPDATE COMPANY_PARTNER_DENIED SET IS_VIEW =1 WHERE PARTNER_ID=#arguments.PARTNER_ID# and DENIED_PAGE='#arguments.pageinfo#'
            </cfquery>            
           <cfset durum=1>
        </cfif>
        <cfif arguments.islem eq 2>
            <cfquery name="getMax_id" datasource="#dsn#">
            select max(DENIED_PAGE_ID) AS MAX_ID  from w3Partner.COMPANY_PARTNER_DENIED
            </cfquery>
            <cfset maxid=getMax_id.MAX_ID+1>
                <cfquery name="upddenied" datasource="#dsn#">
                   INSERT INTO w3Partner.COMPANY_PARTNER_DENIED (IS_VIEW,PARTNER_ID,DENIED_PAGE,DENIED_PAGE_ID) VALUES (1,#arguments.PARTNER_ID#,'#arguments.pageinfo#',#maxid#)                
            </cfquery>
       <cfset durum=2>
        </cfif>
        <cfif arguments.islem eq 3>
          <cfquery name="upddenied" datasource="#dsn#">
                UPDATE COMPANY_PARTNER_DENIED SET IS_VIEW =0 WHERE PARTNER_ID=#arguments.PARTNER_ID# and DENIED_PAGE='#arguments.pageinfo#'
            </cfquery>
        <cfset durum=3>
        </cfif>
        <cfreturn durum> 
    </cffunction>
</cfcomponent>
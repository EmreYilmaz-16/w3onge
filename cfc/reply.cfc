<cfcomponent>

    <cffunction name = "init" access = "public" output="false" description = "Define dsn" returnType="reply">

        <cfargument name="dsn" type="string">
        <cfset variables.dsn = arguments.dsn>
        <cfreturn this>

    </cffunction>
    

    <cffunction name = "select" returnType = "any" access = "remote" description = "Get topic replies">

        <cfargument name="replyid" default="0">
        <cfargument name="topicid" default="0">
        <cfargument name="keyword" default="">
        <cfargument name="special_definition" default="">
        <cfargument name="reply_status" default="">
        <cfargument name="startrow" default="0">
        <cfargument name="maxrows" default="#session.ep.maxrows#">

        <cfquery name="GET_REPLIES" datasource="#variables.dsn#">
            WITH CTE1 AS(
                SELECT 
                    TOPICID,
                    USERKEY,
                    REPLY,
                    HIERARCHY,
                    UPDATE_DATE,
                    REPLYID,
                    FORUM_REPLY_FILE,
                    RECORD_EMP,
                    FORUM_REPLY_FILE_SERVER_ID,
                    SPECIAL_DEFINITION_ID,
                    IS_ACTIVE,
                    IMAGEID,
                    MAIN_HIERARCHY,
                    RECORD_DATE
                FROM 
                    FORUM_REPLYS
                WHERE 
                    <cfif isdefined("arguments.replyid") and arguments.replyid neq 0>
                        REPLYID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.replyid#">
                    <cfelseif isdefined("arguments.topicid") and arguments.topicid neq 0>
                        TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicid#">
                    </cfif>
                    <cfif isdefined("arguments.keyword") and len(arguments.keyword)>
                        AND REPLY LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#attributes.keyword#%">
                    </cfif>
                    <cfif isdefined("arguments.special_definition") and len(arguments.special_definition)>
                        AND SPECIAL_DEFINITION_ID LIKE <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.special_definition#">
                    </cfif>
                    <cfif (isDefined("arguments.reply_status") and len(arguments.reply_status))>
                        AND IS_ACTIVE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.reply_status#">
                    </cfif>
            ),
            CTE2 AS (
                        SELECT
                            CTE1.*,
                            ROW_NUMBER() OVER (	 
                                   ORDER BY MAIN_HIERARCHY DESC				    							    
                            ) AS RowNum,
                            (SELECT COUNT(*) FROM CTE1) AS QUERY_COUNT
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
        
        <cfreturn GET_REPLIES>
        
    </cffunction>

    <cffunction name = "insert" access = "public" description = "Add new reply for topic">
        
        <cfargument name="forumid" type="numeric" required="yes">
        <cfargument name="topicid" type="numeric" required="yes">
        <cfargument name="reply" type="string" required="yes">
        <!---<cfargument name="special_definition" type="string" required="yes" default="">--->
        <cfargument name="fileFullName" type="string" default="">
        <cfargument name="file_name" type="string" default="">
        <cfargument name="server_machine" type="string" default="">
        <cfargument name="domain" type="struct" required="yes">
    <!---
        <cftry>
--->
            <cftransaction>
                <cfquery name="ADD_REPLY" datasource="#variables.dsn#" result="MAX_ID">
                    INSERT INTO 
                        FORUM_REPLYS 
                        (
                            TOPICID, 
                            USERKEY, 
                            REPLY,
                            VERIFIED,
                            SPECIAL_DEFINITION_ID,
                            <cfif isdefined("arguments.file_name") and len(arguments.file_name)>
                                FORUM_REPLY_FILE,
                                FORUM_REPLY_FILE_SERVER_ID,
                            </cfif>
                            IS_ACTIVE,
                            RECORD_DATE,
                            RECORD_IP,
                            RECORD_EMP,
                            UPDATE_DATE,
                            UPDATE_IP,
                            UPDATE_EMP
                        )
                        VALUES  
                        (
                            #topicid#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.ep.userkey#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#reply#">,
                            1,
                            <!---<cfif isDefined('arguments.special_definition') and len(arguments.special_definition)>#arguments.special_definition#<cfelse>NULL</cfif>--->NULL,
                            <cfif isdefined("arguments.file_name") and len(arguments.file_name)>
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.file_name#">,
                                #arguments.server_machine#,
                            </cfif>
                            1,
                            #now()#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                            #session.ep.userid#,
                            #now()#,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
                            #session.ep.userid#
                        )
                </cfquery>
                <cfquery name="UPD_" datasource="#variables.dsn#">
                    UPDATE
                        FORUM_REPLYS
                    SET
                        <cfif isdefined("arguments.first_hie") and len(arguments.first_hie)>
                            HIERARCHY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_hie#.#max_id.identitycol#">,
                            MAIN_HIERARCHY = #listfirst(arguments.first_hie,'.')#
                        <cfelse>
                            HIERARCHY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#max_id.identitycol#">,
                            MAIN_HIERARCHY = #max_id.identitycol#
                        </cfif>
                    WHERE
                        REPLYID = <cfqueryparam cfsqltype="cf_sql_integer" value="#max_id.identitycol#">
                </cfquery>
                <cfquery name="EMAIL_EMPS" datasource="#variables.dsn#">
                    SELECT EMAIL_EMPS, TITLE FROM FORUM_TOPIC WHERE TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicid#">
                </cfquery>
                <cfif not isdefined("email_emp")><cfset email_emp = 0></cfif>
                <!--- istek varsa email listesine ekle --->
                <cfset new_emails = valuelist(email_emps.email_emps)>
                <cfif email_emp neq 0>
                    <!--- listede yoksa ekle --->
                    <cfif listfindnocase(new_emails,email_emp) eq 0>
                        <cfset new_emails = listappend(new_emails,email_emp)>
                    </cfif>
                <cfelse>
                <!--- listede varsa çıkar --->
                    <cfif listfindnocase(new_emails,session.ep.userid) neq 0>
                        <cfset new_emails = listdeleteat(new_emails,listfindnocase(new_emails,session.ep.userid))>
                    </cfif>
                </cfif>
                <cfquery name="UPD_EMP_EMAIL_ALERTS" datasource="#variables.dsn#">
                    UPDATE
                        FORUM_TOPIC
                    SET
                        EMAIL_EMPS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#NEW_EMAILS#">
                    WHERE
                        TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicid#">
                </cfquery>
                <cfquery name="UPD_FORUM_LAST_MSG_DATE" datasource="#variables.dsn#">
                    UPDATE
                        FORUM_MAIN
                    SET
                        LAST_MSG_DATE = #now()#,
                        LAST_MSG_USERKEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.EP.USERKEY#">,
                        REPLY_COUNT = REPLY_COUNT + 1
                    WHERE
                        FORUMID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.forumid#">
                </cfquery>
                <cfquery name="UPD_TOPIC_LAST_REPLY_DATE" datasource="#variables.dsn#">
                    UPDATE
                        FORUM_TOPIC
                    SET
                        LAST_REPLY_DATE = #now()#,
                        LAST_REPLY_USERKEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.EP.USERKEY#">,
                        REPLY_COUNT = REPLY_COUNT + 1
                    WHERE
                        TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicid#">
                </cfquery>
                <!--- alert email at--->
                <cfquery name="EMAIL_IDS" datasource="#variables.dsn#">
                    SELECT
                        EMAIL_EMPS,
                        EMAIL_PARS,
                        EMAIL_CONS
                    FROM
                        FORUM_TOPIC
                    WHERE
                        TOPICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicid#">
                </cfquery>
                <cfif isDefined('arguments.work_id') and len(arguments.work_id)>
                    <cfquery name="UPD_WORK" datasource="#variables.dsn#">
                        UPDATE
                            PRO_WORKS
                        SET
                            FORUM_REPLY_ID = #max_id.identitycol#
                        WHERE
                            WORK_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.work_id#">
                    </cfquery>
                </cfif>

                <cfset mailfrom_ = "#session.ep.company#<#session.ep.company_email#>">

                <cfif len(email_ids.email_emps)>
                    <cfquery name="EMP_EMAILS" datasource="#DSN#">
                        SELECT 
                            EP.EMPLOYEE_NAME AS NAME,
                            EP.EMPLOYEE_SURNAME AS SURNAME,
                            E.EMPLOYEE_EMAIL AS EMAIL
                        FROM
                            EMPLOYEES E,
                            EMPLOYEE_POSITIONS EP
                        WHERE
                            E.EMPLOYEE_EMAIL IS NOT NULL AND
                            EP.EMPLOYEE_ID = E.EMPLOYEE_ID AND
                            E.EMPLOYEE_ID IN (#email_ids.email_emps#) AND
                            E.EMPLOYEE_EMAIL <> ''
                    </cfquery>
                    <cfset siteDomain = arguments.domain.user_domain>
                    <cfloop query="emp_emails">
                        <cfmail from="#mailfrom_#" to="#email#" subject="#email_emps.title# !" type="HTML">
                        <cfinclude template="../query/add_reply_mail.cfm">
                        </cfmail>
                    </cfloop>
                </cfif>
                <cfif len(email_ids.email_pars)>
                    <cfquery name="PAR_EMAILS" datasource="#DSN#">
                        SELECT
                            COMPANY_PARTNER_NAME AS NAME,
                            COMPANY_PARTNER_SURNAME AS SURNAME,
                            COMPANY_PARTNER_EMAIL AS EMAIL
                        FROM
                            COMPANY_PARTNER
                        WHERE
                            PARTNER_ID IN (#email_ids.email_pars#)
                            AND
                            COMPANY_PARTNER_EMAIL <> ''
                    </cfquery>
                    <cfset siteDomain = arguments.domain.partner_domain>
                    <cfloop query="par_emails">
                        <cfmail from="#mailfrom_#" to="#email#" subject="#email_emps.title# !" type="HTML">
                            <cfinclude template="add_reply_mail.cfm">
                        </cfmail>
                    </cfloop>
                </cfif>
                <cfif len(email_ids.email_cons)>
                    <cfquery name="CON_EMAILS" datasource="#DSN#">
                        SELECT
                            CONSUMER_NAME AS NAME,
                            CONSUMER_SURNAME AS SURNAME,
                            CONSUMER_EMAIL AS EMAIL
                        FROM
                            CONSUMER
                        WHERE
                            CONSUMER_ID IN (#email_ids.email_cons#)
                            AND
                            CONSUMER_EMAIL <> ''
                    </cfquery>
                    <cfset siteDomain = arguments.domain.public_domain>
                    <cfloop query="con_emails">
                        <cfmail from="#mailfrom_#" to="#email#" subject="#email_emps.title# !" type="HTML">
                            <cfinclude template="add_reply_mail.cfm">
                        </cfmail>
                    </cfloop>
                </cfif>
            
            </cftransaction>
<!----
            <cfcatch type = "any">
                <cfreturn false>
            </cfcatch>
        </cftry>
     ---->
        <cfreturn true>

    </cffunction>

</cfcomponent>
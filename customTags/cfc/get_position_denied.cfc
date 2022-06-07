<cfcomponent>
    <cfset dsn = application.systemParam.systemParam().dsn>
    <cffunction name= "GET_EMP_DEL_BUTTONS" access="remote" returntype="any">
        <cfargument name="module_name" default="">                                               
        <cfargument name="position_id" default="">                         
        <cfargument name="user_id" default="">  
        <cfargument name="denied_page" default="">                         
        <cfquery name="GET_EMP_DEL_BUTTONS" datasource="#DSN#">
            SELECT
                ED.DENIED_PAGE,
                ED.IS_DELETE
            FROM
                EMPLOYEE_POSITIONS_DENIED ED,
                EMPLOYEE_POSITIONS E
            WHERE
                (ED.IS_DELETE = 1) AND
                ED.DENIED_TYPE = 1 AND
                ED.MODULE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.module_name#"> AND
                ED.DENIED_PAGE = '#arguments.denied_page#' AND
                ED.DENIED_PAGE NOT IN
                (
                    SELECT
                        DENIED_PAGE
                    FROM
                        EMPLOYEE_POSITIONS_DENIED EPD,
                        EMPLOYEE_POSITIONS EP
                    WHERE
                        (EPD.IS_DELETE = 1) AND
                        EPD.DENIED_TYPE = 1 AND
                        EPD.MODULE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.module_name#"> AND
                        EPD.DENIED_PAGE =<cfqueryparam cfsqltype="cf_sql_varchar" value='#arguments.denied_page#'> AND
                        EP.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.position_id#"> AND
                        (
                            EPD.POSITION_CODE = EP.POSITION_CODE OR
                            EPD.POSITION_CAT_ID = EP.POSITION_CAT_ID OR
                            EPD.USER_GROUP_ID = EP.USER_GROUP_ID
                        )
                )
                    UNION 
                    SELECT
                        U.OBJECT_NAME AS DENIED_PAGE,
                        DELETE_OBJECT AS IS_DELETE
                    FROM
                        EMPLOYEE_POSITIONS AS E
                        LEFT JOIN USER_GROUP_OBJECT AS U ON E.USER_GROUP_ID = U.USER_GROUP_ID
                    WHERE
                        E.EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
                        AND U.OBJECT_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value='#arguments.denied_page#'>
        </cfquery>
        <cfreturn GET_EMP_DEL_BUTTONS>
    </cffunction>   
</cfcomponent>
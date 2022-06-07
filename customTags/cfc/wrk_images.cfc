<cfcomponent>
	<cfset dsn = application.systemParam.systemParam().dsn>
    <cfset dsn1 = '#application.systemParam.systemParam().dsn#_product'>
    <cffunction name="GET_IMAGES" access="remote" returntype="query">
        <cfquery name="GET_IMAGES" datasource="#DSN1#">
            SELECT 
                PI.IMAGE_SIZE,
                PI.PRODUCT_IMAGEID,
                PI.PATH,
                PI.PRD_IMG_NAME AS NAME,
                PI.DETAIL,
                PI.PATH_SERVER_ID,
                PI.STOCK_ID,
                PI.IS_EXTERNAL_LINK,
                PI.VIDEO_LINK,
                PI.VIDEO_PATH,
                PI.IMAGE_SIZE,
                P.PRODUCT_NAME
            FROM
                PRODUCT_IMAGES PI,
                PRODUCT P
            WHERE
                P.PRODUCT_ID = PI.PRODUCT_ID AND
                PI.PRODUCT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pid#">
            ORDER BY
                PI.PRODUCT_IMAGEID DESC   
        </cfquery>
        <cfreturn GET_IMAGES>
    </cffunction> 
    <cffunction name="GET_BRANDS_IMAGES" access="remote" returntype="query">
        <cfquery name="GET_BRANDS_IMAGES" datasource="#DSN1#">
            SELECT 
                PBI.IMAGE_SIZE,
                PBI.BRAND_IMAGEID AS PRODUCT_IMAGEID,
                PBI.PATH,
                PI.PRD_IMG_NAME AS NAME,
                PBI.DETAIL,
                PBI.PATH_SERVER_ID,
                PBI.IS_EXTERNAL_LINK,
                PB.BRAND_NAME
            FROM
                PRODUCT_BRANDS_IMAGES PBI,
                PRODUCT_BRANDS PB
            WHERE
                PB.BRAND_ID = PBI.BRAND_ID AND
                PBI.BRAND_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.brand_id#">
            ORDER BY
                PRODUCT_IMAGEID DESC
        </cfquery>
        <cfreturn GET_BRANDS_IMAGES>
    </cffunction> 
    <cffunction name="GET_IMAGE_CONT" access="remote" returntype="query">
        <cfquery name="GET_IMAGE_CONT" datasource="#DSN#">
                SELECT 
                    CNT_IMG_NAME AS NAME,
                    CONTIMAGE_ID, 
                    CONTIMAGE_SMALL AS PATH, 
                    IMAGE_SERVER_ID,
                    IMAGE_SIZE, 
                    IS_EXTERNAL_LINK,
                    PATH AS VIDEO_PATH, 
                    VIDEO_LINK
                FROM 
                    CONTENT_IMAGE 
                WHERE 
                    CONTENT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contentId#">
        </cfquery>
        <cfreturn GET_IMAGE_CONT>
    </cffunction> 
    <cffunction name="GET_STOCKS" access="remote" returntype="query">
        <cfquery name="GET_STOCKS" datasource="#DSN1#">
            SELECT STOCK_CODE,STOCK_ID,PROPERTY FROM STOCKS WHERE PRODUCT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.stocksId#">
        </cfquery>
        <cfreturn GET_STOCKS>
    </cffunction>
    <cffunction name="GET_LANGUAGE" access="remote" returntype="query">
        <cfquery name="GET_LANGUAGE" datasource="#DSN#">
            SELECT LANGUAGE_SHORT,LANGUAGE_SET FROM SETUP_LANGUAGE ORDER BY LANGUAGE_ID ASC
        </cfquery>
        <cfreturn GET_LANGUAGE>
    </cffunction>
    <cffunction name="GET_IMAGE_" access="remote" returntype="query">
        <cfquery name="GET_IMAGE_" datasource="#DSN1#">
            SELECT * FROM #arguments.table# WHERE #arguments.identity_column# = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
        </cfquery>
        <cfreturn GET_IMAGE_>
    </cffunction>
    <cffunction name="GET_IMAGE_CONTENT" access="remote" returntype="query">
        <cfquery name="GET_IMAGE_CONTENT" datasource="#DSN#">
                SELECT 
                    CNT_IMG_NAME AS NAME,
                    CONTIMAGE_ID, 
                    CONTIMAGE_SMALL AS PATH, 
                    IMAGE_SERVER_ID,
                    IMAGE_SIZE, 
                    IS_EXTERNAL_LINK,
                    PATH AS VIDEO_PATH, 
                    VIDEO_LINK,
                    LANGUAGE_ID,
                    CNT_IMG_NAME ,
                    DETAIL,
                    UPDATE_EMP,
                    UPDATE_DATE,
                    CONTENT_ID 
                FROM 
                    CONTENT_IMAGE 
                WHERE 
                    CONTIMAGE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.action_id#">
        </cfquery>
        <cfreturn GET_IMAGE_CONTENT>
    </cffunction> 
</cfcomponent>
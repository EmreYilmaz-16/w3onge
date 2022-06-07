<cfcomponent>
	<cfset dsn = application.systemParam.params().dsn>
    <cffunction name="GET_ASSET_CAT" access="remote"   returntype="any" returnformat="json"
                produces="application/json">
                <cfset ass=urlDecode(replace(cgi.QUERY_STRING,"+","%2B"))>
                        <cfset str = StructNew()>
        <cfloop index = "ListElement" list = "#ass#" delimiters = "&">
        	<cfset str['#listFirst(ListElement,"=")#'] = listLast(ListElement,"=")> 
        </cfloop>
        		<cfscript>
            temp = str['password'];
            cryptedPassword = hash(temp);
			str['password'] = cryptedPassword;
        </cfscript>
        <cfquery name="Login" datasource="#dsn#">
        SELECT EMPLOYEE_ID,EMPLOYEE_NAME,EMPLOYEE_SURNAME,PHOTO,count(*) as HAS FROM w3Partner.EMPLOYEES WHERE EMPLOYEE_USERNAME=<cfqueryparam cfsqltype="cf_sql_varchar" value="#str['username']#">
         AND EMPLOYEE_PASSWORD =<cfqueryparam cfsqltype="cf_sql_varchar" value="#str['password']#">
         group by EMPLOYEE_NAME,EMPLOYEE_SURNAME,EMPLOYEE_ID,PHOTO         
        </cfquery>
        <cfset returnObj=structNew()>
        <cfset returnObj.EMPLOYEE_NAME=Login.EMPLOYEE_NAME>
        <cfset returnObj.EMPLOYEE_SURNAME=Login.EMPLOYEE_SURNAME>
        <cfset returnObj.HAS=Login.HAS>
        <cfset returnObj.PHOTO=Login.PHOTO>
         <cfset returnObj.EMPLOYEE_ID=Login.EMPLOYEE_ID>
<cfreturn Replace(SerializeJSON(returnObj),'//','')>

     </cffunction>  
     <cffunction  name="setData"  httpMethod="post" access="remote" rreturntype="any" returnformat="json"
                produces="application/json" >
<cfargument  name="konu" default="">
<cfargument  name="dessc" default="">
<cfquery name="insertQuery" datasource="#dsn#">
INSERT INTO TestTable(Konu,Descriptions) VALUES('#konu#','#desc#')
</cfquery>
<cfset ss2=structNew()>
<cfset ss2.donen="1">
<cfreturn Replace(SerializeJSON(ss2),'//','')>
</cffunction> 
<cffunction  name="get_Processcats" httpMethod="GET" access="remote" rreturntype="any" returnformat="json"
                produces="application/json" >
<cfargument  name="empid" default="">
<cfargument  name="ooops" default="">
<cfquery name="getpcat" datasource="#dsn#">
SELECT PR.PROCESS_ROW_ID,PR.STAGE FROM w3Partner.PROCESS_TYPE AS PT,w3Partner.PROCESS_TYPE_ROWS AS PR
WHERE PT.PROCESS_ID =PR.PROCESS_ID AND PT.FACTION LIKE '%#ooops#%'
AND PR.PROCESS_ROW_ID IN (SELECT PROCESS_ROW_ID FROM w3Partner.PROCESS_TYPE_ROWS_POSID WHERE PRO_POSITION_ID=
(SELECT POSITION_ID FROM w3Partner.EMPLOYEE_POSITIONS WHERE EMPLOYEE_ID=#empid# ))
</cfquery>
<cfset poslist=structNew()>
<cfset myarr=arrayNew(1)>
<cfloop query="getpcat">
<cfscript>
proc=[PROCESS_ROW_ID,STAGE];
ArrayAppend(myarr,proc,true);
</cfscript>
</cfloop>
<cfset poslist.pos=myarr>

<cfreturn Replace(SerializeJSON(poslist),'//','')>
</cffunction>

</cfcomponent>

<!--- json_type parametresi 1 : tab menü, 2: page bar, null : page designer 
	objectID parametresi gelirse pageBar duzenleniyor
--->
	
<cfcomponent>
	<cffunction name="params" access="remote" returntype="struct">
    	<cfscript>
			var systemParam.dsn = 'W3ONGE';
			var systemParam.uploadFolder = '\\devappsrv\documents\';
		</cfscript>
        <cfreturn systemParam>
    </cffunction>
</cfcomponent>
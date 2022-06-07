<cfcomponent hint="B2B operasyonlari">
    <cfset dsn = application.systemParam.params().dsn>
    <cffunction  name="addTakip"  access="remote" returntype="any" returnFormat="json" httpMethod="POST" description="Kategorileri Getirir" output="no">
        <cfargument name="takip_note">
        <cfargument name="onge_id">
        <cfargument name="employee_id">

        <cfquery name="insertOnge" datasource="#dsn#" result="res">
            INSERT INTO ONGE_TAKIP (ONGE_ID,RECOR_EMP,RECORD_DATE,TAKIP) VALUES (#arguments.onge_id#,#arguments.employee_id#,GETDATE(),'#arguments.takip_note#')
        </cfquery>
         <cfreturn Replace(SerializeJSON(res),'//','')>
    </cffunction>
    <cffunction  name="getTakip"  access="remote" returntype="any" returnFormat="json" httpMethod="POST" description="Kategorileri Getirir" output="no">
        <cfargument name="onge_id"> 
        <cfquery name="insertOnge" datasource="#dsn#" >
            SELECT OT.*,EMP.EMPLOYEE_NAME+' '+EMP.EMPLOYEE_SURNAME AS EMPLOYEE FROM ONGE_TAKIP AS OT 
            LEFT JOIN EMPLOYEES AS EMP ON EMP.EMPLOYEE_ID=OT.RECOR_EMP WHERE ONGE_ID=#arguments.onge_id#
        </cfquery>
        <cfset res_data=structNew()>
        <cfset res_data.recordCount=insertOnge.recordCount>
            <cfset returnarr=arrayNew(1)>
        <cfloop query="insertOnge">
            <cfscript>
                item={
                    TAKIP=TAKIP,
                    EMP=EMPLOYEE,
                    REC_DATE="#dateformat(RECORD_DATE,"dd/mm/yyyy")# #timeFormat(RECORD_DATE,"HH:nn")#" 
                };
                arrayAppend(returnarr,item);
            </cfscript>
        </cfloop>
        <cfset res_data.data=returnarr>
        <cfreturn Replace(SerializeJSON(res_data),'//','')>
    </cffunction>
</cfcomponent>
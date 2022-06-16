<cfquery name="getEMp" datasource="#dsn#">
    SELECT * FROM EMPLOYEES
</cfquery>
<table class="table striped subcompact">
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                Çalışan Adı
            </th>
            <th>
                Soyadı
            </th>
            
        </tr>
    </thead>
<tbody>
    <cfoutput query="getEMp">
    <tr>
        <td>
            #currentrow#
        </td>
        <td>
           <a href="/index.cfm?fuseaction=employee.update_employee&employee_id=#EMPLOYEE_ID#">#EMPLOYEE_NAME#</a>
        </td>
        <td>
            #EMPLOYEE_SURNAME#
        </td>
    </tr>
</cfoutput>
</tbody>
</table>
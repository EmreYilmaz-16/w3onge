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
            #EMPLOYEE_NAME#
        </td>
        <td>
            #EMPLOYEE_SURNAME#
        </td>
    </tr>
</cfoutput>
</tbody>
</table>
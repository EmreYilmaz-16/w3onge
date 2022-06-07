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
            <a href="javascript://" onclick="selectEmployee(#EMPLOYEE_ID#,'#EMPLOYEE_NAME# #EMPLOYEE_SURNAME#')">
            #EMPLOYEE_NAME# #EMPLOYEE_SURNAME#</a>
        </td>
    </tr>
</cfoutput>
</tbody>
</table>



<script>
   
    function selectEmployee(id,name){
        window.opener.selectEmployee(id,name)
   
    }
    
</script>

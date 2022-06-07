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
>
<script>
   <cfoutput>  
    function selectEmployee(id,name){
    window.opener.#attributes.field_emp_id#.value=id
    window.opener.#attributes.field_name#.value=name
    this.close();
    }
    </cfoutput> 
</script>
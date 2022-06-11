<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&onge_id=#attributes.onge_id#">
<cfquery name="getstages" datasource="#dsn#">
    SELECT * FROM PROCESS_TYPE_ROWS WHERE PROCESS_TYPE_ID IN (SELECT PROCESS_TYPE_ID FROM PROCESS_TYPE WHERE FACTION LIKE '%#attributes.fuseaction#%')
</cfquery>
<style>
    .ck-editor__editable_inline {
min-height: 250px;
}
</style>
<input type="checkbox" data-role="switch" data-material="true" name="status" data-caption="Aktif">
<p>Başlık</p>
<input type="text" data-role="input" name="ROW_HEADER" class="">

<p>Süreç</p>
<select  data-role="select" name="stage" data-filter="false">      
    <cfoutput query="getstages">
        <option value="#PROCESS_ROW_ID#">#STAGE#</option>
    </cfoutput>
</select>

<p>Açıklama</p>
<textarea type="text" id="editor" name="ROW_DESCRIPTION" class=""></textarea>

<p>Görevli</p>
<div id="görevli_area">
    <table class="table striped ">
        <thead>
            <tr>
                <th>
                    Çalışan
                </th>
                <th>Görevi</th>
                <th><a  class="button secondary outline" href="javascript://" onclick="windowopen('/index.cfm?fuseaction=objects.popup_list_positions_multiuser&res_id=employees&form_name=onge&main_div=görevli_area','page')"><span class="mif-user-plus"></span></th></a>
            </tr>                
        </thead>
        <tbody id="employees" name="employees">

        </tbody>
    </table>
</div>

<input type="hidden" name="is_submit">
<input type="submit">



</cfform>


<script src="/ckeditor/ckeditor.js"></script>
<script>
    ClassicEditor
        .create( document.querySelector( '#editor' ), {
            // toolbar: [ 'heading', '|', 'bold', 'italic', 'link' ]
        } )
        .then( editor => {
            window.editor = editor;
        } )
        .catch( err => {
            console.error( err.stack );
        } );

    function getData() {
        console.log(arguments)
        
    }
</script>

<div style="display:none">
    <select  class="input-small" data-role="select" name="emp_ix_role" data-filter="false">
        <option value="">Seçiniz</option>
        <cfquery name="getRoles" datasource="#dsn#">
            SELECT * FROM ONGE_ROLES
        </cfquery>
        <cfoutput query="getRoles">
            <option value="#ROLE_ID#">#ONGE_ROLE#</option>
        </cfoutput>
    </select>
</div>

<script> 
    function selectEmployee(id,name){
        var tr=document.createElement("tr");
var td=document.createElement("td");
var i=document.createElement("input");
i.setAttribute("type","hidden");
i.setAttribute("name","employe_ids")
i.setAttribute("value",id);
td.innerText=name
td.appendChild(i);
tr.appendChild(td);

var td=document.createElement("td");
var e=document.getElementsByName("emp_ix_role")[0].cloneNode(true); 
e.setAttribute("name","emp_ix_role_"+id) 
td.appendChild(e);
tr.appendChild(td);
var td=document.createElement("td");
var btn=document.createElement("button")
var ix=document.createElement("span");
ix.setAttribute("class","mif-user-minus");
btn.appendChild(ix);
btn.setAttribute("onclick","removeRow(this)")
btn.setAttribute("type","button")
btn.setAttribute("class","button alert outline")
td.appendChild(btn);
tr.appendChild(td);
document.getElementById("employees").appendChild(tr);
    }

    function removeRow(el) {
        el.parentElement.parentElement.remove();
    }
    </script>



<cfif isDefined("attributes.is_submit")>
 

    <cfquery name="insertOngeMain" datasource="#dsn#" result="res">
        INSERT INTO
        ONGE_ROWS(ROW_HEADER, 
          ROW_DESCRIPTION,           
          ROW_STAGE, 
          ONGE_STATUS,  
          ONGE_ID,       
          RECORD_EMP, 
          RECORD_DATE
          ) VALUES(
              '#attributes.ROW_HEADER#',
              '#attributes.ROW_DESCRIPTION#',              
              #attributes.STAGE#,
            <cfif isDefined("attributes.status")>1<cfelse>0</cfif>,
            #attributes.onge_id#,
              #session.ep.USERID#,
              GETDATE()
              
          )
    </cfquery>
  
    <cfloop list="#attributes.EMPLOYE_IDS#" item="i">
        <cfquery name="insertW" datasource="#dsn#">
            INSERT INTO ONGE_ROW_EMPLOYEE
                (ONGE_ROW_ID, EMP_ID, ROLE_ID)
            VALUES (#res.IDENTITYCOL#,#i#,#evaluate("attributes.EMP_IX_ROLE_#i#")#)
        </cfquery>
    </cfloop>

</cfif>


<!----
<cfquery name="getEmp" datasource="#dsn#">
    SELECT *,EMPLOYEE_NAME+' '+EMPLOYEE_SURNAME AS EMP FROM EMPLOYEES
</cfquery>

<cf_multiple_select query="#getEmp#" value_column="EMPLOYEE_ID" text_column="EMP">
    ---->
<cfparam name="attributes.ONGE_ID" default="1">
<cfparam name="attributes.EMPLOYEE_ID" default="1">
<cfquery name="getstages" datasource="#dsn#">
    SELECT * FROM PROCESS_TYPE_ROWS WHERE PROCESS_TYPE_ID IN (SELECT PROCESS_TYPE_ID FROM PROCESS_TYPE WHERE FACTION LIKE '%#attributes.fuseaction#%')
</cfquery>
<cfquery name="getMain" datasource="#DSN#">
     SELECT * FROM ONGE_MAIN
</cfquery>
<cfquery name="get_employee" datasource="#DSN#">
    SELECT * FROM EMPLOYEES
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" name="onge">
    <cfoutput>
    <p>Başlık</p>
    <input type="text" name="ONGE_HEADER" data-role="input" class="" value="#getMain.ONGE_HEADER#">
    <p>Bildiren</p>
    <input type="hidden" name="EMPLOYEE_ID" >
    <script>
        var emp_buttons=[
            {
                html:"<span class='mif-user'></span>",
                cls:"alert",
                onclick:"windowopen('index.cfm?fuseaction=objects.popup_list_positions&field_emp_id=onge.EMPLOYEE_ID&field_name=onge.EMPLOYEE_NAME','page')"
            }
        ]
    </script>

    <input type="text" name="EMPLOYEE_NAME" data-role="input" class="" data-custom-buttons="emp_buttons" value="#get_employee.EMPLOYEE_NAME#">
    <p>Süreç</p>
    <!---<select  data-role="select" name="stage" data-filter="false">      
        <cfoutput query="getstages">
            <option value="#PROCESS_ROW_ID#">#STAGE#</option>
        </cfoutput>
    </select>--->
    <p>Açıklama</p>
    <textarea id="editor" name="editor" value="#getMain.ONGE_DESCRIPTION#">
        <p>The editor content goes here.</p>
    </textarea>
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
            <tbody id="employees" name="employees" value="#get_employee.EMPLOYEE_ID#">

            </tbody>
        </table>
    </div>

    <input type="hidden" name="is_submit">
    <input type="submit" value="Güncelle">
</cfoutput>
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

<!----
    openBoxDraggable('index.cfm?fuseaction=objects.popup_list_positions&
    field_emp_id=order_form.order_employee_id&field_name=order_form.order_employee&is_form_submitted=1&select_list=1');
    ----->
<cfif isDefined("attributes.is_submit") >
    <cfif not isDefined("session.ep.USERID")>
        <cfset session.ep.USERID=1>
    </cfif>
    <cfparam name="attributes.ONGE_CATID" default="1">
    <cfquery name="updOngeMain" datasource="#dsn#">
        UPDATE ONGE_MAIN 
        SET  ONGE_HEADER='#attributes.ONGE_HEADER#',
             EMPLOYEE_NAME='#attributes.EMPLOYEE_NAME#',
            <!--- stage='#attributes.STAGE#',--->
             editor='#attributes.editor#',
             employees='#attributes.employees#'
        WHERE ONGE_ID=#attributes.ONGE_ID#
    </cfquery>
    <cfdump var="#res.IDENTITYCOL#">
    <!---<cfloop list="#attributes.EMPLOYE_IDS#" item="i">
        <cfquery name="insertW" datasource="#dsn#">
            INSERT INTO ONGE_EMPLOYEE
                (ONGE_ID, EMP_ID, ROLE_ID)
            VALUES (#res.IDENTITYCOL#,#i#,#evaluate("attributes.EMP_IX_ROLE_#i#")#)
        </cfquery>
    </cfloop>--->
</cfif>

    <cfdump var="#attributes#">

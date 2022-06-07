<cfif not isDefined("session.ep.USERID")>
    <cfset session.ep.USERID=1>
</cfif>
<cfparam name="attributes.ONGE_ID" default="2">
<cfquery name="getOnge" datasource="#dsn#">
  SELECT PTR.STAGE,OM.ONGE_HEADER,OM.ONGE_DESCRIPTION,OM.RECORD_DATE,OC.ONGE_CAT,E.EMPLOYEE_NAME+' '+E.EMPLOYEE_SURNAME AS NOTIFY_EMP,E2.EMPLOYEE_NAME+' '+E2.EMPLOYEE_SURNAME AS REC_EMP FROM ONGE_MAIN AS OM
LEFT JOIN ONGE_CATS AS OC ON OC.ONGE_CATID=OM.ONGE_CATID
LEFT JOIN PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID=OM.ONGE_STAGE
LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID =OM.NOTIFY_EMPLOYEE
LEFT JOIN EMPLOYEES AS E2 ON E2.EMPLOYEE_ID =OM.RECORD_EMP
 where OM.ONGE_ID =#attributes.ONGE_ID#
</cfquery>
<div class="row">
    <div class="cell-9">
        <div data-role="panel"
        data-title-caption="Önge"
        data-collapsed="false"
        data-collapsible="true">
    
        <cfoutput>
      
            <b>
                #getOnge.ONGE_HEADER#
            </b>
         
           
            <div class="p-2">
                #decodeForHTML(getOnge.ONGE_DESCRIPTION)#
            </div>
            <hr>
            <table>
                <tr>
                    <td>
                     <code> <b> Bildiren :</b></code>
                    </td>
                    <td>
                    <code>#getOnge.NOTIFY_EMP#</code>
                    </td>
                    <td>
                        <code> <b> Bildirim Tarihi :</b></code>
                       </td>
                       <td>
                       <code>#dateformat(getOnge.RECORD_DATE,"dd/mm/yyyy")# #timeFormat(getOnge.RECORD_DATE,"HH:nn")#</code>
                       </td>
                       <td>
                        <code> <b> Önge Kategorisi:</b></code>
                       </td>
                       <td>
                       <code>#getOnge.ONGE_CAT#</code>
                       </td>
                       <td>
                        <code> <b> Süreç:</b></code>
                       </td>
                       <td>
                       <code>#getOnge.STAGE#</code>
                       </td>
                </tr>
            </table>
        </div>
        <div data-role="panel"
        data-title-caption="Takipler"
        data-collapsed="true"
        data-collapsible="true">
        <div class="row">
            <div class="cell-4">
                <style>
                    .ck-editor__editable_inline {
    min-height: 350px;
}
                </style>
            <textarea id="txt_takip" name="txt_takip">

        </textarea>
        
        <button class="button outline success" onclick="takipEkle(#session.ep.USERID#,#attributes.ONGE_ID#)" type="button">Takip Ekle</button>
    </div>
    <div class="cell-8" style="max-height:450px;overflow-y: scroll;">
        <ul class="items-list" id="mesaj_list">
            <cfquery name="insertOnge" datasource="#dsn#" >
                SELECT OT.*,EMP.EMPLOYEE_NAME+' '+EMP.EMPLOYEE_SURNAME AS EMPLOYEE FROM ONGE_TAKIP AS OT 
                LEFT JOIN EMPLOYEES AS EMP ON EMP.EMPLOYEE_ID=OT.RECOR_EMP WHERE ONGE_ID=#attributes.onge_id#
            </cfquery>
            <cfloop query="insertOnge">
            <li>
                <img class="avatar" src="/mg.jpg">
                <span class="label">#EMPLOYEE#</span>
                <span class="second-label">#TAKIP#</span>
                <span class="second-label">#dateformat(RECORD_DATE,"dd/mm/yyyy")# #timeFormat(RECORD_DATE,"HH:nn")#</span>
            </li>
        </cfloop>
        </ul>
    </div>
    </div>
    
        </div>
        <div data-role="panel"
        data-title-caption="Önge Adımları"
        data-collapsed="true"
        data-collapsible="true">
        <table class="table">
            <tr>
                <th>
                    
                </th>
                <th>
                    Süreç
                </th>
                <th>
                    <a class="button" href="javascript://" onclick="windowopen('/index.cfm?fuseaction=onge.emptypopup_add_onge_row&onge_id=#attributes.ONGE_ID#','list')"><span class="mif-plus"></span></a>
                </th>
            </tr>
        
        </table>
    </div>
    </div>
    </cfoutput>
<div class="cell-3">
    <div data-role="panel"
    data-title-caption="Ekip"
    data-title-icon="<span class='mif-apps'></span>">
    <cfquery name="getEkip" datasource="#dsn#">
        SELECT E.EMPLOYEE_NAME+' '+E.EMPLOYEE_SURNAME AS EMP,ORR.ONGE_ROLE FROM ONGE_EMPLOYEE AS OE 
LEFT JOIN EMPLOYEES AS E ON E.EMPLOYEE_ID=OE.EMP_ID
LEFT JOIN ONGE_ROLES AS ORR ON ORR.ROLE_ID=OE.ROLE_ID
WHERE ONGE_ID=#attributes.ONGE_ID#
    </cfquery>
    <table class="table striped subcompact">
        <cfoutput query="getEkip">
            <tr>
                <td>
                    #EMP#
                </td>
                <td>
#ONGE_ROLE#
                </td>
            </tr>
        </cfoutput>
    </table>
</div>
<cfoutput>
<script>
    var panelButtons = [
        {
            html: "<span class='mif-rocket'></span>",
            cls: "sys-button",
            onclick: "windowopen('/index.cfm?fuseaction=objects.popup_add_belge&action_id=#attributes.ONGE_ID#&from=onge')"
        },
    ]
</script>
</cfoutput>
<div data-role="panel"
data-title-caption="Belgeler"
data-title-icon="<span class='mif-apps'></span>" data-custom-buttons="panelButtons">
<cfquery name="getBelge" datasource="#dsn#">
    SELECT * FROM ONGE_DOCUMENTS WHERE ONGE_ID=#attributes.ONGE_ID#
</cfquery>
<table class="table striped subcompact">
<cfoutput query="getBelge">
    <tr>
        <td><a href="/documents/onge/#DOC_PATH#" target="blank">#DOC_NAME#</a></td>
    </tr>
</cfoutput>
</div>
</table>
</div>
</div>
<script src="/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function(){
    ClassicEditor
        .create( document.querySelector( '#txt_takip' ), {
            // toolbar: [ 'heading', '|', 'bold', 'italic', 'link' ]
        } )
        .then( editor => {
            window.editor = editor;
        } )
        .catch( err => {
            console.error( err.stack );
        } );

    })
function takipEkle(emp_id,onge_id){
    var data=window.editor.getData();
    var emp=emp_id;
    $.ajax({
        url:"/cfc/ongeFunctions.cfc?method=addTakip",
        data:{
            takip_note:data,
            onge_id:onge_id,
            employee_id:emp
        },success:function(d){
            getTakip(onge_id)
        }

    })
}  

var j_data="";
function getTakip(onge_id=<cfoutput>#attributes.ONGE_ID#</cfoutput>){
    $.ajax({
        url:"/cfc/ongeFunctions.cfc?method=getTakip&onge_id="+onge_id,
      
        success: function(data) {
            var o=JSON.parse(data)
            j_data=o;
            takipListele(o)
        }

    })
}


function takipListele(data){

    var mesajArea=document.getElementById("mesaj_list");
    $(mesajArea).html("")
  for(let i=0;i<data.RECORDCOUNT;i++){
    var li=document.createElement("li");
    var img=document.createElement("img");
     img.setAttribute("src","/mg.jpg");
     img.setAttribute("class","avatar");
    li.appendChild(img);
    mesajArea.appendChild(li)
   
    var span=document.createElement("span");
    span.setAttribute("class","label");
    span.innerText=data.DATA[i].EMP
    li.appendChild(span);

    var span=document.createElement("span");
    span.setAttribute("class","second-label");
    span.innerHTML=data.DATA[i].TAKIP
    li.appendChild(span);

    var span=document.createElement("span");
    span.setAttribute("class","second-label");
    span.innerText=data.DATA[i].REC_DATE
    li.appendChild(span);
    mesajArea.appendChild(li)}

}
</script>

<!---
<img class="avatar" src="/mg.jpg">
<span class="label">Emre Yılmaz</span>
<span class="second-label">Bu Ne</span>
<span class="second-label">17min ago</span>---->
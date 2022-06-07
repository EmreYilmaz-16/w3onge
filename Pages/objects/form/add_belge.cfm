<cfform method="post" enctype="multipart/form-data"  action="#request.self#?fuseaction=#attributes.fuseaction#&action_id=#attributes.action_id#&from=#attributes.from#">

    <p>Dosya Adı</p>
    <input type="text" name="DOC_NAME" data-role="input" class="" required>

    
    <p>Açıklama</p>
    <textarea data-role="textarea" name="DOC_DESCRIPTION" data-prepend="<span class='mif-leanpub'></span>"></textarea>
    <p>Dosya</p>
    <input type="file" data-role="file"  name="FileContents" required>
    <input type="submit">
<input type="hidden" name="is_submit">
</cfform>


<cfif attributes.from eq "onge">
    <cfset cur_folder="/onge">
</cfif>


<cfif isDefined("attributes.is_submit")>
    <cfset emre= CreateUUID()>
   
    
     <cfif isDefined("Form.FileContents") > 
      <cffile action = "upload" fileField = "FileContents" destination = "#expandPath("/Documents/#cur_folder#")#" nameConflict = "Overwrite" result="aaaa">
   
    </cfif>
    
      <cffile action="rename" source="#aaaa.SERVERDIRECTORY#/#aaaa.CLIENTFILE#" destination="#aaaa.SERVERDIRECTORY#/#emre#.#aaaa.CLIENTFILEEXT#" result="nbbb"> 
      <cfdump var="#aaaa#">
    
<cfquery name="setBelge" datasource="#dsn#">
    INSERT INTO ONGE_DOCUMENTS (ONGE_ID,DOC_NAME,DOC_DESCRIPTION,DOC_PATH) VALUES (#attributes.action_id#,'#attributes.DOC_NAME#','#attributes.DOC_DESCRIPTION#','#emre#.#aaaa.CLIENTFILEEXT#')
</cfquery>

    </cfif>
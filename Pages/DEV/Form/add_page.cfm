<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <input type="text" data-role="input" name="PageHead" placeholder="Sayfa Başlığı">
    <input type="text" data-role="input" name="PagePath" placeholder="Sayfa Yolu">
    <input type="text" data-role="input" name="FUE" placeholder="Fuseaction">
    <cfquery name="getModules" datasource="#dsn#">
        SELECT * FROM MODULES
    </cfquery>
    <SELECT name="MODULE_ID" data-role="select">
    <cfoutput query="getModules">
        <option value="#MODULE_ID#">#MODULE#</option>
    </cfoutput>
</SELECT>
<input type="hidden" name="is_submit">
<input type="submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    <cfquery name="ins" datasource="#dsn#">
        INSERT INTO PAGES (PAGE_HEAD,PAGE_PATH,FUSEACTION,MODULE_ID) 
        VALUES('#attributes.PageHead#','#attributes.PagePath#','#attributes.FUE#',#attributes.MODULE_ID#)
    </cfquery>
</cfif>


<!-----PAGE_HEAD NVARCHAR(150),PAGE_PATH NVARCHAR(250),FUSEACTION NVARCHAR(250),MODULE_ID----->
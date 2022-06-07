<cfquery name="getUpperModules" datasource="#dsn#">
    SELECT * FROM MODULES WHERE UPPER_MODULE IS NULL
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <p>Module Adı</p>
    <input type="text" name="name" data-role="input" class="">
    <p>Üst Modül</p>
    <select data-role="select" name="upper_module">
        <option value="">Seçiniz</option>
        <cfoutput query="getUpperModules">
            <option value="#MODULE_ID#">#MODULE#</option>
        </cfoutput>
    </select>
    <input type="hidden" name="is_submit">
    <input type="submit">
</cfform>


<cfif isDefined("attributes.is_submit")>
    <cfquery name="ins" datasource="#dsn#">
        INSERT INTO  MODULES (MODULE, UPPER_MODULE) values ('#attributes.name#',<cfif len(attributes.upper_module)>#attributes.upper_module#<cfelse>NULL</cfif> )
    </cfquery>
</cfif>
<cfparam name="attributes.detail" default="0">
<cfparam name="attributes.page" default="1">
<cfif attributes.detail eq 1>
	<input type="hidden" name="page" value="<cfoutput>index.cfm?pageInfo=#caller.attributes.page#</cfoutput>" />
    <div class="input-group-btn">
        <button type="button" onclick="searchDetailContentButton(this);" class="btn default dropdown-toggle" title="Detay" data-toggle="dropdown" tabindex="-1" aria-expanded="false">
            <i class="fa fa-angle-down"></i> Detay
        </button>
        <cfif not isdefined("attributes.onclick")>
        	<button type="submit" class="btn btn-info" tabindex="-1" onClick="controlPaging(this);">Ara</button>
		<cfelse>
        	<button type="button" class="btn btn-info" tabindex="-1" onClick="controlPaging(this); <cfoutput>#attributes.onClick#</cfoutput>">Ara</button>
        </cfif>
    </div>
<cfelse>
	<cfif not isdefined("attributes.onclick")>
		<button type="submit" class="btn btn-info" onClick="controlPaging(this);">Ara</button>
	<cfelse>
        <button type="button" class="btn btn-info" onClick="controlPaging(this); <cfoutput>#attributes.onClick#</cfoutput>">Ara</button>
    </cfif>
</cfif>
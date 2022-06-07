<cfparam name="attributes.pageinfo" default="">
<cfparam name="attributes.PARTNER_ID" default="">
<cfset dsn="w3Partner">
<cfif len(attributes.pageinfo)>
    <cfquery name=getAccess datasource="#dsn#">
        select * from COMPANY_PARTNER_DENIED where DENIED_PAGE='#attributes.pageinfo#' and PARTNER_ID=#attributes.PARTNER_ID#
    </cfquery>
</cfif>
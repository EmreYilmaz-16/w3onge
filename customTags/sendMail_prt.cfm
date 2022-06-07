<cfparam name="attributes.fuseaction" default="">
<cfparam name="attributes.send_mail" default="1">
<cfparam name="attributes.send_duyuru" default="1">
<cfparam  name="attributes.prcat" default="">
<cfparam  name="attributes.service_id" default="">
<cfparam  name="attributes.service_head" default="">
<cfparam  name="attributes.system_paper_no" default="">
<cfparam  name="attributes.service_detail" default="">
<cfparam  name="attributes.SERVICE_NO" default="">
<cfset dsn="w3Partner">
<cfif len(attributes.fuseaction)>
<cfdump  var="#attributes#">
<cfquery name="get_mail_list" datasource="#dsn#">
SELECT DISTINCT (CAU_POSITION_ID)
	,(
		SELECT EMPLOYEE_EMAIL
		FROM w3Partner.EMPLOYEE_POSITIONS
		WHERE POSITION_ID = CAU_POSITION_ID
		) AS MAIL
FROM w3Partner.PROCESS_TYPE_ROWS_CAUID
WHERE PROCESS_ROW_ID IN (
		SELECT PROCESS_ROW_ID
		FROM w3Partner.PROCESS_TYPE_ROWS
		WHERE PROCESS_ID IN (
				SELECT PROCESS_ID
				FROM w3Partner.PROCESS_TYPE
				WHERE FACTION LIKE '%#attributes.fuseaction#%'
				)
			AND IS_EMAIL = 1
		)
</cfquery>
<cfloop query="get_mail_list">
<cfmail
from="info@partnerbilgisayar.com"
to="#get_mail_list.MAIL#"
subject="Bir Başvuru Oluşturuldu"
type="HTML">
Yeni İş Başvurusu Oluşturulmuştur;<br>
Link: <a href="http://w3.partnerbilgisayar.com/index.cfm?fuseaction=call.list_service&event=upd&service_id=<cfoutput>#attributes.SERVICE_ID#</cfoutput>&service_no=<cfoutput>#attributes.SERVICE_NO#</cfoutput>"><cfoutput>#attributes.SERVICE_NO#</cfoutput></a><br>
Konu : <b><cfoutput><cfif len(attributes.service_head)>'#attributes.service_head#'<cfelse>'#attributes.system_paper_no#'</cfif></cfoutput></b><br>
Açıklama : <b><cfoutput><cfif len(service_detail)>'#service_detail#'<cfelse>----</cfif></cfoutput></b><br>
Firma : <cfoutput>#session.pp.COMPANY_NICK#</cfoutput><br>
Başvuruyu Yapan : <cfoutput>#session.pp.NAME# #session.pp.SURNAME#</cfoutput><br>
Başvuru Tarihi : <cfoutput>#now()#</cfoutput>
</cfmail>

</cfloop>



</cfif>
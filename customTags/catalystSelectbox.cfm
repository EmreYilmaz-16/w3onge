<cfparam name="attributes.name" default="selectbox">
<cfparam name="attributes.multiple" default="">
<cfparam name="attributes.findSelect" default="1">
<cfif thisTag.executionMode eq "start">
	<cfoutput>
		<select name="#attributes.name#" id="#attributes.name#" class="form-control selectpicker show-tick" data-size="5"<cfif attributes.findSelect eq 1> data-live-search="true"</cfif><cfif len(attributes.multiple)> multiple</cfif>>
    </cfoutput>
<cfelse>
	</select>
</cfif>
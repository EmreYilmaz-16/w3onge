<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <p>Adı</p>
<input type="text" name="EMPLOYEE_NAME" data-role="input" class="">
<p>Soyadı</p>
<input type="text" name="EMPLOYEE_SURNAME" data-role="input" class="">
<p>Kullanıcı Adı</p>
<input type="text" name="EMPLOYEE_USERNAME" data-role="input" class="">
<p>Şifre</p>
<input type="password" name="EMPLOYEE_PASSWORD" data-role="input" class="">
<input type="hidden" name="is_submit" value="1">
<input type="submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cfquery name="addEmp" datasource="#dsn#">
        INSERT INTO EMPLOYEES (EMPLOYEE_NAME, EMPLOYEE_SURNAME, EMPLOYEE_USERNAME, EMPLOYEE_PASSWORD)
        VALUES(
        '#attributes.EMPLOYEE_NAME#','#attributes.EMPLOYEE_SURNAME#','#attributes.EMPLOYEE_USERNAME#','#attributes.EMPLOYEE_PASSWORD#'
        )
    </cfquery>
</cfif>

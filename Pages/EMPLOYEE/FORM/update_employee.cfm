<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
<cfquery name="getEmp" datasource="#dsn#">
    SELECT EMPLOYEE_NAME, EMPLOYEE_SURNAME, EMPLOYEE_USERNAME, EMPLOYEE_PASSWORD,EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID =#attributes.EMPLOYEE_ID#
</cfquery>
    <cfoutput>
    <p>Adı</p>
<input type="text" name="EMPLOYEE_NAME" data-role="input" class="" value="#getEmp.EMPLOYEE_NAME#">
<p>Soyadı</p>
<input type="text" name="EMPLOYEE_SURNAME" data-role="input" class="" value="#getEmp.EMPLOYEE_SURNAME#">
<p>E-Mail</p>
<input type="email" name="email" data-role="input" class="" value="#getEmp.EMAIL#">
<p>Kullanıcı Adı</p>
<input type="text" name="EMPLOYEE_USERNAME" data-role="input" class="" value="#getEmp.EMPLOYEE_USERNAME#">

<p>Şifre</p>
<input type="password" name="EMPLOYEE_PASSWORD" data-role="input" class="" value="#getEmp.EMPLOYEE_PASSWORD#">
<input type="hidden" name="employee_id" value="#attributes.employee_id#">
</cfoutput>

<input type="hidden" name="is_submit" value="1">
<input type="submit">
</cfform>

<cfif isDefined("attributes.is_submit")>
    <cfquery name="addEmp" datasource="#dsn#">
        UPDATE EMPLOYEES SET 
        EMPLOYEE_NAME='#attributes.EMPLOYEE_NAME#',
        EMPLOYEE_SURNAME='#attributes.EMPLOYEE_SURNAME#',
        EMPLOYEE_USERNAME='#attributes.EMPLOYEE_USERNAME#',
        EMPLOYEE_PASSWORD='#attributes.EMPLOYEE_PASSWORD#',
        EMAIL='#attributes.email#'
            WHERE EMPLOYEE_ID=#attributes.employee_id#
      
      <!----  INSERT INTO EMPLOYEES (EMPLOYEE_NAME, EMPLOYEE_SURNAME, EMPLOYEE_USERNAME, EMPLOYEE_PASSWORD,EMAIL)
        VALUES(
        '#attributes.EMPLOYEE_NAME#','#attributes.EMPLOYEE_SURNAME#','#attributes.EMPLOYEE_USERNAME#','#attributes.EMPLOYEE_PASSWORD#','#attributes.email#'
        )----->
    </cfquery>
</cfif>


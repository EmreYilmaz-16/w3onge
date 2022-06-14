<cfquery name="getP" datasource="#dsn#">
    SELECT PAGES.PAGE_HEAD,MODULES.MODULE,PAGES.FUSEACTION AS FACTION FROM PAGES 
        LEFT JOIN MODULES ON MODULES.MODULE_ID=PAGES.MODULE_ID
</cfquery>

<table class="table striped subcompact">
<cfoutput query="getP">
    <TR>
  <TD>  #PAGE_HEAD# </TD> <TD>  #MODULE# </TD> <TD>  #getP.FACTION# </TD>
</TR>
</cfoutput>
</table>

gtttt emre yilmaz
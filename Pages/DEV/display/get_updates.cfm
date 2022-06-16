<cfoutput>
    <cfset index_folder=expandPath(".")>
    <cfset gitUrl="https://github.com/EmreYilmaz-16/w3onge.git">
    <cfset git_username="emre.yilmaz@hotmail.co.uk">
    <cfset git_password="J6F2ATaWpvGu3Lx">
  </cfoutput>
  
<cfexecute name = "#index_folder#/gite.bat"  
timeout = "1000"
variable="local.out"
errorvariable="local.err"> 
</cfexecute>

<cfdump var="#local#">

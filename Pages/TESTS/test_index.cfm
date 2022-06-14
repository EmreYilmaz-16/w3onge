<cfoutput>
  <cfset index_folder=expandPath(".")>
  <cfset gitUrl="https://github.com/EmreYilmaz-16/w3onge.git">
  <cfset git_username="emre.yilmaz@hotmail.co.uk">
  <cfset git_password="J6F2ATaWpvGu3Lx">
</cfoutput>

<cfscript>
    		
    cfGit = createObject( "component", "/wcloud/cfcGit" );
    cfGit.init( 
        argGit_path : "git", 
        argGit_folder : index_folder,
        argGit_url : gitUrl,
        argGit_username : git_username,
        argGit_password : git_password
    );
    writeDump(cfGit.status());
</cfscript>







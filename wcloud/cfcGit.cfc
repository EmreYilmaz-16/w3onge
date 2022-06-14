<!---
	File : cfGit.cfc
	Author : Uğur Hamurpet<ugurhamurpet@workcube.com>
	Date : 16/08/2019
	Description : Git üzerinde add, diff, pull, checkout, log, show, status komutlarını cfexecute ile çalıştırmak amacıyla oluşturuldu
--->

<cfcomponent displayname="cfGit" hint="I interact with git" extends="cfGit_helper">
	<!--- The setup --->
	<cfproperty
		name="git_path"
		displayname="Git path"
		hint="On *nix system you can find the git to path by running $which git"
		type="string" />
	
	<cfproperty
		name="git_fullPath"
		displayname="Repository Full Path"
		hint="Repostory full path /// path.git"
		type="string" />
		
	<cfproperty
		name="git_folder"
		displayname="Repository folder"
		hint="I am the folder you are going to query"
		type="string" />
	
	<cfproperty
		name="git_url"
		displayname="Git url"
		hint="https://bitbucket.org/workcube/devcatalyst.git"
		type="string" />

	<cfproperty
		name="git_username"
		displayname="Git username"
		hint="just username, no email"
		type="string" />

	<cfproperty
		name="git_password"
		displayname="Git password"
		type="string" />
	
	<cfproperty
		name="git_fullUrl"
		displayname="Git Full Url"
		type="string" />

	<cffunction name="init" access="public" output="false" returntype="any" hint="I setup the CFC">
		<cfargument name="argGit_path" type="string" required="true">
		<cfargument name="argGit_folder" type="string" required="true">
		<cfargument name="argGit_url" type="string" required="true">
		<cfargument name="argGit_username" type="string" required="true">
		<cfargument name="argGit_password" type="string" required="true">
		
		<cfscript>
			setGit_path( argGit_path );
			setgit_folder( arggit_folder );
			setgit_fullUrl( argGit_url, argGit_username, argGit_password);
			return this;
		</cfscript>
	</cffunction>
	<!--- End: the setup --->

	<!--- Commands --->
	<cffunction name="add" access="public" output="false" returntype="any" hint="Add file contents to the index">
		<cfargument
			name="argFiles"
			type="string"
			default="."
			hint="Limits the number of commits to show" />
			
		<cfreturn execGit( "add", argFiles )>
	</cffunction> 

	<cffunction name="diff" access="public" output="false" returntype="any">
		<cfargument name="stat" type="boolean" default="false" required="no"/>
		<cfargument name="nameOnly" type="boolean" default="false" required="no"/>
		<cfargument name="option" type="struct" required="yes" hint="{ getArray => boolean, workTreeMode => boolean, excluding : Array }"/>

		<cfscript>
			
			if( stat || nameOnly ) diffArguments = "#( arguments.stat ? '--stat' : NULL)##( arguments.nameOnly ? ' --name-only' : NULL)#";
			
			exec = execGit( "diff", diffArguments, option.workTreeMode );
			exec.diffPages = ( option.getArray ) ? this.getPages( allPages : exec.result, excluding : option.excluding ) : "";
			return exec;

		</cfscript>

	</cffunction>

	<cffunction name="currentBranch" access="public" output="false" returntype="any" hint="Get current branch name">
		<cfargument name="option" type="struct" required="yes" hint="{ workTreeMode => boolean }"/>
		
		<cfscript>

			return execGit( "rev-parse", "--abbrev-ref HEAD", option.workTreeMode ); 

		</cfscript>

	</cffunction>

	<cffunction name="fetch" access="public" output="false" returntype="any">
		<cfargument name="option" type="struct" required="yes" hint="{ workTreeMode => boolean }"/>

		<cfscript>

			return execGit( "fetch", getgit_fullUrl() , option.workTreeMode );

		</cfscript>

	</cffunction>

	<cffunction name="pull" access="public" output="false" returntype="any">
		<cfargument name="pullBranchName" type="string" default="" required="yes" hint="Name of pull branch name"/>
		<cfargument name="option" type="struct" required="yes" hint="{ workTreeMode => boolean }"/>
		
		<cfscript>
			///Current Branch değeri doğru gelmesine rağmen pull işlemi sırasında hata oluştuğu için branch name değerinin argument olarak alınması sağlandı
			/* currentBranch = this.currentBranch( option : { workTreeMode:true } );
			if( currentBranch.status ){ */

				/* gitRequestArguments = "#getgit_fullUrl()# origin #currentBranch.result#"; */
				gitRequestArguments = "#getgit_fullUrl()#/refs/remotes/origin #pullBranchName#";
				return execGit( "pull", gitRequestArguments , option.workTreeMode );

			/* }else return currentBranch; */
			

		</cfscript>

	</cffunction>

	<cffunction name="checkout" access="public" output="false" returntype="any">
		<cfargument name="checkoutBranchName" type="string" default="" required="no" hint="Name of checkout branch name"/>
		<cfargument name="createBranchName" type="string" default="" required="no" hint="Name of new branch name"/>
		<cfargument name="discardFilePath" type="string" default="" required="no" hint="Path of discarding file"/>
		<cfargument name="option" type="struct" required="yes" hint="{ workTreeMode => boolean }"/>

		<cfscript>
		
			if( len( arguments.checkoutBranchName ) ) checkOutArguments = arguments.checkoutBranchName;
			else if( len( arguments.createBranchName ) ) checkOutArguments = "-b " & arguments.createBranchName;
			else if( len( arguments.discardFilePath ) ) checkOutArguments = "-- " & arguments.discardFilePath;

		</cfscript>

		<cfreturn  execGit( "checkout", checkOutArguments, option.workTreeMode ) >
	</cffunction>
		
	<cffunction name="log" access="public" output="false" returntype="any" hint="log">
		<cfargument
			name="argN"
			type="numeric"
			default="5"
			hint="Limits the number of commits to show" />
			
		<cfif len( trim( argN )) AND isValid( "integer", argN )>
			<cfset argN = "-n " & argN>
		</cfif>
		
		<cfreturn execGit( "log", argN )>
	</cffunction>

	<cffunction name="show" access="public" output="false" returntype="any" hint="Show various types of objects">
		<cfreturn execGit( "show" )>
	</cffunction>
	
	<cffunction name="status" access="public" output="false" returntype="any" hint="Show the working tree status">
		<cfreturn execGit( "status" )>
	</cffunction>

	<!--- End: Commands --->

	<!--- wrapped up the execute in a function to save repetition --->
	<cffunction name="execGit" access="public" output="false" returntype="any">
		<cfargument name="argCommand" required="yes" type="string">
		<cfargument name="argArguments" required="no" type="string" default="">
		<cfargument name="workTreeMode" required="no" type="boolean" default="false">
		
		<cfset var local = {} />
		<cfset execArgument = "--git-dir='#getgit_fullPath()#' #( workTreeMode ? '--work-tree=w3Onge' : '' )# #argCommand# #argArguments#">
     
        <cfdump var="#execArgument#">
		<cfset response = structNew()>
		<cfset response.execArgument=execArgument>
		<cfset response.pth=getGit_path()>
		<cfexecute name = "C:\Program Files\Git\bin\git.exe" 
		    arguments = "#execArgument#"  
		    timeout = "1000"
			variable="local.out"
			errorvariable="local.err"> 
		</cfexecute>		
    
		<cfif len( trim( local.err ) )>
			<!--- <cfset local.msg = "error running Git command <b>$git #uCase(argCommand &" "&argArguments)#</b> in execGit()">
			<cfsavecontent variable="error">
				<cfthrow detail="#local.err#" type="git" message="#local.msg#" />
			</cfsavecontent> --->
			<cfset response.status = false>
			<cfset response.result = local.err>
		<cfelse>
			<cfset response.status = true>
			<cfset response.result = local.out>
		</cfif>

		<cfreturn response>
	</cffunction>

	<!--- Getters and Setters --->
	<cffunction name="getGit_path" access="public" output="false" returntype="string">
		<cfreturn git_path>
	</cffunction>

	<cffunction name="setGit_path" access="private" output="false" returntype="void">
		<cfargument name="argGit_path" type="any">
		<cfset git_path = argGit_path/>
	</cffunction>

	<cffunction name="getgit_fullPath" access="public" output="false" returntype="string">
		<cfreturn git_fullPath>
	</cffunction>

	<cffunction name="getgit_folder" access="remote" output="false" returntype="string">
		<cfreturn git_folder>
	</cffunction>

	<cffunction name="getgit_fullUrl" access="public" output="false" returntype="string">
		<cfreturn git_fullUrl>
	</cffunction>

	<cffunction name="setgit_folder" access="private" output="false" returntype="void">
		<cfargument name="arggit_folder" type="any">
		<cfscript>

			git_folder =  arggit_folder;
			if( right( arggit_folder, 1) NEQ "/"){ arggit_folder = arggit_folder & "/"; }
			git_fullPath = git_folder & "/.git";
		
		</cfscript>		
	</cffunction>

	<cffunction name="setgit_fullUrl" access="private" output="false" returntype="void">
		<cfargument name="argGit_url" type="string" required="true">
		<cfargument name="argGit_username" type="string" required="true">
		<cfargument name="argGit_password" type="string" required="true">

		<cfscript>

			explodedUrl = ListToArray( trim( argGit_url ), ":" );
			git_fullUrl = explodedUrl[1] & "://" & argGit_username & ":" & argGit_password & "@" & replaceNoCase(explodedUrl[2],"//","");

		</cfscript>

	</cffunction>

</cfcomponent>
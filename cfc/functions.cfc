<!--- json_type parametresi 1 : tab menü, 2: page bar, null : page designer 
	objectID parametresi gelirse pageBar duzenleniyor
--->
	
<cfcomponent>
  

    
    <cffunction name="date_add" returntype="any" output="true">
        <cfargument name="type" type="string" required="true">
        <cfargument name="value" type="string" required="true">
        <cfargument name="date" type="string" required="true">
        <cfif type is 'h'>
            <cfset deger_ = value * 60>
            <cfset date_new_ = dateadd("n",deger_,date)>
        <cfelse>
            <cfset date_new_ = dateadd("#type#",value,date)>
        </cfif>
        <cfreturn date_new_>
    </cffunction>
    
	<cffunction name="ListDeleteDuplicates" returntype="string" output="false">
        <cfargument name="list" required="yes">
        <cfargument name="delim2" required="no" default=",">	
        <cfscript>
			var i = 1;
			var delimiter = arguments.delim2;
			var returnValue = '';
			list = ListToArray(arguments.list, delimiter);
			for(i = 1; i lte ArrayLen(list); i = i + 1)
				if(not ListFind(returnValue, list[i], delimiter))
					returnValue = ListAppend(returnValue, list[i], delimiter);
        </cfscript>
        <cfreturn returnValue>
    </cffunction>

    <cffunction name="TLFormat" returntype="string" output="false">
		<!--- <cfargument name="money" type="numeric" required="true"> sorunlar duzelince alttaki yerine acilacak--->
        <cfargument name="money">
        <cfargument name="no_of_decimal" required="no" default="2">
        <cfargument name="is_round" type="boolean" required="no" default="true">
        <cfscript>
        /*if (not len(arguments.money)) return 0;*/
        if (not len(arguments.money)) return '';
        arguments.money = trim(arguments.money);
        if (arguments.money contains 'E') arguments.money = ReplaceNoCase(NumberFormat(arguments.money),',','','all');
        if (arguments.money contains '-'){
            negativeFlag = 1;
            arguments.money = ReplaceNoCase(arguments.money,'-','','all');}
        else negativeFlag = 0;
        if(not isnumeric(arguments.no_of_decimal)) arguments.no_of_decimal= 2;	
        nokta = Find('.', arguments.money);
        if (nokta)
            {
            if(arguments.is_round) /* 20050823 and arguments.no_of_decimal */ 
            {
                rounded_value = CreateObject("java", "java.math.BigDecimal");
                rounded_value.init(arguments.money);
                rounded_value = rounded_value.setScale(arguments.no_of_decimal, rounded_value.ROUND_HALF_UP);
                rounded_value = rounded_value.toString();
                if(rounded_value contains '.') /*10.00 degeri yerine 10 dondurmek icin*/
                {
                    if(listlast(rounded_value,'.') eq 0)
                        rounded_value = listfirst(rounded_value,'.');
                }
                arguments.money = rounded_value;
                if (arguments.money contains 'E') 
                {
                    first_value = listgetat(arguments.money,1,'E-');
                    first_value = ReplaceNoCase(first_value,',','.');
                    last_value = ReplaceNoCase(listgetat(arguments.money,2,'E-'),'0','','all');
                    for(kk_float=1;kk_float lte last_value;kk_float=kk_float+1)
                    {
                        zero_info = ReplaceNoCase(first_value,'.','');
                        first_value = '0.#zero_info#';
                    }
                    arguments.money = first_value;
                    first_value = listgetat(arguments.money,1,'.');
                    arguments.money = "#first_value#.#Left(listgetat(arguments.money,2,'.'),8)#";
                    if(arguments.money lt 0.00000001) arguments.money = 0;
                    if(Find('.', arguments.money))
                    {
                        arguments.money = "#first_value#,#Left(listgetat(arguments.money,2,'.'),8)#";
                        return arguments.money;
                    }
                }
            }
            if(arguments.money neq 0) nokta = Find('.', arguments.money);
            if(ceiling(arguments.money) neq arguments.money){
                tam = ceiling(arguments.money)-1;
                onda = Mid(arguments.money, nokta+1,arguments.no_of_decimal);
                if(len(onda) lt arguments.no_of_decimal)
                    onda = onda & RepeatString(0,arguments.no_of_decimal-len(onda));
                }
            else{
                tam = arguments.money;
                onda = RepeatString(0,arguments.no_of_decimal);}
            }
        else{
            tam = arguments.money;
            onda = RepeatString(0,arguments.no_of_decimal);
            }
        textFormat='';
        t=0;
        if (len(tam) gt 3) 
            {
            for (k=len(tam); k; k=k-1)
                {
                t = t+1;
                if (not (t mod 3)) textFormat = '.' & mid(tam, k, 1) & textFormat; 
                else textFormat = mid(tam, k, 1) & textFormat;
                } 
            if (mid(textFormat, 1, 1) is '.') textFormat =  "#right(textFormat,len(textFormat)-1)#,#onda#";
            else textFormat =  "#textFormat#,#onda#";
            }
        else
            textFormat = "#tam#,#onda#";
            
        if (negativeFlag) textFormat =  "-#textFormat#";
        
        if (not arguments.no_of_decimal) 
            textFormat = ListFirst(textFormat,',');
        return textFormat;
        </cfscript>
    </cffunction>
    <cffunction name="checkDenied" returntype="string" output="false">
    <cfargument name="pageinfo">
    <cfargument name="PARTNER_ID">
        <cfif len(arguments.pageinfo) and len(arguments.PARTNER_ID)>
            <cfquery name=getAccess datasource="#dsn#">
            select * from COMPANY_PARTNER_DENIED where DENIED_PAGE='#arguments.pageinfo#' and PARTNER_ID=#arguments.PARTNER_ID#
            </cfquery>
            <cfif getAccess.recordcount and getAccess.IS_VIEW EQ 1 >
                <cfreturn "1">
            <cfelse>
            <cfreturn "0">
            </cfif>
            
            <cfelse>
            <cfreturn "0">
        </cfif>
    </cffunction>
</cfcomponent>
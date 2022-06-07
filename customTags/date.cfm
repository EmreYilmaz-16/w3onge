<!--- 
Description : 
	Verilen tarih değişkeninin değerini "31/12/2003 gibi" ODBC tarih formatına çevirir
Parameters :
	tarih = required
Syntax :
	<cf_date tarih="attributes.startdate">
	
modified : 
	EK20030708 : cfscript yapıldı 
	20031002 : , . - lerden / a temizlendi ve sadece / a gore calistirildi saglama alindi.
 --->
<cfsavecontent variable="warning">
	<cftry>
    	<cf_get_lang_main no="2180.Yanlış Tarih Kullanımı">
    <cfcatch>Hata</cfcatch>
    </cftry>
</cfsavecontent>
<cfscript>
	if (isdefined("attributes.tarih") and len(trim(attributes.tarih)) and isDefined('caller.#attributes.tarih#') )
		{
			temp = evaluate("caller.#attributes.tarih#");
			if (not temp contains '{ts')
				{
				temp = Replace(temp,',','/','all');
				temp = Replace(temp,'.','/','all');
				temp = Replace(temp,'-','/','all');
				if (listlen(temp,"/") eq 3)
					{
						yil = listgetat(temp,3,"/");
						ay  = listgetat(temp,2,"/");
						gun = listgetat(temp,1,"/");
						if (len(ay) eq 0) ay = "01";
						else if (len(ay) eq 1) ay = "0#ay#";
						if (len(gun) eq 0) gun = "01";
						else if (len(gun) eq 1) gun = "0#gun#";
						if (len(yil) eq 1) yil = "#left(year(now()),3)##yil#";
						else if (len(yil) eq 2) yil = "#left(year(now()),2)##yil#";
						else if (len(yil) eq 3) yil = "#left(year(now()),1)##yil#";
						if(yil lt 1753)
							{
							yil = 1753;
							ay = "01";
							gun = "01";
							}
						temp = "#yil#-#ay#-#gun#";
					}
				if (isDate(temp))
					"caller.#attributes.tarih#" = createodbcdatetime(temp);
				else
					"caller.#attributes.tarih#" = "NULL";
				}
			else if(not caller.workcube_mode) writeoutput('<font color=red><cfoutput>#warning#</cfoutput>(#attributes.tarih#)</font>');
		}
</cfscript>

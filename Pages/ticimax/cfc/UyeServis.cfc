<cfcomponent>
    <cfset UyeKodu="4SRYTUATO1QM23K6OBQ9AXTB42PZKX">
    <cfset web_service_url="https://ashleyturkiye.ticimaxdemo.com/Servis/UyeServis.svc"> 
    <cffunction name="SelectUyeAdres">
        <cfargument name="AdressId" required="true">
        <cfargument name="UyeId" required="true">        
        <cfxml variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUyeAdres>        
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>          
                            <tem:adresId>#arguments.AdressId#</tem:adresId>          
                            <tem:uyeId>#arguments.UyeId#</tem:uyeId>
                        </tem:SelectUyeAdres>
                    </soapenv:Body>
            </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUyeServis/SelectUyeAdres"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
            </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
</cfcomponent>
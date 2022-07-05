<cfcomponent>
    <cfset UyeKodu="4SRYTUATO1QM23K6OBQ9AXTB42PZKX">
    <cfset web_service_url="https://ashleyturkiye.ticimaxdemo.com/Servis/CustomServis.svc">
    <cffunction  name="SelectKargoFirmalari">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectKargoFirmalari>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        </tem:SelectKargoFirmalari>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ICustomServis/SelectKargoFirmalari"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectIlceler">
        <cfargument  name="SelectIlceRequest" required="true" hint="Filtre bilgilerini içeren SelectIlceRequest sınıfı">
        <cfargument  name="FiltreIlceID" hint="Filtre ilçe id değeri">
        <cfargument  name="FiltreIlID" hint="Filtre il id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectIlceler>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:SelectRequest>
                                <cfif len(arguments.FiltreIlID)><ns:FiltreIlID>#arguments.FiltreIlID#</ns:FiltreIlID></cfif>
                                <cfif len(arguments.FiltreIlceID)><ns:FiltreIlceID>#arguments.FiltreIlceID#</ns:FiltreIlceID></cfif>
                            </tem:SelectRequest>
                        </tem:SelectIlceler>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ICustomServis/SelectIlceler"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectIller">
        <cfargument  name="SelectIlRequest" required="true" hint="Filtre bilgilerini içeren SelectIlRequest sınıfı">
        <cfargument  name="FiltreIlID" hint="Filtre il id değeri">
        <cfargument  name="FiltreUlkeID" hint="Filtre üke id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectIller>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:SelectRequest>
                                <cfif len(arguments.FiltreIlID)><ns:FiltreIlID>#arguments.FiltreIlID#</ns:FiltreIlID></cfif>
                                <cfif len(arguments.FiltreUlkeID)><ns:FiltreUlkeID>#arguments.FiltreUlkeID#</ns:FiltreUlkeID></cfif>
                            </tem:SelectRequest>
                        </tem:SelectIller>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ICustomServis/SelectIller"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectUlkeler">
        <cfargument  name="SelectUlkeRequest" required="true" hint="Filtre bilgilerini içeren SelectUlkeRequest sınıfı">
        <cfargument  name="FiltreUlkeKodu" hint="Filtre ülke kodu değeri">
        <cfargument  name="FiltreUlkeID" hint="Filtre üke id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUlkeler>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:SelectRequest>
                                <cfif len(arguments.FiltreUlkeID)><ns:FiltreUlkeID>#arguments.FiltreUlkeID#</ns:FiltreUlkeID></cfif>
                                <cfif len(arguments.FiltreUlkeKodu)><ns:FiltreUlkeKodu>#arguments.FiltreUlkeKodu#</ns:FiltreUlkeKodu></cfif>
                            </tem:SelectRequest>
                        </tem:SelectUlkeler>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ICustomServis/SelectUlkeler"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
</cfcomponent>

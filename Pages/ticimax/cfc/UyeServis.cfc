<cfcomponent>
    <cfset UyeKodu="4SRYTUATO1QM23K6OBQ9AXTB42PZKX">
    <cfset web_service_url="https://ashleyturkiye.ticimaxdemo.com/Servis/UyeServis.svc"> 
    <cffunction name="SelectUyeAdres">
        <cfargument name="AdressId" default="-1" >
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
    <cffunction name="SelectUyeler">
        <cfargument name="Aktif" default="-1" type="numeric">
        <cfargument name="AlisverisYapti" default="" type="numeric">
        <cfargument name="Cinsiyet" default="" type="numeric">
        <cfargument name="DogumTarihi1" default="" type="date">
        <cfargument name="DogumTarihi2" default="" type="date">
        <cfargument name="DuzenlemeTarihi1" default="" type="date">
        <cfargument name="DuzenlemeTarihi2" default="" type="date">
        <cfargument name="IlID" default="" type="numeric">
        <cfargument name="IlceID" default="" type="numeric">
        <cfargument name="Mail" default="" 
        <cfargument name="MailIzin" default="-1">
        <cfargument name="MusteriKodu" default="">

        <cfargument name="SmsIzin" default="-1">
        <cfargument name="SonGirisTarihi1" default="">
        <cfargument name="SonGirisTarihi2" default="">
        <cfargument name="Telefon" default="">

        <cfargument name="UyeID" default="">
        <cfargument name="UyelikTarihi1" default="">
        <cfargument name="UyelikTarihi2" default="">
        <cfxml variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                <soapenv:Header/>
                <soapenv:Body>
                   <tem:SelectUyeler>
                      <!--Optional:-->
                      <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                      <!--Optional:-->
                      <tem:filtre>                    
                        <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>  
                        <cfif len(arguments.AlisverisYapti)><ns:AlisverisYapti>#arguments.AlisverisYapti#</ns:AlisverisYapti></cfif>                     
                        <cfif len(arguments.Cinsiyet)><ns:Cinsiyet>#arguments.Cinsiyet#</ns:Cinsiyet></cfif>                              
                        <cfif len(arguments.IlID)><ns:IlID>#arguments.IlID#</ns:IlID></cfif>                         
                        <cfif len(arguments.IlceID)><ns:IlceID>#arguments.IlceID#</ns:IlceID></cfif>                                                              
                        <cfif len(arguments.Mail)><ns:Mail>#arguments.Mail#</ns:Mail></cfif>                       
                        <cfif len(arguments.MailIzin)><ns:MailIzin>#arguments.MailIzin#</ns:MailIzin></cfif>                         
                        <cfif len(arguments.MusteriKodu)><ns:MusteriKodu>#arguments.MusteriKodu#</ns:MusteriKodu></cfif>                                                                
                        <cfif len(arguments.SmsIzin)><ns:SmsIzin>#arguments.SmsIzin#</ns:SmsIzin></cfif>
                        <cfif len(arguments.Telefon)><ns:Telefon>#arguments.Telefon#</ns:Telefon></cfif>                         
                        <cfif len(arguments.UyeID)><ns:UyeID>#arguments.UyeID#</ns:UyeID></cfif> 
                        <cfif len(arguments.DogumTarihi1)><ns:DogumTarihi1>#arguments.DogumTarihi1#</ns:DogumTarihi1></cfif>                         
                        <cfif len(arguments.DogumTarihi2)><ns:DogumTarihi2>#arguments.DogumTarihi2#</ns:DogumTarihi2></cfif>                    
                        <cfif len(arguments.DuzenlemeTarihi1)><ns:DuzenlemeTarihi1>#arguments.DuzenlemeTarihi1#</ns:DuzenlemeTarihi1></cfif>                 
                        <cfif len(arguments.DuzenlemeTarihi2)><ns:DuzenlemeTarihi2>#arguments.DuzenlemeTarihi2#</ns:DuzenlemeTarihi2>   </cfif>                      
                        <cfif len(arguments.SonGirisTarihi1)><ns:SonGirisTarihi1>#arguments.SonGirisTarihi1</ns:SonGirisTarihi1></cfif>                       
                        <cfif len(arguments.SonGirisTarihi2)><ns:SonGirisTarihi2>#arguments.SonGirisTarihi2</ns:SonGirisTarihi2></cfif>                                                                        
                        <cfif len(arguments.UyelikTarihi1)><ns:UyelikTarihi1>#arguments.UyelikTarihi1</ns:UyelikTarihi1></cfif>                          
                        <cfif len(arguments.UyelikTarihi2)><ns:UyelikTarihi2>#arguments.UyelikTarihi2</ns:UyelikTarihi2></cfif> 
                      </tem:filtre>
                      <!--Optional:-->
                      <tem:sayfalama>
                         <!--Optional:-->
                         <ns:KayitSayisi>20</ns:KayitSayisi>
                         <!--Optional:-->
                         <ns:SayfaNo>1</ns:SayfaNo>
                         <!--Optional:-->
                         <ns:SiralamaDegeri>?</ns:SiralamaDegeri>
                         <!--Optional:-->
                         <ns:SiralamaYonu>?</ns:SiralamaYonu>
                      </tem:sayfalama>
                   </tem:SelectUyeler>
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
<cfcomponent>
    <cfset UyeKodu="4SRYTUATO1QM23K6OBQ9AXTB42PZKX">
    <cfset web_service_url="https://ashleyturkiye.ticimaxdemo.com/Servis/UrunServis.svc">
    <cffunction  name="DeleteKategori">
        <cfargument  name="KategoriId" required="true">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:DeleteKategori>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:KategoriID>#arguments.KategoriId#</tem:KategoriID>
                        </tem:DeleteKategori>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/DeleteKategori"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveKategori">
        <cfargument name="Kategori" required="true">
        <cfargument  name="Id" required="true" hint="0 gönderilir ise yeni kategori eklenir 0 dan büyük gönderilir ise
        gönderilen id li kategori güncellenir.">
        <cfargument name="Pid" required="true" hint="Üst kategori id. Üst kategori yoksa 0 gönderilmelidir.">
        <cfargument  name="Tanim" required="true" hint="Kategori adı.">
        <cfargument  name="Kod" required="true" hint="Kategori Kodu.">
        <cfargument  name="SeoAnahtarKelime" hint="Seo optimizasyonu için kullanılan kelimeler.">
        <cfargument  name="SeoSayfaBaslik" hint="Seo optimizasyonu için kullanılan sayfa başlığı.">
        <cfargument  name="SeoSayfaAciklama" hint="Seo optimizasyonu için kullanılan açıklama.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveKategori>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:kategori>
                                <ns:ID>#arguments.Id#</ns:ID>
                                <ns:KategoriMenuGoster>1</ns:KategoriMenuGoster>
                                <ns:Kod>#arguments.Kod#</ns:Kod>
                                <ns:PID>#arguments.Pid#</ns:PID>
                                <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                            </tem:kategori>
                        </tem:SaveKategori>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveKategori"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveKategoriParent">
        <cfargument  name="KategoriId" required="true" hint="Üst kategori eklenecek kategorinin Id değeri.">
        <cfargument  name="ParentId" required="true" hint="Üst kategori Id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveKategoriParent>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:KategoriID>#arguments.KategoriId#</tem:KategoriID>
                            <tem:ParentID>#arguments.ParentId#</tem:ParentID>
                        </tem:SaveKategoriParent>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveKategoriParent"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectKategori">
        <cfargument  name="KategoriId" required="true">
        <cfargument  name="Dil" hint="Kategorinin hangi dilde geleceğinin belirtildiği parametre.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectKategori>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:kategoriID>#arguments.KategoriId#</tem:kategoriID>
                            <cfif len(arguments.Dil)><tem:dil>#arguments.Dil#</tem:dil></cfif>
                        </tem:SelectKategori>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectKategori"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="UpdateKategoriDil">
        <cfargument  name="UpdateKategoriDilRequest" required="true" hint="Kategorileri ve ayarlari içeren UpdateKategoriDilRequest sınıfı">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateKategoriDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Ayar>
                                </ns:Ayar>
                                <ns:Liste>
                                <ns:KategoriDil>
                                </ns:KategoriDil>
                                </ns:Liste>
                            </tem:request>
                        </tem:UpdateKategoriDil>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateKategoriDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="DeleteMarka">
        <cfargument  name="MarkaId" required="true" hint="Silinmek istenen markanın id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:DeleteMarka>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:MarkaID>#argumnets.MarkaID#</tem:MarkaID>
                        </tem:DeleteMarka>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/DeleteMarka"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveMarka">
        <cfargument  name="Marka" required="true" hint="Eklenecek markanın bilgilerini içeren Marka sınıfı.">
        <cfargument  name="ID" required="true">
        <cfxml veriable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveMarka>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:marka>
                                <ns:ID>#arguments.ID#</ns:ID>
                            </tem:marka>
                        </tem:SaveMarka>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveMarka"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectMarka">
        <cfargument  name="MarkaID" required="true" hint="Getirilmek istenen Markaya ait tekil anahtar(id).">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectMarka>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:markaID>#arguments.MarkaID#</tem:markaID>
                        </tem:SelectMarka>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectMarka"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="DeleteTedarikci">
        <cfargument  name="TedarikciID" required="true" hint="Silinmek istenen Tedarikçiye ait tekil anahtar(id).">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:DeleteTedarikci>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:TedarikciID>#arguments.TedarikciID#</tem:TedarikciID>
                        </tem:DeleteTedarikci>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/DeleteTedarikci"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveTedarikci">
        <cfargument  name="Marka" required="true" hint="Eklenecek markanın bilgilerini içeren Marka sınıfı">
        <cfargument  name="ID" required="true">
        <cfxml  variable="xmlData">
            <cfoutput>
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                <soapenv:Header/>
                <soapenv:Body>
                    <tem:SaveTedarikci>
                        <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        <tem:tedarikci>
                            <ns:ID>#arguments.ID#</ns:ID>
                        </tem:tedarikci>
                    </tem:SaveTedarikci>
                </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveTedarikci"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectTedarikci">
        <cfargument  name="TedarikciId" required="true" hint="Getirilmek istenen Tedarikçiye ait tekil anahtar(id).">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectTedarikci>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:tedarikciID>#arguments.TedarikciId#</tem:tedarikciID>
                        </tem:SelectTedarikci>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectTedarikci"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveUrun">
        <cfargument  name="UrunKartlari" required="true" hint="Eklenecek olan ürün kartlarını içeren UrunKarti listesi.">
        <cfargument  name="UrunKartiAyar" required="true" hint="Ürün Kartı ayarlarını içeren UrunKartiAyar sınıfı.">
        <cfargument  name="VaryasyonAyar" required="true" hint="Ürün ayarlarını içeren VaryasyonAyar sınıfı.">
        <cfargument name="ID" required="true" hint="Ürün Kartı Id">
        <cfargument  name="UrunAdi" required="true" hint="Ürün Kartı ürün adı">
        <cfargument  name="Aciklama" required="true" hint="Ürün kartı açıklaması">
        <cfargument  name="AnaKategori" required="true" hint="Ürün kartı ana kategori"><!-----emre abiye sor bunları ona göre eklersin------>
        <cfargument  name="AnaKategoriID" required="true" hint="Ürün kartı ana kategori id">
        <cfargument  name="Kategoriler" required="true" hint="ürün kartı kategoriler">
        <cfargument  name="MarkaID" required="true" hint="ürün kartı marka id">
        <cfargument  name="TedarikciID" required="true" hint="ürün kartı tedarikçi id">
        <cfargument  name="Resimler" required="true" hint="ürün kartı resimler">
        <cfargument  name="SatisBirimi" required="true" hint="ürün kartı satış birimi">
        <cfargument  name="UcretsizKargo" required="true" hint="ürün kartı ücretsiz kargo">
        <cfargument  name="Varyasyonlar" required="true" hint="ürün kartı varyasyonlar">
        <cfargument  name="TedarikciKodu" required="true" hint="ürün kartı tedarikçi kodu">
        <cfargument  name="VaryasyonID" required="true" hint="varyasyon id">
        <cfargument  name="ParaBirimiID" required="true" hint="varyasyon para birimi id">
        <cfargument  name="VaryasyonSatisFiyati" required="true" hint="varyasyon satış fiyatı">
        <cfargument  name="Tanım" required="true" hint="varyasyon özellik tanım">
        <cfargument  name="Deger" required="true" hint="varyasyon özellik değer">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveUrun>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:urunKartlari>#arguments.UrunKartlari#</tem:urunKartlari>
                            <tem:ukAyar>#arguments.UrunKartiAyar#<tem:vAyar>
                            <tem:vAyar>#arguments.VaryasyonAyar#</tem:vAyar>
                        </tem:SaveUrun>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveUrun"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectUrun">
        <cfargument  name="UrunFiltre" required="true" hint="Ürünlerin filtre değerlerini içeren UrunFiltre sınıfı.">
        <cfargument  name="UrunSayfalama" required="true" hint="Ürünlerin sayfalama ve sıralama değerlerini içeren UrunSayfalama sınıfı.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUrun>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:f>#arguments.UrunFiltre#</tem:f>
                            <tem:s>#arguments.UrunSayfalama#</tem:s>
                        </tem:SelectUrun>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectUrun"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectUrunCount">
        <cfargument  name="UrunFiltre" required="true" hint="Ürünlerin filtre değerlerini içeren UrunFiltre sınıfı">
        <cfxml  variable="xmlData">
        <cfoutput>
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                <soapenv:Header/>
                <soapenv:Body>
                    <tem:SelectUrunCount>
                        <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        <tem:f>#arguments.UrunFiltre#</tem:f>
                    </tem:SelectUrunCount>
                </soapenv:Body>
            </soapenv:Envelope>
        </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectUrunCount"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectUrunOdemeSecenek">
        <cfargument  name="VaryasyonId" required="true" hint="Ödeme seçenekleri getirilmek istenen varyasyona ait iddeğeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUrunOdemeSecenek>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:varyasyonId>#arguments.VaryasyonId#</tem:varyasyonId>
                        </tem:SelectUrunOdemeSecenek>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectUrunOdemeSecenek"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectUrunYorum">
        <cfargument  name="UrunKartId" required="true" hint="Yorumları getirilmek istenen ürün kartına ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUrunYorum>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:urunKartId>#arguments.UrunKartId#</tem:urunKartId>
                        </tem:SelectUrunYorum>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectUrunYorum"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectUrunKategori">
        <cfargument  name="UrunKartId" hint="Kategorileri getirilmek istenen ürün kartına ait id değeri.">
        <cfargument  name="KategoriId" hint="Kategoriye ait id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUrunKategori>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <cfif len(arguments.KategoriID)><tem:KategoriID>#arguments.KategoriID#</tem:KategoriID></cfif>
                            <cfif len(arguments.UrunKartId)><tem:UrunKartiID>#arguments.UrunKartId#</tem:UrunKartiID></cfif>
                        </tem:SelectUrunKategori>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectUrunKategori"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveResim">
        <cfargument  name="Kartlar" required="true" hint="Ürün Katlarını ve kartlara eklenecek resimleri içeren UrunKarti sınıfı listesi.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveResim>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:kartlar>#arguments.Kartlar#</tem:kartlar>
                        </tem:SaveResim>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveResim"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveMagazaStok">
        <cfargument  name="SaveMagazaStokRequest" required="true" hint="Mağaza ve stok bilgilerini içeren saveMagazaStokRequestModeli.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveMagazaStok>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>#arguments.SaveMagazaStokRequest#</tem:request>
                        </tem:SaveMagazaStok>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveMagazaStok"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="UpdateUrunDil">
        <cfargument  name="UpdateUrunDilRequest" required="true" hint="Dil bilgilerini ve güncelleme ayarlarını içeren UpdateUrunDilRequest sınıfı">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateUrunDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>#arguments.UpdateUrunDilRequest#</tem:request>
                        </tem:UpdateUrunDil>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateUrunDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveIlgılıUrun">
        <cfargument  name="IlgiliUrunListe" required="true" hint="İlgili ürünleri içeren liste">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveIlgiliUrun>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:list>#arguments.IlgiliUrunListe#</tem:list>
                        </tem:SaveIlgiliUrun>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveIlgiliUrun"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveTeknikDetayDeger">
        <cfargument  name="TeknikDetayDeger" required="true" hint="Teknik detay deger bilgilerini içeren TeknikDetayDeger sınıfı.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveTeknikDetayDeger>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>#arguments.TeknikDetayDeger#</tem:m>
                        </tem:SaveTeknikDetayDeger>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveTeknikDetayDeger"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveTeknikDetayGrup">
        <cfargument  name="TeknikDetayGrup" required="true" hint="Teknik deyat grup bilgilerini içeren TeknikDetayGrup sınıfı.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveTeknikDetayGrup>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>#arguments.TeknikDetayGrup#</tem:m>
                        </tem:SaveTeknikDetayGrup>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveTeknikDetayGrup"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveTeknikDetayOzellik">
        
    </cffunction>
</cfcomponent>
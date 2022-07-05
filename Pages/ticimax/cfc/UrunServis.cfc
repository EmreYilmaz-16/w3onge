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
    <!---Kategori kısmı class---->
    <cffunction  name="SaveKategori">
        <cfargument name="Kategori" required="true">
        <cfargument  name="Id" required="true" hint="0 gönderilir ise yeni kategori eklenir 0 dan büyük gönderilir ise gönderilen id li kategori güncellenir.">
        <cfargument name="Pid" required="true" hint="Üst kategori id. Üst kategori yoksa 0 gönderilmelidir.">
        <cfargument name="Aktif" hint="Kategori aktif olma durumu.">
        <cfargument  name="Tanim" required="true" hint="Kategori adı.">
        <cfargument  name="Kod" required="true" hint="Kategori Kodu.">
        <cfargument  name="SeoAnahtarKelime" hint="Seo optimizasyonu için kullanılan kelimeler.">
        <cfargument  name="SeoSayfaBaslik" hint="Seo optimizasyonu için kullanılan sayfa başlığı.">
        <cfargument  name="SeoSayfaAciklama" hint="Seo optimizasyonu için kullanılan açıklama.">
        <cfargument  name="Icerik" hint="Html içerik alanı.">
        <cfargument  name="Sira" hint="Kategorinin sıra numarası.">
        <cfargument  name="Url" hint="Kategori url bilgisi">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveKategori>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:kategori>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <ns:ID>#arguments.Id#</ns:ID>
                                <cfif len(arguments.Icerik)><ns:Icerik>#arguments.Icerik#</ns:Icerik></cfif>
                                <ns:KategoriMenuGoster>1</ns:KategoriMenuGoster>
                                <ns:Kod>#arguments.Kod#</ns:Kod>
                                <ns:PID>#arguments.Pid#</ns:PID>
                                <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                <cfif len(arguments.Sira)><ns:Sira>#arguments.Sira#</ns:Sira></cfif>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                <cfif len(arguments.Url)><ns:Url>#arguments.Url#</ns:Url></cfif>
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
    <!---UpdateKategorDilRequest class ayrıca liste de var burada----->
    <cffunction  name="UpdateKategoriDil">
        <cfargument  name="UpdateKategoriDilRequest" required="true" hint="Kategorileri ve ayarlari içeren UpdateKategoriDilRequest sınıfı">
        <cfargument  name="Ayar" required="true" hint="Güncelleme ayarlarını içeren KategoriDilAyar sınıfı">
        <cfargument  name="Dil" required="true" hint="Dil kodu örn = “en”">
        <cfargument  name="Liste" required="true" hint="Kategori ve değişecek değerleri içeren KategoriDil sınıfı listesi ">
        <cfargument  name="IcerikGuncelle" hint="Içerik güncelleme durumu">
        <cfargument  name="SeoAnahtarKelimeGuncelle" hint="Seo anahtar kelime güncelleme durumu">
        <cfargument  name="SeoSayfaAciklamaGuncelle" hint="Seo sayfa açıklama güncelleme durumu">
        <cfargument  name="SeoSayfaBaslikGuncelle" hint="Seo sayfa başlık güncelleme durumu">
        <cfargument  name="TanimGuncelle" hint="Tanım güncelleme durumu">
        <cfargument  name="ID" required="true" hint="Kategori id">
        <cfargument  name="Icerik" hint="Güncellenecek içerik değeri">
        <cfargument  name="SeoAnahtarKelime" hint="Günellenecek seo anahtar kelime">
        <cfargument  name="SeoSayfaAciklama" hint="Güncellenecek seo sayfa açıklama">
        <cfargument  name="SeoSayfaBaslik" hint="Güncellenecek seo sayfa başlık">
        <cfargument  name="Tanim" hint="Güncellenecek tanım">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateKategoriDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Ayar>
                                <cfif len(arguments.IcerikGuncelle)><ns:IcerikGuncelle>#arguments.IcerikGuncelle#</ns:IcerikGuncelle></cfif>
                                <cfif len(arguments.SeoAnahtarKelimeGuncelle)><ns:SeoAnahtarKelimeGuncelle>#arguments.SeoAnahtarKelimeGuncelle#</ns:SeoAnahtarKelimeGuncelle></cfif>
                                <cfif len(arguments.SeoSayfaAciklamaGuncelle)><ns:SeoSayfaAciklamaGuncelle>#arguments.SeoSayfaAciklamaGuncelle#</ns:SeoSayfaAciklamaGuncelle></cfif>
                                <cfif len(arguments.SeoSayfaBaslikGuncelle)><ns:SeoSayfaBaslikGuncelle>#arguments.SeoSayfaBaslikGuncelle#</ns:SeoSayfaBaslikGuncelle></cfif>
                                <cfif len(arguments.TanimGuncelle)><ns:TanimGuncelle>#arguments.TanimGuncelle#</ns:TanimGuncelle></cfif>
                                </ns:Ayar>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:KategoriDil>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <cfif len(arguments.Icerik)><ns:Icerik>#arguments.Icerik#</ns:Icerik></cfif>
                                    <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                    <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                    <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                    <cfif len(arguments.Tanim)><ns:Tanim>#arguments.Tanim#</ns:Tanim></cfif>
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
    <!---Marka kısmı class--->
    <cffunction  name="SaveMarka">
        <cfargument  name="Marka" required="true" hint="Eklenecek markanın bilgilerini içeren Marka sınıfı.">
        <cfargument  name="ID" required="true">
        <cfargument  name="Aktif" hint="Markanın aktiflik durumu.">
        <cfargument  name="SeoAnahtarKelime" hint="Seo optimizasyonu için kullanılan kelimeler.">
        <cfargument  name="SeoSayfaAciklama" hint="Seo optimizasyonu için kullanılan açıklama.">
        <cfargument  name="SeoSayfaBaslik" hint="Seo optimizasyonu için kullanılan sayfa başlığı.">
        <cfargument  name="Tanim" required="true" hint="Marka adı.">
        <cfargument  name="Breadcrumb" default="">
        <cfargument  name="EklemeTarihi" default="">
        <cfargument  name="GuncellemeTarihi" default="">
        <cfargument  name="Icerik" default="">
        <cfargument  name="Resim" default="">
        <cfargument  name="Sira" default="">
        <cfargument name="Url" default="">
        <cfxml veriable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                <soapenv:Header/>
                <soapenv:Body>
                   <tem:SaveMarka>
                      <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                      <tem:marka>
                         <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                         <cfif len(arguments.Breadcrumb)><ns:Breadcrumb>#arguments.Breadcrumb#</ns:Breadcrumb></cfif>
                         <cfif len(arguments.EklemeTarihi)><ns:EklemeTarihi>#arguments.EklemeTarihi#</ns:EklemeTarihi></cfif>
                         <cfif len(arguments.GuncellemeTarihi)><ns:GuncellemeTarihi>#arguments.GuncellemeTarihi#</ns:GuncellemeTarihi></cfif>
                         <ns:ID>#arguments.ID#</ns:ID>
                         <cfif len(arguments.Icerik)><ns:Icerik>#arguments.Icerik#</ns:Icerik></cfif>
                         <cfif len(arguments.Resim)><ns:Resim>#arguments.Resim#</ns:Resim></cfif>
                         <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                         <cfif len(arguemnts.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                         <cfif len(arguemnts.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguemnts.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                         <cfif len(arguments.Sira)><ns:Sira>#arguments.Sira#</ns:Sira></cfif>
                         <ns:Tanim>#arguemnts.Tanim#</ns:Tanim>
                         <cfif len(arguments.Url)><ns:Url>#arguemnts.Url#</ns:Url></cfif>
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
    <!---Marka kısmı class---->
    <cffunction  name="SaveTedarikci">
        <cfargument  name="Marka" required="true" hint="Eklenecek markanın bilgilerini içeren Marka sınıfı">
        <cfargument  name="Aktif" hint="Tedarikçinin aktiflik durumu.">
        <cfargument  name="ID" required="true" hint="0 gönderilir ise yeni tedarikçi eklenir 0 dan büyük gönderilir ise gönderilen id li tedarikçi güncellenir.">
        <cfargument  name="Mail" hint="Tedarikçi mail adresi.">
        <cfargument  name="Not" hint="Eklenmek istenen not bilgisi.">
        <cfargument  name="Tanim" required="true" hint="Tedarikçi adı">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                <soapenv:Header/>
                <soapenv:Body>
                   <tem:SaveTedarikci>
                      <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                      <tem:tedarikci>
                         <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                         <ns:ID>#arguments.ID#</ns:ID>
                         <cfif len(arguemnts.Mail)><ns:Mail>#arguemnts.Mail#</ns:Mail></cfif>
                         <cfif len(arguments.Not)><ns:Not>#arguments.Not#</ns:Not></cfif>
                         <ns:Tanim>#arguments.Tanim#</ns:Tanim>
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
    <!----UrunKartları,UrunKartıAyar ve VaryasyonAyar kısımları class içerisinde list de var----->
    <cffunction  name="SaveUrun">
        <cfargument  name="UrunKartlari" required="true" hint="Eklenecek olan ürün kartlarını içeren UrunKarti listesi.">
        <cfargument  name="UrunKartiAyar" required="true" hint="Ürün Kartı ayarlarını içeren UrunKartiAyar sınıfı.">
        <cfargument  name="VaryasyonAyar" required="true" hint="Ürün ayarlarını içeren VaryasyonAyar sınıfı.">
        <cfargument name="ID" required="true" hint="Ürün Kartı Id">
        <cfargument  name="UrunAdi" required="true" hint="Ürün Kartı ürün adı">
        <cfargument  name="Aciklama" required="true" hint="Ürün kartı açıklaması">
        <cfargument  name="AnaKategori" required="true" hint="Ürün kartı ana kategori">
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
        <cfargument  name="ParaBirimi" default="">
        <cfargument  name="ParaBirimiID" required="true" hint="varyasyon para birimi id">
        <cfargument  name="VaryasyonSatisFiyati" required="true" hint="varyasyon satış fiyatı">
        <cfargument  name="Tanim" required="true" hint="varyasyon özellik tanım">
        <cfargument  name="Deger" required="true" hint="varyasyon özellik değer">
        <cfargument  name="AciklamaGuncelle" hint="Açıklama güncelleme durumu.">
        <cfargument  name="AktifGuncelle" hint="Aktiflik güncelleme durumu.">
        <cfargument  name="FBStoreGosterGuncelle" hint="Facebook store da ki görünürlüğü güncelleme durumu.">
        <cfargument  name="FirsatUrunuGuncelle" hint="Fırsat ürünü güncelleme durumu.">
        <cfargument  name="KategoriGuncelle" hint="Kategorileri güncelleme durumu.">
        <cfargument  name="MaksTaksitSayisiGuncelle" hint="Maksimum taksit sayısı güncelleme durumu.">
        <cfargument  name="MarkaGuncelle" hint="Marka güncelleme durumu.">
        <cfargument  name="OnYaziGuncelle" hint="Ön yazı güncelleme durumu.">
        <cfargument  name="ParaPuanGuncelle" hint="Para puan güncelleme durumu.">
        <cfargument  name="SatisBirimiGuncelle" hint="Satış birimi güncelleme durumu.">
        <cfargument  name="SeoAnahtarKelimeGuncelle" hint="Seo anahtar kelime güncelleme durumu.">
        <cfargument  name="SeoSayfaAciklamaGuncelle" hint="Seo sayfa açıklama güncelleme durumu.">
        <cfargument  name="SeoSayfaBaslikGuncelle" hint="Seo sayfa başlık güncelleme durumu.">
        <cfargument  name="TedarikciGuncelle" hint="Tedarikçi güncelleme durumu.">
        <cfargument  name="UcretsizKargoGuncelle" hint="Ücretsiz kargo güncelleme durumu.">
        <cfargument  name="UrunAdiGuncelle" hint="Ürün adi güncelleme durumu.">
        <cfargument  name="UrunResimGuncelle" hint="Ürün resim güncelleme durumu.">
        <cfargument  name="VitrinGuncelle" hint="Vitrin görünürlüğü güncelleme durumu.">
        <cfargument  name="YeniUrunGuncelle" hint="Yeni ürün güncelleme durumu.">
        <cfargument  name="AdwordsAciklamaGuncelle" hint="Adwords açıklama güncelleme durumu.">
        <cfargument  name="AdwordsKategoriGuncelle" hint="Adwords kategori güncelleme durumu.">
        <cfargument  name="AdwordsTipGuncelle" hint="Adwords tipi güncelleme durumu.">
        <cfargument  name="UserAgent" hint="User agent bilgisi">
        <cfargument  name="AramaAnahtarKelimeGuncelle" hint="Arama anahtar kelime güncelleme durumu.">
        <cfargument  name="AsortiGrupGuncelle" hint="Asorti grup güncelleme durumu.">
        <cfargument  name="Base64resim" hint="Base64 resim güncelleme durumu.">
        <cfargument  name="EtiketGuncelle" hint="Etkiet güncelleme durumu">
        <cfargument  name="KargoTipiGuncelle" hint="Kargo tipi güncelleme durumu.">
        <cfargument  name="OncekiKategoriEslestirmeleriniTemizle" hint="Önceki kategorileri temizleme durumu.">
        <cfargument  name="OncekiResimleriSil" hint="Önceki resimleri silme durumu.">
        <cfargument  name="OzelAlan1Guncelle" hint="Özel alan 1 güncelleme durumu.">
        <cfargument  name="OzelAlan2Guncelle" hint="Özel alan 2 güncelleme durumu.">
        <cfargument  name="OzelAlan3Guncelle" hint="Özel alan 3 güncelleme durumu.">
        <cfargument  name="OzelAlan4Guncelle" hint="Özel alan 4 güncelleme durumu.">
        <cfargument  name="OzelAlan5Guncelle" hint="Özel alan 5 güncelleme durumu">
        <cfargument  name="ResimleriIndirme" hint="Resimleri indirme durumu.">
        <cfargument  name="ResmiOlmayanlaraResimEkle" hint="Resmi olmayanlara resim ekleme durumu.">
        <cfargument  name="SeoNoFollowGuncelle" hint="Seo no follow özelliği güncelleme durumu.">
        <cfargument  name="SeoNoIndexGuncelle" hint="Seo no index özelliği güncelleme durumu.">
        <cfargument  name="TahminiTeslimSuresiGuncelle" hint="Tahmini teslim süresi güncelleme durumu.">
        <cfargument  name="TedarikciKodunaGoreGuncelle" hint="Tedarikçi koduna göre güncelleme durumu.">
        <cfargument  name="TeknikDetayGuncelle" hint="Teknik detay güncelleme durumu.">
        <cfargument  name="UrunAdresiniElleOlustur" hint="Ürün adresini elle oluşturma durumu.">
        <cfargument  name="UyeAlimMaxGuncelle" hint="Üye maksimum alım güncelleme durumu.">
        <cfargument  name="UyeAlimMinGuncelle" hint="Üye minumum alım güncelleme durumu.">
        <cfargument  name="YayinTarihiGuncelle" hint="Yayın tarihi güncelleme durumu.">
        <cfargument  name="AktifGuncelle2" hint="Aktiflik güncelleme durumu.">
        <cfargument  name="AlisFiyatiGuncelle" hint="Alış fiyatı güncelleme durumu.">
        <cfargument  name="BarkodGuncelle" hint="Barkod güncelleme durumu.">
        <cfargument  name="IndirimliFiyatiGuncelle" hint="Indirimli fiyat güncelleme durumu">
        <cfargument  name="KargoUcretiGuncelle" hint="Kargo ücreti güncelleme durumu.">
        <cfargument  name="KargoAgirligiGuncelle" hint="Kargo ağırlığı güncelleme durumu.">
        <cfargument  name="ParaBirimiGuncelle" hint="Para birimi güncelleme durumu.">
        <cfargument  name="PiyasaFiyatiGuncelle" hint="Piyasa fiyatı güncelleme durumu.">
        <cfargument  name="SatisFiyatiGuncelle" hint="Satış fiyatı güncelleme durumu.">
        <cfargument  name="StokAdediGuncelle" hint="Stok adedi güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat1Guncelle" hint="Uye tipi fiyat 1 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat2Guncelle" hint="Uye tipi fiyat 2 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat3Guncelle" hint="Uye tipi fiyat 3 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat4Guncelle" hint="Uye tipi fiyat 4 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat5Guncelle" hint="Uye tipi fiyat 5 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat6Guncelle" hint="Uye tipi fiyat 6 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat7Guncelle" hint="Uye tipi fiyat 7 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat8Guncelle" hint="Uye tipi fiyat 8 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat9Guncelle" hint="Uye tipi fiyat 9 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat10Guncelle" hint="Uye tipi fiyat 10 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat11Guncelle" hint="Uye tipi fiyat 11 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat12Guncelle" hint="Uye tipi fiyat 12 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat13Guncelle" hint="Uye tipi fiyat 13 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat14Guncelle" hint="Uye tipi fiyat 14 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat15Guncelle" hint="Uye tipi fiyat 15 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat16Guncelle" hint="Uye tipi fiyat 16 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat17Guncelle" hint="Uye tipi fiyat 17 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat18Guncelle" hint="Uye tipi fiyat 18 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat19Guncelle" hint="Uye tipi fiyat 19 güncelleme durumu.">
        <cfargument  name="UyeTipiFiyat20Guncelle" hint="Uye tipi fiyat 20 güncelleme durumu.">
        <cfargument  name="EksiStokAdediGuncelle" hint="Eski stok adedi güncelleme durumu.">
        <cfargument  name="KdvDahilGuncelle" hint="Kdv dahil güncelleme durumu.">
        <cfargument  name="KdvOraniGuncelle" hint="Kdv oranı güncelleme durumu.">
        <cfargument  name="OncekiResimleriSil2" hint="Önceki resimlerin silinmesi durumu.">
        <cfargument  name="ResimOlmayanlaraResimEkle" hint="Resmi olmayanlara resim eklenmesi durumu.">
        <cfargument  name="StokKoduGuncelle" hint="Stok kodu güncelleme durumu.">
        <cfargument  name="UrunResimGuncelle2" hint="Ürün resmi güncelleme durumu.">
        <cfargument  name="Aktif" hint="Ürünün aktiflik durumu.">
        <cfargument  name="OnYazi" hint="Ürün önyazısı.">
        <cfargument  name="SeoAnahtarKelime" hint="Seo optimizasyonu için kullanılan kelimeler.">
        <cfargument  name="SeoSayfaAciklama" hint="Seo optimizasyonu için kullanılan açıklama.">
        <cfargument  name="SeoSayfaBaslik" hint="Seo optimizasyonu için kullanılan sayfa başlık.">
        <cfargument  name="Vitrin" hint="Ürünün vitrinde görünme durumu.">
        <cfargument  name="YeniUrun" hint="Ürünün yeni ürün olarak görünme durumu.">
        <cfargument  name="AdwordsAciklama" hint="Xml deki açıklama.">
        <cfargument  name="AdwordsKategori" hint="Xml deki kategori.">
        <cfargument  name="AdwordsTip" hint="Xml deki tip.">
        <cfargument  name="AramaAnahtarKelime" hint="Sitede arama yaparken kullanılacak anahtar kelimeler ">
        <cfargument  name="AsortiGrupId" hint="Ürüne eklenecek asorti grup id değeri.">
        <cfargument  name="DuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="EkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EntegrasyonID" hint="Ürüne eklenecek entegrasyon id değeri.">
        <cfargument  name="FBStoreGoster" hint="Ürünün facebook store da gösterilme durumu.">
        <cfargument  name="FirsatUrunu" hint="Ürünün fırsat ürünlerine eklenme durumu">
        <cfargument  name="IndirimliFiyatOzellik" hint="Bu alanda 3 farklı değer girebiliyoruz. 0=Devamlı indirim , 1=Stok adedine göre indirim, 2= Tarihe göre indirim. ">
        <cfargument  name="IndirimliFiyatOzellikStok1" hint="İndirim başlangıç stok adedi">
        <cfargument  name="IndirimliFiyatOzellikStok2" hint="İndirim bitiş stok adedi. ">
        <cfargument  name="IndirimliFiyatOzellikTarih1" hint="İndirim başlangıç tarihi.">
        <cfargument  name="IndirimliFiyatOzellikTarih2" hint="İndirim bitiş tarihi.">
        <cfargument  name="MaksTaksitSayisi" hint="Ürünün maksimum taksit sayısı değeri.">
        <cfargument  name="OzelAlan1" hint="Eklenecek farklı özelliklerde kullanılacak özel alan. ">
        <cfargument  name="OzelAlan2" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="OzelAlan3" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="OzelAlan4" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="OzelAlan5" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="SeoNoFollow">
        <cfargument  name="SeoNoIndex">
        <cfargument  name="TahminiTeslimSuresi" hint="Ürünün tahmini teslim süresi">
        <cfargument  name="TeknikDetayGrupID" hint="Teknik Detay grup id değeri.">
        <cfargument  name="UrunSayfaAdresi" hint="Ürün url bilgisi.">
        <cfargument  name="UyeAlimMax" hint="Bir üyenin en fazla kaç ürün alabileceği değeri.">
        <cfargument  name="UyeAlimMin" hint="Bir üyenin en az kaç ürün alabileceği değeri.">
        <cfargument  name="YayinTarihi" hint="Ürünün yayın tarihi değeri.">
        <cfargument  name="AlisFiyati" hint="Varyasyona ait alis fiyatı değeri.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri.">
        <cfargument  name="Desi" hint="Varyasyon desi değeri.">
        <cfargument  name="KargoUcreti" hint="Varyasyon kargo ücreti değeri.">
        <cfargument  name="KdvDahil" hint="Kdv dahil olma durumu.">
        <cfargument  name="KdvOrani" hint="Varyasyon kdv orani değeri">
        <cfargument  name="Ozellikler" hint="Varyasyonun özellikleri."> 
        <cfargument  name="VaryasyonResimler" hint="Varyasyon resimleri.">
        <cfargument  name="StokAdedi" hint="Stok adedi değeri. ">
        <cfargument  name="StokKodu" hint="Varyasyon stok kodu .">
        <cfargument  name="VaryasyonAktif" hint="Varyasyonun aktif olma durumu.">
        <cfargument  name="VDuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="VEkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EksiStokAdedi" hint="Ayrılacak olan stok adedi.">
        <cfargument  name="IndirimliFiyati" hint="Varyasyon indirimli fiyat değeri.">
        <cfargument  name="VParaBirimi" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="VParaBirimiKodu" hint="Eğer para birimiId girildiyse boş gönderilebilir">
        <cfargument  name="VTedarikciKodu" hint="Tedarikçi koduna göre güncelle true ise zorunlu">
        <cfargument  name="UyeTipiFiyat1" hint="Üye tipi 1 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat2" hint="Üye tipi 2 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat3" hint="Üye tipi 3 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat4" hint="Üye tipi 4 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat5" hint="Üye tipi 5 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat6" hint="Üye tipi 6 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat7" hint="Üye tipi 7 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat8" hint="Üye tipi 8 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat9" hint="Üye tipi 9 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat10" hint="Üye tipi 10 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat11" hint="Üye tipi 11 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat12" hint="Üye tipi 12 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat13" hint="Üye tipi 13 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat14" hint="Üye tipi 14 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat15" hint="Üye tipi 15 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat16" hint="Üye tipi 16 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat17" hint="Üye tipi 17 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat18" hint="Üye tipi 18 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat19" hint="Üye tipi 19 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat20" hint="Üye tipi 20 ye özel fiyat değeri.">
        <cfargument name="EklemeTarihi" default="">
        <cfargument  name="EtiketID" default="">
        <cfargument  name="HediyeIpucu" default="">
        <cfargument  name="IlgiliUrunResim" default="">
        <cfargument  name="KargoTipi" default="">
        <cfargument  name="int" default="">
        <cfargument  name="ListedeGoster" default="">
        <cfargument  name="Marka" default="">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="Alpha2Code" default="">
        <cfargument  name="Alpha3Code" default="">
        <cfargument  name="UlkeID" default="">
        <cfargument  name="NumericCode" default="">
        <cfargument  name="UlkeTanim" default="">
        <cfargument  name="PuanDeger" default="">
        <cfargument  name="Sira" default="">
        <cfargument  name="TahminiTeslimSuresiAyniGun" default="">
        <cfargument  name="TahminiTeslimSuresiGoster" default="">
        <cfargument  name="TahminiTeslimSuresiTarih" default="">
        <cfargument  name="TakimKampanyaId" default="">
        <cfargument  name="TakimUrun" default="">
        <cfargument  name="TedarikciKodu2" default="">
        <cfargument  name="DegerID" default="">
        <cfargument  name="OzellikID" default="">
        <cfargument  name="ToplamStokAdedi" default="">
        <cfargument  name="UrunAdediKademeDeger" default="">
        <cfargument  name="UrunAdediMinimumDeger" default="">
        <cfargument  name="UrunAdediOndalikliSayiGirilebilir" default="">
        <cfargument  name="UrunAdediVarsayilanDeger" default="">
        <cfargument  name="UrunKapidaOdemeYasakli" default="">
        <cfargument  name="Desi2" default="">
        <cfargument  name="IndirimliFiyati1" default="">
        <cfargument  name="IndirimliFiyati2" default="">
        <cfargument  name="IndirimliFiyati3" default="">
        <cfargument  name="IndirimliFiyati4" default="">
        <cfargument  name="IndirimliFiyati5" default="">
        <cfargument  name="IndirimliFiyati6" default="">
        <cfargument  name="IndirimliFiyati7" default="">
        <cfargument  name="IndirimliFiyati8" default="">
        <cfargument  name="IndirimliFiyati9" default="">
        <cfargument  name="IndirimliFiyati10" default="">
        <cfargument  name="IndirimliFiyati11" default="">
        <cfargument  name="IndirimliFiyati12" default="">
        <cfargument  name="IndirimliFiyati13" default="">
        <cfargument  name="IndirimliFiyati14" default="">
        <cfargument  name="IndirimliFiyati15" default="">
        <cfargument  name="IndirimliFiyati16" default="">
        <cfargument  name="IndirimliFiyati17" default="">
        <cfargument  name="IndirimliFiyati18" default="">
        <cfargument  name="IndirimliFiyati19" default="">
        <cfargument  name="IndirimliFiyati20" default="">
        <cfargument  name="IscilikAgirlik" default="">
        <cfargument  name="IscilikParaBirimi" default="">
        <cfargument  name="IscilikParaBirimiId" default="">
        <cfargument  name="IscilikParaBirimiKodu" default="">
        <cfargument  name="IscilikParaBirimiGuncelle" default="">
        <cfargument  name="KdvDahil1" default="">
        <cfargument  name="KdvDahil2" default="">
        <cfargument  name="KdvDahil3" default="">
        <cfargument  name="KdvDahil4" default="">
        <cfargument  name="KdvDahil5" default="">
        <cfargument  name="KdvDahil7" default="">
        <cfargument  name="KdvDahil8" default="">
        <cfargument  name="KdvDahil9" default="">
        <cfargument  name="KdvDahil10" default="">
        <cfargument  name="KdvDahil11" default="">
        <cfargument  name="KdvDahil12" default="">
        <cfargument  name="KdvDahil13" default="">
        <cfargument  name="KdvDahil14" default="">
        <cfargument  name="KdvDahil15" default="">
        <cfargument  name="KdvDahil16" default="">
        <cfargument  name="KdvDahil17" default="">
        <cfargument  name="KdvDahil18" default="">
        <cfargument  name="KdvDahil19" default="">
        <cfargument  name="KdvDahil20" default="">
        <cfargument  name="KdvOrani1" default="">
        <cfargument  name="KdvOrani2" default="">
        <cfargument  name="KdvOrani3" default="">
        <cfargument  name="KdvOrani4" default="">
        <cfargument  name="KdvOrani5" default="">
        <cfargument  name="KdvOrani6" default="">
        <cfargument  name="KdvOrani7" default="">
        <cfargument  name="KdvOrani8" default="">
        <cfargument  name="KdvOrani9" default="">
        <cfargument  name="KdvOrani10" default="">
        <cfargument  name="KdvOrani11" default="">
        <cfargument  name="KdvOrani12" default="">
        <cfargument  name="KdvOrani13" default="">
        <cfargument  name="KdvOrani14" default="">
        <cfargument  name="KdvOrani15" default="">
        <cfargument  name="KdvOrani16" default="">
        <cfargument  name="KdvOrani17" default="">
        <cfargument  name="KdvOrani18" default="">
        <cfargument  name="KdvOrani19" default="">
        <cfargument  name="KdvOrani20" default="">
        <cfargument  name="VMarkaID" default="">
        <cfargument  name="Tur" default="">
        <cfargument  name="XmlKod" default="">
        <cfargument  name="ParaBirimiKodu" default="">
        <cfargument  name="ParaBirimi1Id" default="">
        <cfargument  name="ParaBirimi2Id" default="">
        <cfargument  name="ParaBirimi3Id" default="">
        <cfargument  name="ParaBirimi4Id" default="">
        <cfargument  name="ParaBirimi5Id" default="">
        <cfargument  name="ParaBirimi6Id" default="">
        <cfargument  name="ParaBirimi7Id" default="">
        <cfargument  name="ParaBirimi8Id" default="">
        <cfargument  name="ParaBirimi9Id" default="">
        <cfargument  name="ParaBirimi10Id" default="">
        <cfargument  name="ParaBirimi11Id" default="">
        <cfargument  name="ParaBirimi12Id" default="">
        <cfargument  name="ParaBirimi13Id" default="">
        <cfargument  name="ParaBirimi14Id" default="">
        <cfargument  name="ParaBirimi15Id" default="">
        <cfargument  name="ParaBirimi16Id" default="">
        <cfargument  name="ParaBirimi17Id" default="">
        <cfargument  name="ParaBirimi18Id" default="">
        <cfargument  name="ParaBirimi19Id" default="">
        <cfargument  name="ParaBirimi20Id" default="">
        <cfargument  name="SatisFiyati1" default="">
        <cfargument  name="SatisFiyati2" default="">
        <cfargument  name="SatisFiyati3" default="">
        <cfargument  name="SatisFiyati4" default="">
        <cfargument  name="SatisFiyati5" default="">
        <cfargument  name="SatisFiyati6" default="">
        <cfargument  name="SatisFiyati7" default="">
        <cfargument  name="SatisFiyati8" default="">
        <cfargument  name="SatisFiyati9" default="">
        <cfargument  name="SatisFiyati10" default="">
        <cfargument  name="SatisFiyati11" default="">
        <cfargument  name="SatisFiyati12" default="">
        <cfargument  name="SatisFiyati13" default="">
        <cfargument  name="SatisFiyati14" default="">
        <cfargument  name="SatisFiyati15" default="">
        <cfargument  name="SatisFiyati16" default="">
        <cfargument  name="SatisFiyati17" default="">
        <cfargument  name="SatisFiyati18" default="">
        <cfargument  name="SatisFiyati19" default="">
        <cfargument  name="SatisFiyati20" default="">
        <cfargument  name="StokGuncellemeTarihi" default="">
        <cfargument  name="UpdateKey" default="">
        <cfargument  name="UrunAgirligi" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfargument  name="YonlendirmeAdresi" default="">
        <cfargument  name="AlanAdi" default="">
        <cfargument  name="DegerTanim" default="">
        <cfargument  name="EntegrasyonKodu" default="">
        <cfargument  name="HediyeIpucuGosterGuncelle" default="">
        <cfargument  name="IlgiliUrunResimGuncelle" default="">
        <cfargument  name="ListedeGosterGuncelle" default="">
        <cfargument  name="MarketPlaceAktifGuncelle" default="">
        <cfargument  name="MarketPlaceAktif2Guncelle" default="">
        <cfargument  name="MarketPlaceAktif3Guncelle" default="">
        <cfargument  name="MarketPlaceAktif4Guncelle" default="">
        <cfargument  name="MarketPlaceAktif5Guncelle" default="">
        <cfargument  name="MenseiUlkeGuncelle" default="">
        <cfargument  name="TahminiTeslimSuresiGosterGuncelle" default="">
        <cfargument  name="TahminiTeslimSuresiTarihGuncelle" default="">
        <cfargument  name="TedarikciKodu2GoreGuncelle" default="">
        <cfargument  name="UrunAdediKademeDegerGuncelle" default="">
        <cfargument  name="UrunAdediOndalikliSayiGirilebilirGuncelle" default="">
        <cfargument  name="UrunAdediMinimumDegerGuncelle" default="">
        <cfargument  name="UrunAdediVarsayilanDegerGuncelle" default="">
        <cfargument  name="UrunKapidaOdemeYasakliGuncelle" default="">
        <cfargument  name="UyeAlimMaksGuncelle" default="">
        <cfargument  name="EkSecenekGuncelle" default="">
        <cfargument  name="FiyatTipleriGuncelle" default="">
        <cfargument  name="IscilikAgirlikGuncelle" default="">
        <cfargument  name="KargoAgirligiYurtDisiGuncelle" default="">
        <cfargument  name="KonsinyeUrunStokAdediGuncelle" default="">
        <cfargument name="TahminiTeslimSuresiAyniGunGuncelle" default="">
        <cfargument  name="UpdateKeyGuncelle" default="">
        <cfargument  name="UrunAgirligiGuncelle" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveUrun>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:urunKartlari>
                                <ns:UrunKarti>
                                <ns:Aciklama>#arguments.Aciklama#</ns:Aciklama>
                                <cfif len(arguments.AdwordsAciklama)><ns:AdwordsAciklama>#arguments.AdwordsAciklama#</ns:AdwordsAciklama></cfif>
                                <cfif len(arguments.AdwordsKategori)><ns:AdwordsKategori>#arguments.AdwordsKategori#</ns:AdwordsKategori></cfif>
                                <cfif len(arguments.AdwordsTip)><ns:AdwordsTip>#arguments.AdwordsTip#</ns:AdwordsTip></cfif>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <ns:AnaKategori>#arguments.AnaKategori#</ns:AnaKategori>
                                <ns:AnaKategoriID>#arguments.AnaKategoriID#</ns:AnaKategoriID>
                                <cfif len(arguments.AramaAnahtarKelime)><ns:AramaAnahtarKelime>#arguments.AramaAnahtarKelime#</ns:AramaAnahtarKelime></cfif>
                                <cfif len(arguments.AsortiGrupId)><ns:AsortiGrupID>#arguments.AsortiGrupId#</ns:AsortiGrupID></cfif>
                                <cfif len(arguments.DuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.DuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                <cfif len(arguments.EklemeTarihi)><ns:EklemeTarihi>#arguments.EklemeTarihi#</ns:EklemeTarihi></cfif>
                                <cfif len(arguments.EkleyenKullanici)><ns:EkleyenKullanici>#arguments.EkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                <cfif len(arguments.EntegrasyonID)><ns:EntegrasyonID>#arguments.EntegrasyonID#</ns:EntegrasyonID></cfif>
                                <ns:Etiketler>
                                    <ns:UrunKartiEtiket>
                                        <cfif len(arguments.EtiketID)><ns:EtiketID>#arguments.EtiketID#</ns:EtiketID></cfif>
                                    </ns:UrunKartiEtiket>
                                </ns:Etiketler>
                                <cfif len(arguments.FBStoreGoster)><ns:FBStoreGoster>#arguments.FBStoreGoster#</ns:FBStoreGoster></cfif>
                                <cfif len(arguments.FirsatUrunu)><ns:FirsatUrunu>#arguments.FirsatUrunu#</ns:FirsatUrunu></cfif>
                                <cfif len(arguments.HediyeIpucu)><ns:HediyeIpucu>#arguments.HediyeIpucu#</ns:HediyeIpucu></cfif>
                                <ns:ID>#argument.ID#</ns:ID>
                                <cfif len(arguments.IlgiliUrunResim)><ns:IlgiliUrunResim>#arguments.IlgiliUrunResim#</ns:IlgiliUrunResim></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellik)><ns:IndirimliFiyatOzellik>#arguments.IndirimliFiyatOzellik#</ns:IndirimliFiyatOzellik></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikStok1)><ns:IndirimliFiyatOzellikStok1>#arguments.IndirimliFiyatOzellikStok1#</ns:IndirimliFiyatOzellikStok1></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikStok2)><ns:IndirimliFiyatOzellikStok2>#arguments.IndirimliFiyatOzellikStok2#</ns:IndirimliFiyatOzellikStok2></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikTarih1)><ns:IndirimliFiyatOzellikTarih1>#arguments.IndirimliFiyatOzellikTarih1#</ns:IndirimliFiyatOzellikTarih1></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikTarih2)><ns:IndirimliFiyatOzellikTarih2>#arguments.IndirimliFiyatOzellikTarih2#</ns:IndirimliFiyatOzellikTarih2></cfif>
                                <cfif len(arguments.KargoTipi)><ns:KargoTipi>#arguments.KargoTipi#</ns:KargoTipi></cfif>
                                <ns:Kategoriler>
                                    <cfif len(arguments.Kategoriler)><arr:int>#arguments.Kategoriler#</arr:int></cfif>
                                </ns:Kategoriler>
                                <cfif len(arguments.ListedeGoster)><ns:ListedeGoster>#arguments.ListedeGoster#</ns:ListedeGoster></cfif>
                                <cfif len(arguments.MaksTaksitSayisi)><ns:MaksTaksitSayisi>#arguments.MaksTaksitSayisi#</ns:MaksTaksitSayisi></cfif>
                                <cfif len(arguments.Marka)><ns:Marka>#arguments.Marka#</ns:Marka></cfif>
                                <ns:MarkaID>#arguments.MarkaID#</ns:MarkaID>
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <ns:MenseiUlke>
                                    <cfif len(arguments.Alpha2Code)><ns:Alpha2Code>#arguments.Alpha2Code#</ns:Alpha2Code></cfif>
                                    <cfif len(arguments.Alpha3Code)><ns:Alpha3Code>#arguments.Alpha3Code#</ns:Alpha3Code></cfif>
                                    <cfif len(arguments.UlkeID)><ns:ID>#arguments.UlkeID#</ns:ID></cfif>
                                    <cfif len(arguments.NumericCode)><ns:NumericCode>#arguments.NumericCode#</ns:NumericCode></cfif>
                                    <cfif len(arguments.UlkeTanim)><ns:Tanim>#arguments.UlkeTanim#</ns:Tanim></cfif>
                                </ns:MenseiUlke>
                                <cfif len(arguments.OnYazi)><ns:OnYazi>#arguments.OnYazi#</ns:OnYazi></cfif>
                                <cfif len(arguments.OzelAlan1)><ns:OzelAlan1>#arguments.OzelAlan1#</ns:OzelAlan1></cfif>
                                <cfif len(arguments.OzelAlan2)><ns:OzelAlan2>#arguments.OzelAlan2#</ns:OzelAlan2></cfif>
                                <cfif len(arguments.OzelAlan3)><ns:OzelAlan3>#arguments.OzelAlan3#</ns:OzelAlan3></cfif>
                                <cfif len(arguments.OzelAlan4)><ns:OzelAlan4>#arguments.OzelAlan4#</ns:OzelAlan4></cfif>
                                <cfif len(arguments.OzelAlan5)><ns:OzelAlan5>#arguments.OzelAlan5#</ns:OzelAlan5></cfif>
                                <cfif len(arguments.PuanDeger)><ns:PuanDeger>#arguments.PuanDeger#</ns:PuanDeger></cfif>
                                <ns:Resimler>
                                    <arr:string>#arguments.Resimler#</arr:string>
                                </ns:Resimler>
                                <ns:SatisBirimi>#arguments.SatisBirimi#</ns:SatisBirimi>
                                <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                <cfif len(arguments.SeoNoFollow)><ns:SeoNoFollow>#arguments.SeoNoFollow#</ns:SeoNoFollow></cfif>
                                <cfif len(arguments.SeoNoIndex)><ns:SeoNoIndex>#arguments.SeoNoIndex#</ns:SeoNoIndex></cfif>
                                <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                <cfif len(arguments.Sira)><ns:Sira>#arguments.Sira#</ns:Sira></cfif>
                                <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                <cfif len(arguments.TakimKampanyaId)><ns:TakimKampanyaId>#arguments.TakimKampanyaId#</ns:TakimKampanyaId></cfif>
                                <cfif len(arguments.TakimUrun)><ns:TakimUrun>#arguments.TakimUrun#</ns:TakimUrun></cfif>
                                <ns:TedarikciID>#arguments.TedarikciID#</ns:TedarikciID>
                                <cfif len(arguments.TedarikciKodu)><ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu></cfif>
                                <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                <cfif len(arguments.TeknikDetayGrupID)><ns:TeknikDetayGrupID>#arguments.TeknikDetayGrupID#</ns:TeknikDetayGrupID></cfif>
                                <ns:TeknikDetaylar>
                                    <ns:UrunKartiTeknikDetay>
                                        <cfif len(arguments.DegerID)><ns:DegerID>#arguments.DegerID#</ns:DegerID></cfif>
                                        <cfif len(arguments.OzellikID)><ns:OzellikID>#arguments.OzellikID#</ns:OzellikID></cfif>
                                    </ns:UrunKartiTeknikDetay>
                                </ns:TeknikDetaylar>
                                <cfif len(arguments.ToplamStokAdedi)><ns:ToplamStokAdedi>#arguments.ToplamStokAdedi#</ns:ToplamStokAdedi></cfif>
                                <ns:UcretsizKargo>#arguments.UcretsizKargo#</ns:UcretsizKargo>
                                <cfif len(arguments.UrunAdediKademeDeger)><ns:UrunAdediKademeDeger>#arguments.UrunAdediKademeDeger#</ns:UrunAdediKademeDeger></cfif>
                                <cfif len(arguments.UrunAdediMinimumDeger)><ns:UrunAdediMinimumDeger>#arguments.UrunAdediMinimumDeger#</ns:UrunAdediMinimumDeger></cfif>
                                <cfif len(arguments.UrunAdediOndalikliSayiGirilebilir)><ns:UrunAdediOndalikliSayiGirilebilir>#arguments.UrunAdediOndalikliSayiGirilebilir#</ns:UrunAdediOndalikliSayiGirilebilir></cfif>
                                <cfif len(arguments.UrunAdediVarsayilanDeger)><ns:UrunAdediVarsayilanDeger>#arguments.UrunAdediVarsayilanDeger#</ns:UrunAdediVarsayilanDeger></cfif>
                                <ns:UrunAdi>#arguments.UrunAdi#</ns:UrunAdi>
                                <cfif len(arguments.UrunKapidaOdemeYasakli)><ns:UrunKapidaOdemeYasakli>#arguments.UrunKapidaOdemeYasakli#</ns:UrunKapidaOdemeYasakli></cfif>
                                <cfif len(arguments.UrunSayfaAdresi)><ns:UrunSayfaAdresi>#arguments.UrunSayfaAdresi#</ns:UrunSayfaAdresi></cfif>
                                <cfif len(arguments.UyeAlimMax)><ns:UyeAlimMax>#arguments.UyeAlimMax#</ns:UyeAlimMax></cfif>
                                <cfif len(arguments.UyeAlimMin)><ns:UyeAlimMin>#arguments.UyeAlimMin#</ns:UyeAlimMin></cfif>
                                <ns:Varyasyonlar>
                                    <ns:Varyasyon>
                                        <cfif len(arguments.VaryasyonAktif)><ns:Aktif>#arguments.VaryasyonAktif#</ns:Aktif></cfif>
                                        <cfif len(arguments.AlisFiyati)><ns:AlisFiyati>#arguments.AlisFiyati#</ns:AlisFiyati></cfif>
                                        <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                        <ns:Barkodlar>
                                            <cfif len(arguments.Barkod)><arr:string>#arguments.Barkod#</arr:string></cfif>
                                        </ns:Barkodlar>
                                        <cfif len(arguments.Desi)><ns:Desi>#arguments.Desi#</ns:Desi></cfif>
                                        <cfif len(arguments.Desi2)><ns:Desi2>#arguments.Desi2#</ns:Desi2></cfif>
                                        <cfif len(arguments.VDuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.VDuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                        <cfif len(arguments.VEkleyenKullanici)><ns:EkleyenKullanici>#arguments.VEkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                        <cfif len(arguments.EksiStokAdedi)><ns:EksiStokAdedi>#arguments.EksiStokAdedi#</ns:EksiStokAdedi></cfif>
                                        <ns:ID>#arguments.VaryasyonID#</ns:ID>
                                        <cfif len(arguments.IndirimliFiyati)><ns:IndirimliFiyati>#arguments.IndirimliFiyati#</ns:IndirimliFiyati></cfif>
                                        <cfif len(arguments.IndirimliFiyati1)><ns:IndirimliFiyati1>#arguments.IndirimliFiyati1#</ns:IndirimliFiyati1></cfif>
                                        <cfif len(arguments.IndirimliFiyati10)><ns:IndirimliFiyati10>#arguments.IndirimliFiyati10#</ns:IndirimliFiyati10></cfif>
                                        <cfif len(arguments.IndirimliFiyati11)><ns:IndirimliFiyati11>#arguments.IndirimliFiyati11#</ns:IndirimliFiyati11></cfif>
                                        <cfif len(arguments.IndirimliFiyati12)><ns:IndirimliFiyati12>#arguments.IndirimliFiyati12#</ns:IndirimliFiyati12></cfif>
                                        <cfif len(arguments.IndirimliFiyati13)><ns:IndirimliFiyati13>#arguments.IndirimliFiyati13#</ns:IndirimliFiyati13></cfif>
                                        <cfif len(arguments.IndirimliFiyati14)><ns:IndirimliFiyati14>#arguments.IndirimliFiyati14#</ns:IndirimliFiyati14></cfif>
                                        <cfif len(arguments.IndirimliFiyati15)><ns:IndirimliFiyati15>#arguments.IndirimliFiyati15#</ns:IndirimliFiyati15></cfif>
                                        <cfif len(arguments.IndirimliFiyati16)><ns:IndirimliFiyati16>#arguments.IndirimliFiyati16#</ns:IndirimliFiyati16></cfif>
                                        <cfif len(arguments.IndirimliFiyati17)><ns:IndirimliFiyati17>#arguments.IndirimliFiyati17#</ns:IndirimliFiyati17></cfif>
                                        <cfif len(arguments.IndirimliFiyati18)><ns:IndirimliFiyati18>#arguments.IndirimliFiyati18#</ns:IndirimliFiyati18></cfif>
                                        <cfif len(arguments.IndirimliFiyati19)><ns:IndirimliFiyati19>#arguments.IndirimliFiyati19#</ns:IndirimliFiyati19></cfif>
                                        <cfif len(arguments.IndirimliFiyati2)><ns:IndirimliFiyati2>#arguments.IndirimliFiyati2#</ns:IndirimliFiyati2></cfif>
                                        <cfif len(arguments.IndirimliFiyati20)><ns:IndirimliFiyati20>#arguments.IndirimliFiyati20#</ns:IndirimliFiyati20></cfif>
                                        <cfif len(arguments.IndirimliFiyati3)><ns:IndirimliFiyati3>#arguments.IndirimliFiyati3#</ns:IndirimliFiyati3></cfif>
                                        <cfif len(arguments.IndirimliFiyati4)><ns:IndirimliFiyati4>#arguments.IndirimliFiyati4#</ns:IndirimliFiyati4></cfif>
                                        <cfif len(arguments.IndirimliFiyati5)><ns:IndirimliFiyati5>#arguments.IndirimliFiyati5#</ns:IndirimliFiyati5></cfif>
                                        <cfif len(arguments.IndirimliFiyati6)><ns:IndirimliFiyati6>#arguments.IndirimliFiyati6#</ns:IndirimliFiyati6></cfif>
                                        <cfif len(arguments.IndirimliFiyati7)><ns:IndirimliFiyati7>#arguments.IndirimliFiyati7#</ns:IndirimliFiyati7></cfif>
                                        <cfif len(arguments.IndirimliFiyati8)><ns:IndirimliFiyati8>#arguments.IndirimliFiyati8#</ns:IndirimliFiyati8></cfif>
                                        <cfif len(arguments.IndirimliFiyati9)><ns:IndirimliFiyati9>#arguments.IndirimliFiyati9#</ns:IndirimliFiyati9></cfif>
                                        <cfif len(arguments.IscilikAgirlik)><ns:IscilikAgirlik>#arguments.IscilikAgirlik#</ns:IscilikAgirlik></cfif>
                                        <cfif len(arguments.IscilikParaBirimi)><ns:IscilikParaBirimi>#arguments.IscilikParaBirimi#</ns:IscilikParaBirimi></cfif>
                                        <cfif len(arguments.IscilikParaBirimiId)><ns:IscilikParaBirimiId>#arguments.IscilikParaBirimiId#</ns:IscilikParaBirimiId></cfif>
                                        <cfif len(arguments.IscilikParaBirimiKodu)><ns:IscilikParaBirimiKodu>#arguments.IscilikParaBirimiKodu#</ns:IscilikParaBirimiKodu></cfif>
                                        <cfif len(arguments.KargoUcreti)><ns:KargoUcreti>#arguments.KargoUcreti#</ns:KargoUcreti></cfif>
                                        <ns:Kategoriler>
                                            <arr:int>#arguments.Kategoriler#</arr:int>
                                        </ns:Kategoriler>
                                        <cfif len(arguments.KdvDahil)><ns:KdvDahil>#arguments.KdvDahil#</ns:KdvDahil></cfif>
                                        <cfif len(arguments.KdvDahil1)><ns:KdvDahil1>?#arguments.KdvDahil1#</ns:KdvDahil1></cfif>
                                        <cfif len(arguments.KdvDahil10)><ns:KdvDahil10>#arguments.KdvDahil10#</ns:KdvDahil10></cfif>
                                        <cfif len(arguments.KdvDahil11)><ns:KdvDahil11>#arguments.KdvDahil11#</ns:KdvDahil11></cfif>
                                        <cfif len(arguments.KdvDahil12)><ns:KdvDahil12>#arguments.KdvDahil12#</ns:KdvDahil12></cfif>
                                        <cfif len(arguments.KdvDahil13)><ns:KdvDahil13>#arguments.KdvDahil13#</ns:KdvDahil13></cfif>
                                        <cfif len(arguments.KdvDahil14)><ns:KdvDahil14>#arguments.KdvDahil14#</ns:KdvDahil14></cfif>
                                        <cfif len(arguments.KdvDahil15)><ns:KdvDahil15>#arguments.KdvDahil15#</ns:KdvDahil15></cfif>
                                        <cfif len(arguments.KdvDahil16)><ns:KdvDahil16>#arguments.KdvDahil16#</ns:KdvDahil16></cfif>
                                        <cfif len(arguments.KdvDahil17)><ns:KdvDahil17>#arguments.KdvDahil17#</ns:KdvDahil17></cfif>
                                        <cfif len(arguments.KdvDahil18)><ns:KdvDahil18>#arguments.KdvDahil18#</ns:KdvDahil18></cfif>
                                        <cfif len(arguments.KdvDahil19)><ns:KdvDahil19>#arguments.KdvDahil19#</ns:KdvDahil19></cfif>
                                        <cfif len(arguments.KdvDahil2)><ns:KdvDahil2>#arguments.KdvDahil2#</ns:KdvDahil2></cfif>
                                        <cfif len(arguments.KdvDahil20)><ns:KdvDahil20>#arguments.KdvDahil20#</ns:KdvDahil20></cfif>
                                        <cfif len(arguments.KdvDahil3)><ns:KdvDahil3>#arguments.KdvDahil3#</ns:KdvDahil3></cfif>
                                        <cfif len(arguments.KdvDahil4)><ns:KdvDahil4>#arguments.KdvDahil4#</ns:KdvDahil4></cfif>
                                        <cfif len(arguments.KdvDahil5)><ns:KdvDahil5>#arguments.KdvDahil5#</ns:KdvDahil5></cfif>
                                        <cfif len(arguments.KdvDahil6)><ns:KdvDahil6>#arguments.KdvDahil6#</ns:KdvDahil6></cfif>
                                        <cfif len(arguments.KdvDahil7)><ns:KdvDahil7>#arguments.KdvDahil7#</ns:KdvDahil7></cfif>
                                        <cfif len(arguments.KdvDahil8)><ns:KdvDahil8>#arguments.KdvDahil8#</ns:KdvDahil8></cfif>
                                        <cfif len(arguments.KdvDahil9)><ns:KdvDahil9>#arguments.KdvDahil9#</ns:KdvDahil9></cfif>
                                        <cfif len(arguments.KdvOrani)><ns:KdvOrani>#arguments.KdvOrani#</ns:KdvOrani></cfif>
                                        <cfif len(arguments.KdvOrani1)><ns:KdvOrani1>#arguments.KdvOrani1#</ns:KdvOrani1></cfif>
                                        <cfif len(arguments.KdvOrani10)><ns:KdvOrani10>#arguments.KdvOrani10#</ns:KdvOrani10></cfif>
                                        <cfif len(arguments.KdvOrani11)><ns:KdvOrani11>#arguments.KdvOrani11#</ns:KdvOrani11></cfif>
                                        <cfif len(arguments.KdvOrani12)><ns:KdvOrani12>#arguments.KdvOrani12#</ns:KdvOrani12></cfif>
                                        <cfif len(arguments.KdvOrani13)><ns:KdvOrani13>#arguments.KdvOrani13#</ns:KdvOrani13></cfif>
                                        <cfif len(arguments.KdvOrani14)><ns:KdvOrani14>#arguments.KdvOrani14#</ns:KdvOrani14></cfif>
                                        <cfif len(arguments.KdvOrani15)><ns:KdvOrani15>#arguments.KdvOrani15#</ns:KdvOrani15></cfif>
                                        <cfif len(arguments.KdvOrani16)><ns:KdvOrani16>#arguments.KdvOrani16#</ns:KdvOrani16></cfif>
                                        <cfif len(arguments.KdvOrani17)><ns:KdvOrani17>#arguments.KdvOrani17#</ns:KdvOrani17></cfif>
                                        <cfif len(arguments.KdvOrani18)><ns:KdvOrani18>#arguments.KdvOrani18#</ns:KdvOrani18></cfif>
                                        <cfif len(arguments.KdvOrani19)><ns:KdvOrani19>#arguments.KdvOrani19#</ns:KdvOrani19></cfif>
                                        <cfif len(arguments.KdvOrani2)><ns:KdvOrani2>#arguments.KdvOrani2#</ns:KdvOrani2></cfif>
                                        <cfif len(arguments.KdvOrani20)><ns:KdvOrani20>#arguments.KdvOrani20#</ns:KdvOrani20></cfif>
                                        <cfif len(arguments.KdvOrani3)><ns:KdvOrani3>#arguments.KdvOrani3#</ns:KdvOrani3></cfif>
                                        <cfif len(arguments.KdvOrani4)><ns:KdvOrani4>#arguments.KdvOrani4#</ns:KdvOrani4></cfif>
                                        <cfif len(arguments.KdvOrani5)><ns:KdvOrani5>#arguments.KdvOrani5#</ns:KdvOrani5></cfif>
                                        <cfif len(arguments.KdvOrani6)><ns:KdvOrani6>#arguments.KdvOrani6#</ns:KdvOrani6></cfif>
                                        <cfif len(arguments.KdvOrani7)><ns:KdvOrani7>#arguments.KdvOrani7#</ns:KdvOrani7></cfif>
                                        <cfif len(arguments.KdvOrani8)><ns:KdvOrani8>#arguments.KdvOrani8#</ns:KdvOrani8></cfif>
                                        <cfif len(arguments.KdvOrani9)><ns:KdvOrani9>#arguments.KdvOrani9#</ns:KdvOrani9></cfif>
                                        <cfif len(arguments.VMarkaID)><ns:MarkaID>#arguments.VMarkaID#</ns:MarkaID></cfif>
                                        <!-----buralardaki marketplaceaktif kısımları varyasyon için geçerli bunlar varyasyon olarak tanımlanmalı mı yoksa bu şekilde devam mı?---->
                                        <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                        <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                        <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                        <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                        <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                        <ns:Ozellikler>
                                            <ns:VaryasyonOzellik>
                                            <ns:Deger>#arguments.Deger#</ns:Deger>
                                            <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                            <cfif len(arguments.Tur)><ns:Tur>#arguments.Tur#</ns:Tur></cfif>
                                            <cfif len(arguments.XmlKod)><ns:XmlKod>#arguments.XmlKod#</ns:XmlKod></cfif>
                                            </ns:VaryasyonOzellik>
                                        </ns:Ozellikler>
                                        <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                        <cfif len(arguments.ParaBirimi10Id)><ns:ParaBirimi10Id>#arguments.ParaBirimi10Id#</ns:ParaBirimi10Id></cfif>                    
                                        <cfif len(arguments.ParaBirimi11Id)><ns:ParaBirimi11Id>#arguments.ParaBirimi11Id#</ns:ParaBirimi11Id></cfif>
                                        <cfif len(arguments.ParaBirimi12Id)><ns:ParaBirimi12Id>#arguments.ParaBirimi12Id#</ns:ParaBirimi12Id></cfif>
                                        <cfif len(arguments.ParaBirimi13Id)><ns:ParaBirimi13Id>#arguments.ParaBirimi13Id#</ns:ParaBirimi13Id></cfif>
                                        <cfif len(arguments.ParaBirimi14Id)><ns:ParaBirimi14Id>#arguments.ParaBirimi14Id#</ns:ParaBirimi14Id></cfif>
                                        <cfif len(arguments.ParaBirimi15Id)><ns:ParaBirimi15Id>#arguments.ParaBirimi15Id#</ns:ParaBirimi15Id></cfif>
                                        <cfif len(arguments.ParaBirimi16Id)><ns:ParaBirimi16Id>#arguments.ParaBirimi16Id#</ns:ParaBirimi16Id></cfif>
                                        <cfif len(arguments.ParaBirimi17Id)><ns:ParaBirimi17Id>#arguments.ParaBirimi17Id#</ns:ParaBirimi17Id></cfif>
                                        <cfif len(arguments.ParaBirimi18Id)><ns:ParaBirimi18Id>#arguments.ParaBirimi18Id#</ns:ParaBirimi18Id></cfif>
                                        <cfif len(arguments.ParaBirimi19Id)><ns:ParaBirimi19Id>#arguments.ParaBirimi19Id#</ns:ParaBirimi19Id></cfif>
                                        <cfif len(arguments.ParaBirimi1Id)><ns:ParaBirimi1Id>#arguments.ParaBirimi1Id#</ns:ParaBirimi1Id></cfif>
                                        <cfif len(arguments.ParaBirimi20Id)><ns:ParaBirimi20Id>#arguments.ParaBirimi20Id#</ns:ParaBirimi20Id></cfif>
                                        <cfif len(arguments.ParaBirimi2Id)><ns:ParaBirimi2Id>#arguments.ParaBirimi2Id#</ns:ParaBirimi2Id></cfif>
                                        <cfif len(arguments.ParaBirimi3Id)><ns:ParaBirimi3Id>#arguments.ParaBirimi3Id#</ns:ParaBirimi3Id></cfif>
                                        <cfif len(arguments.ParaBirimi4Id)><ns:ParaBirimi4Id>#arguments.ParaBirimi4Id#</ns:ParaBirimi4Id></cfif>
                                        <cfif len(arguments.ParaBirimi5Id)><ns:ParaBirimi5Id>#arguments.ParaBirimi5Id#</ns:ParaBirimi5Id></cfif>
                                        <cfif len(arguments.ParaBirimi6Id)><ns:ParaBirimi6Id>#arguments.ParaBirimi6Id#</ns:ParaBirimi6Id></cfif>
                                        <cfif len(arguments.ParaBirimi7Id)><ns:ParaBirimi7Id>#arguments.ParaBirimi7Id#</ns:ParaBirimi7Id></cfif>
                                        <cfif len(arguments.ParaBirimi8Id)><ns:ParaBirimi8Id>#arguments.ParaBirimi8Id#</ns:ParaBirimi8Id></cfif>
                                        <cfif len(arguments.ParaBirimi9Id)><ns:ParaBirimi9Id>#arguments.ParaBirimi9Id#</ns:ParaBirimi9Id></cfif>
                                        <ns:ParaBirimiID>#arguments.ParaBirimiID#</ns:ParaBirimiID>
                                        <cfif len(arguments.ParaBirimiKodu)><ns:ParaBirimiKodu>#arguments.ParaBirimiKodu#</ns:ParaBirimiKodu></cfif>                    
                                        <ns:Resimler>
                                            <cfif len(arguments.VaryasyonResimler)><arr:string>#arguments.VaryasyonResimler#</arr:string></cfif>
                                        </ns:Resimler>
                                        <ns:SatisFiyati>#arguments.VaryasyonSatisFiyati#</ns:SatisFiyati>
                                        <cfif len(arguments.SatisFiyati1)><ns:SatisFiyati1>#arguments.SatisFiyati1#</ns:SatisFiyati1></cfif>
                                        <cfif len(arguments.SatisFiyati10)><ns:SatisFiyati10>#arguments.SatisFiyati10#</ns:SatisFiyati10></cfif>
                                        <cfif len(arguments.SatisFiyati11)><ns:SatisFiyati11>#arguments.SatisFiyati11#</ns:SatisFiyati11></cfif>
                                        <cfif len(arguments.SatisFiyati12)><ns:SatisFiyati12>#arguments.SatisFiyati12#</ns:SatisFiyati12></cfif>
                                        <cfif len(arguments.SatisFiyati13)><ns:SatisFiyati13>#arguments.SatisFiyati13#</ns:SatisFiyati13></cfif>
                                        <cfif len(arguments.SatisFiyati14)><ns:SatisFiyati14>#arguments.SatisFiyati14#</ns:SatisFiyati14></cfif>
                                        <cfif len(arguments.SatisFiyati15)><ns:SatisFiyati15>#arguments.SatisFiyati15#</ns:SatisFiyati15></cfif>
                                        <cfif len(arguments.SatisFiyati16)><ns:SatisFiyati16>#arguments.SatisFiyati16#</ns:SatisFiyati16></cfif>
                                        <cfif len(arguments.SatisFiyati17)><ns:SatisFiyati17>#arguments.SatisFiyati17#</ns:SatisFiyati17></cfif>
                                        <cfif len(arguments.SatisFiyati18)><ns:SatisFiyati18>#arguments.SatisFiyati18#</ns:SatisFiyati18></cfif>
                                        <cfif len(arguments.SatisFiyati19)><ns:SatisFiyati19>#arguments.SatisFiyati19#</ns:SatisFiyati19></cfif>
                                        <cfif len(arguments.SatisFiyati2)><ns:SatisFiyati2>#arguments.SatisFiyati2#</ns:SatisFiyati2></cfif>
                                        <cfif len(arguments.SatisFiyati20)><ns:SatisFiyati20>#arguments.SatisFiyati20#</ns:SatisFiyati20></cfif>
                                        <cfif len(arguments.SatisFiyati3)><ns:SatisFiyati3>#arguments.SatisFiyati3#</ns:SatisFiyati3></cfif>
                                        <cfif len(arguments.SatisFiyati4)><ns:SatisFiyati4>#arguments.SatisFiyati4#</ns:SatisFiyati4></cfif>
                                        <cfif len(arguments.SatisFiyati5)><ns:SatisFiyati5>#arguments.SatisFiyati5#</ns:SatisFiyati5></cfif>
                                        <cfif len(arguments.SatisFiyati6)><ns:SatisFiyati6>#arguments.SatisFiyati6#</ns:SatisFiyati6></cfif>
                                        <cfif len(arguments.SatisFiyati7)><ns:SatisFiyati7>#arguments.SatisFiyati7#</ns:SatisFiyati7></cfif>
                                        <cfif len(arguments.SatisFiyati8)<ns:SatisFiyati8>#arguments.SatisFiyati8#</ns:SatisFiyati8></cfif>
                                        <cfif len(arguments.SatisFiyati9)><ns:SatisFiyati9>#arguments.SatisFiyati9#</ns:SatisFiyati9></cfif>
                                        <cfif len(arguments.StokAdedi)><ns:StokAdedi>#arguments.StokAdedi#</ns:StokAdedi></cfif>
                                        <cfif len(arguments.StokGuncellemeTarihi)><ns:StokGuncellemeTarihi>#arguments.StokGuncellemeTarihi#</ns:StokGuncellemeTarihi></cfif>
                                        <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                        <!-----tahmini teslim süresi yukarıda ürün için tanımlanmış varyasyon için tanımlayıp onu mu almam gerekiyor yoksa aynı argumentden devam mı şu an yaptığım aynısı ------>
                                        <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                        <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                        <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                        <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                        <cfif len(arguments.VTedarikciKodu)><ns:TedarikciKodu>#arguments.VTedarikciKodu#</ns:TedarikciKodu></cfif>
                                        <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                        <cfif len(arguments.UpdateKey)><ns:UpdateKey>#arguments.UpdateKey#</ns:UpdateKey></cfif>
                                        <cfif len(arguemnts.UrunAgirligi)><ns:UrunAgirligi>#arguments.UrunAgirligi#</ns:UrunAgirligi></cfif>
                                        <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                        <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                        <cfif len(arguments.UyeTipiFiyat1)><ns:UyeTipiFiyat1>#arguments.UyeTipiFiyat1#</ns:UyeTipiFiyat1></cfif>
                                        <cfif len(arguments.UyeTipiFiyat10)><ns:UyeTipiFiyat10>#arguments.UyeTipiFiyat10#</ns:UyeTipiFiyat10></cfif>
                                        <cfif len(arguments.UyeTipiFiyat11)><ns:UyeTipiFiyat11>#arguments.UyeTipiFiyat11#</ns:UyeTipiFiyat11></cfif>
                                        <cfif len(arguments.UyeTipiFiyat12)><ns:UyeTipiFiyat12>#arguments.UyeTipiFiyat12#</ns:UyeTipiFiyat12></cfif>
                                        <cfif len(arguments.UyeTipiFiyat13)><ns:UyeTipiFiyat13>#arguments.UyeTipiFiyat13#</ns:UyeTipiFiyat13></cfif>
                                        <cfif len(arguments.UyeTipiFiyat14)><ns:UyeTipiFiyat14>#arguments.UyeTipiFiyat14#</ns:UyeTipiFiyat14></cfif>
                                        <cfif len(arguments.UyeTipiFiyat15)><ns:UyeTipiFiyat15>#arguments.UyeTipiFiyat15#</ns:UyeTipiFiyat15></cfif>
                                        <cfif len(arguments.UyeTipiFiyat16)><ns:UyeTipiFiyat16>#arguments.UyeTipiFiyat16#</ns:UyeTipiFiyat16></cfif>
                                        <cfif len(arguments.UyeTipiFiyat17)><ns:UyeTipiFiyat17>#arguments.UyeTipiFiyat17#</ns:UyeTipiFiyat17></cfif>
                                        <cfif len(arguments.UyeTipiFiyat18)><ns:UyeTipiFiyat18>#arguments.UyeTipiFiyat18#</ns:UyeTipiFiyat18></cfif>
                                        <cfif len(arguments.UyeTipiFiyat19)><ns:UyeTipiFiyat19>#arguments.UyeTipiFiyat19#</ns:UyeTipiFiyat19></cfif>
                                        <cfif len(arguments.UyeTipiFiyat2)><ns:UyeTipiFiyat2>#arguments.UyeTipiFiyat2#</ns:UyeTipiFiyat2></cfif>
                                        <cfif len(arguments.UyeTipiFiyat20)><ns:UyeTipiFiyat20>#arguments.UyeTipiFiyat20#</ns:UyeTipiFiyat20></cfif>
                                        <cfif len(arguments.UyeTipiFiyat3)><ns:UyeTipiFiyat3>#arguments.UyeTipiFiyat3#</ns:UyeTipiFiyat3></cfif>
                                        <cfif len(arguments.UyeTipiFiyat4)><ns:UyeTipiFiyat4>#arguments.UyeTipiFiyat4#</ns:UyeTipiFiyat4></cfif>
                                        <cfif len(arguments.UyeTipiFiyat5)><ns:UyeTipiFiyat5>#arguments.UyeTipiFiyat5#</ns:UyeTipiFiyat5></cfif>
                                        <cfif len(arguments.UyeTipiFiyat6)><ns:UyeTipiFiyat6>#arguments.UyeTipiFiyat6#</ns:UyeTipiFiyat6></cfif>
                                        <cfif len(arguments.UyeTipiFiyat7)><ns:UyeTipiFiyat7>#arguments.UyeTipiFiyat7#</ns:UyeTipiFiyat7></cfif>
                                        <cfif len(arguments.UyeTipiFiyat8)><ns:UyeTipiFiyat8>#arguments.UyeTipiFiyat8#</ns:UyeTipiFiyat8></cfif>
                                        <cfif len(arguments.UyeTipiFiyat9)><ns:UyeTipiFiyat9>#arguments.UyeTipiFiyat9#</ns:UyeTipiFiyat9></cfif>
                                    </ns:Varyasyon>
                                </ns:Varyasyonlar>
                                <cfif len(arguments.Vitrin)><ns:Vitrin>#arguments.Vitrin#</ns:Vitrin></cfif>
                                <cfif len(arguments.YayinTarihi)><ns:YayinTarihi>#arguments.YayinTarihi#</ns:YayinTarihi></cfif>
                                <cfif len(arguments.YeniUrun)><ns:YeniUrun>#arguments.YeniUrun#</ns:YeniUrun></cfif>
                                <cfif len(arguments.YonlendirmeAdresi)><ns:YonlendirmeAdresi>#arguments.YonlendirmeAdresi#</ns:YonlendirmeAdresi></cfif>
                                </ns:UrunKarti>
                            </tem:urunKartlari>
                            <tem:ukAyar>
                                <cfif len(arguments.AciklamaGuncelle)><ns:AciklamaGuncelle>#arguments.AciklamaGuncelle#</ns:AciklamaGuncelle></cfif>
                                <cfif len(arguments.AdwordsAciklamaGuncelle)><ns:AdwordsAciklamaGuncelle>#arguments.AdwordsAciklamaGuncelle#</ns:AdwordsAciklamaGuncelle></cfif>
                                <cfif len(arguments.AdwordsKategoriGuncelle)><ns:AdwordsKategoriGuncelle>#arguments.AdwordsKategoriGuncelle#</ns:AdwordsKategoriGuncelle></cfif>
                                <cfif len(arguments.AdwordsTipGuncelle)><ns:AdwordsTipGuncelle>#arguments.AdwordsTipGuncelle#</ns:AdwordsTipGuncelle></cfif>
                                <cfif len(arguments.AktifGuncelle)><ns:AktifGuncelle>#arguments.AktifGuncelle#</ns:AktifGuncelle></cfif>
                                <cfif len(arguments.AlanAdi)><ns:AlanAdi>#arguments.AlanAdi#</ns:AlanAdi></cfif>
                                <ns:AnaKategoriId>#arguments.AnaKategoriId#</ns:AnaKategoriId>
                                <cfif len(arguments.AramaAnahtarKelimeGuncelle)><ns:AramaAnahtarKelimeGuncelle>#arguments.AramaAnahtarKelimeGuncelle#</ns:AramaAnahtarKelimeGuncelle></cfif>
                                <cfif len(arguments.AsortiGrupGuncelle)><ns:AsortiGrupGuncelle>#arguments.AsortiGrupGuncelle#</ns:AsortiGrupGuncelle></cfif>
                                <cfif len(arguments.Base64Resim)><ns:Base64Resim>#arguments.Base64Resim#</ns:Base64Resim></cfif>
                                <cfif len(arguments.DegerTanim)><ns:DegerTanim>#argumets.DegerTanim#</ns:DegerTanim></cfif>
                                <cfif len(arguments.EntegrasyonKodu)><ns:EntegrasyonKodu>#arguments.EntegrasyonKodu#</ns:EntegrasyonKodu></cfif>
                                <cfif len(arguments.EtiketGuncelle)><ns:EtiketGuncelle>#arguments.EtiketGuncelle#</ns:EtiketGuncelle></cfif>
                                <cfif len(arguments.FBStoreGosterGuncelle)><ns:FBStoreGosterGuncelle>#arguments.FBStoreGosterGuncelle#</ns:FBStoreGosterGuncelle></cfif>
                                <cfif len(arguments.FirsatUrunuGuncelle)><ns:FirsatUrunuGuncelle>#arguments.FirsatUrunuGuncelle#</ns:FirsatUrunuGuncelle></cfif>
                                <cfif len(arguments.HediyeIpucuGosterGuncelle)><ns:HediyeIpucuGosterGuncelle>#arguemnts.HediyeIpucuGosterGuncelle#</ns:HediyeIpucuGosterGuncelle></cfif>
                                <cfif len(arguments.IlgiliUrunResimGuncelle)><ns:IlgiliUrunResimGuncelle>#arguemnts.IlgiliUrunResimGuncelle#</ns:IlgiliUrunResimGuncelle></cfif>
                                <cfif len(arguments.KargoTipiGuncelle)><ns:KargoTipiGuncelle>#arguments.KargoTipiGuncelle#</ns:KargoTipiGuncelle></cfif>
                                <cfif len(arguments.KategoriGuncelle)><ns:KategoriGuncelle>#arguments.KategoriGuncelle#</ns:KategoriGuncelle></cfif>
                                <cfif len(arguments.ListedeGosterGuncelle)><ns:ListedeGosterGuncelle>#arguments.ListedeGosterGuncelle#</ns:ListedeGosterGuncelle></cfif>
                                <cfif len(arguments.MaksTaksitSayisiGuncelle)><ns:MaksTaksitSayisiGuncelle>#arguments.MaksTaksitSayisiGuncelle#</ns:MaksTaksitSayisiGuncelle></cfif>
                                <cfif len(arguments.MarkaGuncelle)><ns:MarkaGuncelle>#arguments.MarkaGuncelle#</ns:MarkaGuncelle></cfif>
                                <cfif len(arguments.MarketPlaceAktif2Guncelle)><ns:MarketPlaceAktif2Guncelle>#arguments.MarketPlaceAktif2Guncelle#</ns:MarketPlaceAktif2Guncelle></cfif>
                                <cfif len(arguments.MarketPlaceAktif3Guncelle)><ns:MarketPlaceAktif3Guncelle>#arguments.MarketPlaceAktif3Guncelle#</ns:MarketPlaceAktif3Guncelle></cfif>
                                <cfif len(arguments.MarketPlaceAktif4Guncelle)><ns:MarketPlaceAktif4Guncelle>#arguments.MarketPlaceAktif4Guncelle#</ns:MarketPlaceAktif4Guncelle></cfif>
                                <cfif len(arguemnts.MarketPlaceAktif5Guncelle)><ns:MarketPlaceAktif5Guncelle>#arguments.MarketPlaceAktif5Guncelle#</ns:MarketPlaceAktif5Guncelle></cfif>
                                <cfif len(arguments.MarketPlaceAktifGuncelle)><ns:MarketPlaceAktifGuncelle>#arguments.MarketPlaceAktifGuncelle#</ns:MarketPlaceAktifGuncelle></cfif>
                                <cfif len(arguments.MenseiUlkeGuncelle)><ns:MenseiUlkeGuncelle>#arguments.MenseiUlkeGuncelle#</ns:MenseiUlkeGuncelle></cfif>
                                <cfif len(arguments.OnYaziGuncelle)><ns:OnYaziGuncelle>#arguments.OnYaziGuncelle#</ns:OnYaziGuncelle></cfif>
                                <cfif len(arguments.OncekiKategoriEslestirmeleriniTemizle)><ns:OncekiKategoriEslestirmeleriniTemizle>#arguments.OncekiKategoriEslestirmeleriniTemizle#</ns:OncekiKategoriEslestirmeleriniTemizle></cfif>
                                <cfif len(arguments.OncekiResimleriSil)><ns:OncekiResimleriSil>#arguments.OncekiResimleriSil#</ns:OncekiResimleriSil></cfif>
                                <cfif len(arguments.OzelAlan1Guncelle)><ns:OzelAlan1Guncelle>#arguments.OzelAlan1Guncelle#</ns:OzelAlan1Guncelle></cfif>
                                <cfif len(arguments.OzelAlan2Guncelle)><ns:OzelAlan2Guncelle>#arguments.OzelAlan2Guncelle#</ns:OzelAlan2Guncelle></cfif>
                                <cfif len(arguments.OzelAlan3Guncelle)><ns:OzelAlan3Guncelle>#arguments.OzelAlan3Guncelle#</ns:OzelAlan3Guncelle></cfif>
                                <cfif len(arguments.OzelAlan4Guncelle)><ns:OzelAlan4Guncelle>#arguments.OzelAlan4Guncelle#</ns:OzelAlan4Guncelle></cfif>
                                <cfif len(arguments.OzelAlan5Guncelle)><ns:OzelAlan5Guncelle>#arguments.OzelAlan5Guncelle#</ns:OzelAlan5Guncelle></cfif>
                                <cfif len(arguments.ParaPuanGuncelle)><ns:ParaPuanGuncelle>#arguments.ParaPuanGuncelle#</ns:ParaPuanGuncelle></cfif>
                                <cfif len(arguments.ResimOlmayanlaraResimEkle)><ns:ResimOlmayanlaraResimEkle>#arguments.ResimOlmayanlaraResimEkle#</ns:ResimOlmayanlaraResimEkle></cfif>
                                <cfif len(arguments.ResimleriIndirme)><ns:ResimleriIndirme>#arguments.ResimleriIndirme#</ns:ResimleriIndirme></cfif>
                                <cfif len(arguments.SatisBirimiGuncelle)><ns:SatisBirimiGuncelle>#arguments.SatisBirimiGuncelle#</ns:SatisBirimiGuncelle></cfif>
                                <cfif len(arguments.SeoAnahtarKelimeGuncelle)><ns:SeoAnahtarKelimeGuncelle>#arguments.SeoAnahtarKelimeGuncelle#</ns:SeoAnahtarKelimeGuncelle></cfif>
                                <cfif len(arguments.SeoNoFollowGuncelle)><ns:SeoNoFollowGuncelle>#arguments.SeoNoFollowGuncelle#</ns:SeoNoFollowGuncelle></cfif>
                                <cfif len(arguments.SeoNoIndexGuncelle)><ns:SeoNoIndexGuncelle>#arguments.SeoNoIndexGuncelle#</ns:SeoNoIndexGuncelle></cfif>
                                <cfif len(arguments.SeoSayfaAciklamaGuncelle)><ns:SeoSayfaAciklamaGuncelle>#arguments.SeoSayfaAciklamaGuncelle#</ns:SeoSayfaAciklamaGuncelle></cfif>
                                <cfif len(arguments.SeoSayfaBaslikGuncelle)><ns:SeoSayfaBaslikGuncelle>#arguments.SeoSayfaBaslikGuncelle#</ns:SeoSayfaBaslikGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGosterGuncelle)><ns:TahminiTeslimSuresiGosterGuncelle>#arguments.TahminiTeslimSuresiGosterGuncelle#</ns:TahminiTeslimSuresiGosterGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGuncelle)><ns:TahminiTeslimSuresiGuncelle>#arguments.TahminiTeslimSuresiGuncelle#</ns:TahminiTeslimSuresiGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarihGuncelle)><ns:TahminiTeslimSuresiTarihGuncelle>#arguments.TahminiTeslimSuresiTarihGuncelle#</ns:TahminiTeslimSuresiTarihGuncelle></cfif>
                                <cfif len(arguments.TedarikciGuncelle)><ns:TedarikciGuncelle>#arguments.TedarikciGuncelle#</ns:TedarikciGuncelle></cfif>
                                <cfif len(arguments.TedarikciKodu2GoreGuncelle)><ns:TedarikciKodu2GoreGuncelle>#arguments.TedarikciKodu2GoreGuncelle#</ns:TedarikciKodu2GoreGuncelle></cfif>
                                <cfif len(arguments.TedarikciKodunaGoreGuncelle)><ns:TedarikciKodunaGoreGuncelle>#arguments.TedarikciKodunaGoreGuncelle#</ns:TedarikciKodunaGoreGuncelle></cfif>
                                <cfif len(arguments.TeknikDetayGuncelle)><ns:TeknikDetayGuncelle>#arguments.TeknikDetayGuncelle#</ns:TeknikDetayGuncelle></cfif>
                                <cfif len(arguments.UcretsizKargoGuncelle)><ns:UcretsizKargoGuncelle>#arguments.UcretsizKargoGuncelle#</ns:UcretsizKargoGuncelle></cfif>
                                <cfif len(arguments.UrunAdediKademeDegerGuncelle)><ns:UrunAdediKademeDegerGuncelle>#arguments.UrunAdediKademeDegerGuncelle#</ns:UrunAdediKademeDegerGuncelle></cfif>
                                <cfif len(arguments.UrunAdediMinimumDegerGuncelle)><ns:UrunAdediMinimumDegerGuncelle>#arguments.UrunAdediMinimumDegerGuncelle#</ns:UrunAdediMinimumDegerGuncelle></cfif>
                                <cfif len(arguments.UrunAdediOndalikliSayiGirilebilirGuncelle)><ns:UrunAdediOndalikliSayiGirilebilirGuncelle>#arguments.UrunAdediOndalikliSayiGirilebilirGuncelle#</ns:UrunAdediOndalikliSayiGirilebilirGuncelle></cfif>
                                <cfif len(arguments.UrunAdediVarsayilanDegerGuncelle)><ns:UrunAdediVarsayilanDegerGuncelle>#arguments.UrunAdediVarsayilanDegerGuncelle#</ns:UrunAdediVarsayilanDegerGuncelle></cfif>
                                <cfif len(arguments.UrunAdiGuncelle)><ns:UrunAdiGuncelle>#arguments.UrunAdiGuncelle#</ns:UrunAdiGuncelle></cfif>
                                <cfif len(arguments.UrunAdresiniElleOlustur)><ns:UrunAdresiniElleOlustur>#arguments.UrunAdresiniElleOlustur#</ns:UrunAdresiniElleOlustur></cfif>
                                <cfif len(arguments.UrunKapidaOdemeYasakliGuncelle)><ns:UrunKapidaOdemeYasakliGuncelle>#arguments.UrunKapidaOdemeYasakliGuncelle#</ns:UrunKapidaOdemeYasakliGuncelle></cfif>
                                <cfif len(arguments.UrunResimGuncelle)><ns:UrunResimGuncelle>#arguments.UrunResimGuncelle#</ns:UrunResimGuncelle></cfif>
                                <cfif len(arguemnts.UserAgent)><ns:UserAgent>#arguments.UserAgent#</ns:UserAgent></cfif>
                                <cfif len(arguments.UyeAlimMaksGuncelle)><ns:UyeAlimMaksGuncelle>#arguments.UyeAlimMaksGuncelle#</ns:UyeAlimMaksGuncelle></cfif>
                                <cfif len(arguments.UyeAlimMinGuncelle)><ns:UyeAlimMinGuncelle>#arguments.UyeAlimMinGuncelle#</ns:UyeAlimMinGuncelle></cfif>
                                <cfif len(arguments.VitrinGuncelle)><ns:VitrinGuncelle>#arguments.VitrinGuncelle#</ns:VitrinGuncelle></cfif>
                                <cfif len(arguments.YayinTarihiGuncelle)><ns:YayinTarihiGuncelle>#arguments.YayinTarihiGuncelle#</ns:YayinTarihiGuncelle></cfif>
                                <cfif len(arguemnts.YeniUrunGuncelle)><ns:YeniUrunGuncelle>#arguments.YeniUrunGuncelle#</ns:YeniUrunGuncelle></cfif>
                            </tem:ukAyar>
                            <tem:vAyar>
                                <cfif len(arguments.AktifGuncelle2)><ns:AktifGuncelle>#arguments.AktifGuncelle2#</ns:AktifGuncelle></cfif>
                                <cfif len(arguments.AlisFiyatiGuncelle)><ns:AlisFiyatiGuncelle>#arguments.AlisFiyatiGuncelle#</ns:AlisFiyatiGuncelle></cfif>
                                <cfif len(arguments.BarkodGuncelle)><ns:BarkodGuncelle>#arguments.BarkodGuncelle#</ns:BarkodGuncelle></cfif>
                                <cfif len(arguments.EkSecenekGuncelle)><ns:EkSecenekGuncelle>#arguments.EkSecenekGuncelle#</ns:EkSecenekGuncelle></cfif>
                                <cfif len(arguemnts.EksiStokAdediGuncelle)><ns:EksiStokAdediGuncelle>#arguments.EksiStokAdediGuncelle#</ns:EksiStokAdediGuncelle></cfif>
                                <cfif len(arguments.FiyatTipleriGuncelle)><ns:FiyatTipleriGuncelle>#arguments.FiyatTipleriGuncelle#</ns:FiyatTipleriGuncelle></cfif>
                                <cfif len(arguments.IndirimliFiyatiGuncelle)><ns:IndirimliFiyatiGuncelle>#arguments.IndirimliFiyatiGuncelle#</ns:IndirimliFiyatiGuncelle></cfif>
                                <cfif len(arguments.IscilikAgirlikGuncelle)><ns:IscilikAgirlikGuncelle>#arguments.IscilikAgirlikGuncelle#</ns:IscilikAgirlikGuncelle></cfif>
                                <cfif len(arguments.IscilikParaBirimiGuncelle)><ns:IscilikParaBirimiGuncelle>#arguments.IscilikParaBirimiGuncelle#</ns:IscilikParaBirimiGuncelle></cfif>
                                <cfif len(arguments.KargoAgirligiGuncelle)><ns:KargoAgirligiGuncelle>#arguments.KargoAgirligiGuncelle#</ns:KargoAgirligiGuncelle></cfif>
                                <cfif len(arguments.KargoAgirligiYurtDisiGuncelle)><ns:KargoAgirligiYurtDisiGuncelle>#arguments.KargoAgirligiYurtDisiGuncelle#</ns:KargoAgirligiYurtDisiGuncelle></cfif>
                                <cfif len(arguments.KargoUcretiGuncelle)><ns:KargoUcretiGuncelle>#arguments.KargoUcretiGuncelle#</ns:KargoUcretiGuncelle></cfif>
                                <cfif len(arguments.KdvDahilGuncelle)><ns:KdvDahilGuncelle>#arguments.KdvDahilGuncelle#</ns:KdvDahilGuncelle></cfif>
                                <cfif len(arguments.KdvOraniGuncelle)><ns:KdvOraniGuncelle>#arguments.KdvOraniGuncelle#</ns:KdvOraniGuncelle></cfif>
                                <cfif len(arguments.KonsinyeUrunStokAdediGuncelle)><ns:KonsinyeUrunStokAdediGuncelle>#arguments.KonsinyeUrunStokAdediGuncelle#</ns:KonsinyeUrunStokAdediGuncelle></cfif>
                                <cfif len(arguments.OncekiResimleriSil2)><ns:OncekiResimleriSil>#arguments.OncekiResimleriSil2#</ns:OncekiResimleriSil></cfif>
                                <cfif len(arguments.ParaBirimiGuncelle)><ns:ParaBirimiGuncelle>#arguments.ParaBirimiGuncelle#</ns:ParaBirimiGuncelle></cfif>
                                <cfif len(arguments.ResimOlmayanlaraResimEkle)><ns:ResimOlmayanlaraResimEkle>#arguments.ResimOlmayanlaraResimEkle#</ns:ResimOlmayanlaraResimEkle></cfif>
                                <cfif len(arguments.SatisFiyatiGuncelle)><ns:SatisFiyatiGuncelle>#arguments.SatisFiyatiGuncelle#</ns:SatisFiyatiGuncelle></cfif>
                                <cfif len(arguments.StokAdediGuncelle)><ns:StokAdediGuncelle>#arguments.StokAdediGuncelle#</ns:StokAdediGuncelle></cfif>
                                <cfif len(arguments.StokKoduGuncelle)><ns:StokKoduGuncelle>#arguments.StokKoduGuncelle#</ns:StokKoduGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGunGuncelle)><ns:TahminiTeslimSuresiAyniGunGuncelle>#arguments.TahminiTeslimSuresiAyniGunGuncelle#</ns:TahminiTeslimSuresiAyniGunGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGosterGuncelle)><ns:TahminiTeslimSuresiGosterGuncelle>#arguments.TahminiTeslimSuresiGosterGuncelle#</ns:TahminiTeslimSuresiGosterGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGuncelle)><ns:TahminiTeslimSuresiGuncelle>#arguments.TahminiTeslimSuresiGuncelle#</ns:TahminiTeslimSuresiGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarihGuncelle)><ns:TahminiTeslimSuresiTarihGuncelle>#arguments.TahminiTeslimSuresiTarihGuncelle#</ns:TahminiTeslimSuresiTarihGuncelle></cfif>
                                <cfif len(arguments.TedarikciKodunaGoreGuncelle)><ns:TedarikciKodunaGoreGuncelle>#arguments.TedarikciKodunaGoreGuncelle#</ns:TedarikciKodunaGoreGuncelle></cfif>
                                <cfif len(arguments.UpdateKeyGuncelle)><ns:UpdateKeyGuncelle>#arguments.UpdateKeyGuncelle#</ns:UpdateKeyGuncelle></cfif>
                                <cfif len(arguments.UrunAgirligiGuncelle)><ns:UrunAgirligiGuncelle>#arguments.UrunAgirligiGuncelle#</ns:UrunAgirligiGuncelle></cfif>
                                <cfif len(arguments.UrunResimGuncelle2)><ns:UrunResimGuncelle>#arguments.UrunResimGuncelle2#</ns:UrunResimGuncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat10Guncelle)><ns:UyeTipiFiyat10Guncelle>#arguments.UyeTipiFiyat10Guncelle#</ns:UyeTipiFiyat10Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat11Guncelle)><ns:UyeTipiFiyat11Guncelle>#arguments.UyeTipiFiyat11Guncelle#</ns:UyeTipiFiyat11Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat12Guncelle)><ns:UyeTipiFiyat12Guncelle>#arguments.UyeTipiFiyat12Guncelle#</ns:UyeTipiFiyat12Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat13Guncelle)><ns:UyeTipiFiyat13Guncelle>#arguments.UyeTipiFiyat13Guncelle#</ns:UyeTipiFiyat13Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat14Guncelle)><ns:UyeTipiFiyat14Guncelle>#arguments.UyeTipiFiyat14Guncelle#</ns:UyeTipiFiyat14Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat15Guncelle)><ns:UyeTipiFiyat15Guncelle>#arguments.UyeTipiFiyat15Guncelle#</ns:UyeTipiFiyat15Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat16Guncelle)><ns:UyeTipiFiyat16Guncelle>#arguments.UyeTipiFiyat16Guncelle#</ns:UyeTipiFiyat16Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat17Guncelle)><ns:UyeTipiFiyat17Guncelle>#arguments.UyeTipiFiyat17Guncelle#</ns:UyeTipiFiyat17Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat18Guncelle)><ns:UyeTipiFiyat18Guncelle>#arguments.UyeTipiFiyat18Guncelle#</ns:UyeTipiFiyat18Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat19Guncelle)><ns:UyeTipiFiyat19Guncelle>#arguments.UyeTipiFiyat19Guncelle#</ns:UyeTipiFiyat19Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat1Guncelle)><ns:UyeTipiFiyat1Guncelle>#arguments.UyeTipiFiyat1Guncelle#</ns:UyeTipiFiyat1Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat20Guncelle)><ns:UyeTipiFiyat20Guncelle>#arguments.UyeTipiFiyat20Guncelle#</ns:UyeTipiFiyat20Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat2Guncelle)><ns:UyeTipiFiyat2Guncelle>#arguments.UyeTipiFiyat2Guncelle#</ns:UyeTipiFiyat2Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat3Guncelle)><ns:UyeTipiFiyat3Guncelle>#arguments.UyeTipiFiyat3Guncelle#</ns:UyeTipiFiyat3Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat4Guncelle)><ns:UyeTipiFiyat4Guncelle>#arguments.UyeTipiFiyat4Guncelle#</ns:UyeTipiFiyat4Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat5Guncelle)><ns:UyeTipiFiyat5Guncelle>#arguments.UyeTipiFiyat5Guncelle#</ns:UyeTipiFiyat5Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat6Guncelle)><ns:UyeTipiFiyat6Guncelle>#arguments.UyeTipiFiyat6Guncelle#</ns:UyeTipiFiyat6Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat7Guncelle)><ns:UyeTipiFiyat7Guncelle>#arguments.UyeTipiFiyat7Guncelle#</ns:UyeTipiFiyat7Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat8Guncelle)><ns:UyeTipiFiyat8Guncelle>#arguments.UyeTipiFiyat8Guncelle#</ns:UyeTipiFiyat8Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat9Guncelle)><ns:UyeTipiFiyat9Guncelle>#arguments.UyeTipiFiyat9Guncelle#</ns:UyeTipiFiyat9Guncelle></cfif>
                            </tem:vAyar>
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
    <!---UrunFiltre ve UrunSayfalama kısımları class---->
    <cffunction  name="SelectUrun">
        <cfargument  name="UrunFiltre" required="true" hint="Ürünlerin filtre değerlerini içeren UrunFiltre sınıfı.">
        <cfargument  name="UrunSayfalama" required="true" hint="Ürünlerin sayfalama ve sıralama değerlerini içeren UrunSayfalama sınıfı.">
        <cfargument  name="Aktif" hint="Ürün aktiflik durumu. -1= filtre yok - 0= false - 1= true">
        <cfargument  name="Firsat" hint="Ürün fırsat -1= filtre yok - 0= false - 1= true">
        <cfargument  name="Indirimli" hint="Ürün indirimli durumu -1= filtre yok - 0= false - 1= true">
        <cfargument  name="Vitrin" hint="Ürün vitrin durumu -1= filtre yok - 0= false - 1= true">
        <cfargument  name="KategoriID" hint="Kategori id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="MarkaID" hint="Marka id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="UrunKartiID" hint="Ürün kartı id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="ToplamStokAdediBas" hint="Toplam stok adedi filtre başlangıç değeri">
        <cfargument  name="ToplamStokAdediSon" hint="Toplam stok adedi filtre bitiş değeri ">
        <cfargument  name="TedarikciID" hint="Tedarikçi id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="BaşlangicIndex" hint="Sayfalama başlangıç değeri.">
        <cfargument  name="KayitSayisi" hint="Getirilecek kayıt sayısı.">
        <cfargument  name="SiralamaDeger" hint="Sıralama değeri. Örn: “Id”">
        <cfargument  name="SiralamaYonu" hint="Sıralama yönü. Artan için “ASC” azalan için “DESC”">
        <cfargument  name="Barkod" default="">
        <cfargument  name="Dil" default="">
        <cfargument  name="DuzenlemeTarihiBaslangic" default="">
        <cfargument  name="DuzenlemeTarihiBitis" default="">
        <cfargument  name="EklemeTarihiBaslangic" default="">
        <cfargument  name="EklemeTarihiBitis" default="">
        <cfargument  name="EntegrasyonDegerTanim" default="">
        <cfargument  name="EntegrasyonKodu" default="">
        <cfargument  name="FiyatBaslangic" default="">
        <cfargument  name="FiyatBitis" default="">
        <cfargument  name="FiyatTipi" default="">
        <cfargument  name="HediyeIpucuAktif" default="">
        <cfargument  name="IlgiliUrunleriListele" default="">
        <cfargument  name="KasaOnuFirsatlari" default="">
        <cfargument  name="KategoriIDList" default="">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="PasifResimleriGetir" default="">
        <cfargument  name="ResimDurumu" default="">
        <cfargument  name="ResimEklemeTarihiBaslangic" default="">
        <cfargument  name="ResimEklemeTarihiBitis" default="">
        <cfargument  name="StokGuncellemeTarihiBaslangic" default="">
        <cfargument  name="StokGuncellemeTarihiBitis" default="">
        <cfargument  name="StokKodu" default="">
        <cfargument  name="StokKoduList" default="">
        <cfargument  name="BaslangicIndex" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectUrun>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:f>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                <cfif len(arguments.Dil)><ns:Dil>#arguments.Dil#</ns:Dil></cfif>
                                <cfif len(arguments.DuzenlemeTarihiBaslangic)><ns:DuzenlemeTarihiBaslangic>#arguments.DuzenlemeTarihiBaslangic#</ns:DuzenlemeTarihiBaslangic></cfif>
                                <cfif len(arguments.DuzenlemeTarihiBitis)><ns:DuzenlemeTarihiBitis>#arguments.DuzenlemeTarihiBitis#</ns:DuzenlemeTarihiBitis></cfif>
                                <cfif len(arguments.EklemeTarihiBaslangic)><ns:EklemeTarihiBaslangic>#arguments.EklemeTarihiBaslangic#</ns:EklemeTarihiBaslangic></cfif>
                                <cfif len(arguments.EklemeTarihiBitis)><ns:EklemeTarihiBitis>#arguments.EklemeTarihiBitis#</ns:EklemeTarihiBitis></cfif>
                                <cfif len(arguments.EntegrasyonDegerTanim)><ns:EntegrasyonDegerTanim>#arguments.EntegrasyonDegerTanim#</ns:EntegrasyonDegerTanim></cfif>
                                <cfif len(arguments.EntegrasyonKodu)><ns:EntegrasyonKodu>#arguments.EntegrasyonKodu#</ns:EntegrasyonKodu></cfif>
                                <cfif len(arguments.Firsat)><ns:Firsat>#arguments.Firsat#</ns:Firsat></cfif>
                                <ns:FiyatFiltre>
                                <ns:UrunFiyatFiltre>
                                    <cfif len(arguments.FiyatBaslangic)><ns:FiyatBaslangic>#arguments.FiyatBaslangic#</ns:FiyatBaslangic></cfif>
                                    <cfif len(arguments.FiyatBitis)><ns:FiyatBitis>#arguments.FiyatBitis#</ns:FiyatBitis></cfif>
                                    <cfif len(arguments.FiyatTipi)><ns:FiyatTipi>#arguments.FiyatTipi#</ns:FiyatTipi></cfif>
                                </ns:UrunFiyatFiltre>
                                </ns:FiyatFiltre>
                                <cfif len(arguments.HediyeIpucuAktif)><ns:HediyeIpucuAktif>#arguments.HediyeIpucuAktif#</ns:HediyeIpucuAktif></cfif>
                                <cfif len(arguments.IlgiliUrunleriListele)><ns:IlgiliUrunleriListele>#arguments.IlgiliUrunleriListele#</ns:IlgiliUrunleriListele></cfif>
                                <cfif len(arguments.Indirimli)><ns:Indirimli>#arguments.Indirimli#</ns:Indirimli></cfif>
                                <cfif len(arguments.KasaOnuFirsatlari)><ns:KasaOnuFirsatlari>#arguments.KasaOnuFirsatlari#</ns:KasaOnuFirsatlari></cfif>
                                <cfif len(arguments.KategoriID)><ns:KategoriID>#arguments.KategoriID#</ns:KategoriID></cfif>
                                <ns:KategoriIDList>
                                <cfif len(arguments.KategoriIDList)><arr:int>#arguments.KategoriIDList#</arr:int></cfif>
                                </ns:KategoriIDList>
                                <cfif len(arguments.MarkaID)><ns:MarkaID>#arguments.MarkaID#</ns:MarkaID></cfif>
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <cfif len(arguments.PasifResimleriGetir)><ns:PasifResimleriGetir>#arguments.PasifResimleriGetir#</ns:PasifResimleriGetir></cfif>
                                <cfif len(arguments.ResimDurumu)><ns:ResimDurumu>#arguments.ResimDurumu#</ns:ResimDurumu></cfif>
                                <cfif len(arguments.ResimEklemeTarihiBaslangic)><ns:ResimEklemeTarihiBaslangic>#arguments.ResimEklemeTarihiBaslangic#</ns:ResimEklemeTarihiBaslangic></cfif>
                                <cfif len(arguments.ResimEklemeTarihiBitis)><ns:ResimEklemeTarihiBitis>#arguments.ResimEklemeTarihiBitis#</ns:ResimEklemeTarihiBitis></cfif>
                                <cfif len(arguments.StokGuncellemeTarihiBaslangic)><ns:StokGuncellemeTarihiBaslangic>#arguments.StokGuncellemeTarihiBaslangic#</ns:StokGuncellemeTarihiBaslangic></cfif>
                                <cfif len(arguments.StokGuncellemeTarihiBitis)><ns:StokGuncellemeTarihiBitis>#arguments.StokGuncellemeTarihiBitis#</ns:StokGuncellemeTarihiBitis></cfif>
                                <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                <ns:StokKoduList>
                                <cfif len(arguments.StokKoduList)><arr:string>#arguments.StokKoduList#</arr:string></cfif>
                                </ns:StokKoduList>
                                <cfif len(arguments.TedarikciID)><ns:TedarikciID>#arguments.TedarikciID#</ns:TedarikciID></cfif>
                                <cfif len(arguments.ToplamStokAdediBas)><ns:ToplamStokAdediBas>#arguments.ToplamStokAdediBas#</ns:ToplamStokAdediBas></cfif>
                                <cfif len(arguments.ToplamStokAdediSon)><ns:ToplamStokAdediSon>#arguments.ToplamStokAdediSon#</ns:ToplamStokAdediSon></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                <cfif len(arguments.Vitrin)><ns:Vitrin>#arguments.Vitrin#</ns:Vitrin></cfif>
                            </tem:f>
                            <tem:s>
                                <cfif len(arguments.BaslangicIndex)><ns:BaslangicIndex>#arguments.BaslangicIndex#</ns:BaslangicIndex></cfif>
                                <cfif len(arguments.KayitSayisi)><ns:KayitSayisi>#arguments.KayitSayisi#</ns:KayitSayisi></cfif>
                                <cfif len(arguments.SiralamaDeger)><ns:SiralamaDegeri>#arguments.SiralamaDeger#</ns:SiralamaDegeri></cfif>
                                <cfif len(arguments.SiralamaYonu)><ns:SiralamaYonu>#arguments.SiralamaYonu#</ns:SiralamaYonu></cfif>
                            </tem:s>
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
    <!----UrunFiltre kısımı class---->
    <cffunction  name="SelectUrunCount">
        <cfargument  name="UrunFiltre" required="true" hint="Ürünlerin filtre değerlerini içeren UrunFiltre sınıfı">
        <cfargument  name="Aktif" hint="Ürün aktiflik durumu. -1= filtre yok - 0= false - 1= true">
        <cfargument  name="Firsat" hint="Ürün fırsat -1= filtre yok - 0= false - 1= true">
        <cfargument  name="Indirimli" hint="Ürün indirimli durumu -1= filtre yok - 0= false - 1= true">
        <cfargument  name="Vitrin" hint="Ürün vitrin durumu -1= filtre yok - 0= false - 1= true">
        <cfargument  name="KategoriID" hint="Kategori id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="MarkaID" hint="Marka id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="UrunKartiID" hint="Ürün kartı id değeri. 0 gönderilirse filtre yapılmaz">
        <cfargument  name="ToplamStokAdediBas" hint="Toplam stok adedi filtre başlangıç değeri">
        <cfargument  name="ToplamStokAdediSon" hint="Toplam stok adedi filtre bitiş değeri">
        <cfargument  name="TedarikciID" hint="Tedarikçi id değeri. 0 gönderilirse filtre yapılmaz.">
        <cfargument  name="Barkod" default="">
        <cfargument  name="Dil" default="">
        <cfargument  name="DuzenlemeTarihiBaslangic" default="">
        <cfargument  name="DuzenlemeTarihiBitis" default="">
        <cfargument  name="EklemeTarihiBaslangic" default="">
        <cfargument  name="EklemeTarihiBitis" default="">
        <cfargument  name="EntegrasyonDegerTanim" default="">
        <cfargument  name="EntegrasyonKodu" default="">
        <cfargument  name="FiyatBaslangic" default="">
        <cfargument  name="FiyatBitis" default="">
        <cfargument  name="FiyatTipi" default="">
        <cfargument  name="HediyeIpucuAktif" default="">
        <cfargument  name="IlgiliUrunleriListele" default="">
        <cfargument  name="KasaOnuFirsatlari" default="">
        <cfargument  name="KategoriIDList" default="">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="PasifResimleriGetir" default="">
        <cfargument  name="ResimDurumu" default="">
        <cfargument  name="ResimEklemeTarihiBaslangic" default="">
        <cfargument  name="ResimEklemeTarihiBitis" default="">
        <cfargument  name="StokGuncellemeTarihiBaslangic" default="">
        <cfargument  name="StokGuncellemeTarihiBitis" default="">
        <cfargument  name="StokKodu" default="">
        <cfargument  name="StokKoduList" default="">
        <cfxml  variable="xmlData">
        <cfoutput>
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                <soapenv:Header/>
                <soapenv:Body>
                    <tem:SelectUrunCount>
                        <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        <tem:f>
                            <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                            <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                            <cfif len(arguments.Dil)><ns:Dil>#arguments.Dil#</ns:Dil></cfif>
                            <cfif len(arguments.DuzenlemeTarihiBaslangic)><ns:DuzenlemeTarihiBaslangic>#arguments.DuzenlemeTarihiBaslangic#</ns:DuzenlemeTarihiBaslangic></cfif>
                            <cfif len(arguments.DuzenlemeTarihiBitis)><ns:DuzenlemeTarihiBitis>#arguments.DuzenlemeTarihiBitis#</ns:DuzenlemeTarihiBitis></cfif>
                            <cfif len(arguments.EklemeTarihiBaslangic)><ns:EklemeTarihiBaslangic>#arguments.EklemeTarihiBaslangic#</ns:EklemeTarihiBaslangic></cfif>
                            <cfif len(arguments.EklemeTarihiBitis)><ns:EklemeTarihiBitis>#arguments.EklemeTarihiBitis#</ns:EklemeTarihiBitis></cfif>    
                            <cfif len(arguments.EntegrasyonDegerTanim)><ns:EntegrasyonDegerTanim>#arguments.EntegrasyonDegerTanim#</ns:EntegrasyonDegerTanim></cfif>
                            <cfif len(arguments.EntegrasyonKodu)><ns:EntegrasyonKodu>#arguments.EntegrasyonKodu#</ns:EntegrasyonKodu></cfif>
                            <cfif len(arguments.Firsat)><ns:Firsat>#arguments.Firsat#</ns:Firsat></cfif>
                            <ns:FiyatFiltre>
                            <ns:UrunFiyatFiltre>
                                <cfif len(arguments.FiyatBaslangic)><ns:FiyatBaslangic>#arguments.FiyatBaslangic#</ns:FiyatBaslangic></cfif>
                                <cfif len(arguments.FiyatBitis)><ns:FiyatBitis>#arguments.FiyatBitis#</ns:FiyatBitis></cfif>
                                <cfif len(arguments.FiyatTipi)><ns:FiyatTipi>#arguments.FiyatTipi#</ns:FiyatTipi></cfif>
                            </ns:UrunFiyatFiltre>
                            </ns:FiyatFiltre>
                            <cfif len(arguments.HediyeIpucuAktif)><ns:HediyeIpucuAktif>#arguments.HediyeIpucuAktif#</ns:HediyeIpucuAktif></cfif>
                            <cfif len(arguments.IlgiliUrunleriListele)><ns:IlgiliUrunleriListele>#arguments.IlgiliUrunleriListele#</ns:IlgiliUrunleriListele></cfif>
                            <cfif len(arguments.Indirimli)><ns:Indirimli>#arguments.Indirimli#</ns:Indirimli></cfif>
                            <cfif len(arguments.KasaOnuFirsatlari)><ns:KasaOnuFirsatlari>#arguments.KasaOnuFirsatlari#</ns:KasaOnuFirsatlari></cfif>
                            <cfif len(arguments.KategoriID)><ns:KategoriID>#arguments.KategoriID#</ns:KategoriID></cfif>
                            <ns:KategoriIDList>
                            <cfif len(arguments.KategoriIDList)><arr:int>#arguments.KategoriIDList#</arr:int></cfif>
                            </ns:KategoriIDList>
                            <cfif len(arguments.MarkaID)><ns:MarkaID>#arguments.MarkaID#</ns:MarkaID></cfif>
                            <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                            <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                            <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                            <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                            <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                            <cfif len(arguments.PasifResimleriGetir)><ns:PasifResimleriGetir>#arguments.PasifResimleriGetir#</ns:PasifResimleriGetir></cfif>
                            <cfif len(arguments.ResimDurumu)><ns:ResimDurumu>#arguments.ResimDurumu#</ns:ResimDurumu></cfif>
                            <cfif len(arguments.ResimEklemeTarihiBaslangic)><ns:ResimEklemeTarihiBaslangic>#arguments.ResimEklemeTarihiBaslangic#</ns:ResimEklemeTarihiBaslangic></cfif>
                            <cfif len(arguments.ResimEklemeTarihiBitis)><ns:ResimEklemeTarihiBitis>#arguments.ResimEklemeTarihiBitis#</ns:ResimEklemeTarihiBitis></cfif>
                            <cfif len(arguments.StokGuncellemeTarihiBaslangic)><ns:StokGuncellemeTarihiBaslangic>#arguments.StokGuncellemeTarihiBaslangic#</ns:StokGuncellemeTarihiBaslangic></cfif>
                            <cfif len(arguments.StokGuncellemeTarihiBitis)><ns:StokGuncellemeTarihiBitis>#arguments.StokGuncellemeTarihiBitis#</ns:StokGuncellemeTarihiBitis></cfif>
                            <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                            <ns:StokKoduList>
                            <cfif len(arguments.StokKoduList)><arr:string>#arguments.StokKoduList#</arr:string></cfif>
                            </ns:StokKoduList>
                            <cfif len(arguments.TedarikciID)><ns:TedarikciID>#arguments.TedarikciID#</ns:TedarikciID></cfif>
                            <cfif len(arguments.ToplamStokAdediBas)><ns:ToplamStokAdediBas>#arguments.ToplamStokAdediBas#</ns:ToplamStokAdediBas></cfif>
                            <cfif len(arguments.ToplamStokAdediSon)><ns:ToplamStokAdediSon>#arguments.ToplamStokAdediSon#</ns:ToplamStokAdediSon></cfif>
                            <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                            <cfif len(arguments.Vitrin)><ns:Vitrin>#arguments.Vitrin#</ns:Vitrin></cfif>
                        </tem:f>
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
        <cfargument  name="AlanAdi" hint="Alan adi değeri.">
        <cfargument  name="Tanim" required="true" hint="varyasyon özellik tanım">
        <cfargument  name="Deger" required="true" hint="varyasyon özellik değer">
        <cfargument  name="UserAgent" hint="User agent bilgisi.">
        <cfargument  name="Aktif" hint="Ürünün aktiflik durumu.">
        <cfargument  name="ID" required="true" hint="0 gönderilir ise yeni ürün eklenir 0 dan büyük gönderilir ise gönderilen id li ürün güncellenir.">
        <cfargument  name="UrunAdi" required="true" hint="Ürün adı.">
        <cfargument  name="Aciklama" required="true" hint="Ürün açıklaması.">
        <cfargument  name="AnaKategori" required="true" hint="Ana kategori adı.">
        <cfargument  name="AnaKategoriID" required="true" hint="Ana kategori id değeri.">
        <cfargument  name="Kategoriler" required="true" hint="Kategori id leri listesi.">
        <cfargument  name="MarkaID" required="true" hint="Marka id değeri (Verilen id ile kayıtlı bir marka yoksa ürün eklenmez).">
        <cfargument  name="TedarikciID" required="true" hint="Tedarikçi id değeri.">
        <cfargument  name="Resimler" required="true" hint="Ürün resimleri listesi.">
        <cfargument  name="SatisBirimi" required="true" hint="Ürün satış birimi. Örn=”adet”">
        <cfargument  name="UcretsizKargo" required="true" hint="Ücretsiz kargo seçeneği.">
        <cfargument  name="OnYazi" hint="Ürün önyazısı.">
        <cfargument  name="SeoAnahtarKelime" hint="Seo optimizasyonu için kullanılan kelimeler">
        <cfargument  name="SeoSayfaAciklama" hint="Seo optimizasyonu için kullanılan açıklama.">
        <cfargument  name="SeoSayfaBaslik" hint="Seo optimizasyonu için kullanılan sayfa başlık.">
        <cfargument  name="Varyasyonlar" required="true" hint="Ürün kartına eklenecek olan ürünlerin listesi.">
        <cfargument  name="Vitrin" hint="Ürünün vitrinde görünme durumu.">
        <cfargument  name="YeniUrun" hint="Ürünün yeni ürün olarak görünme durumu.">
        <cfargument  name="AdwordsAciklama" hint="Xml deki açıklama.">
        <cfargument  name="AdwordsKategori" hint="Xml deki kategori.">
        <cfargument  name="AdwordsTip" hint="Xml deki tip.">
        <cfargument  name="AramaAnahtarKelime" hint="Sitede arama yaparken kullanılacak anahtar kelimeler ">
        <cfargument  name="AsortiGrupId" hint="Ürüne eklenecek asorti grup id değeri.">
        <cfargument  name="DuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="EkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EntegrasyonID" hint="Ürüne eklenecek entegrasyon id değeri.">
        <cfargument  name="FBStoreGoster" hint="Ürünün facebook store da gösterilme durumu.">
        <cfargument  name="FirsatUrunu" hint="Ürünün fırsat ürünlerine eklenme durumu">
        <cfargument  name="IndirimliFiyatOzellik" hint="Bu alanda 3 farklı değer girebiliyoruz. 0=Devamlı indirim , 1=Stok adedine göre indirim, 2= Tarihe göre indirim. ">
        <cfargument  name="IndirimliFiyatOzellikStok1" hint="İndirim başlangıç stok adedi">
        <cfargument  name="IndirimliFiyatOzellikStok2" hint="İndirim bitiş stok adedi. ">
        <cfargument  name="IndirimliFiyatOzellikTarih1" hint="İndirim başlangıç tarihi.">
        <cfargument  name="IndirimliFiyatOzellikTarih2" hint="İndirim bitiş tarihi.">
        <cfargument  name="MaksTaksitSayisi" hint="Ürünün maksimum taksit sayısı değeri.">
        <cfargument  name="OzelAlan1" hint="Eklenecek farklı özelliklerde kullanılacak özel alan. ">
        <cfargument  name="OzelAlan2" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="OzelAlan3" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="OzelAlan4" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="OzelAlan5" hint="Eklenecek farklı özelliklerde kullanılacak özel alan.">
        <cfargument  name="SeoNoFollow">
        <cfargument  name="SeoNoIndex">
        <cfargument  name="TahminiTeslimSuresi" hint="Ürünün tahmini teslim süresi">
        <cfargument  name="TeknikDetayGrupID" hint="Teknik Detay grup id değeri.">
        <cfargument  name="UrunSayfaAdresi" hint="Ürün url bilgisi.">
        <cfargument  name="UyeAlimMax" hint="Bir üyenin en fazla kaç ürün alabileceği değeri.">
        <cfargument  name="UyeAlimMin" hint="Bir üyenin en az kaç ürün alabileceği değeri.">
        <cfargument  name="YayinTarihi" hint="Ürünün yayın tarihi değeri.">
        <cfargument  name="AlisFiyati" hint="Varyasyona ait alis fiyatı değeri.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri.">
        <cfargument  name="Desi" hint="Varyasyon desi değeri.">
        <cfargument  name="KargoUcreti" hint="Varyasyon kargo ücreti değeri.">
        <cfargument  name="KdvDahil" hint="Kdv dahil olma durumu.">
        <cfargument  name="KdvOrani" hint="Varyasyon kdv orani değeri">
        <cfargument  name="Ozellikler" hint="Varyasyonun özellikleri."> 
        <cfargument  name="VaryasyonResimler" hint="Varyasyon resimleri.">
        <cfargument  name="StokAdedi" hint="Stok adedi değeri. ">
        <cfargument  name="StokKodu" hint="Varyasyon stok kodu .">
        <cfargument  name="VaryasyonAktif" hint="Varyasyonun aktif olma durumu.">
        <cfargument  name="VDuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="VEkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EksiStokAdedi" hint="Ayrılacak olan stok adedi.">
        <cfargument  name="IndirimliFiyati" hint="Varyasyon indirimli fiyat değeri.">
        <cfargument  name="VParaBirimi" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="VParaBirimiKodu" hint="Eğer para birimiId girildiyse boş gönderilebilir">
        <cfargument  name="VTedarikciKodu" hint="Tedarikçi koduna göre güncelle true ise zorunlu">
        <cfargument  name="UyeTipiFiyat1" hint="Üye tipi 1 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat2" hint="Üye tipi 2 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat3" hint="Üye tipi 3 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat4" hint="Üye tipi 4 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat5" hint="Üye tipi 5 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat6" hint="Üye tipi 6 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat7" hint="Üye tipi 7 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat8" hint="Üye tipi 8 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat9" hint="Üye tipi 9 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat10" hint="Üye tipi 10 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat11" hint="Üye tipi 11 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat12" hint="Üye tipi 12 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat13" hint="Üye tipi 13 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat14" hint="Üye tipi 14 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat15" hint="Üye tipi 15 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat16" hint="Üye tipi 16 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat17" hint="Üye tipi 17 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat18" hint="Üye tipi 18 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat19" hint="Üye tipi 19 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat20" hint="Üye tipi 20 ye özel fiyat değeri.">
        <cfargument  name="ParaBirimiID" required="true" hint="varyasyon para birimi id">
        <cfargument  name="VaryasyonSatisFiyati" required="true" hint="varyasyon satış fiyatı">
        <cfargument  name="TedarikciKodu" required="true" hint="ürün kartı tedarikçi kodu">
        <cfargument  name="VaryasyonID" required="true" hint="varyasyon id">
        <cfargument name="EklemeTarihi" default="">
        <cfargument  name="EtiketID" default="">
        <cfargument  name="HediyeIpucu" default="">
        <cfargument  name="IlgiliUrunResim" default="">
        <cfargument  name="KargoTipi" default="">
        <cfargument  name="int" default="">
        <cfargument  name="ListedeGoster" default="">
        <cfargument  name="Marka" default="">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="Alpha2Code" default="">
        <cfargument  name="Alpha3Code" default="">
        <cfargument  name="UlkeID" default="">
        <cfargument  name="NumericCode" default="">
        <cfargument  name="UlkeTanim" default="">
        <cfargument  name="PuanDeger" default="">
        <cfargument  name="Sira" default="">
        <cfargument  name="TahminiTeslimSuresiAyniGun" default="">
        <cfargument  name="TahminiTeslimSuresiGoster" default="">
        <cfargument  name="TahminiTeslimSuresiTarih" default="">
        <cfargument  name="TakimKampanyaId" default="">
        <cfargument  name="TakimUrun" default="">
        <cfargument  name="TedarikciKodu2" default="">
        <cfargument  name="DegerID" default="">
        <cfargument  name="OzellikID" default="">
        <cfargument  name="ToplamStokAdedi" default="">
        <cfargument  name="UrunAdediKademeDeger" default="">
        <cfargument  name="UrunAdediMinimumDeger" default="">
        <cfargument  name="UrunAdediOndalikliSayiGirilebilir" default="">
        <cfargument  name="UrunAdediVarsayilanDeger" default="">
        <cfargument  name="UrunKapidaOdemeYasakli" default="">
        <cfargument  name="Desi2" default="">
        <cfargument  name="IndirimliFiyati1" default="">
        <cfargument  name="IndirimliFiyati2" default="">
        <cfargument  name="IndirimliFiyati3" default="">
        <cfargument  name="IndirimliFiyati4" default="">
        <cfargument  name="IndirimliFiyati5" default="">
        <cfargument  name="IndirimliFiyati6" default="">
        <cfargument  name="IndirimliFiyati7" default="">
        <cfargument  name="IndirimliFiyati8" default="">
        <cfargument  name="IndirimliFiyati9" default="">
        <cfargument  name="IndirimliFiyati10" default="">
        <cfargument  name="IndirimliFiyati11" default="">
        <cfargument  name="IndirimliFiyati12" default="">
        <cfargument  name="IndirimliFiyati13" default="">
        <cfargument  name="IndirimliFiyati14" default="">
        <cfargument  name="IndirimliFiyati15" default="">
        <cfargument  name="IndirimliFiyati16" default="">
        <cfargument  name="IndirimliFiyati17" default="">
        <cfargument  name="IndirimliFiyati18" default="">
        <cfargument  name="IndirimliFiyati19" default="">
        <cfargument  name="IndirimliFiyati20" default="">
        <cfargument  name="IscilikAgirlik" default="">
        <cfargument  name="IscilikParaBirimi" default="">
        <cfargument  name="IscilikParaBirimiId" default="">
        <cfargument  name="IscilikParaBirimiKodu" default="">
        <cfargument  name="KdvDahil1" default="">
        <cfargument  name="KdvDahil2" default="">
        <cfargument  name="KdvDahil3" default="">
        <cfargument  name="KdvDahil4" default="">
        <cfargument  name="KdvDahil5" default="">
        <cfargument  name="KdvDahil7" default="">
        <cfargument  name="KdvDahil8" default="">
        <cfargument  name="KdvDahil9" default="">
        <cfargument  name="KdvDahil10" default="">
        <cfargument  name="KdvDahil11" default="">
        <cfargument  name="KdvDahil12" default="">
        <cfargument  name="KdvDahil13" default="">
        <cfargument  name="KdvDahil14" default="">
        <cfargument  name="KdvDahil15" default="">
        <cfargument  name="KdvDahil16" default="">
        <cfargument  name="KdvDahil17" default="">
        <cfargument  name="KdvDahil18" default="">
        <cfargument  name="KdvDahil19" default="">
        <cfargument  name="KdvDahil20" default="">
        <cfargument  name="KdvOrani1" default="">
        <cfargument  name="KdvOrani2" default="">
        <cfargument  name="KdvOrani3" default="">
        <cfargument  name="KdvOrani4" default="">
        <cfargument  name="KdvOrani5" default="">
        <cfargument  name="KdvOrani6" default="">
        <cfargument  name="KdvOrani7" default="">
        <cfargument  name="KdvOrani8" default="">
        <cfargument  name="KdvOrani9" default="">
        <cfargument  name="KdvOrani10" default="">
        <cfargument  name="KdvOrani11" default="">
        <cfargument  name="KdvOrani12" default="">
        <cfargument  name="KdvOrani13" default="">
        <cfargument  name="KdvOrani14" default="">
        <cfargument  name="KdvOrani15" default="">
        <cfargument  name="KdvOrani16" default="">
        <cfargument  name="KdvOrani17" default="">
        <cfargument  name="KdvOrani18" default="">
        <cfargument  name="KdvOrani19" default="">
        <cfargument  name="KdvOrani20" default="">
        <cfargument  name="VMarkaID" default="">
        <cfargument  name="Tur" default="">
        <cfargument  name="XmlKod" default="">
        <cfargument  name="ParaBirimiKodu" default="">
        <cfargument  name="ParaBirimi1Id" default="">
        <cfargument  name="ParaBirimi2Id" default="">
        <cfargument  name="ParaBirimi3Id" default="">
        <cfargument  name="ParaBirimi4Id" default="">
        <cfargument  name="ParaBirimi5Id" default="">
        <cfargument  name="ParaBirimi6Id" default="">
        <cfargument  name="ParaBirimi7Id" default="">
        <cfargument  name="ParaBirimi8Id" default="">
        <cfargument  name="ParaBirimi9Id" default="">
        <cfargument  name="ParaBirimi10Id" default="">
        <cfargument  name="ParaBirimi11Id" default="">
        <cfargument  name="ParaBirimi12Id" default="">
        <cfargument  name="ParaBirimi13Id" default="">
        <cfargument  name="ParaBirimi14Id" default="">
        <cfargument  name="ParaBirimi15Id" default="">
        <cfargument  name="ParaBirimi16Id" default="">
        <cfargument  name="ParaBirimi17Id" default="">
        <cfargument  name="ParaBirimi18Id" default="">
        <cfargument  name="ParaBirimi19Id" default="">
        <cfargument  name="ParaBirimi20Id" default="">
        <cfargument  name="SatisFiyati1" default="">
        <cfargument  name="SatisFiyati2" default="">
        <cfargument  name="SatisFiyati3" default="">
        <cfargument  name="SatisFiyati4" default="">
        <cfargument  name="SatisFiyati5" default="">
        <cfargument  name="SatisFiyati6" default="">
        <cfargument  name="SatisFiyati7" default="">
        <cfargument  name="SatisFiyati8" default="">
        <cfargument  name="SatisFiyati9" default="">
        <cfargument  name="SatisFiyati10" default="">
        <cfargument  name="SatisFiyati11" default="">
        <cfargument  name="SatisFiyati12" default="">
        <cfargument  name="SatisFiyati13" default="">
        <cfargument  name="SatisFiyati14" default="">
        <cfargument  name="SatisFiyati15" default="">
        <cfargument  name="SatisFiyati16" default="">
        <cfargument  name="SatisFiyati17" default="">
        <cfargument  name="SatisFiyati18" default="">
        <cfargument  name="SatisFiyati19" default="">
        <cfargument  name="SatisFiyati20" default="">
        <cfargument  name="StokGuncellemeTarihi" default="">
        <cfargument  name="UpdateKey" default="">
        <cfargument  name="UrunAgirligi" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfargument  name="YonlendirmeAdresi" default="">

        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveResim>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:kartlar>
                                <ns:UrunKarti>
                                <ns:Aciklama>#arguments.Aciklama#</ns:Aciklama>
                                <cfif len(arguments.AdwordsAciklama)><ns:AdwordsAciklama>#arguments.AdwordsAciklama#</ns:AdwordsAciklama></cfif>
                                <cfif len(arguments.AdwordsKategori)><ns:AdwordsKategori>#arguments.AdwordsKategori#</ns:AdwordsKategori></cfif>
                                <cfif len(arguments.AdwordsTip)><ns:AdwordsTip>#arguments.AdwordsTip#</ns:AdwordsTip></cfif>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <ns:AnaKategori>#arguments.AnaKategori#</ns:AnaKategori>
                                <ns:AnaKategoriID>#arguments.AnaKategoriID#</ns:AnaKategoriID>
                                <cfif len(arguments.AramaAnahtarKelime)><ns:AramaAnahtarKelime>#arguments.AramaAnahtarKelime#</ns:AramaAnahtarKelime></cfif>
                                <cfif len(arguments.AsortiGrupId)><ns:AsortiGrupID>#arguments.AsortiGrupId#</ns:AsortiGrupID></cfif>
                                <cfif len(arguments.DuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.DuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                <cfif len(arguments.EklemeTarihi)><ns:EklemeTarihi>#arguments.EklemeTarihi#</ns:EklemeTarihi></cfif>
                                <cfif len(arguments.EkleyenKullanici)><ns:EkleyenKullanici>#arguments.EkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                <cfif len(arguments.EntegrasyonID)><ns:EntegrasyonID>#arguments.EntegrasyonID#</ns:EntegrasyonID></cfif>
                                <ns:Etiketler>
                                    <ns:UrunKartiEtiket>
                                        <cfif len(arguments.EtiketID)><ns:EtiketID>#arguments.EtiketID#</ns:EtiketID></cfif>
                                    </ns:UrunKartiEtiket>
                                </ns:Etiketler>
                                <cfif len(arguments.FBStoreGoster)><ns:FBStoreGoster>#arguments.FBStoreGoster#</ns:FBStoreGoster></cfif>
                                <cfif len(arguments.FirsatUrunu)><ns:FirsatUrunu>#arguments.FirsatUrunu#</ns:FirsatUrunu></cfif>
                                <cfif len(arguments.HediyeIpucu)><ns:HediyeIpucu>#arguments.HediyeIpucu#</ns:HediyeIpucu></cfif>
                                <ns:ID>#argument.ID#</ns:ID>
                                <cfif len(arguments.IlgiliUrunResim)><ns:IlgiliUrunResim>#arguments.IlgiliUrunResim#</ns:IlgiliUrunResim></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellik)><ns:IndirimliFiyatOzellik>#arguments.IndirimliFiyatOzellik#</ns:IndirimliFiyatOzellik></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikStok1)><ns:IndirimliFiyatOzellikStok1>#arguments.IndirimliFiyatOzellikStok1#</ns:IndirimliFiyatOzellikStok1></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikStok2)><ns:IndirimliFiyatOzellikStok2>#arguments.IndirimliFiyatOzellikStok2#</ns:IndirimliFiyatOzellikStok2></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikTarih1)><ns:IndirimliFiyatOzellikTarih1>#arguments.IndirimliFiyatOzellikTarih1#</ns:IndirimliFiyatOzellikTarih1></cfif>
                                <cfif len(arguments.IndirimliFiyatOzellikTarih2)><ns:IndirimliFiyatOzellikTarih2>#arguments.IndirimliFiyatOzellikTarih2#</ns:IndirimliFiyatOzellikTarih2></cfif>
                                <cfif len(arguments.KargoTipi)><ns:KargoTipi>#arguments.KargoTipi#</ns:KargoTipi></cfif>
                                <ns:Kategoriler>
                                    <arr:int>#arguments.Kategoriler#</arr:int>
                                </ns:Kategoriler>
                                <cfif len(arguments.ListedeGoster)><ns:ListedeGoster>#arguments.ListedeGoster#</ns:ListedeGoster></cfif>
                                <cfif len(arguments.MaksTaksitSayisi)><ns:MaksTaksitSayisi>#arguments.MaksTaksitSayisi#</ns:MaksTaksitSayisi></cfif>
                                <cfif len(arguments.Marka)><ns:Marka>#arguments.Marka#</ns:Marka></cfif>
                                <ns:MarkaID>#arguments.MarkaID#</ns:MarkaID>
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <ns:MenseiUlke>
                                    <cfif len(arguments.Alpha2Code)><ns:Alpha2Code>#arguments.Alpha2Code#</ns:Alpha2Code></cfif>
                                    <cfif len(arguments.Alpha3Code)><ns:Alpha3Code>#arguments.Alpha3Code#</ns:Alpha3Code></cfif>
                                    <cfif len(arguments.UlkeID)><ns:ID>#arguments.UlkeID#</ns:ID></cfif>
                                    <cfif len(arguments.NumericCode)><ns:NumericCode>#arguments.NumericCode#</ns:NumericCode></cfif>
                                    <cfif len(arguments.UlkeTanim)><ns:Tanim>#arguments.UlkeTanim#</ns:Tanim></cfif>
                                </ns:MenseiUlke>
                                <cfif len(arguments.OnYazi)><ns:OnYazi>#arguments.OnYazi#</ns:OnYazi></cfif>
                                <cfif len(arguments.OzelAlan1)><ns:OzelAlan1>#arguments.OzelAlan1#</ns:OzelAlan1></cfif>
                                <cfif len(arguments.OzelAlan2)><ns:OzelAlan2>#arguments.OzelAlan2#</ns:OzelAlan2></cfif>
                                <cfif len(arguments.OzelAlan3)><ns:OzelAlan3>#arguments.OzelAlan3#</ns:OzelAlan3></cfif>
                                <cfif len(arguments.OzelAlan4)><ns:OzelAlan4>#arguments.OzelAlan4#</ns:OzelAlan4></cfif>
                                <cfif len(arguments.OzelAlan5)><ns:OzelAlan5>#arguments.OzelAlan5#</ns:OzelAlan5></cfif>
                                <cfif len(arguments.PuanDeger)><ns:PuanDeger>#arguments.PuanDeger#</ns:PuanDeger></cfif>
                                <ns:Resimler>
                                    <arr:string>#arguments.Resimler#</arr:string>
                                </ns:Resimler>
                                <ns:SatisBirimi>#arguments.SatisBirimi#</ns:SatisBirimi>
                                <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                <cfif len(arguments.SeoNoFollow)><ns:SeoNoFollow>#arguments.SeoNoFollow#</ns:SeoNoFollow></cfif>
                                <cfif len(arguments.SeoNoIndex)><ns:SeoNoIndex>#arguments.SeoNoIndex#</ns:SeoNoIndex></cfif>
                                <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                <cfif len(arguments.Sira)><ns:Sira>#arguments.Sira#</ns:Sira></cfif>
                                <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                <cfif len(arguments.TakimKampanyaId)><ns:TakimKampanyaId>#arguments.TakimKampanyaId#</ns:TakimKampanyaId></cfif>
                                <cfif len(arguments.TakimUrun)><ns:TakimUrun>#arguments.TakimUrun#</ns:TakimUrun></cfif>
                                <ns:TedarikciID>#arguments.TedarikciID#</ns:TedarikciID>
                                <cfif len(arguments.TedarikciKodu)><ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu></cfif>
                                <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                <cfif len(arguments.TeknikDetayGrupID)><ns:TeknikDetayGrupID>#arguments.TeknikDetayGrupID#</ns:TeknikDetayGrupID></cfif>
                                <ns:TeknikDetaylar>
                                    <ns:UrunKartiTeknikDetay>
                                        <cfif len(arguments.DegerID)><ns:DegerID>#arguments.DegerID#</ns:DegerID></cfif>
                                        <cfif len(arguments.OzellikID)><ns:OzellikID>#arguments.OzellikID#</ns:OzellikID></cfif>
                                    </ns:UrunKartiTeknikDetay>
                                </ns:TeknikDetaylar>
                                <cfif len(arguments.ToplamStokAdedi)><ns:ToplamStokAdedi>#arguments.ToplamStokAdedi#</ns:ToplamStokAdedi></cfif>
                                <ns:UcretsizKargo>#arguments.UcretsizKargo#</ns:UcretsizKargo>
                                <cfif len(arguments.UrunAdediKademeDeger)><ns:UrunAdediKademeDeger>#arguments.UrunAdediKademeDeger#</ns:UrunAdediKademeDeger></cfif>
                                <cfif len(arguments.UrunAdediMinimumDeger)><ns:UrunAdediMinimumDeger>#arguments.UrunAdediMinimumDeger#</ns:UrunAdediMinimumDeger></cfif>
                                <cfif len(arguments.UrunAdediOndalikliSayiGirilebilir)><ns:UrunAdediOndalikliSayiGirilebilir>#arguments.UrunAdediOndalikliSayiGirilebilir#</ns:UrunAdediOndalikliSayiGirilebilir></cfif>
                                <cfif len(arguments.UrunAdediVarsayilanDeger)><ns:UrunAdediVarsayilanDeger>#arguments.UrunAdediVarsayilanDeger#</ns:UrunAdediVarsayilanDeger></cfif>
                                <ns:UrunAdi>#arguments.UrunAdi#</ns:UrunAdi>
                                <cfif len(arguments.UrunKapidaOdemeYasakli)><ns:UrunKapidaOdemeYasakli>#arguments.UrunKapidaOdemeYasakli#</ns:UrunKapidaOdemeYasakli></cfif>
                                <cfif len(arguments.UrunSayfaAdresi)><ns:UrunSayfaAdresi>#arguments.UrunSayfaAdresi#</ns:UrunSayfaAdresi></cfif>
                                <cfif len(arguments.UyeAlimMax)><ns:UyeAlimMax>#arguments.UyeAlimMax#</ns:UyeAlimMax></cfif>
                                <cfif len(arguments.UyeAlimMin)><ns:UyeAlimMin>#arguments.UyeAlimMin#</ns:UyeAlimMin></cfif>
                                <ns:Varyasyonlar>
                                    <ns:Varyasyon>
                                        <cfif len(arguments.VaryasyonAktif)><ns:Aktif>#arguments.VaryasyonAktif#</ns:Aktif></cfif>
                                        <cfif len(arguments.AlisFiyati)><ns:AlisFiyati>#arguments.AlisFiyati#</ns:AlisFiyati></cfif>
                                        <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                        <ns:Barkodlar>
                                            <cfif len(arguments.Barkod)><arr:string>#arguments.Barkod#</arr:string></cfif>
                                        </ns:Barkodlar>
                                        <cfif len(arguments.Desi)><ns:Desi>#arguments.Desi#</ns:Desi></cfif>
                                        <cfif len(arguments.Desi2)><ns:Desi2>#arguments.Desi2#</ns:Desi2></cfif>
                                        <cfif len(arguments.VDuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.VDuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                        <cfif len(arguments.VEkleyenKullanici)><ns:EkleyenKullanici>#arguments.VEkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                        <cfif len(arguments.EksiStokAdedi)><ns:EksiStokAdedi>#arguments.EksiStokAdedi#</ns:EksiStokAdedi></cfif>
                                        <ns:ID>#arguments.VaryasyonID#</ns:ID>
                                        <cfif len(arguments.IndirimliFiyati)><ns:IndirimliFiyati>#arguments.IndirimliFiyati#</ns:IndirimliFiyati></cfif>
                                        <cfif len(arguments.IndirimliFiyati1)><ns:IndirimliFiyati1>#arguments.IndirimliFiyati1#</ns:IndirimliFiyati1></cfif>
                                        <cfif len(arguments.IndirimliFiyati10)><ns:IndirimliFiyati10>#arguments.IndirimliFiyati10#</ns:IndirimliFiyati10></cfif>
                                        <cfif len(arguments.IndirimliFiyati11)><ns:IndirimliFiyati11>#arguments.IndirimliFiyati11#</ns:IndirimliFiyati11></cfif>
                                        <cfif len(arguments.IndirimliFiyati12)><ns:IndirimliFiyati12>#arguments.IndirimliFiyati12#</ns:IndirimliFiyati12></cfif>
                                        <cfif len(arguments.IndirimliFiyati13)><ns:IndirimliFiyati13>#arguments.IndirimliFiyati13#</ns:IndirimliFiyati13></cfif>
                                        <cfif len(arguments.IndirimliFiyati14)><ns:IndirimliFiyati14>#arguments.IndirimliFiyati14#</ns:IndirimliFiyati14></cfif>
                                        <cfif len(arguments.IndirimliFiyati15)><ns:IndirimliFiyati15>#arguments.IndirimliFiyati15#</ns:IndirimliFiyati15></cfif>
                                        <cfif len(arguments.IndirimliFiyati16)><ns:IndirimliFiyati16>#arguments.IndirimliFiyati16#</ns:IndirimliFiyati16></cfif>
                                        <cfif len(arguments.IndirimliFiyati17)><ns:IndirimliFiyati17>#arguments.IndirimliFiyati17#</ns:IndirimliFiyati17></cfif>
                                        <cfif len(arguments.IndirimliFiyati18)><ns:IndirimliFiyati18>#arguments.IndirimliFiyati18#</ns:IndirimliFiyati18></cfif>
                                        <cfif len(arguments.IndirimliFiyati19)><ns:IndirimliFiyati19>#arguments.IndirimliFiyati19#</ns:IndirimliFiyati19></cfif>
                                        <cfif len(arguments.IndirimliFiyati2)><ns:IndirimliFiyati2>#arguments.IndirimliFiyati2#</ns:IndirimliFiyati2></cfif>
                                        <cfif len(arguments.IndirimliFiyati20)><ns:IndirimliFiyati20>#arguments.IndirimliFiyati20#</ns:IndirimliFiyati20></cfif>
                                        <cfif len(arguments.IndirimliFiyati3)><ns:IndirimliFiyati3>#arguments.IndirimliFiyati3#</ns:IndirimliFiyati3></cfif>
                                        <cfif len(arguments.IndirimliFiyati4)><ns:IndirimliFiyati4>#arguments.IndirimliFiyati4#</ns:IndirimliFiyati4></cfif>
                                        <cfif len(arguments.IndirimliFiyati5)><ns:IndirimliFiyati5>#arguments.IndirimliFiyati5#</ns:IndirimliFiyati5></cfif>
                                        <cfif len(arguments.IndirimliFiyati6)><ns:IndirimliFiyati6>#arguments.IndirimliFiyati6#</ns:IndirimliFiyati6></cfif>
                                        <cfif len(arguments.IndirimliFiyati7)><ns:IndirimliFiyati7>#arguments.IndirimliFiyati7#</ns:IndirimliFiyati7></cfif>
                                        <cfif len(arguments.IndirimliFiyati8)><ns:IndirimliFiyati8>#arguments.IndirimliFiyati8#</ns:IndirimliFiyati8></cfif>
                                        <cfif len(arguments.IndirimliFiyati9)><ns:IndirimliFiyati9>#arguments.IndirimliFiyati9#</ns:IndirimliFiyati9></cfif>
                                        <cfif len(arguments.IscilikAgirlik)><ns:IscilikAgirlik>#arguments.IscilikAgirlik#</ns:IscilikAgirlik></cfif>
                                        <cfif len(arguments.IscilikParaBirimi)><ns:IscilikParaBirimi>#arguments.IscilikParaBirimi#</ns:IscilikParaBirimi></cfif>
                                        <cfif len(arguments.IscilikParaBirimiId)><ns:IscilikParaBirimiId>#arguments.IscilikParaBirimiId#</ns:IscilikParaBirimiId></cfif>
                                        <cfif len(arguments.IscilikParaBirimiKodu)><ns:IscilikParaBirimiKodu>#arguments.IscilikParaBirimiKodu#</ns:IscilikParaBirimiKodu></cfif>
                                        <cfif len(arguments.KargoUcreti)><ns:KargoUcreti>#arguments.KargoUcreti#</ns:KargoUcreti></cfif>
                                        <ns:Kategoriler>
                                            <arr:int>#arguments.Kategoriler#</arr:int>
                                        </ns:Kategoriler>
                                        <cfif len(arguments.KdvDahil)><ns:KdvDahil>#arguments.KdvDahil#</ns:KdvDahil></cfif>
                                        <cfif len(arguments.KdvDahil1)><ns:KdvDahil1>?#arguments.KdvDahil1#</ns:KdvDahil1></cfif>
                                        <cfif len(arguments.KdvDahil10)><ns:KdvDahil10>#arguments.KdvDahil10#</ns:KdvDahil10></cfif>
                                        <cfif len(arguments.KdvDahil11)><ns:KdvDahil11>#arguments.KdvDahil11#</ns:KdvDahil11></cfif>
                                        <cfif len(arguments.KdvDahil12)><ns:KdvDahil12>#arguments.KdvDahil12#</ns:KdvDahil12></cfif>
                                        <cfif len(arguments.KdvDahil13)><ns:KdvDahil13>#arguments.KdvDahil13#</ns:KdvDahil13></cfif>
                                        <cfif len(arguments.KdvDahil14)><ns:KdvDahil14>#arguments.KdvDahil14#</ns:KdvDahil14></cfif>
                                        <cfif len(arguments.KdvDahil15)><ns:KdvDahil15>#arguments.KdvDahil15#</ns:KdvDahil15></cfif>
                                        <cfif len(arguments.KdvDahil16)><ns:KdvDahil16>#arguments.KdvDahil16#</ns:KdvDahil16></cfif>
                                        <cfif len(arguments.KdvDahil17)><ns:KdvDahil17>#arguments.KdvDahil17#</ns:KdvDahil17></cfif>
                                        <cfif len(arguments.KdvDahil18)><ns:KdvDahil18>#arguments.KdvDahil18#</ns:KdvDahil18></cfif>
                                        <cfif len(arguments.KdvDahil19)><ns:KdvDahil19>#arguments.KdvDahil19#</ns:KdvDahil19></cfif>
                                        <cfif len(arguments.KdvDahil2)><ns:KdvDahil2>#arguments.KdvDahil2#</ns:KdvDahil2></cfif>
                                        <cfif len(arguments.KdvDahil20)><ns:KdvDahil20>#arguments.KdvDahil20#</ns:KdvDahil20></cfif>
                                        <cfif len(arguments.KdvDahil3)><ns:KdvDahil3>#arguments.KdvDahil3#</ns:KdvDahil3></cfif>
                                        <cfif len(arguments.KdvDahil4)><ns:KdvDahil4>#arguments.KdvDahil4#</ns:KdvDahil4></cfif>
                                        <cfif len(arguments.KdvDahil5)><ns:KdvDahil5>#arguments.KdvDahil5#</ns:KdvDahil5></cfif>
                                        <cfif len(arguments.KdvDahil6)><ns:KdvDahil6>#arguments.KdvDahil6#</ns:KdvDahil6></cfif>
                                        <cfif len(arguments.KdvDahil7)><ns:KdvDahil7>#arguments.KdvDahil7#</ns:KdvDahil7></cfif>
                                        <cfif len(arguments.KdvDahil8)><ns:KdvDahil8>#arguments.KdvDahil8#</ns:KdvDahil8></cfif>
                                        <cfif len(arguments.KdvDahil9)><ns:KdvDahil9>#arguments.KdvDahil9#</ns:KdvDahil9></cfif>
                                        <cfif len(arguments.KdvOrani)><ns:KdvOrani>#arguments.KdvOrani#</ns:KdvOrani></cfif>
                                        <cfif len(arguments.KdvOrani1)><ns:KdvOrani1>#arguments.KdvOrani1#</ns:KdvOrani1></cfif>
                                        <cfif len(arguments.KdvOrani10)><ns:KdvOrani10>#arguments.KdvOrani10#</ns:KdvOrani10></cfif>
                                        <cfif len(arguments.KdvOrani11)><ns:KdvOrani11>#arguments.KdvOrani11#</ns:KdvOrani11></cfif>
                                        <cfif len(arguments.KdvOrani12)><ns:KdvOrani12>#arguments.KdvOrani12#</ns:KdvOrani12></cfif>
                                        <cfif len(arguments.KdvOrani13)><ns:KdvOrani13>#arguments.KdvOrani13#</ns:KdvOrani13></cfif>
                                        <cfif len(arguments.KdvOrani14)><ns:KdvOrani14>#arguments.KdvOrani14#</ns:KdvOrani14></cfif>
                                        <cfif len(arguments.KdvOrani15)><ns:KdvOrani15>#arguments.KdvOrani15#</ns:KdvOrani15></cfif>
                                        <cfif len(arguments.KdvOrani16)><ns:KdvOrani16>#arguments.KdvOrani16#</ns:KdvOrani16></cfif>
                                        <cfif len(arguments.KdvOrani17)><ns:KdvOrani17>#arguments.KdvOrani17#</ns:KdvOrani17></cfif>
                                        <cfif len(arguments.KdvOrani18)><ns:KdvOrani18>#arguments.KdvOrani18#</ns:KdvOrani18></cfif>
                                        <cfif len(arguments.KdvOrani19)><ns:KdvOrani19>#arguments.KdvOrani19#</ns:KdvOrani19></cfif>
                                        <cfif len(arguments.KdvOrani2)><ns:KdvOrani2>#arguments.KdvOrani2#</ns:KdvOrani2></cfif>
                                        <cfif len(arguments.KdvOrani20)><ns:KdvOrani20>#arguments.KdvOrani20#</ns:KdvOrani20></cfif>
                                        <cfif len(arguments.KdvOrani3)><ns:KdvOrani3>#arguments.KdvOrani3#</ns:KdvOrani3></cfif>
                                        <cfif len(arguments.KdvOrani4)><ns:KdvOrani4>#arguments.KdvOrani4#</ns:KdvOrani4></cfif>
                                        <cfif len(arguments.KdvOrani5)><ns:KdvOrani5>#arguments.KdvOrani5#</ns:KdvOrani5></cfif>
                                        <cfif len(arguments.KdvOrani6)><ns:KdvOrani6>#arguments.KdvOrani6#</ns:KdvOrani6></cfif>
                                        <cfif len(arguments.KdvOrani7)><ns:KdvOrani7>#arguments.KdvOrani7#</ns:KdvOrani7></cfif>
                                        <cfif len(arguments.KdvOrani8)><ns:KdvOrani8>#arguments.KdvOrani8#</ns:KdvOrani8></cfif>
                                        <cfif len(arguments.KdvOrani9)><ns:KdvOrani9>#arguments.KdvOrani9#</ns:KdvOrani9></cfif>
                                        <cfif len(arguments.VMarkaID)><ns:MarkaID>#arguments.VMarkaID#</ns:MarkaID></cfif>
                                        <!-----buralardaki marketplaceaktif kısımları varyasyon için geçerli bunlar varyasyon olarak tanımlanmalı mı yoksa bu şekilde devam mı?---->
                                        <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                        <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                        <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                        <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                        <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                        <ns:Ozellikler>
                                            <ns:VaryasyonOzellik>
                                            <ns:Deger>#arguments.Deger#</ns:Deger>
                                            <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                            <cfif len(arguments.Tur)><ns:Tur>#arguments.Tur#</ns:Tur></cfif>
                                            <cfif len(arguments.XmlKod)><ns:XmlKod>#arguments.XmlKod#</ns:XmlKod></cfif>
                                            </ns:VaryasyonOzellik>
                                        </ns:Ozellikler>
                                        <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                        <cfif len(arguments.ParaBirimi10Id)><ns:ParaBirimi10Id>#arguments.ParaBirimi10Id#</ns:ParaBirimi10Id></cfif>                    
                                        <cfif len(arguments.ParaBirimi11Id)><ns:ParaBirimi11Id>#arguments.ParaBirimi11Id#</ns:ParaBirimi11Id></cfif>
                                        <cfif len(arguments.ParaBirimi12Id)><ns:ParaBirimi12Id>#arguments.ParaBirimi12Id#</ns:ParaBirimi12Id></cfif>
                                        <cfif len(arguments.ParaBirimi13Id)><ns:ParaBirimi13Id>#arguments.ParaBirimi13Id#</ns:ParaBirimi13Id></cfif>
                                        <cfif len(arguments.ParaBirimi14Id)><ns:ParaBirimi14Id>#arguments.ParaBirimi14Id#</ns:ParaBirimi14Id></cfif>
                                        <cfif len(arguments.ParaBirimi15Id)><ns:ParaBirimi15Id>#arguments.ParaBirimi15Id#</ns:ParaBirimi15Id></cfif>
                                        <cfif len(arguments.ParaBirimi16Id)><ns:ParaBirimi16Id>#arguments.ParaBirimi16Id#</ns:ParaBirimi16Id></cfif>
                                        <cfif len(arguments.ParaBirimi17Id)><ns:ParaBirimi17Id>#arguments.ParaBirimi17Id#</ns:ParaBirimi17Id></cfif>
                                        <cfif len(arguments.ParaBirimi18Id)><ns:ParaBirimi18Id>#arguments.ParaBirimi18Id#</ns:ParaBirimi18Id></cfif>
                                        <cfif len(arguments.ParaBirimi19Id)><ns:ParaBirimi19Id>#arguments.ParaBirimi19Id#</ns:ParaBirimi19Id></cfif>
                                        <cfif len(arguments.ParaBirimi1Id)><ns:ParaBirimi1Id>#arguments.ParaBirimi1Id#</ns:ParaBirimi1Id></cfif>
                                        <cfif len(arguments.ParaBirimi20Id)><ns:ParaBirimi20Id>#arguments.ParaBirimi20Id#</ns:ParaBirimi20Id></cfif>
                                        <cfif len(arguments.ParaBirimi2Id)><ns:ParaBirimi2Id>#arguments.ParaBirimi2Id#</ns:ParaBirimi2Id></cfif>
                                        <cfif len(arguments.ParaBirimi3Id)><ns:ParaBirimi3Id>#arguments.ParaBirimi3Id#</ns:ParaBirimi3Id></cfif>
                                        <cfif len(arguments.ParaBirimi4Id)><ns:ParaBirimi4Id>#arguments.ParaBirimi4Id#</ns:ParaBirimi4Id></cfif>
                                        <cfif len(arguments.ParaBirimi5Id)><ns:ParaBirimi5Id>#arguments.ParaBirimi5Id#</ns:ParaBirimi5Id></cfif>
                                        <cfif len(arguments.ParaBirimi6Id)><ns:ParaBirimi6Id>#arguments.ParaBirimi6Id#</ns:ParaBirimi6Id></cfif>
                                        <cfif len(arguments.ParaBirimi7Id)><ns:ParaBirimi7Id>#arguments.ParaBirimi7Id#</ns:ParaBirimi7Id></cfif>
                                        <cfif len(arguments.ParaBirimi8Id)><ns:ParaBirimi8Id>#arguments.ParaBirimi8Id#</ns:ParaBirimi8Id></cfif>
                                        <cfif len(arguments.ParaBirimi9Id)><ns:ParaBirimi9Id>#arguments.ParaBirimi9Id#</ns:ParaBirimi9Id></cfif>
                                        <ns:ParaBirimiID>#arguments.ParaBirimiID#</ns:ParaBirimiID>
                                        <cfif len(arguments.ParaBirimiKodu)><ns:ParaBirimiKodu>#arguments.ParaBirimiKodu#</ns:ParaBirimiKodu></cfif>                    
                                        <ns:Resimler>
                                            <cfif len(arguments.VaryasyonResimler)><arr:string>#arguments.VaryasyonResimler#</arr:string></cfif>
                                        </ns:Resimler>
                                        <ns:SatisFiyati>#arguments.VaryasyonSatisFiyati#</ns:SatisFiyati>
                                        <cfif len(arguments.SatisFiyati1)><ns:SatisFiyati1>#arguments.SatisFiyati1#</ns:SatisFiyati1></cfif>
                                        <cfif len(arguments.SatisFiyati10)><ns:SatisFiyati10>#arguments.SatisFiyati10#</ns:SatisFiyati10></cfif>
                                        <cfif len(arguments.SatisFiyati11)><ns:SatisFiyati11>#arguments.SatisFiyati11#</ns:SatisFiyati11></cfif>
                                        <cfif len(arguments.SatisFiyati12)><ns:SatisFiyati12>#arguments.SatisFiyati12#</ns:SatisFiyati12></cfif>
                                        <cfif len(arguments.SatisFiyati13)><ns:SatisFiyati13>#arguments.SatisFiyati13#</ns:SatisFiyati13></cfif>
                                        <cfif len(arguments.SatisFiyati14)><ns:SatisFiyati14>#arguments.SatisFiyati14#</ns:SatisFiyati14></cfif>
                                        <cfif len(arguments.SatisFiyati15)><ns:SatisFiyati15>#arguments.SatisFiyati15#</ns:SatisFiyati15></cfif>
                                        <cfif len(arguments.SatisFiyati16)><ns:SatisFiyati16>#arguments.SatisFiyati16#</ns:SatisFiyati16></cfif>
                                        <cfif len(arguments.SatisFiyati17)><ns:SatisFiyati17>#arguments.SatisFiyati17#</ns:SatisFiyati17></cfif>
                                        <cfif len(arguments.SatisFiyati18)><ns:SatisFiyati18>#arguments.SatisFiyati18#</ns:SatisFiyati18></cfif>
                                        <cfif len(arguments.SatisFiyati19)><ns:SatisFiyati19>#arguments.SatisFiyati19#</ns:SatisFiyati19></cfif>
                                        <cfif len(arguments.SatisFiyati2)><ns:SatisFiyati2>#arguments.SatisFiyati2#</ns:SatisFiyati2></cfif>
                                        <cfif len(arguments.SatisFiyati20)><ns:SatisFiyati20>#arguments.SatisFiyati20#</ns:SatisFiyati20></cfif>
                                        <cfif len(arguments.SatisFiyati3)><ns:SatisFiyati3>#arguments.SatisFiyati3#</ns:SatisFiyati3></cfif>
                                        <cfif len(arguments.SatisFiyati4)><ns:SatisFiyati4>#arguments.SatisFiyati4#</ns:SatisFiyati4></cfif>
                                        <cfif len(arguments.SatisFiyati5)><ns:SatisFiyati5>#arguments.SatisFiyati5#</ns:SatisFiyati5></cfif>
                                        <cfif len(arguments.SatisFiyati6)><ns:SatisFiyati6>#arguments.SatisFiyati6#</ns:SatisFiyati6></cfif>
                                        <cfif len(arguments.SatisFiyati7)><ns:SatisFiyati7>#arguments.SatisFiyati7#</ns:SatisFiyati7></cfif>
                                        <cfif len(arguments.SatisFiyati8)<ns:SatisFiyati8>#arguments.SatisFiyati8#</ns:SatisFiyati8></cfif>
                                        <cfif len(arguments.SatisFiyati9)><ns:SatisFiyati9>#arguments.SatisFiyati9#</ns:SatisFiyati9></cfif>
                                        <cfif len(arguments.StokAdedi)><ns:StokAdedi>#arguments.StokAdedi#</ns:StokAdedi></cfif>
                                        <cfif len(arguments.StokGuncellemeTarihi)><ns:StokGuncellemeTarihi>#arguments.StokGuncellemeTarihi#</ns:StokGuncellemeTarihi></cfif>
                                        <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                        <!-----tahmini teslim süresi yukarıda ürün için tanımlanmış varyasyon için tanımlayıp onu mu almam gerekiyor yoksa aynı argumentden devam mı şu an yaptığım aynısı ------>
                                        <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                        <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                        <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                        <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                        <cfif len(arguments.VTedarikciKodu)><ns:TedarikciKodu>#arguments.VTedarikciKodu#</ns:TedarikciKodu></cfif>
                                        <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                        <cfif len(arguments.UpdateKey)><ns:UpdateKey>#arguments.UpdateKey#</ns:UpdateKey></cfif>
                                        <cfif len(arguemnts.UrunAgirligi)><ns:UrunAgirligi>#arguments.UrunAgirligi#</ns:UrunAgirligi></cfif>
                                        <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                        <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                        <cfif len(arguments.UyeTipiFiyat1)><ns:UyeTipiFiyat1>#arguments.UyeTipiFiyat1#</ns:UyeTipiFiyat1></cfif>
                                        <cfif len(arguments.UyeTipiFiyat10)><ns:UyeTipiFiyat10>#arguments.UyeTipiFiyat10#</ns:UyeTipiFiyat10></cfif>
                                        <cfif len(arguments.UyeTipiFiyat11)><ns:UyeTipiFiyat11>#arguments.UyeTipiFiyat11#</ns:UyeTipiFiyat11></cfif>
                                        <cfif len(arguments.UyeTipiFiyat12)><ns:UyeTipiFiyat12>#arguments.UyeTipiFiyat12#</ns:UyeTipiFiyat12></cfif>
                                        <cfif len(arguments.UyeTipiFiyat13)><ns:UyeTipiFiyat13>#arguments.UyeTipiFiyat13#</ns:UyeTipiFiyat13></cfif>
                                        <cfif len(arguments.UyeTipiFiyat14)><ns:UyeTipiFiyat14>#arguments.UyeTipiFiyat14#</ns:UyeTipiFiyat14></cfif>
                                        <cfif len(arguments.UyeTipiFiyat15)><ns:UyeTipiFiyat15>#arguments.UyeTipiFiyat15#</ns:UyeTipiFiyat15></cfif>
                                        <cfif len(arguments.UyeTipiFiyat16)><ns:UyeTipiFiyat16>#arguments.UyeTipiFiyat16#</ns:UyeTipiFiyat16></cfif>
                                        <cfif len(arguments.UyeTipiFiyat17)><ns:UyeTipiFiyat17>#arguments.UyeTipiFiyat17#</ns:UyeTipiFiyat17></cfif>
                                        <cfif len(arguments.UyeTipiFiyat18)><ns:UyeTipiFiyat18>#arguments.UyeTipiFiyat18#</ns:UyeTipiFiyat18></cfif>
                                        <cfif len(arguments.UyeTipiFiyat19)><ns:UyeTipiFiyat19>#arguments.UyeTipiFiyat19#</ns:UyeTipiFiyat19></cfif>
                                        <cfif len(arguments.UyeTipiFiyat2)><ns:UyeTipiFiyat2>#arguments.UyeTipiFiyat2#</ns:UyeTipiFiyat2></cfif>
                                        <cfif len(arguments.UyeTipiFiyat20)><ns:UyeTipiFiyat20>#arguments.UyeTipiFiyat20#</ns:UyeTipiFiyat20></cfif>
                                        <cfif len(arguments.UyeTipiFiyat3)><ns:UyeTipiFiyat3>#arguments.UyeTipiFiyat3#</ns:UyeTipiFiyat3></cfif>
                                        <cfif len(arguments.UyeTipiFiyat4)><ns:UyeTipiFiyat4>#arguments.UyeTipiFiyat4#</ns:UyeTipiFiyat4></cfif>
                                        <cfif len(arguments.UyeTipiFiyat5)><ns:UyeTipiFiyat5>#arguments.UyeTipiFiyat5#</ns:UyeTipiFiyat5></cfif>
                                        <cfif len(arguments.UyeTipiFiyat6)><ns:UyeTipiFiyat6>#arguments.UyeTipiFiyat6#</ns:UyeTipiFiyat6></cfif>
                                        <cfif len(arguments.UyeTipiFiyat7)><ns:UyeTipiFiyat7>#arguments.UyeTipiFiyat7#</ns:UyeTipiFiyat7></cfif>
                                        <cfif len(arguments.UyeTipiFiyat8)><ns:UyeTipiFiyat8>#arguments.UyeTipiFiyat8#</ns:UyeTipiFiyat8></cfif>
                                        <cfif len(arguments.UyeTipiFiyat9)><ns:UyeTipiFiyat9>#arguments.UyeTipiFiyat9#</ns:UyeTipiFiyat9></cfif>
                                    </ns:Varyasyon>
                                </ns:Varyasyonlar>
                                <cfif len(arguments.Vitrin)><ns:Vitrin>#arguments.Vitrin#</ns:Vitrin></cfif>
                                <cfif len(arguments.YayinTarihi)><ns:YayinTarihi>#arguments.YayinTarihi#</ns:YayinTarihi></cfif>
                                <cfif len(arguments.YeniUrun)><ns:YeniUrun>#arguments.YeniUrun#</ns:YeniUrun></cfif>
                                <cfif len(arguments.YonlendirmeAdresi)><ns:YonlendirmeAdresi>#arguments.YonlendirmeAdresi#</ns:YonlendirmeAdresi></cfif>
                                </ns:UrunKarti>
                            </tem:kartlar>
                            <!--Optional:-->
                            <cfif len(arguments.alanAdi)><tem:alanAdi>#arguments.alanAdi#</tem:alanAdi></cfif>
                            <cfif len(arguments.userAgent)><tem:userAgent>#arguments.userAgent#</tem:userAgent></cfif>
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
    <!---SaveMagazaStokRequest bu kısım liste   *class----->
    <cffunction  name="SaveMagazaStok">
        <cfargument  name="SaveMagazaStokRequest" required="true" hint="Mağaza ve stok bilgilerini içeren saveMagazaStokRequestModeli.">
        <cfargument  name="MagazaStokList" required="true" hint="Magaza stok bilgileri listesi.">
        <cfargument  name="EksiStokAdedi" hint="Ayrılmak istenen stok adedi.">
        <cfargument  name="MagazaKodu" required="true" hint="Mağaza kodu.">
        <cfargument  name="StokAdedi" required="true" hint="Mağazaya verilmek istenen stok adedi.">
        <cfargument  name="TedarikciKodu" required="true" hint="Tedarikçi kodu değeri.">
        <cfargument  name="UrunID" required="true" hint="Ürün id değeri.">
        <cfargument  name="UrunKartiID" required="true" hint="Ürün kartı id değeri.">
        <cfargument  name="MagazaID" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveMagazaStok>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:MagazaStokList>
                                <ns:WebMagazaStok>
                                    <cfif len(arguments.EksiStokAdedi)><ns:EksiStokAdedi>#arguments.EksiStokAdedi#</ns:EksiStokAdedi></cfif>
                                    <cfif len(arguments.MagazaID)><ns:MagazaID>#arguments.MagazaID#</ns:MagazaID></cfif>
                                    <ns:MagazaKodu>#arguments.MagazaKodu#</ns:MagazaKodu>
                                    <ns:StokAdedi>#arguments.StokAdedi#</ns:StokAdedi>
                                    <ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu>
                                    <ns:UrunID>#arguments.UrunID#</ns:UrunID>
                                    <ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID>
                                </ns:WebMagazaStok>
                                </ns:MagazaStokList>
                            </tem:request>
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
    <!---UpdateUrunDilRequest kısmı class----->
    <cffunction  name="UpdateUrunDil">
        <cfargument  name="UpdateUrunDilRequest" required="true" hint="Dil bilgilerini ve güncelleme ayarlarını içeren UpdateUrunDilRequest sınıfı">
        <cfargument  name="Ayar" required="true" hint="Güncelleme ayarlarını içeren UrunDilAyar sınıfı">
        <cfargument  name="Dil" required="true" hint="Dil kodu">
        <cfargument  name="Liste" required="true" hint="Ürünü ve değişecek değerleri içeren UrunDil sınıfı listesi">
        <cfargument  name="AciklamaGuncelle" hint="Açıklama güncelleme durumu">
        <cfargument  name="AramaAnahtarKelimeGuncelle" hint="Arama anahtar kelime güncelleme durumu">
        <cfargument  name="OnYaziGuncelle" hint="Ön yazı güncelleme durumu">
        <cfargument  name="SatisBirimiGuncelle" hint="Satış birimi güncelleme durumu">
        <cfargument  name="SeoAnahtarKelimeGuncelle" hint="Seo anahtar kelime güncelleme durumu">
        <cfargument  name="SeoNoFollowGuncelle" hint="Seo no follow güncelleme durumu">
        <cfargument  name="SeoNoIndexGuncelle" hint="Seo ne index güncelleme durumu">
        <cfargument  name="SeoSayfaAciklamaGuncelle" hint="Seo sayfa açıklama güncelleme durumu">
        <cfargument  name="SeoSayfaBaslikGuncelle" hint="Seo sayfa başlık güncelleme durumu">
        <cfargument  name="UrunAdiGuncelle" hint="Ürün adı güncelleme durumu">
        <cfargument  name="ID" required="true" hint="Ürün id ">
        <cfargument  name="Aciklama" hint="Güncellenecek açıklama değeri">
        <cfargument  name="AramaAnahtarKelime" hint="Güncellenecek arama anahtar kelime değeri">
        <cfargument  name="SatisBirimi" hint="Güncellenecek satış birimi değeri">
        <cfargument  name="UrunAdi" hint="Güncellenecek ürün adı değeri">
        <cfargument  name="OnYazi" hint="Güncellenecek ön yazı değeri">
        <cfargument  name="SeoAnahtarKelime" hint="Güncellenecek seo anahtar kelime değeri">
        <cfargument  name="SeoNoFollow" hint="Güncellenecek seo no follow değeri">
        <cfargument  name="SeoNoIndex" hint="Güncellenecek seo no index değeri">
        <cfargument  name="SeoSayfaAciklama" hint="Güncellenecek seo sayfa açıklama değeri">
        <cfargument  name="SeoSayfaBaslik" hint="Güncellenecek sep sayfa başlık değeri">
        <cfargument  name="AdwordsKategoriGuncelle" default="">
        <cfargument  name="AdwordsTipGuncelle" default="">
        <cfargument  name="OzelAlan1Guncelle" default="">
        <cfargument  name="OzelAlan2Guncelle" default="">
        <cfargument  name="OzelAlan3Guncelle" default="">
        <cfargument  name="OzelAlan4Guncelle" default="">
        <cfargument  name="OzelAlan5Guncelle" default="">
        <cfargument  name="TedarikciKodunaGoreGuncelle" default="">
        <cfargument  name="AdwordsAciklama" default="">
        <cfargument  name="AdwordsKategori" default="">
        <cfargument  name="AdwordsTip" default="">
        <cfargument  name="OzelAlan1" default="">
        <cfargument  name="OzelAlan2" default="">
        <cfargument  name="OzelAlan3" default="">
        <cfargument  name="OzelAlan4" default="">
        <cfargument  name="OzelAlan5" default="">
        <cfargument  name="TedarikciKodu" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateUrunDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Ayar>
                                <cfif len(arguments.AciklamaGuncelle)><ns:AciklamaGuncelle>#arguments.AciklamaGuncelle#</ns:AciklamaGuncelle></cfif>
                                <cfif len(arguments.AdwordsAciklamaGuncelle)><ns:AdwordsAciklamaGuncelle>#arguments.AdwordsAciklamaGuncelle#</ns:AdwordsAciklamaGuncelle></cfif>
                                <cfif len(arguments.AdwordsKategoriGuncelle)><ns:AdwordsKategoriGuncelle>#arguments.AdwordsKategoriGuncelle#</ns:AdwordsKategoriGuncelle></cfif>
                                <cfif len(arguments.AdwordsTipGuncelle)><ns:AdwordsTipGuncelle>#arguments.AdwordsTipGuncelle#</ns:AdwordsTipGuncelle></cfif>
                                <cfif len(arguments.AramaAnahtarKelimeGuncelle)><ns:AramaAnahtarKelimeGuncelle>#arguments.AramaAnahtarKelimeGuncelle#</ns:AramaAnahtarKelimeGuncelle></cfif>
                                <cfif len(arguments.OnYaziGuncelle)><ns:OnYaziGuncelle>#arguments.OnYaziGuncelle#</ns:OnYaziGuncelle></cfif>
                                <cfif len(arguments.OzelAlan1Guncelle)><ns:OzelAlan1Guncelle>#arguments.OzelAlan1Guncelle#</ns:OzelAlan1Guncelle></cfif>
                                <cfif len(arguments.OzelAlan2Guncelle)><ns:OzelAlan2Guncelle>#arguments.OzelAlan2Guncelle#</ns:OzelAlan2Guncelle></cfif>
                                <cfif len(arguments.OzelAlan3Guncelle)><ns:OzelAlan3Guncelle>#arguments.OzelAlan3Guncelle#</ns:OzelAlan3Guncelle></cfif>
                                <cfif len(arguments.OzelAlan4Guncelle)><ns:OzelAlan4Guncelle>#arguments.OzelAlan4Guncelle#</ns:OzelAlan4Guncelle></cfif>
                                <cfif len(arguments.OzelAlan5Guncelle)><ns:OzelAlan5Guncelle>#arguments.OzelAlan5Guncelle#</ns:OzelAlan5Guncelle></cfif>
                                <cfif len(arguments.SatisBirimiGuncelle)><ns:SatisBirimiGuncelle>#arguments.SatisBirimiGuncelle#</ns:SatisBirimiGuncelle></cfif>
                                <cfif len(arguments.SeoAnahtarKelimeGuncelle)><ns:SeoAnahtarKelimeGuncelle>#arguments.SeoAnahtarKelimeGuncelle#</ns:SeoAnahtarKelimeGuncelle></cfif>
                                <cfif len(arguments.SeoNoFollowGuncelle)><ns:SeoNoFollowGuncelle>#arguments.SeoNoFollowGuncelle#</ns:SeoNoFollowGuncelle></cfif>
                                <cfif len(arguments.SeoNoIndexGuncelle)><ns:SeoNoIndexGuncelle>#arguments.SeoNoIndexGuncelle#</ns:SeoNoIndexGuncelle></cfif>
                                <cfif len(arguments.SeoSayfaAciklamaGuncelle)><ns:SeoSayfaAciklamaGuncelle>#arguments.SeoSayfaAciklamaGuncelle#</ns:SeoSayfaAciklamaGuncelle></cfif>
                                <cfif len(arguments.SeoSayfaBaslikGuncelle)><ns:SeoSayfaBaslikGuncelle>#arguments.SeoSayfaBaslikGuncelle#</ns:SeoSayfaBaslikGuncelle></cfif>
                                <cfif len(arguments.TedarikciKodunaGoreGuncelle)><ns:TedarikciKodunaGoreGuncelle>#arguments.TedarikciKodunaGoreGuncelle#</ns:TedarikciKodunaGoreGuncelle></cfif>
                                <cfif len(arguments.UrunAdiGuncelle)><ns:UrunAdiGuncelle>#arguments.UrunAdiGuncelle#</ns:UrunAdiGuncelle></cfif>
                                </ns:Ayar>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:UrunDil>
                                    <cfif len(arguments.Aciklama)><ns:Aciklama>#arguments.Aciklama#</ns:Aciklama></cfif>
                                    <cfif len(arguments.AdwordsAciklama)><ns:AdwordsAciklama>#arguments.AdwordsAciklama#</ns:AdwordsAciklama></cfif>
                                    <cfif len(arguments.AdwordsKategori)><ns:AdwordsKategori>#arguments.AdwordsKategori#</ns:AdwordsKategori></cfif>
                                    <cfif len(arguments.AdwordsTip)><ns:AdwordsTip>#arguments.AdwordsTip#</ns:AdwordsTip></cfif>
                                    <cfif len(arguments.AramaAnahtarKelime)><ns:AramaAnahtarKelime>#arguments.AramaAnahtarKelime#</ns:AramaAnahtarKelime></cfif>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <cfif len(arguments.OnYazi)><ns:OnYazi>#arguments.OnYazi#</ns:OnYazi></cfif>
                                    <cfif len(arguments.OzelAlan1)><ns:OzelAlan1>#arguments.OzelAlan1#</ns:OzelAlan1></cfif>
                                    <cfif len(arguments.OzelAlan2)><ns:OzelAlan2>#arguments.OzelAlan2#</ns:OzelAlan2></cfif>
                                    <cfif len(arguments.OzelAlan3)><ns:OzelAlan3>#arguments.OzelAlan3#</ns:OzelAlan3></cfif>
                                    <cfif len(arguments.OzelAlan4)><ns:OzelAlan4>#arguments.OzelAlan4#</ns:OzelAlan4></cfif>
                                    <cfif len(arguments.OzelAlan5)><ns:OzelAlan5>#arguments.OzelAlan5#</ns:OzelAlan5></cfif>
                                    <cfif len(arguments.SatisBirimi)><ns:SatisBirimi>#arguments.SatisBirimi#</ns:SatisBirimi></cfif>
                                    <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                    <cfif len(arguments.SeoNoFollow)><ns:SeoNoFollow>#arguments.SeoNoFollow#</ns:SeoNoFollow></cfif>
                                    <cfif len(arguments.SeoNoIndex)><ns:SeoNoIndex>#arguments.SeoNoIndex#</ns:SeoNoIndex></cfif>
                                    <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                    <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                    <cfif len(arguments.TedarikciKodu)><ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu></cfif>
                                    <cfif len(arguments.UrunAdi)><ns:UrunAdi>#arguments.UrunAdi#</ns:UrunAdi></cfif>
                                </ns:UrunDil>
                                </ns:Liste>
                            </tem:request>
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
        <cfargument  name="UrunKartiID" required="true" hint="İlgili ürün eklenecek ürünün id değeri">
        <cfargument  name="IlgiliUrunKartiID" required="true" hint="Eklenecek İlgili ürünün id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveIlgiliUrun>
                        <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        <tem:list>
                            <ns:IlgiliUrun>
                                <ns:IlgiliUrunKartiID>#arguments.IlgiliUrunKartiID#</ns:IlgiliUrunKartiID>
                                <ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID>
                            </ns:IlgiliUrun>
                        </tem:list>
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
    <!----TeknikDetayDeger kısmı class----->
    <cffunction  name="SaveTeknikDetayDeger">
        <cfargument  name="TeknikDetayDeger" required="true" hint="Teknik detay deger bilgilerini içeren TeknikDetayDeger sınıfı.">
        <cfargument  name="ID" required="true" hint="0 girilir ise yani kayıt oluşturulur. 0 dan büyük girilirse girilen id li kayıt güncellenir">
        <cfargument  name="OzellikID" required="true" hint="Kayıtlı olan teknik detay özellik Id değeri.">
        <cfargument  name="Tanim" required="true" hint="Teknik detay değer tanımı">
        <cfargument  name="Sira" required="true" hint="Sıra numarası.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveTeknikDetayDeger>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>
                            <ns:ID>#arguments.ID#</ns:ID>
                            <ns:OzellikID>#arguments.OzellikID#</ns:OzellikID>
                            <ns:Sira>#arguments.Sira#</ns:Sira>
                            <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                            </tem:m>               
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
    <!----TeknikDetayGrup kısmı class--->
    <cffunction  name="SaveTeknikDetayGrup">
        <cfargument  name="TeknikDetayGrup" required="true" hint="Teknik deyat grup bilgilerini içeren TeknikDetayGrup sınıfı.">
        <cfargument  name="ID" required="true" hint="0 girilir ise yani kayıt oluşturulur. 0 dan büyük girilirse girilen id li kayıt güncellenir.">
        <cfargument  name="Tanim" required="true" hint="Teknik detay grup tanımı">
        <cfargument  name="Sira" hint="Sıra numarası.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveTeknikDetayGrup>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <cfif len(arguments.Sira)><ns:Sira>#arguments.Sira#</ns:Sira></cfif>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                            </tem:m>
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
    <!----TeknikDetayOzellik kısmı class---->
    <cffunction  name="SaveTeknikDetayOzellik">
        <cfargument  name="TeknikDetayOzellik" required="true" hint="Teknik deyat özellik bilgilerini içeren TeknikDetayOzellik sınıfı.">
        <cfargument  name="ID" required="true" hint="0 girilir ise yani kayıt oluşturulur. 0 dan büyük girilirse girilen id li kayıt güncellenir.">
        <cfargument  name="Tanim" required="true" hint="Teknik detay özellik tanımı.">
        <cfargument  name="Sira" hint="Sıra numarası.">
        <cfargument  name="GrupId" required="true" hint="Kayıtlı teknik detay grup id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveTeknikDetayOzellik>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>
                                <ns:GrupID>#arguments.GrupID#</ns:GrupID>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <cfif len(arguments.Sira)><ns:Sira>#arguments.Sira#</ns:Sira></cfif>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>                
                            </tem:m>
                        </tem:SaveTeknikDetayOzellik>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveTeknikDetayOzellik"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectTeknikDetayDeger">
        <cfargument  name="TeknikDetayDegerID" required="true" hint="Getirilmek istenilen TeknikDetayDeger in id değeri.">
        <cfargument  name="Dil" hint="Dil seçeneği boş gönderilir ise ‘Tr’ olarak gelir.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectTeknikDetayDeger>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:teknikDetayDegerId>#arguments.TeknikDetayDegerID#</tem:teknikDetayDegerId>
                            <cfif len(arguments.Dil)><tem:dil>#arguments.Dil#</tem:dil></cfif>
                        </tem:SelectTeknikDetayDeger>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectTeknikDetayDeger"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectTeknikDetayGrup">
        <cfargument  name="TeknikDetayGrupID" required="true" hint="Getirilmek istenilen TeknikDetayGrup id değeri.">
        <cfargument  name="Dil" hint="Dil seçeneği boş gönderilir ise ‘Tr’ olarak gelir.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectTeknikDetayGrup>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:teknikDetayGrupId>#arguments.TeknikDetayGrupID#</tem:teknikDetayGrupId>
                            <cfif len(arguments.Dil)><tem:dil>#arguments.Dil#</tem:dil></cfif>
                        </tem:SelectTeknikDetayGrup>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectTeknikDetayGrup"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectTeknikDetayOzellik">
        <cfargument  name="TeknikDetayOzellikID" required="true" hint="Getirilmek istenilen TeknikDetayOzellik id değeri.">
        <cfargument  name="Dil" hint="Dil seçeneği boş gönderilir ise ‘Tr’ olarak gelir.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectTeknikDetayOzellik>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:teknikDetayOzellikId>#arguments.TeknikDetayOzellikID#</tem:teknikDetayOzellikId>
                            <cfif len(arguments.Dil)><tem:dil>#arguments.Dil#</tem:dil></cfif>
                        </tem:SelectTeknikDetayOzellik>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectTeknikDetayOzellik"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----UpdateTeknikDetayDegerDilRequest kısmı class----->
    <cffunction  name="UpdateTeknikDetayDegerDil">
        <cfargument  name="UpdateTeknikDetayDegerDilRequest" required="true" hint="Güncelleme bilgilerini içeren UpdateTeknikDetayDegerDilRequest sınıfı">
        <cfargument  name="Dil" required="true" hint="Dil kodu örn = “en”">
        <cfargument  name="Liste" required="true" hint="Güncellenecek olan teknik detay değerleri içeren TeknikDetayDegerDil sınıfı listesi">
        <cfargument  name="ID" required="true" hint="Teknik detay değer id">
        <cfargument  name="Tanim" required="true" hint="Güncellenecek teknik detay değer tanım">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateTeknikDetayDegerDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:TeknikDetayDegerDil>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                </ns:TeknikDetayDegerDil>
                                </ns:Liste>                
                            </tem:request>
                        </tem:UpdateTeknikDetayDegerDil>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateTeknikDetayDegerDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!---UpdateTeknikDetayGrupDilRequest kısmı class----->
    <cffunction  name="UpdateTeknikDetayGrupDil">
        <cfargument  name="UpdateTeknikDetayGrupDilRequest" required="true" hint="Güncelleme bilgilerini içeren UpdateTeknikDetayGrupDilRequest sınıfı">
        <cfargument  name="Dil" required="true" hint="Dil kodu örn = “en”">
        <cfargument  name="Liste" required="true" hint="Güncellenecek olan teknik detay grupları içeren TeknikDetayGrupDil sınıfı listesi">
        <cfargument  name="ID" required="true" hint="Teknik detay grup id ">
        <cfargument  name="Tanim" required="true" hint="Güncellenecek teknik detay grup tanım">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateTeknikDetayGrupDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:TeknikDetayGrupDil>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                </ns:TeknikDetayGrupDil>
                                </ns:Liste>                
                            </tem:request>
                        </tem:UpdateTeknikDetayGrupDil>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateTeknikDetayGrupDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----UpdateTeknikDetayOzellikDilRequest kısmı class----->
    <cffunction  name="UpdateTeknikDetayOzellikDil">
        <cfargument  name="UpdateTeknikDetayOzellikDilRequest" required="true" hint="Güncelleme bilgilerini içeren UpdateTeknikDetayOzellikDilRequest sınıfı">
        <cfargument  name="Dil" required="true" hint="Dil kodu örn = “en”">
        <cfargument  name="Liste" required="true" hint="Güncellenecek olan teknik detay özellikleri içeren TeknikDetayOzellikDil sınıfı listesi">
        <cfargument  name="ID" required="true" hint="Teknik detay özellik id ">
        <cfargument  name="Tanim" required="true" hint="Güncellenecek teknik detay özellik tanım">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateTeknikDetayOzellikDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:TeknikDetayOzellikDil>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                </ns:TeknikDetayOzellikDil>                
                            </tem:request>
                        </tem:UpdateTeknikDetayOzellikDil>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateTeknikDetayOzellikDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----Etiket kısmı class----->
    <cffunction  name="SaveEtiket">
        <cfargument  name="Etiket" required="true" hint="Eklenmek istenen etiketin bilgilerini içeren Etiket sınıfı">
        <cfargument  name="ID" required="true" hint="0 girilir ise yani kayıt oluşturulur. 0 dan büyük girilirse girilen id li kayıt güncellenir.">
        <cfargument  name="Resim" hint="Etiket resmi">
        <cfargument  name="SeoAnahtarKelime" hint="Seo optimizasyonunda kullanılacak kelimeler.">
        <cfargument  name="SeoSayfaAciklama" hint="Seo optimizasyonunda kullanılacak açıklama.">
        <cfargument  name="SeoSayfaBaslik" hint="Seo optimizasyonunda kullanılacak başlık.">
        <cfargument  name="Tanim" required="true" hint="Etiket adı">
        <cfargument  name="Url" hint="Etiket url bilgisi.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveEtiket>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:etiket>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <cfif len(arguments.Resim)><ns:Resim>#arguments.Resim#</ns:Resim></cfif>
                                <cfif len(arguments.SeoAnahtarKelime)><ns:SeoAnahtarKelime>#arguments.SeoAnahtarKelime#</ns:SeoAnahtarKelime></cfif>
                                <cfif len(arguments.SeoSayfaAciklama)><ns:SeoSayfaAciklama>#arguments.SeoSayfaAciklama#</ns:SeoSayfaAciklama></cfif>
                                <cfif len(arguments.SeoSayfaBaslik)><ns:SeoSayfaBaslik>#arguments.SeoSayfaBaslik#</ns:SeoSayfaBaslik></cfif>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                <cfif len(arguments.Url)><ns:Url>#arguments.Url#</ns:Url></cfif>               
                            </tem:etiket>
                        </tem:SaveEtiket>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveEtiket"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectEtiket">
        <cfargument  name="EtiketId" required="true" hint="Getirilmek istenen etiketin id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectEtiket>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:etiketID>#arguments.EtiketId#</tem:etiketID>
                        </tem:SelectEtiket>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectEtiket"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----VaryasyonFiltre,UrunSayfalama kısımları class---->
    <cffunction  name="SelectVaryasyon">
        <cfargument  name="VaryasyonFiltre" required="true" hint="Varyasyonu filtrelerini içeren VaryasyonFiltre sınıfı.">
        <cfargument  name="Aktif" hint="Varyasyon aktiflik durumu 0=false, 1= true, 1=hepsi.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri">
        <cfargument  name="StokGuncellemeTarihiBas" hint="Stok güncelleme başlangıç tarihi.">
        <cfargument  name="StokGuncellemeTarihiSon" hint="Stok güncelleme bitiş tarihi.">
        <cfargument  name="StokKodu" hint="Stok kodu değeri.">
        <cfargument  name="UrunID" hint="Ürün id değeri.">
        <cfargument  name="UrunKartiID" hint="Ürün karti id değeri.">
        <cfargument  name="FiyatGuncellemeTarihiBas" default="">
        <cfargument  name="FiyatGuncellemeTarihiSon" default="">
        <cfargument  name="FiyatStokGuncellemeTarihiBas" default="">
        <cfargument  name="FiyatStokGuncellemeTarihiSon" default="">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="UrunIdList" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfargument  name="UrunSayfalama" required="true" hint="Ürünün sayfalama ve siralama değerlerini içeren UrunSayfalama sınıfı.">
        <cfargument  name="BaslangicIndex" default="">
        <cfargument  name="KayitSayisi" default="">
        <cfargument  name="SiralamaDegeri" default="">
        <cfargument  name="SiralamaYonu" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectVaryasyon>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:f>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <cfif len(arhguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                <cfif len(arguments.FiyatGuncellemeTarihiBas)><ns:FiyatGuncellemeTarihiBas>#arguments.FiyatGuncellemeTarihiBas#</ns:FiyatGuncellemeTarihiBas></cfif>
                                <cfif len(arguments.FiyatGuncellemeTarihiSon)><ns:FiyatGuncellemeTarihiSon>#arguments.FiyatGuncellemeTarihiSon#</ns:FiyatGuncellemeTarihiSon></cfif>
                                <cfif len(arguments.FiyatStokGuncellemeTarihiBas)><ns:FiyatStokGuncellemeTarihiBas>#arguments.FiyatStokGuncellemeTarihiBas#</ns:FiyatStokGuncellemeTarihiBas></cfif>
                                <cfif len(arguments.FiyatStokGuncellemeTarihiSon)><ns:FiyatStokGuncellemeTarihiSon>#arguments.FiyatStokGuncellemeTarihiSon#</ns:FiyatStokGuncellemeTarihiSon></cfif>
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <cfif len(arguments.StokGuncellemeTarihiBas)><ns:StokGuncellemeTarihiBas>#arguments.StokGuncellemeTarihiBas#</ns:StokGuncellemeTarihiBas></cfif>
                                <cfif len(arguments.StokGuncellemeTarihiSon)><ns:StokGuncellemeTarihiSon>#arguments.StokGuncellemeTarihiSon#</ns:StokGuncellemeTarihiSon></cfif>
                                <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                <cfif len(arguments.UrunID)><ns:UrunID>#arguments.UrunID#</ns:UrunID></cfif>
                                <ns:UrunIdList>
                                    <cfif len(arguments.UrunIdList)><arr:int>#arguments.UrunIdList#</arr:int></cfif>
                                </ns:UrunIdList>
                                <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                            </tem:f>
                            <tem:s>
                                <cfif len(arguments.BaslangicIndex)><ns:BaslangicIndex>#arguments.BaslangicIndex#</ns:BaslangicIndex></cfif>
                                <cfif len(arguments.KayitSayisi)><ns:KayitSayisi>#arguments.KayitSayisi#</ns:KayitSayisi></cfif>
                                <cfif len(arguments.SiralamaDegeri)><ns:SiralamaDegeri>#arguments.SiralamaDegeri#</ns:SiralamaDegeri></cfif>
                                <cfif len(arguments.SiralamaYonu)><ns:SiralamaYonu>#arguments.SiralamaYonu#</ns:SiralamaYonu></cfif>              
                            </tem:s>
                        </tem:SelectVaryasyon>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectVaryasyon"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----VaryasyonFiltre kısmı class---->
    <cffunction  name="SelectVaryasyonCount">
        <cfargument  name="VaryasyonFiltre" required="true" hint="Varyasyonu filtrelerini içeren VaryasyonFiltre sınıfı.">
        <cfargument  name="Aktif" hint="Varyasyon aktiflik durumu 0=false, 1= true, 1=hepsi.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri">
        <cfargument  name="StokGuncellemeTarihiBas" hint="Stok güncelleme başlangıç tarihi.">
        <cfargument  name="StokGuncellemeTarihiSon" hint="Stok güncelleme bitiş tarihi.">
        <cfargument  name="StokKodu" hint="Stok kodu değeri.">
        <cfargument  name="UrunID" hint="Ürün id değeri.">
        <cfargument  name="UrunKartiID" hint="Ürün karti id değeri.">
        <cfargument  name="FiyatGuncellemeTarihiBas" default="">
        <cfargument  name="FiyatGuncellemeTarihiSon" default="">
        <cfargument  name="FiyatStokGuncellemeTarihiBas" default="">
        <cfargument  name="FiyatStokGuncellemeTarihiSon" default="">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="UrunIdList" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectVaryasyonCount>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:f>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <cfif len(arhguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                <cfif len(arguments.FiyatGuncellemeTarihiBas)><ns:FiyatGuncellemeTarihiBas>#arguments.FiyatGuncellemeTarihiBas#</ns:FiyatGuncellemeTarihiBas></cfif>
                                <cfif len(arguments.FiyatGuncellemeTarihiSon)><ns:FiyatGuncellemeTarihiSon>#arguments.FiyatGuncellemeTarihiSon#</ns:FiyatGuncellemeTarihiSon></cfif>
                                <cfif len(arguments.FiyatStokGuncellemeTarihiBas)><ns:FiyatStokGuncellemeTarihiBas>#arguments.FiyatStokGuncellemeTarihiBas#</ns:FiyatStokGuncellemeTarihiBas></cfif>
                                <cfif len(arguments.FiyatStokGuncellemeTarihiSon)><ns:FiyatStokGuncellemeTarihiSon>#arguments.FiyatStokGuncellemeTarihiSon#</ns:FiyatStokGuncellemeTarihiSon></cfif>
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <cfif len(arguments.StokGuncellemeTarihiBas)><ns:StokGuncellemeTarihiBas>#arguments.StokGuncellemeTarihiBas#</ns:StokGuncellemeTarihiBas></cfif>
                                <cfif len(arguments.StokGuncellemeTarihiSon)><ns:StokGuncellemeTarihiSon>#arguments.StokGuncellemeTarihiSon#</ns:StokGuncellemeTarihiSon></cfif>
                                <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                <cfif len(arguments.UrunID)><ns:UrunID>#arguments.UrunID#</ns:UrunID></cfif>
                                <ns:UrunIdList>
                                    <cfif len(arguments.UrunIdList)><arr:int>#arguments.UrunIdList#</arr:int></cfif>
                                </ns:UrunIdList>
                                <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                            </tem:f>
                        </tem:SelectVaryasyonCount>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectVaryasyonCount"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----Varyasyon ve VaryasyonAyar kısımları class---->
    <cffunction  name="VaryasyonGuncelle">
        <cfargument  name="Varyasyon" required="true" hint="Varyasyonun bilgilerini içeren Varyasyon sınıfı.">
        <cfargument  name="ID" required="true" hint="0 gönderilir ise yeni varyasyon eklenir 0 dan büyük gönderilir ise gönderilen id li varyasyon güncellenir">
        <cfargument  name="AlisFiyati" hint="Varyasyona ait alis fiyatı değeri.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri.">
        <cfargument  name="Desi" hint="Varyasyon desi değeri.">
        <cfargument  name="KargoUcreti" hint="Varyasyon kargo ücreti değeri">
        <cfargument  name="KdvDahil" hint="Kdv dahil olma durumu.">
        <cfargument  name="KdvOrani" hint="Varyasyon kdv orani değeri.">
        <cfargument  name="Ozellikler" hint="Varyasyonun özellikleri.">
        <cfargument  name="ParaBirimiID" required="true" hint="Varyasyon para birimi (sitede yer alan para birimlerinden biri girilmelidir).">
        <cfargument  name="Resimler" hint="Varyasyon resimleri.">
        <cfargument  name="SatisFiyati" required="true" hint="Satış fiyati değeri.">
        <cfargument  name="StokAdedi" hint="Stok adedi değeri.">
        <cfargument  name="StokKodu" hint="Varyasyon stok kodu.">
        <cfargument  name="Aktif" hint="Varyasyonun aktif olma durumu.">
        <cfargument  name="DuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="EkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EksiStokAdedi" hint="Ayrılacak olan stok adedi.">
        <cfargument  name="IndirimliFiyati" hint="Varyasyon indirimli fiyat değeri.">
        <cfargument  name="ParaBirimi" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="ParaBirimiKodu" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="TedarikciKodu" hint="Tedarikçi koduna göre güncelle true ise zorunlu">
        <cfargument  name="UyeTipiFiyat1" hint="Üye tipi 1 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat2" hint="Üye tipi 2 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat3" hint="Üye tipi 3 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat4" hint="Üye tipi 4 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat5" hint="Üye tipi 5 e özel fiyat değeri">
        <cfargument  name="UyeTipiFiyat7" hint="Üye tipi 7 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat8" hint="Üye tipi 8 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat9" hint="Üye tipi 9 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat10" hint="Üye tipi 10 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat11" hint="Üye tipi 11 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat12" hint="Üye tipi 12 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat13" hint="Üye tipi 13 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat14" hint="Üye tipi 14 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat15" hint="Üye tipi 15 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat16" hint="Üye tipi 16 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat17" hint="Üye tipi 17 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat18" hint="Üye tipi 18 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat19" hint="Üye tipi 19 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat20" hint="Üye tipi 20 ye özel fiyat değeri.">
        <cfargument  name="Tanım" required="true" hint="Varyasyon özellik tanımı. Örn= “Renk”">
        <cfargument  name="Deger" required="true" hint="Varyasyon özellik Değer,. Örn=”Mavi”">
        
        <cfargument  name="VaryasyonAyar" required="true" hint="Hangi alanlarının güncelleneceği bilgisinin gönderildiği VaryasyonAyar sınıfı">
        <cfargument  name="AktifGuncelle">
        <cfargument  name="AlisFiyatiGuncelle">
        <cfargument  name="BarkodGuncelle">
        <cfargument  name="IndirimliFiyatiGuncelle">
        <cfargument  name="KargoUcretiGuncelle">
        <cfargument  name="KargoAgirligiGuncelle">
        <cfargument  name="ParaBirimiGuncelle">
        <cfargument  name="PiyasaFiyatiGuncelle">
        <cfargument  name="SatisFiyatiGuncelle">
        <cfargument  name="StokAdediGuncelle">
        <cfargument  name="UyeTipiFiyat1Guncelle">
        <cfargument  name="UyeTipiFiyat2Guncelle">
        <cfargument  name="UyeTipiFiyat3Guncelle">
        <cfargument  name="UyeTipiFiyat4Guncelle">
        <cfargument  name="UyeTipiFiyat5Guncelle">
        <cfargument  name="EksiStokAdediGuncelle">
        <cfargument  name="KdvDahilGuncelle">
        <cfargument  name="KdvOraniGuncelle">
        <cfargument  name="OncekiResimleriSil">
        <cfargument  name="ResimOlmayanlaraResimEkle">
        <cfargument  name="StokKoduGuncelle">
        <cfargument  name="UrunResimGuncelle">

        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="TahminiTeslimSuresiAyniGun" default="">
        <cfargument  name="TahminiTeslimSuresiGoster" default="">
        <cfargument  name="TahminiTeslimSuresiTarih" default="">
        <cfargument  name="TedarikciKodu2" default="">
        <cfargument  name="Desi2" default="">
        <cfargument  name="IndirimliFiyati1" default="">
        <cfargument  name="IndirimliFiyati2" default="">
        <cfargument  name="IndirimliFiyati3" default="">
        <cfargument  name="IndirimliFiyati4" default="">
        <cfargument  name="IndirimliFiyati5" default="">
        <cfargument  name="IndirimliFiyati6" default="">
        <cfargument  name="IndirimliFiyati7" default="">
        <cfargument  name="IndirimliFiyati8" default="">
        <cfargument  name="IndirimliFiyati9" default="">
        <cfargument  name="IndirimliFiyati10" default="">
        <cfargument  name="IndirimliFiyati11" default="">
        <cfargument  name="IndirimliFiyati12" default="">
        <cfargument  name="IndirimliFiyati13" default="">
        <cfargument  name="IndirimliFiyati14" default="">
        <cfargument  name="IndirimliFiyati15" default="">
        <cfargument  name="IndirimliFiyati16" default="">
        <cfargument  name="IndirimliFiyati17" default="">
        <cfargument  name="IndirimliFiyati18" default="">
        <cfargument  name="IndirimliFiyati19" default="">
        <cfargument  name="IndirimliFiyati20" default="">
        <cfargument  name="IscilikAgirlik" default="">
        <cfargument  name="IscilikParaBirimi" default="">
        <cfargument  name="IscilikParaBirimiId" default="">
        <cfargument  name="IscilikParaBirimiKodu" default="">
        <cfargument  name="IscilikParaBirimiGuncelle" default="">
        <cfargument  name="KdvDahil1" default="">
        <cfargument  name="KdvDahil2" default="">
        <cfargument  name="KdvDahil3" default="">
        <cfargument  name="KdvDahil4" default="">
        <cfargument  name="KdvDahil5" default="">
        <cfargument  name="KdvDahil7" default="">
        <cfargument  name="KdvDahil8" default="">
        <cfargument  name="KdvDahil9" default="">
        <cfargument  name="KdvDahil10" default="">
        <cfargument  name="KdvDahil11" default="">
        <cfargument  name="KdvDahil12" default="">
        <cfargument  name="KdvDahil13" default="">
        <cfargument  name="KdvDahil14" default="">
        <cfargument  name="KdvDahil15" default="">
        <cfargument  name="KdvDahil16" default="">
        <cfargument  name="KdvDahil17" default="">
        <cfargument  name="KdvDahil18" default="">
        <cfargument  name="KdvDahil19" default="">
        <cfargument  name="KdvDahil20" default="">
        <cfargument  name="KdvOrani1" default="">
        <cfargument  name="KdvOrani2" default="">
        <cfargument  name="KdvOrani3" default="">
        <cfargument  name="KdvOrani4" default="">
        <cfargument  name="KdvOrani5" default="">
        <cfargument  name="KdvOrani6" default="">
        <cfargument  name="KdvOrani7" default="">
        <cfargument  name="KdvOrani8" default="">
        <cfargument  name="KdvOrani9" default="">
        <cfargument  name="KdvOrani10" default="">
        <cfargument  name="KdvOrani11" default="">
        <cfargument  name="KdvOrani12" default="">
        <cfargument  name="KdvOrani13" default="">
        <cfargument  name="KdvOrani14" default="">
        <cfargument  name="KdvOrani15" default="">
        <cfargument  name="KdvOrani16" default="">
        <cfargument  name="KdvOrani17" default="">
        <cfargument  name="KdvOrani18" default="">
        <cfargument  name="KdvOrani19" default="">
        <cfargument  name="KdvOrani20" default="">
        <cfargument  name="MarkaID" default="">
        <cfargument  name="Tur" default="">
        <cfargument  name="XmlKod" default="">
        <cfargument  name="ParaBirimiKodu" default="">
        <cfargument  name="ParaBirimi1Id" default="">
        <cfargument  name="ParaBirimi2Id" default="">
        <cfargument  name="ParaBirimi3Id" default="">
        <cfargument  name="ParaBirimi4Id" default="">
        <cfargument  name="ParaBirimi5Id" default="">
        <cfargument  name="ParaBirimi6Id" default="">
        <cfargument  name="ParaBirimi7Id" default="">
        <cfargument  name="ParaBirimi8Id" default="">
        <cfargument  name="ParaBirimi9Id" default="">
        <cfargument  name="ParaBirimi10Id" default="">
        <cfargument  name="ParaBirimi11Id" default="">
        <cfargument  name="ParaBirimi12Id" default="">
        <cfargument  name="ParaBirimi13Id" default="">
        <cfargument  name="ParaBirimi14Id" default="">
        <cfargument  name="ParaBirimi15Id" default="">
        <cfargument  name="ParaBirimi16Id" default="">
        <cfargument  name="ParaBirimi17Id" default="">
        <cfargument  name="ParaBirimi18Id" default="">
        <cfargument  name="ParaBirimi19Id" default="">
        <cfargument  name="ParaBirimi20Id" default="">
        <cfargument  name="SatisFiyati1" default="">
        <cfargument  name="SatisFiyati2" default="">
        <cfargument  name="SatisFiyati3" default="">
        <cfargument  name="SatisFiyati4" default="">
        <cfargument  name="SatisFiyati5" default="">
        <cfargument  name="SatisFiyati6" default="">
        <cfargument  name="SatisFiyati7" default="">
        <cfargument  name="SatisFiyati8" default="">
        <cfargument  name="SatisFiyati9" default="">
        <cfargument  name="SatisFiyati10" default="">
        <cfargument  name="SatisFiyati11" default="">
        <cfargument  name="SatisFiyati12" default="">
        <cfargument  name="SatisFiyati13" default="">
        <cfargument  name="SatisFiyati14" default="">
        <cfargument  name="SatisFiyati15" default="">
        <cfargument  name="SatisFiyati16" default="">
        <cfargument  name="SatisFiyati17" default="">
        <cfargument  name="SatisFiyati18" default="">
        <cfargument  name="SatisFiyati19" default="">
        <cfargument  name="SatisFiyati20" default="">
        <cfargument  name="StokGuncellemeTarihi" default="">
        <cfargument  name="UpdateKey" default="">
        <cfargument  name="UrunAgirligi" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfargument  name="TahminiTeslimSuresiGosterGuncelle" default="">
        <cfargument  name="TahminiTeslimSuresiTarihGuncelle" default="">
        <cfargument  name="EkSecenekGuncelle" default="">
        <cfargument  name="FiyatTipleriGuncelle" default="">
        <cfargument  name="IscilikAgirlikGuncelle" default="">
        <cfargument  name="KargoAgirligiYurtDisiGuncelle" default="">
        <cfargument  name="KonsinyeUrunStokAdediGuncelle" default="">
        <cfargument name="TahminiTeslimSuresiAyniGunGuncelle" default="">
        <cfargument  name="UpdateKeyGuncelle" default="">
        <cfargument  name="UrunAgirligiGuncelle" default="">

        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:VaryasyonGuncelle>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:urun>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <cfif len(arguments.AlisFiyati)><ns:AlisFiyati>#arguments.AlisFiyati#</ns:AlisFiyati></cfif>
                                <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                <ns:Barkodlar>
                                    <cfif len(arguments.Barkod)><arr:string>#arguments.Barkod#</arr:string></cfif>
                                </ns:Barkodlar>
                                <cfif len(arguments.Desi)><ns:Desi>#arguments.Desi#</ns:Desi></cfif>
                                <cfif len(arguments.Desi2)><ns:Desi2>#arguments.Desi2#</ns:Desi2></cfif>
                                <cfif len(arguments.DuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.DuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                <cfif len(arguments.EkleyenKullanici)><ns:EkleyenKullanici>#arguments.EkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                <cfif len(arguments.EksiStokAdedi)><ns:EksiStokAdedi>#arguments.EksiStokAdedi#</ns:EksiStokAdedi></cfif>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <cfif len(arguments.IndirimliFiyati)><ns:IndirimliFiyati>#arguments.IndirimliFiyati#</ns:IndirimliFiyati></cfif>
                                <cfif len(arguments.IndirimliFiyati1)><ns:IndirimliFiyati1>#arguments.IndirimliFiyati1#</ns:IndirimliFiyati1></cfif>
                                <cfif len(arguments.IndirimliFiyati10)><ns:IndirimliFiyati10>#arguments.IndirimliFiyati10#</ns:IndirimliFiyati10></cfif>
                                <cfif len(arguments.IndirimliFiyati11)><ns:IndirimliFiyati11>#arguments.IndirimliFiyati11#</ns:IndirimliFiyati11></cfif>
                                <cfif len(arguments.IndirimliFiyati12)><ns:IndirimliFiyati12>#arguments.IndirimliFiyati12#</ns:IndirimliFiyati12></cfif>
                                <cfif len(arguments.IndirimliFiyati13)><ns:IndirimliFiyati13>#arguments.IndirimliFiyati13#</ns:IndirimliFiyati13></cfif>
                                <cfif len(arguments.IndirimliFiyati14)><ns:IndirimliFiyati14>#arguments.IndirimliFiyati14#</ns:IndirimliFiyati14></cfif>
                                <cfif len(arguments.IndirimliFiyati15)><ns:IndirimliFiyati15>#arguments.IndirimliFiyati15#</ns:IndirimliFiyati15></cfif>
                                <cfif len(arguments.IndirimliFiyati16)><ns:IndirimliFiyati16>#arguments.IndirimliFiyati16#</ns:IndirimliFiyati16></cfif>
                                <cfif len(arguments.IndirimliFiyati17)><ns:IndirimliFiyati17>#arguments.IndirimliFiyati17#</ns:IndirimliFiyati17></cfif>
                                <cfif len(arguments.IndirimliFiyati18)><ns:IndirimliFiyati18>#arguments.IndirimliFiyati18#</ns:IndirimliFiyati18></cfif>
                                <cfif len(arguments.IndirimliFiyati19)><ns:IndirimliFiyati19>#arguments.IndirimliFiyati19#</ns:IndirimliFiyati19></cfif>
                                <cfif len(arguments.IndirimliFiyati2)><ns:IndirimliFiyati2>#arguments.IndirimliFiyati2#</ns:IndirimliFiyati2></cfif>
                                <cfif len(arguments.IndirimliFiyati20)><ns:IndirimliFiyati20>#arguments.IndirimliFiyati20#</ns:IndirimliFiyati20></cfif>
                                <cfif len(arguments.IndirimliFiyati3)><ns:IndirimliFiyati3>#arguments.IndirimliFiyati3#</ns:IndirimliFiyati3></cfif>
                                <cfif len(arguments.IndirimliFiyati4)><ns:IndirimliFiyati4>#arguments.IndirimliFiyati4#</ns:IndirimliFiyati4></cfif>
                                <cfif len(arguments.IndirimliFiyati5)><ns:IndirimliFiyati5>#arguments.IndirimliFiyati5#</ns:IndirimliFiyati5></cfif>
                                <cfif len(arguments.IndirimliFiyati6)><ns:IndirimliFiyati6>#arguments.IndirimliFiyati6#</ns:IndirimliFiyati6></cfif>
                                <cfif len(arguments.IndirimliFiyati7)><ns:IndirimliFiyati7>#arguments.IndirimliFiyati7#</ns:IndirimliFiyati7></cfif>
                                <cfif len(arguments.IndirimliFiyati8)><ns:IndirimliFiyati8>#arguments.IndirimliFiyati8#</ns:IndirimliFiyati8></cfif>
                                <cfif len(arguments.IndirimliFiyati9)><ns:IndirimliFiyati9>#arguments.IndirimliFiyati9#</ns:IndirimliFiyati9></cfif>
                                <cfif len(arguments.IscilikAgirlik)><ns:IscilikAgirlik>#arguments.IscilikAgirlik#</ns:IscilikAgirlik></cfif>
                                <cfif len(arguments.IscilikParaBirimi)><ns:IscilikParaBirimi>#arguments.IscilikParaBirimi#</ns:IscilikParaBirimi></cfif>
                                <cfif len(arguments.IscilikParaBirimiId)><ns:IscilikParaBirimiId>#arguments.IscilikParaBirimiId#</ns:IscilikParaBirimiId></cfif>
                                <cfif len(arguments.IscilikParaBirimiKodu)><ns:IscilikParaBirimiKodu>#arguments.IscilikParaBirimiKodu#</ns:IscilikParaBirimiKodu></cfif>
                                <cfif len(arguments.KargoUcreti)><ns:KargoUcreti>#arguments.KargoUcreti#</ns:KargoUcreti></cfif>
                                <ns:Kategoriler>
                                    <arr:int>#arguments.Kategoriler#</arr:int>
                                </ns:Kategoriler>
                                <cfif len(arguments.KdvDahil)><ns:KdvDahil>#arguments.KdvDahil#</ns:KdvDahil></cfif>
                                <cfif len(arguments.KdvDahil1)><ns:KdvDahil1>?#arguments.KdvDahil1#</ns:KdvDahil1></cfif>
                                <cfif len(arguments.KdvDahil10)><ns:KdvDahil10>#arguments.KdvDahil10#</ns:KdvDahil10></cfif>
                                <cfif len(arguments.KdvDahil11)><ns:KdvDahil11>#arguments.KdvDahil11#</ns:KdvDahil11></cfif>
                                <cfif len(arguments.KdvDahil12)><ns:KdvDahil12>#arguments.KdvDahil12#</ns:KdvDahil12></cfif>
                                <cfif len(arguments.KdvDahil13)><ns:KdvDahil13>#arguments.KdvDahil13#</ns:KdvDahil13></cfif>
                                <cfif len(arguments.KdvDahil14)><ns:KdvDahil14>#arguments.KdvDahil14#</ns:KdvDahil14></cfif>
                                <cfif len(arguments.KdvDahil15)><ns:KdvDahil15>#arguments.KdvDahil15#</ns:KdvDahil15></cfif>
                                <cfif len(arguments.KdvDahil16)><ns:KdvDahil16>#arguments.KdvDahil16#</ns:KdvDahil16></cfif>
                                <cfif len(arguments.KdvDahil17)><ns:KdvDahil17>#arguments.KdvDahil17#</ns:KdvDahil17></cfif>
                                <cfif len(arguments.KdvDahil18)><ns:KdvDahil18>#arguments.KdvDahil18#</ns:KdvDahil18></cfif>
                                <cfif len(arguments.KdvDahil19)><ns:KdvDahil19>#arguments.KdvDahil19#</ns:KdvDahil19></cfif>
                                <cfif len(arguments.KdvDahil2)><ns:KdvDahil2>#arguments.KdvDahil2#</ns:KdvDahil2></cfif>
                                <cfif len(arguments.KdvDahil20)><ns:KdvDahil20>#arguments.KdvDahil20#</ns:KdvDahil20></cfif>
                                <cfif len(arguments.KdvDahil3)><ns:KdvDahil3>#arguments.KdvDahil3#</ns:KdvDahil3></cfif>
                                <cfif len(arguments.KdvDahil4)><ns:KdvDahil4>#arguments.KdvDahil4#</ns:KdvDahil4></cfif>
                                <cfif len(arguments.KdvDahil5)><ns:KdvDahil5>#arguments.KdvDahil5#</ns:KdvDahil5></cfif>
                                <cfif len(arguments.KdvDahil6)><ns:KdvDahil6>#arguments.KdvDahil6#</ns:KdvDahil6></cfif>
                                <cfif len(arguments.KdvDahil7)><ns:KdvDahil7>#arguments.KdvDahil7#</ns:KdvDahil7></cfif>
                                <cfif len(arguments.KdvDahil8)><ns:KdvDahil8>#arguments.KdvDahil8#</ns:KdvDahil8></cfif>
                                <cfif len(arguments.KdvDahil9)><ns:KdvDahil9>#arguments.KdvDahil9#</ns:KdvDahil9></cfif>
                                <cfif len(arguments.KdvOrani)><ns:KdvOrani>#arguments.KdvOrani#</ns:KdvOrani></cfif>
                                <cfif len(arguments.KdvOrani1)><ns:KdvOrani1>#arguments.KdvOrani1#</ns:KdvOrani1></cfif>
                                <cfif len(arguments.KdvOrani10)><ns:KdvOrani10>#arguments.KdvOrani10#</ns:KdvOrani10></cfif>
                                <cfif len(arguments.KdvOrani11)><ns:KdvOrani11>#arguments.KdvOrani11#</ns:KdvOrani11></cfif>
                                <cfif len(arguments.KdvOrani12)><ns:KdvOrani12>#arguments.KdvOrani12#</ns:KdvOrani12></cfif>
                                <cfif len(arguments.KdvOrani13)><ns:KdvOrani13>#arguments.KdvOrani13#</ns:KdvOrani13></cfif>
                                <cfif len(arguments.KdvOrani14)><ns:KdvOrani14>#arguments.KdvOrani14#</ns:KdvOrani14></cfif>
                                <cfif len(arguments.KdvOrani15)><ns:KdvOrani15>#arguments.KdvOrani15#</ns:KdvOrani15></cfif>
                                <cfif len(arguments.KdvOrani16)><ns:KdvOrani16>#arguments.KdvOrani16#</ns:KdvOrani16></cfif>
                                <cfif len(arguments.KdvOrani17)><ns:KdvOrani17>#arguments.KdvOrani17#</ns:KdvOrani17></cfif>
                                <cfif len(arguments.KdvOrani18)><ns:KdvOrani18>#arguments.KdvOrani18#</ns:KdvOrani18></cfif>
                                <cfif len(arguments.KdvOrani19)><ns:KdvOrani19>#arguments.KdvOrani19#</ns:KdvOrani19></cfif>
                                <cfif len(arguments.KdvOrani2)><ns:KdvOrani2>#arguments.KdvOrani2#</ns:KdvOrani2></cfif>
                                <cfif len(arguments.KdvOrani20)><ns:KdvOrani20>#arguments.KdvOrani20#</ns:KdvOrani20></cfif>
                                <cfif len(arguments.KdvOrani3)><ns:KdvOrani3>#arguments.KdvOrani3#</ns:KdvOrani3></cfif>
                                <cfif len(arguments.KdvOrani4)><ns:KdvOrani4>#arguments.KdvOrani4#</ns:KdvOrani4></cfif>
                                <cfif len(arguments.KdvOrani5)><ns:KdvOrani5>#arguments.KdvOrani5#</ns:KdvOrani5></cfif>
                                <cfif len(arguments.KdvOrani6)><ns:KdvOrani6>#arguments.KdvOrani6#</ns:KdvOrani6></cfif>
                                <cfif len(arguments.KdvOrani7)><ns:KdvOrani7>#arguments.KdvOrani7#</ns:KdvOrani7></cfif>
                                <cfif len(arguments.KdvOrani8)><ns:KdvOrani8>#arguments.KdvOrani8#</ns:KdvOrani8></cfif>
                                <cfif len(arguments.KdvOrani9)><ns:KdvOrani9>#arguments.KdvOrani9#</ns:KdvOrani9></cfif>
                                <cfif len(arguments.MarkaID)><ns:MarkaID>#arguments.MarkaID#</ns:MarkaID></cfif>
                                <!-----buralardaki marketplaceaktif kısımları varyasyon için geçerli bunlar varyasyon olarak tanımlanmalı mı yoksa bu şekilde devam mı?---->
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <ns:Ozellikler>
                                    <ns:VaryasyonOzellik>
                                    <ns:Deger>#arguments.Deger#</ns:Deger>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                    <cfif len(arguments.Tur)><ns:Tur>#arguments.Tur#</ns:Tur></cfif>
                                    <cfif len(arguments.XmlKod)><ns:XmlKod>#arguments.XmlKod#</ns:XmlKod></cfif>
                                    </ns:VaryasyonOzellik>
                                </ns:Ozellikler>
                                <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                <cfif len(arguments.ParaBirimi10Id)><ns:ParaBirimi10Id>#arguments.ParaBirimi10Id#</ns:ParaBirimi10Id></cfif>                    
                                <cfif len(arguments.ParaBirimi11Id)><ns:ParaBirimi11Id>#arguments.ParaBirimi11Id#</ns:ParaBirimi11Id></cfif>
                                <cfif len(arguments.ParaBirimi12Id)><ns:ParaBirimi12Id>#arguments.ParaBirimi12Id#</ns:ParaBirimi12Id></cfif>
                                <cfif len(arguments.ParaBirimi13Id)><ns:ParaBirimi13Id>#arguments.ParaBirimi13Id#</ns:ParaBirimi13Id></cfif>
                                <cfif len(arguments.ParaBirimi14Id)><ns:ParaBirimi14Id>#arguments.ParaBirimi14Id#</ns:ParaBirimi14Id></cfif>
                                <cfif len(arguments.ParaBirimi15Id)><ns:ParaBirimi15Id>#arguments.ParaBirimi15Id#</ns:ParaBirimi15Id></cfif>
                                <cfif len(arguments.ParaBirimi16Id)><ns:ParaBirimi16Id>#arguments.ParaBirimi16Id#</ns:ParaBirimi16Id></cfif>
                                <cfif len(arguments.ParaBirimi17Id)><ns:ParaBirimi17Id>#arguments.ParaBirimi17Id#</ns:ParaBirimi17Id></cfif>
                                <cfif len(arguments.ParaBirimi18Id)><ns:ParaBirimi18Id>#arguments.ParaBirimi18Id#</ns:ParaBirimi18Id></cfif>
                                <cfif len(arguments.ParaBirimi19Id)><ns:ParaBirimi19Id>#arguments.ParaBirimi19Id#</ns:ParaBirimi19Id></cfif>
                                <cfif len(arguments.ParaBirimi1Id)><ns:ParaBirimi1Id>#arguments.ParaBirimi1Id#</ns:ParaBirimi1Id></cfif>
                                <cfif len(arguments.ParaBirimi20Id)><ns:ParaBirimi20Id>#arguments.ParaBirimi20Id#</ns:ParaBirimi20Id></cfif>
                                <cfif len(arguments.ParaBirimi2Id)><ns:ParaBirimi2Id>#arguments.ParaBirimi2Id#</ns:ParaBirimi2Id></cfif>
                                <cfif len(arguments.ParaBirimi3Id)><ns:ParaBirimi3Id>#arguments.ParaBirimi3Id#</ns:ParaBirimi3Id></cfif>
                                <cfif len(arguments.ParaBirimi4Id)><ns:ParaBirimi4Id>#arguments.ParaBirimi4Id#</ns:ParaBirimi4Id></cfif>
                                <cfif len(arguments.ParaBirimi5Id)><ns:ParaBirimi5Id>#arguments.ParaBirimi5Id#</ns:ParaBirimi5Id></cfif>
                                <cfif len(arguments.ParaBirimi6Id)><ns:ParaBirimi6Id>#arguments.ParaBirimi6Id#</ns:ParaBirimi6Id></cfif>
                                <cfif len(arguments.ParaBirimi7Id)><ns:ParaBirimi7Id>#arguments.ParaBirimi7Id#</ns:ParaBirimi7Id></cfif>
                                <cfif len(arguments.ParaBirimi8Id)><ns:ParaBirimi8Id>#arguments.ParaBirimi8Id#</ns:ParaBirimi8Id></cfif>
                                <cfif len(arguments.ParaBirimi9Id)><ns:ParaBirimi9Id>#arguments.ParaBirimi9Id#</ns:ParaBirimi9Id></cfif>
                                <ns:ParaBirimiID>#arguments.ParaBirimiID#</ns:ParaBirimiID>
                                <cfif len(arguments.ParaBirimiKodu)><ns:ParaBirimiKodu>#arguments.ParaBirimiKodu#</ns:ParaBirimiKodu></cfif>                    
                                <ns:Resimler>
                                    <cfif len(arguments.Resimler)><arr:string>#arguments.Resimler#</arr:string></cfif>
                                </ns:Resimler>
                                <ns:SatisFiyati>#arguments.VaryasyonSatisFiyati#</ns:SatisFiyati>
                                <cfif len(arguments.SatisFiyati1)><ns:SatisFiyati1>#arguments.SatisFiyati1#</ns:SatisFiyati1></cfif>
                                <cfif len(arguments.SatisFiyati10)><ns:SatisFiyati10>#arguments.SatisFiyati10#</ns:SatisFiyati10></cfif>
                                <cfif len(arguments.SatisFiyati11)><ns:SatisFiyati11>#arguments.SatisFiyati11#</ns:SatisFiyati11></cfif>
                                <cfif len(arguments.SatisFiyati12)><ns:SatisFiyati12>#arguments.SatisFiyati12#</ns:SatisFiyati12></cfif>
                                <cfif len(arguments.SatisFiyati13)><ns:SatisFiyati13>#arguments.SatisFiyati13#</ns:SatisFiyati13></cfif>
                                <cfif len(arguments.SatisFiyati14)><ns:SatisFiyati14>#arguments.SatisFiyati14#</ns:SatisFiyati14></cfif>
                                <cfif len(arguments.SatisFiyati15)><ns:SatisFiyati15>#arguments.SatisFiyati15#</ns:SatisFiyati15></cfif>
                                <cfif len(arguments.SatisFiyati16)><ns:SatisFiyati16>#arguments.SatisFiyati16#</ns:SatisFiyati16></cfif>
                                <cfif len(arguments.SatisFiyati17)><ns:SatisFiyati17>#arguments.SatisFiyati17#</ns:SatisFiyati17></cfif>
                                <cfif len(arguments.SatisFiyati18)><ns:SatisFiyati18>#arguments.SatisFiyati18#</ns:SatisFiyati18></cfif>
                                <cfif len(arguments.SatisFiyati19)><ns:SatisFiyati19>#arguments.SatisFiyati19#</ns:SatisFiyati19></cfif>
                                <cfif len(arguments.SatisFiyati2)><ns:SatisFiyati2>#arguments.SatisFiyati2#</ns:SatisFiyati2></cfif>
                                <cfif len(arguments.SatisFiyati20)><ns:SatisFiyati20>#arguments.SatisFiyati20#</ns:SatisFiyati20></cfif>
                                <cfif len(arguments.SatisFiyati3)><ns:SatisFiyati3>#arguments.SatisFiyati3#</ns:SatisFiyati3></cfif>
                                <cfif len(arguments.SatisFiyati4)><ns:SatisFiyati4>#arguments.SatisFiyati4#</ns:SatisFiyati4></cfif>
                                <cfif len(arguments.SatisFiyati5)><ns:SatisFiyati5>#arguments.SatisFiyati5#</ns:SatisFiyati5></cfif>
                                <cfif len(arguments.SatisFiyati6)><ns:SatisFiyati6>#arguments.SatisFiyati6#</ns:SatisFiyati6></cfif>
                                <cfif len(arguments.SatisFiyati7)><ns:SatisFiyati7>#arguments.SatisFiyati7#</ns:SatisFiyati7></cfif>
                                <cfif len(arguments.SatisFiyati8)<ns:SatisFiyati8>#arguments.SatisFiyati8#</ns:SatisFiyati8></cfif>
                                <cfif len(arguments.SatisFiyati9)><ns:SatisFiyati9>#arguments.SatisFiyati9#</ns:SatisFiyati9></cfif>
                                <cfif len(arguments.StokAdedi)><ns:StokAdedi>#arguments.StokAdedi#</ns:StokAdedi></cfif>
                                <cfif len(arguments.StokGuncellemeTarihi)><ns:StokGuncellemeTarihi>#arguments.StokGuncellemeTarihi#</ns:StokGuncellemeTarihi></cfif>
                                <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                <!-----tahmini teslim süresi yukarıda ürün için tanımlanmış varyasyon için tanımlayıp onu mu almam gerekiyor yoksa aynı argumentden devam mı şu an yaptığım aynısı ------>
                                <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                <cfif len(arguments.TedarikciKodu)><ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu></cfif>
                                <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                <cfif len(arguments.UpdateKey)><ns:UpdateKey>#arguments.UpdateKey#</ns:UpdateKey></cfif>
                                <cfif len(arguemnts.UrunAgirligi)><ns:UrunAgirligi>#arguments.UrunAgirligi#</ns:UrunAgirligi></cfif>
                                <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                <cfif len(arguments.UyeTipiFiyat1)><ns:UyeTipiFiyat1>#arguments.UyeTipiFiyat1#</ns:UyeTipiFiyat1></cfif>
                                <cfif len(arguments.UyeTipiFiyat10)><ns:UyeTipiFiyat10>#arguments.UyeTipiFiyat10#</ns:UyeTipiFiyat10></cfif>
                                <cfif len(arguments.UyeTipiFiyat11)><ns:UyeTipiFiyat11>#arguments.UyeTipiFiyat11#</ns:UyeTipiFiyat11></cfif>
                                <cfif len(arguments.UyeTipiFiyat12)><ns:UyeTipiFiyat12>#arguments.UyeTipiFiyat12#</ns:UyeTipiFiyat12></cfif>
                                <cfif len(arguments.UyeTipiFiyat13)><ns:UyeTipiFiyat13>#arguments.UyeTipiFiyat13#</ns:UyeTipiFiyat13></cfif>
                                <cfif len(arguments.UyeTipiFiyat14)><ns:UyeTipiFiyat14>#arguments.UyeTipiFiyat14#</ns:UyeTipiFiyat14></cfif>
                                <cfif len(arguments.UyeTipiFiyat15)><ns:UyeTipiFiyat15>#arguments.UyeTipiFiyat15#</ns:UyeTipiFiyat15></cfif>
                                <cfif len(arguments.UyeTipiFiyat16)><ns:UyeTipiFiyat16>#arguments.UyeTipiFiyat16#</ns:UyeTipiFiyat16></cfif>
                                <cfif len(arguments.UyeTipiFiyat17)><ns:UyeTipiFiyat17>#arguments.UyeTipiFiyat17#</ns:UyeTipiFiyat17></cfif>
                                <cfif len(arguments.UyeTipiFiyat18)><ns:UyeTipiFiyat18>#arguments.UyeTipiFiyat18#</ns:UyeTipiFiyat18></cfif>
                                <cfif len(arguments.UyeTipiFiyat19)><ns:UyeTipiFiyat19>#arguments.UyeTipiFiyat19#</ns:UyeTipiFiyat19></cfif>
                                <cfif len(arguments.UyeTipiFiyat2)><ns:UyeTipiFiyat2>#arguments.UyeTipiFiyat2#</ns:UyeTipiFiyat2></cfif>
                                <cfif len(arguments.UyeTipiFiyat20)><ns:UyeTipiFiyat20>#arguments.UyeTipiFiyat20#</ns:UyeTipiFiyat20></cfif>
                                <cfif len(arguments.UyeTipiFiyat3)><ns:UyeTipiFiyat3>#arguments.UyeTipiFiyat3#</ns:UyeTipiFiyat3></cfif>
                                <cfif len(arguments.UyeTipiFiyat4)><ns:UyeTipiFiyat4>#arguments.UyeTipiFiyat4#</ns:UyeTipiFiyat4></cfif>
                                <cfif len(arguments.UyeTipiFiyat5)><ns:UyeTipiFiyat5>#arguments.UyeTipiFiyat5#</ns:UyeTipiFiyat5></cfif>
                                <cfif len(arguments.UyeTipiFiyat6)><ns:UyeTipiFiyat6>#arguments.UyeTipiFiyat6#</ns:UyeTipiFiyat6></cfif>
                                <cfif len(arguments.UyeTipiFiyat7)><ns:UyeTipiFiyat7>#arguments.UyeTipiFiyat7#</ns:UyeTipiFiyat7></cfif>
                                <cfif len(arguments.UyeTipiFiyat8)><ns:UyeTipiFiyat8>#arguments.UyeTipiFiyat8#</ns:UyeTipiFiyat8></cfif>
                                <cfif len(arguments.UyeTipiFiyat9)><ns:UyeTipiFiyat9>#arguments.UyeTipiFiyat9#</ns:UyeTipiFiyat9></cfif>
                            </tem:urun>
                            <tem:ayar>
                                <cfif len(arguments.AktifGuncelle)><ns:AktifGuncelle>#arguments.AktifGuncelle#</ns:AktifGuncelle></cfif>
                                <cfif len(arguments.AlisFiyatiGuncelle)><ns:AlisFiyatiGuncelle>#arguments.AlisFiyatiGuncelle#</ns:AlisFiyatiGuncelle></cfif>
                                <cfif len(arguments.BarkodGuncelle)><ns:BarkodGuncelle>#arguments.BarkodGuncelle#</ns:BarkodGuncelle></cfif>
                                <cfif len(arguments.EkSecenekGuncelle)><ns:EkSecenekGuncelle>#arguments.EkSecenekGuncelle#</ns:EkSecenekGuncelle></cfif>
                                <cfif len(arguemnts.EksiStokAdediGuncelle)><ns:EksiStokAdediGuncelle>#arguments.EksiStokAdediGuncelle#</ns:EksiStokAdediGuncelle></cfif>
                                <cfif len(arguments.FiyatTipleriGuncelle)><ns:FiyatTipleriGuncelle>#arguments.FiyatTipleriGuncelle#</ns:FiyatTipleriGuncelle></cfif>
                                <cfif len(arguments.IndirimliFiyatiGuncelle)><ns:IndirimliFiyatiGuncelle>#arguments.IndirimliFiyatiGuncelle#</ns:IndirimliFiyatiGuncelle></cfif>
                                <cfif len(arguments.IscilikAgirlikGuncelle)><ns:IscilikAgirlikGuncelle>#arguments.IscilikAgirlikGuncelle#</ns:IscilikAgirlikGuncelle></cfif>
                                <cfif len(arguments.IscilikParaBirimiGuncelle)><ns:IscilikParaBirimiGuncelle>#arguments.IscilikParaBirimiGuncelle#</ns:IscilikParaBirimiGuncelle></cfif>
                                <cfif len(arguments.KargoAgirligiGuncelle)><ns:KargoAgirligiGuncelle>#arguments.KargoAgirligiGuncelle#</ns:KargoAgirligiGuncelle></cfif>
                                <cfif len(arguments.KargoAgirligiYurtDisiGuncelle)><ns:KargoAgirligiYurtDisiGuncelle>#arguments.KargoAgirligiYurtDisiGuncelle#</ns:KargoAgirligiYurtDisiGuncelle></cfif>
                                <cfif len(arguments.KargoUcretiGuncelle)><ns:KargoUcretiGuncelle>#arguments.KargoUcretiGuncelle#</ns:KargoUcretiGuncelle></cfif>
                                <cfif len(arguments.KdvDahilGuncelle)><ns:KdvDahilGuncelle>#arguments.KdvDahilGuncelle#</ns:KdvDahilGuncelle></cfif>
                                <cfif len(arguments.KdvOraniGuncelle)><ns:KdvOraniGuncelle>#arguments.KdvOraniGuncelle#</ns:KdvOraniGuncelle></cfif>
                                <cfif len(arguments.KonsinyeUrunStokAdediGuncelle)><ns:KonsinyeUrunStokAdediGuncelle>#arguments.KonsinyeUrunStokAdediGuncelle#</ns:KonsinyeUrunStokAdediGuncelle></cfif>
                                <cfif len(arguments.OncekiResimleriSil)><ns:OncekiResimleriSil>#arguments.OncekiResimleriSil#</ns:OncekiResimleriSil></cfif>
                                <cfif len(arguments.ParaBirimiGuncelle)><ns:ParaBirimiGuncelle>#arguments.ParaBirimiGuncelle#</ns:ParaBirimiGuncelle></cfif>
                                <cfif len(arguments.ResimOlmayanlaraResimEkle)><ns:ResimOlmayanlaraResimEkle>#arguments.ResimOlmayanlaraResimEkle#</ns:ResimOlmayanlaraResimEkle></cfif>
                                <cfif len(arguments.SatisFiyatiGuncelle)><ns:SatisFiyatiGuncelle>#arguments.SatisFiyatiGuncelle#</ns:SatisFiyatiGuncelle></cfif>
                                <cfif len(arguments.StokAdediGuncelle)><ns:StokAdediGuncelle>#arguments.StokAdediGuncelle#</ns:StokAdediGuncelle></cfif>
                                <cfif len(arguments.StokKoduGuncelle)><ns:StokKoduGuncelle>#arguments.StokKoduGuncelle#</ns:StokKoduGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGunGuncelle)><ns:TahminiTeslimSuresiAyniGunGuncelle>#arguments.TahminiTeslimSuresiAyniGunGuncelle#</ns:TahminiTeslimSuresiAyniGunGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGosterGuncelle)><ns:TahminiTeslimSuresiGosterGuncelle>#arguments.TahminiTeslimSuresiGosterGuncelle#</ns:TahminiTeslimSuresiGosterGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGuncelle)><ns:TahminiTeslimSuresiGuncelle>#arguments.TahminiTeslimSuresiGuncelle#</ns:TahminiTeslimSuresiGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarihGuncelle)><ns:TahminiTeslimSuresiTarihGuncelle>#arguments.TahminiTeslimSuresiTarihGuncelle#</ns:TahminiTeslimSuresiTarihGuncelle></cfif>
                                <cfif len(arguments.TedarikciKodunaGoreGuncelle)><ns:TedarikciKodunaGoreGuncelle>#arguments.TedarikciKodunaGoreGuncelle#</ns:TedarikciKodunaGoreGuncelle></cfif>
                                <cfif len(arguments.UpdateKeyGuncelle)><ns:UpdateKeyGuncelle>#arguments.UpdateKeyGuncelle#</ns:UpdateKeyGuncelle></cfif>
                                <cfif len(arguments.UrunAgirligiGuncelle)><ns:UrunAgirligiGuncelle>#arguments.UrunAgirligiGuncelle#</ns:UrunAgirligiGuncelle></cfif>
                                <cfif len(arguments.UrunResimGuncelle)><ns:UrunResimGuncelle>#arguments.UrunResimGuncelle#</ns:UrunResimGuncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat10Guncelle)><ns:UyeTipiFiyat10Guncelle>#arguments.UyeTipiFiyat10Guncelle#</ns:UyeTipiFiyat10Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat11Guncelle)><ns:UyeTipiFiyat11Guncelle>#arguments.UyeTipiFiyat11Guncelle#</ns:UyeTipiFiyat11Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat12Guncelle)><ns:UyeTipiFiyat12Guncelle>#arguments.UyeTipiFiyat12Guncelle#</ns:UyeTipiFiyat12Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat13Guncelle)><ns:UyeTipiFiyat13Guncelle>#arguments.UyeTipiFiyat13Guncelle#</ns:UyeTipiFiyat13Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat14Guncelle)><ns:UyeTipiFiyat14Guncelle>#arguments.UyeTipiFiyat14Guncelle#</ns:UyeTipiFiyat14Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat15Guncelle)><ns:UyeTipiFiyat15Guncelle>#arguments.UyeTipiFiyat15Guncelle#</ns:UyeTipiFiyat15Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat16Guncelle)><ns:UyeTipiFiyat16Guncelle>#arguments.UyeTipiFiyat16Guncelle#</ns:UyeTipiFiyat16Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat17Guncelle)><ns:UyeTipiFiyat17Guncelle>#arguments.UyeTipiFiyat17Guncelle#</ns:UyeTipiFiyat17Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat18Guncelle)><ns:UyeTipiFiyat18Guncelle>#arguments.UyeTipiFiyat18Guncelle#</ns:UyeTipiFiyat18Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat19Guncelle)><ns:UyeTipiFiyat19Guncelle>#arguments.UyeTipiFiyat19Guncelle#</ns:UyeTipiFiyat19Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat1Guncelle)><ns:UyeTipiFiyat1Guncelle>#arguments.UyeTipiFiyat1Guncelle#</ns:UyeTipiFiyat1Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat20Guncelle)><ns:UyeTipiFiyat20Guncelle>#arguments.UyeTipiFiyat20Guncelle#</ns:UyeTipiFiyat20Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat2Guncelle)><ns:UyeTipiFiyat2Guncelle>#arguments.UyeTipiFiyat2Guncelle#</ns:UyeTipiFiyat2Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat3Guncelle)><ns:UyeTipiFiyat3Guncelle>#arguments.UyeTipiFiyat3Guncelle#</ns:UyeTipiFiyat3Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat4Guncelle)><ns:UyeTipiFiyat4Guncelle>#arguments.UyeTipiFiyat4Guncelle#</ns:UyeTipiFiyat4Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat5Guncelle)><ns:UyeTipiFiyat5Guncelle>#arguments.UyeTipiFiyat5Guncelle#</ns:UyeTipiFiyat5Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat6Guncelle)><ns:UyeTipiFiyat6Guncelle>#arguments.UyeTipiFiyat6Guncelle#</ns:UyeTipiFiyat6Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat7Guncelle)><ns:UyeTipiFiyat7Guncelle>#arguments.UyeTipiFiyat7Guncelle#</ns:UyeTipiFiyat7Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat8Guncelle)><ns:UyeTipiFiyat8Guncelle>#arguments.UyeTipiFiyat8Guncelle#</ns:UyeTipiFiyat8Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat9Guncelle)><ns:UyeTipiFiyat9Guncelle>#arguments.UyeTipiFiyat9Guncelle#</ns:UyeTipiFiyat9Guncelle></cfif>
                            </tem:ayar>
                        </tem:VaryasyonGuncelle>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/VaryasyonGuncelle"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!----Varyasyonlar kısmı liste Ayar kısmı class---->
    <cffunction  name="SaveVaryasyon">
        <cfargument  name="Varyasyonlar" required="true" hint="Varyasyonları içeren varyasyon sınıfı listesi">
        <cfargument  name="ID" required="true" hint="0 gönderilir ise yeni varyasyon eklenir 0 dan büyük gönderilir ise gönderilen id li varyasyon güncellenir">
        <cfargument  name="AlisFiyati" hint="Varyasyona ait alis fiyatı değeri.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri.">
        <cfargument  name="Desi" hint="Varyasyon desi değeri.">
        <cfargument  name="KargoUcreti" hint="Varyasyon kargo ücreti değeri">
        <cfargument  name="KdvDahil" hint="Kdv dahil olma durumu.">
        <cfargument  name="KdvOrani" hint="Varyasyon kdv orani değeri.">
        <cfargument  name="Ozellikler" hint="Varyasyonun özellikleri.">
        <cfargument  name="ParaBirimiID" required="true" hint="Varyasyon para birimi (sitede yer alan para birimlerinden biri girilmelidir).">
        <cfargument  name="Resimler" hint="Varyasyon resimleri.">
        <cfargument  name="SatisFiyati" required="true" hint="Satış fiyati değeri.">
        <cfargument  name="StokAdedi" hint="Stok adedi değeri.">
        <cfargument  name="StokKodu" hint="Varyasyon stok kodu.">
        <cfargument  name="Aktif" hint="Varyasyonun aktif olma durumu.">
        <cfargument  name="DuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="EkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EksiStokAdedi" hint="Ayrılacak olan stok adedi.">
        <cfargument  name="IndirimliFiyati" hint="Varyasyon indirimli fiyat değeri.">
        <cfargument  name="ParaBirimi" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="ParaBirimiKodu" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="TedarikciKodu" hint="Tedarikçi koduna göre güncelle true ise zorunlu">
        <cfargument  name="UyeTipiFiyat1" hint="Üye tipi 1 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat2" hint="Üye tipi 2 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat3" hint="Üye tipi 3 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat4" hint="Üye tipi 4 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat5" hint="Üye tipi 5 e özel fiyat değeri">
        <cfargument  name="UyeTipiFiyat7" hint="Üye tipi 7 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat8" hint="Üye tipi 8 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat9" hint="Üye tipi 9 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat10" hint="Üye tipi 10 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat11" hint="Üye tipi 11 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat12" hint="Üye tipi 12 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat13" hint="Üye tipi 13 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat14" hint="Üye tipi 14 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat15" hint="Üye tipi 15 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat16" hint="Üye tipi 16 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat17" hint="Üye tipi 17 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat18" hint="Üye tipi 18 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat19" hint="Üye tipi 19 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat20" hint="Üye tipi 20 ye özel fiyat değeri.">
        <cfargument  name="Ayar" required="true" hint="Varyasyon ayar sınıfı">
        <cfargument  name="AktifGuncelle">
        <cfargument  name="AlisFiyatiGuncelle">
        <cfargument  name="BarkodGuncelle">
        <cfargument  name="IndirimliFiyatiGuncelle">
        <cfargument  name="KargoUcretiGuncelle">
        <cfargument  name="KargoAgirligiGuncelle">
        <cfargument  name="ParaBirimiGuncelle">
        <cfargument  name="PiyasaFiyatiGuncelle">
        <cfargument  name="SatisFiyatiGuncelle">
        <cfargument  name="StokAdediGuncelle">
        <cfargument  name="UyeTipiFiyat1Guncelle">
        <cfargument  name="UyeTipiFiyat2Guncelle">
        <cfargument  name="UyeTipiFiyat3Guncelle">
        <cfargument  name="UyeTipiFiyat4Guncelle">
        <cfargument  name="UyeTipiFiyat5Guncelle">
        <cfargument  name="EksiStokAdediGuncelle">
        <cfargument  name="KdvDahilGuncelle">
        <cfargument  name="KdvOraniGuncelle">
        <cfargument  name="OncekiResimleriSil">
        <cfargument  name="ResimOlmayanlaraResimEkle">
        <cfargument  name="StokKoduGuncelle">
        <cfargument  name="UrunResimGuncelle">

        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="TahminiTeslimSuresiAyniGun" default="">
        <cfargument  name="TahminiTeslimSuresiGoster" default="">
        <cfargument  name="TahminiTeslimSuresiTarih" default="">
        <cfargument  name="TedarikciKodu2" default="">
        <cfargument  name="Desi2" default="">
        <cfargument  name="IndirimliFiyati1" default="">
        <cfargument  name="IndirimliFiyati2" default="">
        <cfargument  name="IndirimliFiyati3" default="">
        <cfargument  name="IndirimliFiyati4" default="">
        <cfargument  name="IndirimliFiyati5" default="">
        <cfargument  name="IndirimliFiyati6" default="">
        <cfargument  name="IndirimliFiyati7" default="">
        <cfargument  name="IndirimliFiyati8" default="">
        <cfargument  name="IndirimliFiyati9" default="">
        <cfargument  name="IndirimliFiyati10" default="">
        <cfargument  name="IndirimliFiyati11" default="">
        <cfargument  name="IndirimliFiyati12" default="">
        <cfargument  name="IndirimliFiyati13" default="">
        <cfargument  name="IndirimliFiyati14" default="">
        <cfargument  name="IndirimliFiyati15" default="">
        <cfargument  name="IndirimliFiyati16" default="">
        <cfargument  name="IndirimliFiyati17" default="">
        <cfargument  name="IndirimliFiyati18" default="">
        <cfargument  name="IndirimliFiyati19" default="">
        <cfargument  name="IndirimliFiyati20" default="">
        <cfargument  name="IscilikAgirlik" default="">
        <cfargument  name="IscilikParaBirimi" default="">
        <cfargument  name="IscilikParaBirimiId" default="">
        <cfargument  name="IscilikParaBirimiKodu" default="">
        <cfargument  name="IscilikParaBirimiGuncelle" default="">
        <cfargument  name="KdvDahil1" default="">
        <cfargument  name="KdvDahil2" default="">
        <cfargument  name="KdvDahil3" default="">
        <cfargument  name="KdvDahil4" default="">
        <cfargument  name="KdvDahil5" default="">
        <cfargument  name="KdvDahil7" default="">
        <cfargument  name="KdvDahil8" default="">
        <cfargument  name="KdvDahil9" default="">
        <cfargument  name="KdvDahil10" default="">
        <cfargument  name="KdvDahil11" default="">
        <cfargument  name="KdvDahil12" default="">
        <cfargument  name="KdvDahil13" default="">
        <cfargument  name="KdvDahil14" default="">
        <cfargument  name="KdvDahil15" default="">
        <cfargument  name="KdvDahil16" default="">
        <cfargument  name="KdvDahil17" default="">
        <cfargument  name="KdvDahil18" default="">
        <cfargument  name="KdvDahil19" default="">
        <cfargument  name="KdvDahil20" default="">
        <cfargument  name="KdvOrani1" default="">
        <cfargument  name="KdvOrani2" default="">
        <cfargument  name="KdvOrani3" default="">
        <cfargument  name="KdvOrani4" default="">
        <cfargument  name="KdvOrani5" default="">
        <cfargument  name="KdvOrani6" default="">
        <cfargument  name="KdvOrani7" default="">
        <cfargument  name="KdvOrani8" default="">
        <cfargument  name="KdvOrani9" default="">
        <cfargument  name="KdvOrani10" default="">
        <cfargument  name="KdvOrani11" default="">
        <cfargument  name="KdvOrani12" default="">
        <cfargument  name="KdvOrani13" default="">
        <cfargument  name="KdvOrani14" default="">
        <cfargument  name="KdvOrani15" default="">
        <cfargument  name="KdvOrani16" default="">
        <cfargument  name="KdvOrani17" default="">
        <cfargument  name="KdvOrani18" default="">
        <cfargument  name="KdvOrani19" default="">
        <cfargument  name="KdvOrani20" default="">
        <cfargument  name="MarkaID" default="">
        <cfargument  name="Tur" default="">
        <cfargument  name="XmlKod" default="">
        <cfargument  name="ParaBirimiKodu" default="">
        <cfargument  name="ParaBirimi1Id" default="">
        <cfargument  name="ParaBirimi2Id" default="">
        <cfargument  name="ParaBirimi3Id" default="">
        <cfargument  name="ParaBirimi4Id" default="">
        <cfargument  name="ParaBirimi5Id" default="">
        <cfargument  name="ParaBirimi6Id" default="">
        <cfargument  name="ParaBirimi7Id" default="">
        <cfargument  name="ParaBirimi8Id" default="">
        <cfargument  name="ParaBirimi9Id" default="">
        <cfargument  name="ParaBirimi10Id" default="">
        <cfargument  name="ParaBirimi11Id" default="">
        <cfargument  name="ParaBirimi12Id" default="">
        <cfargument  name="ParaBirimi13Id" default="">
        <cfargument  name="ParaBirimi14Id" default="">
        <cfargument  name="ParaBirimi15Id" default="">
        <cfargument  name="ParaBirimi16Id" default="">
        <cfargument  name="ParaBirimi17Id" default="">
        <cfargument  name="ParaBirimi18Id" default="">
        <cfargument  name="ParaBirimi19Id" default="">
        <cfargument  name="ParaBirimi20Id" default="">
        <cfargument  name="SatisFiyati1" default="">
        <cfargument  name="SatisFiyati2" default="">
        <cfargument  name="SatisFiyati3" default="">
        <cfargument  name="SatisFiyati4" default="">
        <cfargument  name="SatisFiyati5" default="">
        <cfargument  name="SatisFiyati6" default="">
        <cfargument  name="SatisFiyati7" default="">
        <cfargument  name="SatisFiyati8" default="">
        <cfargument  name="SatisFiyati9" default="">
        <cfargument  name="SatisFiyati10" default="">
        <cfargument  name="SatisFiyati11" default="">
        <cfargument  name="SatisFiyati12" default="">
        <cfargument  name="SatisFiyati13" default="">
        <cfargument  name="SatisFiyati14" default="">
        <cfargument  name="SatisFiyati15" default="">
        <cfargument  name="SatisFiyati16" default="">
        <cfargument  name="SatisFiyati17" default="">
        <cfargument  name="SatisFiyati18" default="">
        <cfargument  name="SatisFiyati19" default="">
        <cfargument  name="SatisFiyati20" default="">
        <cfargument  name="StokGuncellemeTarihi" default="">
        <cfargument  name="UpdateKey" default="">
        <cfargument  name="UrunAgirligi" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfargument  name="TahminiTeslimSuresiGosterGuncelle" default="">
        <cfargument  name="TahminiTeslimSuresiTarihGuncelle" default="">
        <cfargument  name="EkSecenekGuncelle" default="">
        <cfargument  name="FiyatTipleriGuncelle" default="">
        <cfargument  name="IscilikAgirlikGuncelle" default="">
        <cfargument  name="KargoAgirligiYurtDisiGuncelle" default="">
        <cfargument  name="KonsinyeUrunStokAdediGuncelle" default="">
        <cfargument name="TahminiTeslimSuresiAyniGunGuncelle" default="">
        <cfargument  name="UpdateKeyGuncelle" default="">
        <cfargument  name="UrunAgirligiGuncelle" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveVaryasyon>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:varyasyonlar>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <cfif len(arguments.AlisFiyati)><ns:AlisFiyati>#arguments.AlisFiyati#</ns:AlisFiyati></cfif>
                                <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                <ns:Barkodlar>
                                    <cfif len(arguments.Barkod)><arr:string>#arguments.Barkod#</arr:string></cfif>
                                </ns:Barkodlar>
                                <cfif len(arguments.Desi)><ns:Desi>#arguments.Desi#</ns:Desi></cfif>
                                <cfif len(arguments.Desi2)><ns:Desi2>#arguments.Desi2#</ns:Desi2></cfif>
                                <cfif len(arguments.DuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.DuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                <cfif len(arguments.EkleyenKullanici)><ns:EkleyenKullanici>#arguments.EkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                <cfif len(arguments.EksiStokAdedi)><ns:EksiStokAdedi>#arguments.EksiStokAdedi#</ns:EksiStokAdedi></cfif>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <cfif len(arguments.IndirimliFiyati)><ns:IndirimliFiyati>#arguments.IndirimliFiyati#</ns:IndirimliFiyati></cfif>
                                <cfif len(arguments.IndirimliFiyati1)><ns:IndirimliFiyati1>#arguments.IndirimliFiyati1#</ns:IndirimliFiyati1></cfif>
                                <cfif len(arguments.IndirimliFiyati10)><ns:IndirimliFiyati10>#arguments.IndirimliFiyati10#</ns:IndirimliFiyati10></cfif>
                                <cfif len(arguments.IndirimliFiyati11)><ns:IndirimliFiyati11>#arguments.IndirimliFiyati11#</ns:IndirimliFiyati11></cfif>
                                <cfif len(arguments.IndirimliFiyati12)><ns:IndirimliFiyati12>#arguments.IndirimliFiyati12#</ns:IndirimliFiyati12></cfif>
                                <cfif len(arguments.IndirimliFiyati13)><ns:IndirimliFiyati13>#arguments.IndirimliFiyati13#</ns:IndirimliFiyati13></cfif>
                                <cfif len(arguments.IndirimliFiyati14)><ns:IndirimliFiyati14>#arguments.IndirimliFiyati14#</ns:IndirimliFiyati14></cfif>
                                <cfif len(arguments.IndirimliFiyati15)><ns:IndirimliFiyati15>#arguments.IndirimliFiyati15#</ns:IndirimliFiyati15></cfif>
                                <cfif len(arguments.IndirimliFiyati16)><ns:IndirimliFiyati16>#arguments.IndirimliFiyati16#</ns:IndirimliFiyati16></cfif>
                                <cfif len(arguments.IndirimliFiyati17)><ns:IndirimliFiyati17>#arguments.IndirimliFiyati17#</ns:IndirimliFiyati17></cfif>
                                <cfif len(arguments.IndirimliFiyati18)><ns:IndirimliFiyati18>#arguments.IndirimliFiyati18#</ns:IndirimliFiyati18></cfif>
                                <cfif len(arguments.IndirimliFiyati19)><ns:IndirimliFiyati19>#arguments.IndirimliFiyati19#</ns:IndirimliFiyati19></cfif>
                                <cfif len(arguments.IndirimliFiyati2)><ns:IndirimliFiyati2>#arguments.IndirimliFiyati2#</ns:IndirimliFiyati2></cfif>
                                <cfif len(arguments.IndirimliFiyati20)><ns:IndirimliFiyati20>#arguments.IndirimliFiyati20#</ns:IndirimliFiyati20></cfif>
                                <cfif len(arguments.IndirimliFiyati3)><ns:IndirimliFiyati3>#arguments.IndirimliFiyati3#</ns:IndirimliFiyati3></cfif>
                                <cfif len(arguments.IndirimliFiyati4)><ns:IndirimliFiyati4>#arguments.IndirimliFiyati4#</ns:IndirimliFiyati4></cfif>
                                <cfif len(arguments.IndirimliFiyati5)><ns:IndirimliFiyati5>#arguments.IndirimliFiyati5#</ns:IndirimliFiyati5></cfif>
                                <cfif len(arguments.IndirimliFiyati6)><ns:IndirimliFiyati6>#arguments.IndirimliFiyati6#</ns:IndirimliFiyati6></cfif>
                                <cfif len(arguments.IndirimliFiyati7)><ns:IndirimliFiyati7>#arguments.IndirimliFiyati7#</ns:IndirimliFiyati7></cfif>
                                <cfif len(arguments.IndirimliFiyati8)><ns:IndirimliFiyati8>#arguments.IndirimliFiyati8#</ns:IndirimliFiyati8></cfif>
                                <cfif len(arguments.IndirimliFiyati9)><ns:IndirimliFiyati9>#arguments.IndirimliFiyati9#</ns:IndirimliFiyati9></cfif>
                                <cfif len(arguments.IscilikAgirlik)><ns:IscilikAgirlik>#arguments.IscilikAgirlik#</ns:IscilikAgirlik></cfif>
                                <cfif len(arguments.IscilikParaBirimi)><ns:IscilikParaBirimi>#arguments.IscilikParaBirimi#</ns:IscilikParaBirimi></cfif>
                                <cfif len(arguments.IscilikParaBirimiId)><ns:IscilikParaBirimiId>#arguments.IscilikParaBirimiId#</ns:IscilikParaBirimiId></cfif>
                                <cfif len(arguments.IscilikParaBirimiKodu)><ns:IscilikParaBirimiKodu>#arguments.IscilikParaBirimiKodu#</ns:IscilikParaBirimiKodu></cfif>
                                <cfif len(arguments.KargoUcreti)><ns:KargoUcreti>#arguments.KargoUcreti#</ns:KargoUcreti></cfif>
                                <ns:Kategoriler>
                                    <arr:int>#arguments.Kategoriler#</arr:int>
                                </ns:Kategoriler>
                                <cfif len(arguments.KdvDahil)><ns:KdvDahil>#arguments.KdvDahil#</ns:KdvDahil></cfif>
                                <cfif len(arguments.KdvDahil1)><ns:KdvDahil1>?#arguments.KdvDahil1#</ns:KdvDahil1></cfif>
                                <cfif len(arguments.KdvDahil10)><ns:KdvDahil10>#arguments.KdvDahil10#</ns:KdvDahil10></cfif>
                                <cfif len(arguments.KdvDahil11)><ns:KdvDahil11>#arguments.KdvDahil11#</ns:KdvDahil11></cfif>
                                <cfif len(arguments.KdvDahil12)><ns:KdvDahil12>#arguments.KdvDahil12#</ns:KdvDahil12></cfif>
                                <cfif len(arguments.KdvDahil13)><ns:KdvDahil13>#arguments.KdvDahil13#</ns:KdvDahil13></cfif>
                                <cfif len(arguments.KdvDahil14)><ns:KdvDahil14>#arguments.KdvDahil14#</ns:KdvDahil14></cfif>
                                <cfif len(arguments.KdvDahil15)><ns:KdvDahil15>#arguments.KdvDahil15#</ns:KdvDahil15></cfif>
                                <cfif len(arguments.KdvDahil16)><ns:KdvDahil16>#arguments.KdvDahil16#</ns:KdvDahil16></cfif>
                                <cfif len(arguments.KdvDahil17)><ns:KdvDahil17>#arguments.KdvDahil17#</ns:KdvDahil17></cfif>
                                <cfif len(arguments.KdvDahil18)><ns:KdvDahil18>#arguments.KdvDahil18#</ns:KdvDahil18></cfif>
                                <cfif len(arguments.KdvDahil19)><ns:KdvDahil19>#arguments.KdvDahil19#</ns:KdvDahil19></cfif>
                                <cfif len(arguments.KdvDahil2)><ns:KdvDahil2>#arguments.KdvDahil2#</ns:KdvDahil2></cfif>
                                <cfif len(arguments.KdvDahil20)><ns:KdvDahil20>#arguments.KdvDahil20#</ns:KdvDahil20></cfif>
                                <cfif len(arguments.KdvDahil3)><ns:KdvDahil3>#arguments.KdvDahil3#</ns:KdvDahil3></cfif>
                                <cfif len(arguments.KdvDahil4)><ns:KdvDahil4>#arguments.KdvDahil4#</ns:KdvDahil4></cfif>
                                <cfif len(arguments.KdvDahil5)><ns:KdvDahil5>#arguments.KdvDahil5#</ns:KdvDahil5></cfif>
                                <cfif len(arguments.KdvDahil6)><ns:KdvDahil6>#arguments.KdvDahil6#</ns:KdvDahil6></cfif>
                                <cfif len(arguments.KdvDahil7)><ns:KdvDahil7>#arguments.KdvDahil7#</ns:KdvDahil7></cfif>
                                <cfif len(arguments.KdvDahil8)><ns:KdvDahil8>#arguments.KdvDahil8#</ns:KdvDahil8></cfif>
                                <cfif len(arguments.KdvDahil9)><ns:KdvDahil9>#arguments.KdvDahil9#</ns:KdvDahil9></cfif>
                                <cfif len(arguments.KdvOrani)><ns:KdvOrani>#arguments.KdvOrani#</ns:KdvOrani></cfif>
                                <cfif len(arguments.KdvOrani1)><ns:KdvOrani1>#arguments.KdvOrani1#</ns:KdvOrani1></cfif>
                                <cfif len(arguments.KdvOrani10)><ns:KdvOrani10>#arguments.KdvOrani10#</ns:KdvOrani10></cfif>
                                <cfif len(arguments.KdvOrani11)><ns:KdvOrani11>#arguments.KdvOrani11#</ns:KdvOrani11></cfif>
                                <cfif len(arguments.KdvOrani12)><ns:KdvOrani12>#arguments.KdvOrani12#</ns:KdvOrani12></cfif>
                                <cfif len(arguments.KdvOrani13)><ns:KdvOrani13>#arguments.KdvOrani13#</ns:KdvOrani13></cfif>
                                <cfif len(arguments.KdvOrani14)><ns:KdvOrani14>#arguments.KdvOrani14#</ns:KdvOrani14></cfif>
                                <cfif len(arguments.KdvOrani15)><ns:KdvOrani15>#arguments.KdvOrani15#</ns:KdvOrani15></cfif>
                                <cfif len(arguments.KdvOrani16)><ns:KdvOrani16>#arguments.KdvOrani16#</ns:KdvOrani16></cfif>
                                <cfif len(arguments.KdvOrani17)><ns:KdvOrani17>#arguments.KdvOrani17#</ns:KdvOrani17></cfif>
                                <cfif len(arguments.KdvOrani18)><ns:KdvOrani18>#arguments.KdvOrani18#</ns:KdvOrani18></cfif>
                                <cfif len(arguments.KdvOrani19)><ns:KdvOrani19>#arguments.KdvOrani19#</ns:KdvOrani19></cfif>
                                <cfif len(arguments.KdvOrani2)><ns:KdvOrani2>#arguments.KdvOrani2#</ns:KdvOrani2></cfif>
                                <cfif len(arguments.KdvOrani20)><ns:KdvOrani20>#arguments.KdvOrani20#</ns:KdvOrani20></cfif>
                                <cfif len(arguments.KdvOrani3)><ns:KdvOrani3>#arguments.KdvOrani3#</ns:KdvOrani3></cfif>
                                <cfif len(arguments.KdvOrani4)><ns:KdvOrani4>#arguments.KdvOrani4#</ns:KdvOrani4></cfif>
                                <cfif len(arguments.KdvOrani5)><ns:KdvOrani5>#arguments.KdvOrani5#</ns:KdvOrani5></cfif>
                                <cfif len(arguments.KdvOrani6)><ns:KdvOrani6>#arguments.KdvOrani6#</ns:KdvOrani6></cfif>
                                <cfif len(arguments.KdvOrani7)><ns:KdvOrani7>#arguments.KdvOrani7#</ns:KdvOrani7></cfif>
                                <cfif len(arguments.KdvOrani8)><ns:KdvOrani8>#arguments.KdvOrani8#</ns:KdvOrani8></cfif>
                                <cfif len(arguments.KdvOrani9)><ns:KdvOrani9>#arguments.KdvOrani9#</ns:KdvOrani9></cfif>
                                <cfif len(arguments.MarkaID)><ns:MarkaID>#arguments.MarkaID#</ns:MarkaID></cfif>
                                <!-----buralardaki marketplaceaktif kısımları varyasyon için geçerli bunlar varyasyon olarak tanımlanmalı mı yoksa bu şekilde devam mı?---->
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <ns:Ozellikler>
                                    <ns:VaryasyonOzellik>
                                    <ns:Deger>#arguments.Deger#</ns:Deger>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                    <cfif len(arguments.Tur)><ns:Tur>#arguments.Tur#</ns:Tur></cfif>
                                    <cfif len(arguments.XmlKod)><ns:XmlKod>#arguments.XmlKod#</ns:XmlKod></cfif>
                                    </ns:VaryasyonOzellik>
                                </ns:Ozellikler>
                                <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                <cfif len(arguments.ParaBirimi10Id)><ns:ParaBirimi10Id>#arguments.ParaBirimi10Id#</ns:ParaBirimi10Id></cfif>                    
                                <cfif len(arguments.ParaBirimi11Id)><ns:ParaBirimi11Id>#arguments.ParaBirimi11Id#</ns:ParaBirimi11Id></cfif>
                                <cfif len(arguments.ParaBirimi12Id)><ns:ParaBirimi12Id>#arguments.ParaBirimi12Id#</ns:ParaBirimi12Id></cfif>
                                <cfif len(arguments.ParaBirimi13Id)><ns:ParaBirimi13Id>#arguments.ParaBirimi13Id#</ns:ParaBirimi13Id></cfif>
                                <cfif len(arguments.ParaBirimi14Id)><ns:ParaBirimi14Id>#arguments.ParaBirimi14Id#</ns:ParaBirimi14Id></cfif>
                                <cfif len(arguments.ParaBirimi15Id)><ns:ParaBirimi15Id>#arguments.ParaBirimi15Id#</ns:ParaBirimi15Id></cfif>
                                <cfif len(arguments.ParaBirimi16Id)><ns:ParaBirimi16Id>#arguments.ParaBirimi16Id#</ns:ParaBirimi16Id></cfif>
                                <cfif len(arguments.ParaBirimi17Id)><ns:ParaBirimi17Id>#arguments.ParaBirimi17Id#</ns:ParaBirimi17Id></cfif>
                                <cfif len(arguments.ParaBirimi18Id)><ns:ParaBirimi18Id>#arguments.ParaBirimi18Id#</ns:ParaBirimi18Id></cfif>
                                <cfif len(arguments.ParaBirimi19Id)><ns:ParaBirimi19Id>#arguments.ParaBirimi19Id#</ns:ParaBirimi19Id></cfif>
                                <cfif len(arguments.ParaBirimi1Id)><ns:ParaBirimi1Id>#arguments.ParaBirimi1Id#</ns:ParaBirimi1Id></cfif>
                                <cfif len(arguments.ParaBirimi20Id)><ns:ParaBirimi20Id>#arguments.ParaBirimi20Id#</ns:ParaBirimi20Id></cfif>
                                <cfif len(arguments.ParaBirimi2Id)><ns:ParaBirimi2Id>#arguments.ParaBirimi2Id#</ns:ParaBirimi2Id></cfif>
                                <cfif len(arguments.ParaBirimi3Id)><ns:ParaBirimi3Id>#arguments.ParaBirimi3Id#</ns:ParaBirimi3Id></cfif>
                                <cfif len(arguments.ParaBirimi4Id)><ns:ParaBirimi4Id>#arguments.ParaBirimi4Id#</ns:ParaBirimi4Id></cfif>
                                <cfif len(arguments.ParaBirimi5Id)><ns:ParaBirimi5Id>#arguments.ParaBirimi5Id#</ns:ParaBirimi5Id></cfif>
                                <cfif len(arguments.ParaBirimi6Id)><ns:ParaBirimi6Id>#arguments.ParaBirimi6Id#</ns:ParaBirimi6Id></cfif>
                                <cfif len(arguments.ParaBirimi7Id)><ns:ParaBirimi7Id>#arguments.ParaBirimi7Id#</ns:ParaBirimi7Id></cfif>
                                <cfif len(arguments.ParaBirimi8Id)><ns:ParaBirimi8Id>#arguments.ParaBirimi8Id#</ns:ParaBirimi8Id></cfif>
                                <cfif len(arguments.ParaBirimi9Id)><ns:ParaBirimi9Id>#arguments.ParaBirimi9Id#</ns:ParaBirimi9Id></cfif>
                                <ns:ParaBirimiID>#arguments.ParaBirimiID#</ns:ParaBirimiID>
                                <cfif len(arguments.ParaBirimiKodu)><ns:ParaBirimiKodu>#arguments.ParaBirimiKodu#</ns:ParaBirimiKodu></cfif>                    
                                <ns:Resimler>
                                    <cfif len(arguments.Resimler)><arr:string>#arguments.Resimler#</arr:string></cfif>
                                </ns:Resimler>
                                <ns:SatisFiyati>#arguments.VaryasyonSatisFiyati#</ns:SatisFiyati>
                                <cfif len(arguments.SatisFiyati1)><ns:SatisFiyati1>#arguments.SatisFiyati1#</ns:SatisFiyati1></cfif>
                                <cfif len(arguments.SatisFiyati10)><ns:SatisFiyati10>#arguments.SatisFiyati10#</ns:SatisFiyati10></cfif>
                                <cfif len(arguments.SatisFiyati11)><ns:SatisFiyati11>#arguments.SatisFiyati11#</ns:SatisFiyati11></cfif>
                                <cfif len(arguments.SatisFiyati12)><ns:SatisFiyati12>#arguments.SatisFiyati12#</ns:SatisFiyati12></cfif>
                                <cfif len(arguments.SatisFiyati13)><ns:SatisFiyati13>#arguments.SatisFiyati13#</ns:SatisFiyati13></cfif>
                                <cfif len(arguments.SatisFiyati14)><ns:SatisFiyati14>#arguments.SatisFiyati14#</ns:SatisFiyati14></cfif>
                                <cfif len(arguments.SatisFiyati15)><ns:SatisFiyati15>#arguments.SatisFiyati15#</ns:SatisFiyati15></cfif>
                                <cfif len(arguments.SatisFiyati16)><ns:SatisFiyati16>#arguments.SatisFiyati16#</ns:SatisFiyati16></cfif>
                                <cfif len(arguments.SatisFiyati17)><ns:SatisFiyati17>#arguments.SatisFiyati17#</ns:SatisFiyati17></cfif>
                                <cfif len(arguments.SatisFiyati18)><ns:SatisFiyati18>#arguments.SatisFiyati18#</ns:SatisFiyati18></cfif>
                                <cfif len(arguments.SatisFiyati19)><ns:SatisFiyati19>#arguments.SatisFiyati19#</ns:SatisFiyati19></cfif>
                                <cfif len(arguments.SatisFiyati2)><ns:SatisFiyati2>#arguments.SatisFiyati2#</ns:SatisFiyati2></cfif>
                                <cfif len(arguments.SatisFiyati20)><ns:SatisFiyati20>#arguments.SatisFiyati20#</ns:SatisFiyati20></cfif>
                                <cfif len(arguments.SatisFiyati3)><ns:SatisFiyati3>#arguments.SatisFiyati3#</ns:SatisFiyati3></cfif>
                                <cfif len(arguments.SatisFiyati4)><ns:SatisFiyati4>#arguments.SatisFiyati4#</ns:SatisFiyati4></cfif>
                                <cfif len(arguments.SatisFiyati5)><ns:SatisFiyati5>#arguments.SatisFiyati5#</ns:SatisFiyati5></cfif>
                                <cfif len(arguments.SatisFiyati6)><ns:SatisFiyati6>#arguments.SatisFiyati6#</ns:SatisFiyati6></cfif>
                                <cfif len(arguments.SatisFiyati7)><ns:SatisFiyati7>#arguments.SatisFiyati7#</ns:SatisFiyati7></cfif>
                                <cfif len(arguments.SatisFiyati8)<ns:SatisFiyati8>#arguments.SatisFiyati8#</ns:SatisFiyati8></cfif>
                                <cfif len(arguments.SatisFiyati9)><ns:SatisFiyati9>#arguments.SatisFiyati9#</ns:SatisFiyati9></cfif>
                                <cfif len(arguments.StokAdedi)><ns:StokAdedi>#arguments.StokAdedi#</ns:StokAdedi></cfif>
                                <cfif len(arguments.StokGuncellemeTarihi)><ns:StokGuncellemeTarihi>#arguments.StokGuncellemeTarihi#</ns:StokGuncellemeTarihi></cfif>
                                <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                <!-----tahmini teslim süresi yukarıda ürün için tanımlanmış varyasyon için tanımlayıp onu mu almam gerekiyor yoksa aynı argumentden devam mı şu an yaptığım aynısı ------>
                                <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                <cfif len(arguments.TedarikciKodu)><ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu></cfif>
                                <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                <cfif len(arguments.UpdateKey)><ns:UpdateKey>#arguments.UpdateKey#</ns:UpdateKey></cfif>
                                <cfif len(arguemnts.UrunAgirligi)><ns:UrunAgirligi>#arguments.UrunAgirligi#</ns:UrunAgirligi></cfif>
                                <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                <cfif len(arguments.UyeTipiFiyat1)><ns:UyeTipiFiyat1>#arguments.UyeTipiFiyat1#</ns:UyeTipiFiyat1></cfif>
                                <cfif len(arguments.UyeTipiFiyat10)><ns:UyeTipiFiyat10>#arguments.UyeTipiFiyat10#</ns:UyeTipiFiyat10></cfif>
                                <cfif len(arguments.UyeTipiFiyat11)><ns:UyeTipiFiyat11>#arguments.UyeTipiFiyat11#</ns:UyeTipiFiyat11></cfif>
                                <cfif len(arguments.UyeTipiFiyat12)><ns:UyeTipiFiyat12>#arguments.UyeTipiFiyat12#</ns:UyeTipiFiyat12></cfif>
                                <cfif len(arguments.UyeTipiFiyat13)><ns:UyeTipiFiyat13>#arguments.UyeTipiFiyat13#</ns:UyeTipiFiyat13></cfif>
                                <cfif len(arguments.UyeTipiFiyat14)><ns:UyeTipiFiyat14>#arguments.UyeTipiFiyat14#</ns:UyeTipiFiyat14></cfif>
                                <cfif len(arguments.UyeTipiFiyat15)><ns:UyeTipiFiyat15>#arguments.UyeTipiFiyat15#</ns:UyeTipiFiyat15></cfif>
                                <cfif len(arguments.UyeTipiFiyat16)><ns:UyeTipiFiyat16>#arguments.UyeTipiFiyat16#</ns:UyeTipiFiyat16></cfif>
                                <cfif len(arguments.UyeTipiFiyat17)><ns:UyeTipiFiyat17>#arguments.UyeTipiFiyat17#</ns:UyeTipiFiyat17></cfif>
                                <cfif len(arguments.UyeTipiFiyat18)><ns:UyeTipiFiyat18>#arguments.UyeTipiFiyat18#</ns:UyeTipiFiyat18></cfif>
                                <cfif len(arguments.UyeTipiFiyat19)><ns:UyeTipiFiyat19>#arguments.UyeTipiFiyat19#</ns:UyeTipiFiyat19></cfif>
                                <cfif len(arguments.UyeTipiFiyat2)><ns:UyeTipiFiyat2>#arguments.UyeTipiFiyat2#</ns:UyeTipiFiyat2></cfif>
                                <cfif len(arguments.UyeTipiFiyat20)><ns:UyeTipiFiyat20>#arguments.UyeTipiFiyat20#</ns:UyeTipiFiyat20></cfif>
                                <cfif len(arguments.UyeTipiFiyat3)><ns:UyeTipiFiyat3>#arguments.UyeTipiFiyat3#</ns:UyeTipiFiyat3></cfif>
                                <cfif len(arguments.UyeTipiFiyat4)><ns:UyeTipiFiyat4>#arguments.UyeTipiFiyat4#</ns:UyeTipiFiyat4></cfif>
                                <cfif len(arguments.UyeTipiFiyat5)><ns:UyeTipiFiyat5>#arguments.UyeTipiFiyat5#</ns:UyeTipiFiyat5></cfif>
                                <cfif len(arguments.UyeTipiFiyat6)><ns:UyeTipiFiyat6>#arguments.UyeTipiFiyat6#</ns:UyeTipiFiyat6></cfif>
                                <cfif len(arguments.UyeTipiFiyat7)><ns:UyeTipiFiyat7>#arguments.UyeTipiFiyat7#</ns:UyeTipiFiyat7></cfif>
                                <cfif len(arguments.UyeTipiFiyat8)><ns:UyeTipiFiyat8>#arguments.UyeTipiFiyat8#</ns:UyeTipiFiyat8></cfif>
                                <cfif len(arguments.UyeTipiFiyat9)><ns:UyeTipiFiyat9>#arguments.UyeTipiFiyat9#</ns:UyeTipiFiyat9></cfif>
                            </tem:varyasyonlar>
                            <tem:ayar>
                                <cfif len(arguments.AktifGuncelle)><ns:AktifGuncelle>#arguments.AktifGuncelle#</ns:AktifGuncelle></cfif>
                                <cfif len(arguments.AlisFiyatiGuncelle)><ns:AlisFiyatiGuncelle>#arguments.AlisFiyatiGuncelle#</ns:AlisFiyatiGuncelle></cfif>
                                <cfif len(arguments.BarkodGuncelle)><ns:BarkodGuncelle>#arguments.BarkodGuncelle#</ns:BarkodGuncelle></cfif>
                                <cfif len(arguments.EkSecenekGuncelle)><ns:EkSecenekGuncelle>#arguments.EkSecenekGuncelle#</ns:EkSecenekGuncelle></cfif>
                                <cfif len(arguemnts.EksiStokAdediGuncelle)><ns:EksiStokAdediGuncelle>#arguments.EksiStokAdediGuncelle#</ns:EksiStokAdediGuncelle></cfif>
                                <cfif len(arguments.FiyatTipleriGuncelle)><ns:FiyatTipleriGuncelle>#arguments.FiyatTipleriGuncelle#</ns:FiyatTipleriGuncelle></cfif>
                                <cfif len(arguments.IndirimliFiyatiGuncelle)><ns:IndirimliFiyatiGuncelle>#arguments.IndirimliFiyatiGuncelle#</ns:IndirimliFiyatiGuncelle></cfif>
                                <cfif len(arguments.IscilikAgirlikGuncelle)><ns:IscilikAgirlikGuncelle>#arguments.IscilikAgirlikGuncelle#</ns:IscilikAgirlikGuncelle></cfif>
                                <cfif len(arguments.IscilikParaBirimiGuncelle)><ns:IscilikParaBirimiGuncelle>#arguments.IscilikParaBirimiGuncelle#</ns:IscilikParaBirimiGuncelle></cfif>
                                <cfif len(arguments.KargoAgirligiGuncelle)><ns:KargoAgirligiGuncelle>#arguments.KargoAgirligiGuncelle#</ns:KargoAgirligiGuncelle></cfif>
                                <cfif len(arguments.KargoAgirligiYurtDisiGuncelle)><ns:KargoAgirligiYurtDisiGuncelle>#arguments.KargoAgirligiYurtDisiGuncelle#</ns:KargoAgirligiYurtDisiGuncelle></cfif>
                                <cfif len(arguments.KargoUcretiGuncelle)><ns:KargoUcretiGuncelle>#arguments.KargoUcretiGuncelle#</ns:KargoUcretiGuncelle></cfif>
                                <cfif len(arguments.KdvDahilGuncelle)><ns:KdvDahilGuncelle>#arguments.KdvDahilGuncelle#</ns:KdvDahilGuncelle></cfif>
                                <cfif len(arguments.KdvOraniGuncelle)><ns:KdvOraniGuncelle>#arguments.KdvOraniGuncelle#</ns:KdvOraniGuncelle></cfif>
                                <cfif len(arguments.KonsinyeUrunStokAdediGuncelle)><ns:KonsinyeUrunStokAdediGuncelle>#arguments.KonsinyeUrunStokAdediGuncelle#</ns:KonsinyeUrunStokAdediGuncelle></cfif>
                                <cfif len(arguments.OncekiResimleriSil)><ns:OncekiResimleriSil>#arguments.OncekiResimleriSil#</ns:OncekiResimleriSil></cfif>
                                <cfif len(arguments.ParaBirimiGuncelle)><ns:ParaBirimiGuncelle>#arguments.ParaBirimiGuncelle#</ns:ParaBirimiGuncelle></cfif>
                                <cfif len(arguments.ResimOlmayanlaraResimEkle)><ns:ResimOlmayanlaraResimEkle>#arguments.ResimOlmayanlaraResimEkle#</ns:ResimOlmayanlaraResimEkle></cfif>
                                <cfif len(arguments.SatisFiyatiGuncelle)><ns:SatisFiyatiGuncelle>#arguments.SatisFiyatiGuncelle#</ns:SatisFiyatiGuncelle></cfif>
                                <cfif len(arguments.StokAdediGuncelle)><ns:StokAdediGuncelle>#arguments.StokAdediGuncelle#</ns:StokAdediGuncelle></cfif>
                                <cfif len(arguments.StokKoduGuncelle)><ns:StokKoduGuncelle>#arguments.StokKoduGuncelle#</ns:StokKoduGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGunGuncelle)><ns:TahminiTeslimSuresiAyniGunGuncelle>#arguments.TahminiTeslimSuresiAyniGunGuncelle#</ns:TahminiTeslimSuresiAyniGunGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGosterGuncelle)><ns:TahminiTeslimSuresiGosterGuncelle>#arguments.TahminiTeslimSuresiGosterGuncelle#</ns:TahminiTeslimSuresiGosterGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGuncelle)><ns:TahminiTeslimSuresiGuncelle>#arguments.TahminiTeslimSuresiGuncelle#</ns:TahminiTeslimSuresiGuncelle></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarihGuncelle)><ns:TahminiTeslimSuresiTarihGuncelle>#arguments.TahminiTeslimSuresiTarihGuncelle#</ns:TahminiTeslimSuresiTarihGuncelle></cfif>
                                <cfif len(arguments.TedarikciKodunaGoreGuncelle)><ns:TedarikciKodunaGoreGuncelle>#arguments.TedarikciKodunaGoreGuncelle#</ns:TedarikciKodunaGoreGuncelle></cfif>
                                <cfif len(arguments.UpdateKeyGuncelle)><ns:UpdateKeyGuncelle>#arguments.UpdateKeyGuncelle#</ns:UpdateKeyGuncelle></cfif>
                                <cfif len(arguments.UrunAgirligiGuncelle)><ns:UrunAgirligiGuncelle>#arguments.UrunAgirligiGuncelle#</ns:UrunAgirligiGuncelle></cfif>
                                <cfif len(arguments.UrunResimGuncelle)><ns:UrunResimGuncelle>#arguments.UrunResimGuncelle#</ns:UrunResimGuncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat10Guncelle)><ns:UyeTipiFiyat10Guncelle>#arguments.UyeTipiFiyat10Guncelle#</ns:UyeTipiFiyat10Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat11Guncelle)><ns:UyeTipiFiyat11Guncelle>#arguments.UyeTipiFiyat11Guncelle#</ns:UyeTipiFiyat11Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat12Guncelle)><ns:UyeTipiFiyat12Guncelle>#arguments.UyeTipiFiyat12Guncelle#</ns:UyeTipiFiyat12Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat13Guncelle)><ns:UyeTipiFiyat13Guncelle>#arguments.UyeTipiFiyat13Guncelle#</ns:UyeTipiFiyat13Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat14Guncelle)><ns:UyeTipiFiyat14Guncelle>#arguments.UyeTipiFiyat14Guncelle#</ns:UyeTipiFiyat14Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat15Guncelle)><ns:UyeTipiFiyat15Guncelle>#arguments.UyeTipiFiyat15Guncelle#</ns:UyeTipiFiyat15Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat16Guncelle)><ns:UyeTipiFiyat16Guncelle>#arguments.UyeTipiFiyat16Guncelle#</ns:UyeTipiFiyat16Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat17Guncelle)><ns:UyeTipiFiyat17Guncelle>#arguments.UyeTipiFiyat17Guncelle#</ns:UyeTipiFiyat17Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat18Guncelle)><ns:UyeTipiFiyat18Guncelle>#arguments.UyeTipiFiyat18Guncelle#</ns:UyeTipiFiyat18Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat19Guncelle)><ns:UyeTipiFiyat19Guncelle>#arguments.UyeTipiFiyat19Guncelle#</ns:UyeTipiFiyat19Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat1Guncelle)><ns:UyeTipiFiyat1Guncelle>#arguments.UyeTipiFiyat1Guncelle#</ns:UyeTipiFiyat1Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat20Guncelle)><ns:UyeTipiFiyat20Guncelle>#arguments.UyeTipiFiyat20Guncelle#</ns:UyeTipiFiyat20Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat2Guncelle)><ns:UyeTipiFiyat2Guncelle>#arguments.UyeTipiFiyat2Guncelle#</ns:UyeTipiFiyat2Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat3Guncelle)><ns:UyeTipiFiyat3Guncelle>#arguments.UyeTipiFiyat3Guncelle#</ns:UyeTipiFiyat3Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat4Guncelle)><ns:UyeTipiFiyat4Guncelle>#arguments.UyeTipiFiyat4Guncelle#</ns:UyeTipiFiyat4Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat5Guncelle)><ns:UyeTipiFiyat5Guncelle>#arguments.UyeTipiFiyat5Guncelle#</ns:UyeTipiFiyat5Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat6Guncelle)><ns:UyeTipiFiyat6Guncelle>#arguments.UyeTipiFiyat6Guncelle#</ns:UyeTipiFiyat6Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat7Guncelle)><ns:UyeTipiFiyat7Guncelle>#arguments.UyeTipiFiyat7Guncelle#</ns:UyeTipiFiyat7Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat8Guncelle)><ns:UyeTipiFiyat8Guncelle>#arguments.UyeTipiFiyat8Guncelle#</ns:UyeTipiFiyat8Guncelle></cfif>
                                <cfif len(arguments.UyeTipiFiyat9Guncelle)><ns:UyeTipiFiyat9Guncelle>#arguments.UyeTipiFiyat9Guncelle#</ns:UyeTipiFiyat9Guncelle></cfif>
                            </tem:ayar>
                        </tem:SaveVaryasyon>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveVaryasyon"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!---AsortiGrup kısmı class---->
    <cffunction  name="SaveAsortiGrup">
        <cfargument  name="AsortiGrup" required="true" hint="Eklenecek olan asorti grup bilgilerini içeren AsortiGrup sınıfı">
        <cfargument  name="ID" required="true" hint="0 girilir ise yeni kayıt eklenir. 0 dan büyük girilir ise girilen id li kayıt güncellenir">
        <cfargument  name="EkSecenekTipi" required="true" hint="Kayıtlı olan eksecenek tipi tanım değeri.">
        <cfargument  name="Tanim" required="true" hint="Asorti grup adı">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveAsortiGrup>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>
                                <ns:EkSecenekTipi>#arguments.EkSecenekTipi#</ns:EkSecenekTipi>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>                
                            </tem:m>
                        </tem:SaveAsortiGrup>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveAsortiGrup"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <!-----AsortiMiktar kısmı class----->
    <cffunction  name="SaveAsortiMiktar">
        <cfargument  name="AsortiMiktar" required="true" hint="Asorti miktar bilgilerini içeren AsortiMiktar sınıfı.">
        <cfargument  name="ID" required="true">
        <cfargument  name="EkSecenekTanım" required="true">,
        <cfargument  name="Adet" required="true">
        <cfargument  name="GrupID" required="true">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveAsortiMiktar>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:m>
                                <ns:Adet>#arguments.Adet#</ns:Adet>
                                <ns:EkSecenekTanim>#arguments.EkSecenekTanim#</ns:EkSecenekTanim>
                                <ns:GrupID>#arguments.GrupID#</ns:GrupID>
                                <ns:ID>#arguments.ID#</ns:ID>                
                            </tem:m>
                        </tem:SaveAsortiMiktar>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveAsortiMiktar"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectAsortiGrup">
        <cfargument  name="AsortiGrupId" required="true" hint="Getirilmek istenen asorti grup a ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectAsortiGrup>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:asortiGrupId>#arguments.asortiGrupId#</tem:asortiGrupId>
                        </tem:SelectAsortiGrup>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectAsortiGrup"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectAsortiMiktar">
        <cfargument  name="AsortiMiktarId" required="true" hint="Getirilmek istenen asorti miktar a ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectAsortiMiktar>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:asortiMiktarId>#arguments.asortiMiktarId#</tem:asortiMiktarId>
                        </tem:SelectAsortiMiktar>
                    </soapenv:Body>
                </soapenv:Envelope>
        </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectAsortiMiktar"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectEkSecenekDeger">
        <cfargument  name="EksecenekGroupID" required="true">
        <cfargument  name="dil">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectEkSecenekDeger>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:ekSecenekGrupId>#arguments.ekSecenekGrupId#</tem:ekSecenekGrupId>
                            <cfif len(arguments.dil)><tem:dil>#arguments.dil#</tem:dil></cfif>
                        </tem:SelectEkSecenekDeger>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectEkSecenekDeger"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectEkSecenekGrup">
        <cfargument  name="dil" >
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectEkSecenekGrup>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <cfif len(arguments.dil)><tem:dil>#arguments.dil#</tem:dil></cfif>
                        </tem:SelectEkSecenekGrup>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectEkSecenekGrup"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="UpdateEkSecenekDegerDil">
        <cfargument  name="UpdateEkSecenekDegerDilRequest" required="true" hint="Güncelleme bilgilerini içeren UpdateEkSecenekDegerDilRequest sınıfı">
        <cfargument  name="Dil" required="true">
        <cfargument  name="Liste" required="true" hint="Güncellenecek olan ek seçenek değerleri içeren EkSecenekDegerDil sınıfı listesi ">
        <cfargument  name="ID" required="true">
        <cfargument  name="Tanim" required="true" hint="Güncellenecek ek seçenek değer tanım">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateEkSecenekDegerDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:EkSecenekDegerDil>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                </ns:EkSecenekDegerDil>
                                </ns:Liste>
                            </tem:request>
                        </tem:UpdateEkSecenekDegerDil>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateEkSecenekDegerDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="UpdateEkSecenekGrupDil">
        <cfargument  name="UpdateEkSecenekGrupDilRequest" required="true" hint="Güncelleme bilgilerini içeren UpdateEkSecenekGrupDilRequest sınıfı">
        <cfargument  name="Dil" required="true">
        <cfargument  name="Liste" required="true" hint="Güncellenecek olan ek seçenek grupları içeren EkSecenekGrupDil sınıfı listesi ">
        <cfargument  name="ID" required="true">
        <cfargument  name="Tanim" required="true" hint="Güncellenecek ek seçenek grup tanım ">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateEkSecenekGrupDil>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Dil>#arguments.Dil#</ns:Dil>
                                <ns:Liste>
                                <ns:EkSecenekGrupDil>
                                    <ns:ID>#arguments.ID#</ns:ID>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                </ns:EkSecenekGrupDil>
                                </ns:Liste>
                            </tem:request>
                        </tem:UpdateEkSecenekGrupDil>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateEkSecenekGrupDil"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveParaBirimi">
        <cfargument  name="Parabirimi" required="true" hint="Para birimi bilgilerini içeren ParaBirimi sınıfı.">
        <cfargument  name="ID" required="true" hint="0 girilir ise yeni kayıt eklenir. 0 dan büyük girilir ise girilen id li kayıt güncellenir.">
        <cfargument  name="Kur" required="true" hint="Kur değeri. Örn: 5.60">
        <cfargument  name="DovizKodu" required="true" hint="Döviz kodu. Örn =”USD”">
        <cfargument  name="Tanim" required="true" hint="Para birimi adı. Örn = “Dolar”">
        <cfargument  name="Aktif" hint="Aktiflik durumu.">
        <cfargument  name="GuncellemeTarihi" hint="Güncelleme tarihi.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveParaBirimi>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:parabirimi>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <ns:DovizKodu>#arguments.DovizKodu#</ns:DovizKodu>
                                <cfif len(arguments.GuncellemeTarihi)><ns:GuncellemeTarihi>#arguments.GuncellemeTarihi#</ns:GuncellemeTarihi></cfif>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <ns:Kur>#arguments.Kur#</ns:Kur>
                                <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                            </tem:parabirimi>
                        </tem:SaveParaBirimi>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
            <cftransaction>
                <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                    <cfhttpparam type="header" name="mimetype" value="text/xml" />
                    <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SaveParaBirimi"\'>
                    <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                    <cfhttpparam type="xml"   value="#trim(xmlData)#">            
                </cfhttp>
            </cftransaction>
            <cfreturn httpResponse>
        </cfxml>
    </cffunction>
    <cffunction  name="SelectParaBirimi">
        <cfargument  name="ParabirimiId" required="true" hint="Getirilmek istenen para birimine ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectParaBirimi>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:ParaBirimiID>#arguments.ParaBirimiID#</tem:ParaBirimiID>
                        </tem:SelectParaBirimi>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectParaBirimi"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="GetProductStatus">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:GetProductStatus>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        </tem:GetProductStatus>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/GetProductStatus"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="UpdateUrl">
        <cfargument  name="UpdateUrlReques" required="true" hint="Değişecek olan veriyi içeren UpdateUrlRequest sınıfı.">
        <cfargument  name="ID" required="true">
        <cfargument  name="Dil">
        <cfargument  name="Url" required="true">
        <cfargument  name="Tip" required="true" hint="Url I güncellenecek nesne tipi.">
        <!----
        <cfargument  name="Kategori" default="0">
        <cfargument  name="Marka" default="1">
        <cfargument  name="Urun" default="2">
        <cfargument  name="Tedarikci" default="3">
        ---->
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:UpdateUrl>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <cfif len(arguments.Dil)><ns:Dil>#arguments.Dil#</ns:Dil></cfif>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <ns:Tip>#arguments.Tip#</ns:Tip>
                                <ns:Url>#arguments.Url#</ns:Url>
                            </tem:request>
                        </tem:UpdateUrl>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/UpdateUrl"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="GetTaksitSecenekleri">
        <cfargument  name="Tutar" required="true" hint="Tutar">
        <cfargument  name="MaksimumTaksitSayısı" required="true" hint="Maksimum taksit sayısı">
        <cfargument  name="DovizKuru" required="true" hint="Döviz kuru ">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:GetTaksitSecenekleri>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:Tutar>#arguments.Tutar#</tem:Tutar>
                            <tem:MaximumTaksitSayisi>#arguments.MaximumTaksitSayisi#</tem:MaximumTaksitSayisi>
                            <tem:DovizKodu>#arguments.DovizKuru#</tem:DovizKodu>
                        </tem:GetTaksitSecenekleri>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/GetTaksitSecenekleri"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectMagazaStok">
        <cfargument  name="SelectMagazaStokRequest" required="true" hint="Filtre bilgilerini içeren SelectMagazaStokRequest sınıfı">
        <cfargument  name="MagazaKodu" required="true" hint="Stok bilgileri getirilmek istenen mağaza kodu">
        <cfargument  name="MagazaIdList" default="">
        <cfargument  name="MagazaKoduList" default="">
        <cfargument  name="StokHareketTarihiBas" default="">
        <cfargument  name="StokHareketTarihiSon" default="">
        <cfargument  name="StokOlanlar" default="">
        <cfargument  name="UrunID" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectMagazaStok>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:MagazaIdList>
                                    <cfif len(arguments.MagazaIdList)><arr:int>#arguments.MagazaIdList#</arr:int></cfif>
                                </ns:MagazaIdList>
                                <ns:MagazaKodu>#arguments.MagazaKodu#</ns:MagazaKodu>
                                <ns:MagazaKoduList>
                                    <cfif len(arguments.MagazaKoduList)><arr:string>#arguments.MagazaKoduList#</arr:string></cfif>
                                </ns:MagazaKoduList>
                                <cfif len(arguments.StokHareketTarihiBas)><ns:StokHareketTarihiBas>#arguments.StokHareketTarihiBas#</ns:StokHareketTarihiBas></cfif>
                                <cfif len(arguments.StokHareketTarihiSon)><ns:StokHareketTarihiSon>#arguments.StokHareketTarihiSon#</ns:StokHareketTarihiSon></cfif>
                                <cfif len(arguments.StokOlanlar)><ns:StokOlanlar>#arguments.StokOlanlar#</ns:StokOlanlar></cfif>
                                <cfif len(arguments.UrunID)><ns:UrunID>#arguments.UrunID#</ns:UrunID></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                            </tem:request>
                        </tem:SelectMagazaStok>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectMagazaStok"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="StokAdediGuncelle">
        <cfargument  name="Urunler" required="true" hint="Stok adedi güncellenecek varyasyonları içeren Varyasyon sınıfı listesi ">
        <cfargument  name="StokAdedi" required="true" hint="Güncellenecek stok adedi">
        <cfargument  name="ID" required="true" hint="0 gönderilir ise yeni varyasyon eklenir 0 dan büyük gönderilir ise gönderilen id li varyasyon güncellenir">
        <cfargument  name="AlisFiyati" hint="Varyasyona ait alis fiyatı değeri.">
        <cfargument  name="Barkod" hint="Varyasyon barkod değeri.">
        <cfargument  name="Desi" hint="Varyasyon desi değeri.">
        <cfargument  name="KargoUcreti" hint="Varyasyon kargo ücreti değeri">
        <cfargument  name="KdvDahil" hint="Kdv dahil olma durumu.">
        <cfargument  name="KdvOrani" hint="Varyasyon kdv orani değeri.">
        <cfargument  name="Ozellikler" hint="Varyasyonun özellikleri.">
        <cfargument  name="ParaBirimiID" required="true" hint="Varyasyon para birimi (sitede yer alan para birimlerinden biri girilmelidir).">
        <cfargument  name="Resimler" hint="Varyasyon resimleri.">
        <cfargument  name="SatisFiyati" required="true" hint="Satış fiyati değeri.">
        <cfargument  name="StokAdedi" hint="Stok adedi değeri.">
        <cfargument  name="StokKodu" hint="Varyasyon stok kodu.">
        <cfargument  name="Aktif" hint="Varyasyonun aktif olma durumu.">
        <cfargument  name="DuzenleyenKullanici" hint="Düzenleyen kullanıcı id değeri.">
        <cfargument  name="EkleyenKullanici" hint="Ekleyen kullanıcı id değeri.">
        <cfargument  name="EksiStokAdedi" hint="Ayrılacak olan stok adedi.">
        <cfargument  name="IndirimliFiyati" hint="Varyasyon indirimli fiyat değeri.">
        <cfargument  name="ParaBirimi" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="ParaBirimiKodu" hint="Eğer para birimiId girildiyse boş gönderilebilir.">
        <cfargument  name="TedarikciKodu" hint="Tedarikçi koduna göre güncelle true ise zorunlu">
        <cfargument  name="UyeTipiFiyat1" hint="Üye tipi 1 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat2" hint="Üye tipi 2 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat3" hint="Üye tipi 3 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat4" hint="Üye tipi 4 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat5" hint="Üye tipi 5 e özel fiyat değeri">
        <cfargument  name="UyeTipiFiyat7" hint="Üye tipi 7 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat8" hint="Üye tipi 8 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat9" hint="Üye tipi 9 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat10" hint="Üye tipi 10 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat11" hint="Üye tipi 11 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat12" hint="Üye tipi 12 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat13" hint="Üye tipi 13 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat14" hint="Üye tipi 14 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat15" hint="Üye tipi 15 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat16" hint="Üye tipi 16 ya özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat17" hint="Üye tipi 17 ye özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat18" hint="Üye tipi 18 e özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat19" hint="Üye tipi 19 a özel fiyat değeri.">
        <cfargument  name="UyeTipiFiyat20" hint="Üye tipi 20 ye özel fiyat değeri.">
        <cfargument  name="MarketPlaceAktif" default="">
        <cfargument  name="MarketPlaceAktif2" default="">
        <cfargument  name="MarketPlaceAktif3" default="">
        <cfargument  name="MarketPlaceAktif4" default="">
        <cfargument  name="MarketPlaceAktif5" default="">
        <cfargument  name="TahminiTeslimSuresiAyniGun" default="">
        <cfargument  name="TahminiTeslimSuresiGoster" default="">
        <cfargument  name="TahminiTeslimSuresiTarih" default="">
        <cfargument  name="TedarikciKodu2" default="">
        <cfargument  name="Desi2" default="">
        <cfargument  name="IndirimliFiyati1" default="">
        <cfargument  name="IndirimliFiyati2" default="">
        <cfargument  name="IndirimliFiyati3" default="">
        <cfargument  name="IndirimliFiyati4" default="">
        <cfargument  name="IndirimliFiyati5" default="">
        <cfargument  name="IndirimliFiyati6" default="">
        <cfargument  name="IndirimliFiyati7" default="">
        <cfargument  name="IndirimliFiyati8" default="">
        <cfargument  name="IndirimliFiyati9" default="">
        <cfargument  name="IndirimliFiyati10" default="">
        <cfargument  name="IndirimliFiyati11" default="">
        <cfargument  name="IndirimliFiyati12" default="">
        <cfargument  name="IndirimliFiyati13" default="">
        <cfargument  name="IndirimliFiyati14" default="">
        <cfargument  name="IndirimliFiyati15" default="">
        <cfargument  name="IndirimliFiyati16" default="">
        <cfargument  name="IndirimliFiyati17" default="">
        <cfargument  name="IndirimliFiyati18" default="">
        <cfargument  name="IndirimliFiyati19" default="">
        <cfargument  name="IndirimliFiyati20" default="">
        <cfargument  name="IscilikAgirlik" default="">
        <cfargument  name="IscilikParaBirimi" default="">
        <cfargument  name="IscilikParaBirimiId" default="">
        <cfargument  name="IscilikParaBirimiKodu" default="">
        <cfargument  name="KdvDahil1" default="">
        <cfargument  name="KdvDahil2" default="">
        <cfargument  name="KdvDahil3" default="">
        <cfargument  name="KdvDahil4" default="">
        <cfargument  name="KdvDahil5" default="">
        <cfargument  name="KdvDahil7" default="">
        <cfargument  name="KdvDahil8" default="">
        <cfargument  name="KdvDahil9" default="">
        <cfargument  name="KdvDahil10" default="">
        <cfargument  name="KdvDahil11" default="">
        <cfargument  name="KdvDahil12" default="">
        <cfargument  name="KdvDahil13" default="">
        <cfargument  name="KdvDahil14" default="">
        <cfargument  name="KdvDahil15" default="">
        <cfargument  name="KdvDahil16" default="">
        <cfargument  name="KdvDahil17" default="">
        <cfargument  name="KdvDahil18" default="">
        <cfargument  name="KdvDahil19" default="">
        <cfargument  name="KdvDahil20" default="">
        <cfargument  name="KdvOrani1" default="">
        <cfargument  name="KdvOrani2" default="">
        <cfargument  name="KdvOrani3" default="">
        <cfargument  name="KdvOrani4" default="">
        <cfargument  name="KdvOrani5" default="">
        <cfargument  name="KdvOrani6" default="">
        <cfargument  name="KdvOrani7" default="">
        <cfargument  name="KdvOrani8" default="">
        <cfargument  name="KdvOrani9" default="">
        <cfargument  name="KdvOrani10" default="">
        <cfargument  name="KdvOrani11" default="">
        <cfargument  name="KdvOrani12" default="">
        <cfargument  name="KdvOrani13" default="">
        <cfargument  name="KdvOrani14" default="">
        <cfargument  name="KdvOrani15" default="">
        <cfargument  name="KdvOrani16" default="">
        <cfargument  name="KdvOrani17" default="">
        <cfargument  name="KdvOrani18" default="">
        <cfargument  name="KdvOrani19" default="">
        <cfargument  name="KdvOrani20" default="">
        <cfargument  name="MarkaID" default="">
        <cfargument  name="Tur" default="">
        <cfargument  name="XmlKod" default="">
        <cfargument  name="ParaBirimiKodu" default="">
        <cfargument  name="ParaBirimi1Id" default="">
        <cfargument  name="ParaBirimi2Id" default="">
        <cfargument  name="ParaBirimi3Id" default="">
        <cfargument  name="ParaBirimi4Id" default="">
        <cfargument  name="ParaBirimi5Id" default="">
        <cfargument  name="ParaBirimi6Id" default="">
        <cfargument  name="ParaBirimi7Id" default="">
        <cfargument  name="ParaBirimi8Id" default="">
        <cfargument  name="ParaBirimi9Id" default="">
        <cfargument  name="ParaBirimi10Id" default="">
        <cfargument  name="ParaBirimi11Id" default="">
        <cfargument  name="ParaBirimi12Id" default="">
        <cfargument  name="ParaBirimi13Id" default="">
        <cfargument  name="ParaBirimi14Id" default="">
        <cfargument  name="ParaBirimi15Id" default="">
        <cfargument  name="ParaBirimi16Id" default="">
        <cfargument  name="ParaBirimi17Id" default="">
        <cfargument  name="ParaBirimi18Id" default="">
        <cfargument  name="ParaBirimi19Id" default="">
        <cfargument  name="ParaBirimi20Id" default="">
        <cfargument  name="SatisFiyati1" default="">
        <cfargument  name="SatisFiyati2" default="">
        <cfargument  name="SatisFiyati3" default="">
        <cfargument  name="SatisFiyati4" default="">
        <cfargument  name="SatisFiyati5" default="">
        <cfargument  name="SatisFiyati6" default="">
        <cfargument  name="SatisFiyati7" default="">
        <cfargument  name="SatisFiyati8" default="">
        <cfargument  name="SatisFiyati9" default="">
        <cfargument  name="SatisFiyati10" default="">
        <cfargument  name="SatisFiyati11" default="">
        <cfargument  name="SatisFiyati12" default="">
        <cfargument  name="SatisFiyati13" default="">
        <cfargument  name="SatisFiyati14" default="">
        <cfargument  name="SatisFiyati15" default="">
        <cfargument  name="SatisFiyati16" default="">
        <cfargument  name="SatisFiyati17" default="">
        <cfargument  name="SatisFiyati18" default="">
        <cfargument  name="SatisFiyati19" default="">
        <cfargument  name="SatisFiyati20" default="">
        <cfargument  name="StokGuncellemeTarihi" default="">
        <cfargument  name="UpdateKey" default="">
        <cfargument  name="UrunAgirligi" default="">
        <cfargument  name="UrunKartiAktif" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:StokAdediGuncelle>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:urunler>
                                <ns:Varyasyon>
                                <cfif len(arguments.Aktif)><ns:Aktif>#arguments.Aktif#</ns:Aktif></cfif>
                                <cfif len(arguments.AlisFiyati)><ns:AlisFiyati>#arguments.AlisFiyati#</ns:AlisFiyati></cfif>
                                <cfif len(arguments.Barkod)><ns:Barkod>#arguments.Barkod#</ns:Barkod></cfif>
                                <ns:Barkodlar>
                                    <cfif len(arguments.Barkod)><arr:string>#arguments.Barkod#</arr:string></cfif>
                                </ns:Barkodlar>
                                <cfif len(arguments.Desi)><ns:Desi>#arguments.Desi#</ns:Desi></cfif>
                                <cfif len(arguments.Desi2)><ns:Desi2>#arguments.Desi2#</ns:Desi2></cfif>
                                <cfif len(arguments.DuzenleyenKullanici)><ns:DuzenleyenKullanici>#arguments.DuzenleyenKullanici#</ns:DuzenleyenKullanici></cfif>
                                <cfif len(arguments.EkleyenKullanici)><ns:EkleyenKullanici>#arguments.EkleyenKullanici#</ns:EkleyenKullanici></cfif>
                                <cfif len(arguments.EksiStokAdedi)><ns:EksiStokAdedi>#arguments.EksiStokAdedi#</ns:EksiStokAdedi></cfif>
                                <ns:ID>#arguments.ID#</ns:ID>
                                <cfif len(arguments.IndirimliFiyati)><ns:IndirimliFiyati>#arguments.IndirimliFiyati#</ns:IndirimliFiyati></cfif>
                                <cfif len(arguments.IndirimliFiyati1)><ns:IndirimliFiyati1>#arguments.IndirimliFiyati1#</ns:IndirimliFiyati1></cfif>
                                <cfif len(arguments.IndirimliFiyati10)><ns:IndirimliFiyati10>#arguments.IndirimliFiyati10#</ns:IndirimliFiyati10></cfif>
                                <cfif len(arguments.IndirimliFiyati11)><ns:IndirimliFiyati11>#arguments.IndirimliFiyati11#</ns:IndirimliFiyati11></cfif>
                                <cfif len(arguments.IndirimliFiyati12)><ns:IndirimliFiyati12>#arguments.IndirimliFiyati12#</ns:IndirimliFiyati12></cfif>
                                <cfif len(arguments.IndirimliFiyati13)><ns:IndirimliFiyati13>#arguments.IndirimliFiyati13#</ns:IndirimliFiyati13></cfif>
                                <cfif len(arguments.IndirimliFiyati14)><ns:IndirimliFiyati14>#arguments.IndirimliFiyati14#</ns:IndirimliFiyati14></cfif>
                                <cfif len(arguments.IndirimliFiyati15)><ns:IndirimliFiyati15>#arguments.IndirimliFiyati15#</ns:IndirimliFiyati15></cfif>
                                <cfif len(arguments.IndirimliFiyati16)><ns:IndirimliFiyati16>#arguments.IndirimliFiyati16#</ns:IndirimliFiyati16></cfif>
                                <cfif len(arguments.IndirimliFiyati17)><ns:IndirimliFiyati17>#arguments.IndirimliFiyati17#</ns:IndirimliFiyati17></cfif>
                                <cfif len(arguments.IndirimliFiyati18)><ns:IndirimliFiyati18>#arguments.IndirimliFiyati18#</ns:IndirimliFiyati18></cfif>
                                <cfif len(arguments.IndirimliFiyati19)><ns:IndirimliFiyati19>#arguments.IndirimliFiyati19#</ns:IndirimliFiyati19></cfif>
                                <cfif len(arguments.IndirimliFiyati2)><ns:IndirimliFiyati2>#arguments.IndirimliFiyati2#</ns:IndirimliFiyati2></cfif>
                                <cfif len(arguments.IndirimliFiyati20)><ns:IndirimliFiyati20>#arguments.IndirimliFiyati20#</ns:IndirimliFiyati20></cfif>
                                <cfif len(arguments.IndirimliFiyati3)><ns:IndirimliFiyati3>#arguments.IndirimliFiyati3#</ns:IndirimliFiyati3></cfif>
                                <cfif len(arguments.IndirimliFiyati4)><ns:IndirimliFiyati4>#arguments.IndirimliFiyati4#</ns:IndirimliFiyati4></cfif>
                                <cfif len(arguments.IndirimliFiyati5)><ns:IndirimliFiyati5>#arguments.IndirimliFiyati5#</ns:IndirimliFiyati5></cfif>
                                <cfif len(arguments.IndirimliFiyati6)><ns:IndirimliFiyati6>#arguments.IndirimliFiyati6#</ns:IndirimliFiyati6></cfif>
                                <cfif len(arguments.IndirimliFiyati7)><ns:IndirimliFiyati7>#arguments.IndirimliFiyati7#</ns:IndirimliFiyati7></cfif>
                                <cfif len(arguments.IndirimliFiyati8)><ns:IndirimliFiyati8>#arguments.IndirimliFiyati8#</ns:IndirimliFiyati8></cfif>
                                <cfif len(arguments.IndirimliFiyati9)><ns:IndirimliFiyati9>#arguments.IndirimliFiyati9#</ns:IndirimliFiyati9></cfif>
                                <cfif len(arguments.IscilikAgirlik)><ns:IscilikAgirlik>#arguments.IscilikAgirlik#</ns:IscilikAgirlik></cfif>
                                <cfif len(arguments.IscilikParaBirimi)><ns:IscilikParaBirimi>#arguments.IscilikParaBirimi#</ns:IscilikParaBirimi></cfif>
                                <cfif len(arguments.IscilikParaBirimiId)><ns:IscilikParaBirimiId>#arguments.IscilikParaBirimiId#</ns:IscilikParaBirimiId></cfif>
                                <cfif len(arguments.IscilikParaBirimiKodu)><ns:IscilikParaBirimiKodu>#arguments.IscilikParaBirimiKodu#</ns:IscilikParaBirimiKodu></cfif>
                                <cfif len(arguments.KargoUcreti)><ns:KargoUcreti>#arguments.KargoUcreti#</ns:KargoUcreti></cfif>
                                <ns:Kategoriler>
                                    <arr:int>#arguments.Kategoriler#</arr:int>
                                </ns:Kategoriler>
                                <cfif len(arguments.KdvDahil)><ns:KdvDahil>#arguments.KdvDahil#</ns:KdvDahil></cfif>
                                <cfif len(arguments.KdvDahil1)><ns:KdvDahil1>?#arguments.KdvDahil1#</ns:KdvDahil1></cfif>
                                <cfif len(arguments.KdvDahil10)><ns:KdvDahil10>#arguments.KdvDahil10#</ns:KdvDahil10></cfif>
                                <cfif len(arguments.KdvDahil11)><ns:KdvDahil11>#arguments.KdvDahil11#</ns:KdvDahil11></cfif>
                                <cfif len(arguments.KdvDahil12)><ns:KdvDahil12>#arguments.KdvDahil12#</ns:KdvDahil12></cfif>
                                <cfif len(arguments.KdvDahil13)><ns:KdvDahil13>#arguments.KdvDahil13#</ns:KdvDahil13></cfif>
                                <cfif len(arguments.KdvDahil14)><ns:KdvDahil14>#arguments.KdvDahil14#</ns:KdvDahil14></cfif>
                                <cfif len(arguments.KdvDahil15)><ns:KdvDahil15>#arguments.KdvDahil15#</ns:KdvDahil15></cfif>
                                <cfif len(arguments.KdvDahil16)><ns:KdvDahil16>#arguments.KdvDahil16#</ns:KdvDahil16></cfif>
                                <cfif len(arguments.KdvDahil17)><ns:KdvDahil17>#arguments.KdvDahil17#</ns:KdvDahil17></cfif>
                                <cfif len(arguments.KdvDahil18)><ns:KdvDahil18>#arguments.KdvDahil18#</ns:KdvDahil18></cfif>
                                <cfif len(arguments.KdvDahil19)><ns:KdvDahil19>#arguments.KdvDahil19#</ns:KdvDahil19></cfif>
                                <cfif len(arguments.KdvDahil2)><ns:KdvDahil2>#arguments.KdvDahil2#</ns:KdvDahil2></cfif>
                                <cfif len(arguments.KdvDahil20)><ns:KdvDahil20>#arguments.KdvDahil20#</ns:KdvDahil20></cfif>
                                <cfif len(arguments.KdvDahil3)><ns:KdvDahil3>#arguments.KdvDahil3#</ns:KdvDahil3></cfif>
                                <cfif len(arguments.KdvDahil4)><ns:KdvDahil4>#arguments.KdvDahil4#</ns:KdvDahil4></cfif>
                                <cfif len(arguments.KdvDahil5)><ns:KdvDahil5>#arguments.KdvDahil5#</ns:KdvDahil5></cfif>
                                <cfif len(arguments.KdvDahil6)><ns:KdvDahil6>#arguments.KdvDahil6#</ns:KdvDahil6></cfif>
                                <cfif len(arguments.KdvDahil7)><ns:KdvDahil7>#arguments.KdvDahil7#</ns:KdvDahil7></cfif>
                                <cfif len(arguments.KdvDahil8)><ns:KdvDahil8>#arguments.KdvDahil8#</ns:KdvDahil8></cfif>
                                <cfif len(arguments.KdvDahil9)><ns:KdvDahil9>#arguments.KdvDahil9#</ns:KdvDahil9></cfif>
                                <cfif len(arguments.KdvOrani)><ns:KdvOrani>#arguments.KdvOrani#</ns:KdvOrani></cfif>
                                <cfif len(arguments.KdvOrani1)><ns:KdvOrani1>#arguments.KdvOrani1#</ns:KdvOrani1></cfif>
                                <cfif len(arguments.KdvOrani10)><ns:KdvOrani10>#arguments.KdvOrani10#</ns:KdvOrani10></cfif>
                                <cfif len(arguments.KdvOrani11)><ns:KdvOrani11>#arguments.KdvOrani11#</ns:KdvOrani11></cfif>
                                <cfif len(arguments.KdvOrani12)><ns:KdvOrani12>#arguments.KdvOrani12#</ns:KdvOrani12></cfif>
                                <cfif len(arguments.KdvOrani13)><ns:KdvOrani13>#arguments.KdvOrani13#</ns:KdvOrani13></cfif>
                                <cfif len(arguments.KdvOrani14)><ns:KdvOrani14>#arguments.KdvOrani14#</ns:KdvOrani14></cfif>
                                <cfif len(arguments.KdvOrani15)><ns:KdvOrani15>#arguments.KdvOrani15#</ns:KdvOrani15></cfif>
                                <cfif len(arguments.KdvOrani16)><ns:KdvOrani16>#arguments.KdvOrani16#</ns:KdvOrani16></cfif>
                                <cfif len(arguments.KdvOrani17)><ns:KdvOrani17>#arguments.KdvOrani17#</ns:KdvOrani17></cfif>
                                <cfif len(arguments.KdvOrani18)><ns:KdvOrani18>#arguments.KdvOrani18#</ns:KdvOrani18></cfif>
                                <cfif len(arguments.KdvOrani19)><ns:KdvOrani19>#arguments.KdvOrani19#</ns:KdvOrani19></cfif>
                                <cfif len(arguments.KdvOrani2)><ns:KdvOrani2>#arguments.KdvOrani2#</ns:KdvOrani2></cfif>
                                <cfif len(arguments.KdvOrani20)><ns:KdvOrani20>#arguments.KdvOrani20#</ns:KdvOrani20></cfif>
                                <cfif len(arguments.KdvOrani3)><ns:KdvOrani3>#arguments.KdvOrani3#</ns:KdvOrani3></cfif>
                                <cfif len(arguments.KdvOrani4)><ns:KdvOrani4>#arguments.KdvOrani4#</ns:KdvOrani4></cfif>
                                <cfif len(arguments.KdvOrani5)><ns:KdvOrani5>#arguments.KdvOrani5#</ns:KdvOrani5></cfif>
                                <cfif len(arguments.KdvOrani6)><ns:KdvOrani6>#arguments.KdvOrani6#</ns:KdvOrani6></cfif>
                                <cfif len(arguments.KdvOrani7)><ns:KdvOrani7>#arguments.KdvOrani7#</ns:KdvOrani7></cfif>
                                <cfif len(arguments.KdvOrani8)><ns:KdvOrani8>#arguments.KdvOrani8#</ns:KdvOrani8></cfif>
                                <cfif len(arguments.KdvOrani9)><ns:KdvOrani9>#arguments.KdvOrani9#</ns:KdvOrani9></cfif>
                                <cfif len(arguments.MarkaID)><ns:MarkaID>#arguments.MarkaID#</ns:MarkaID></cfif>
                                <!-----buralardaki marketplaceaktif kısımları varyasyon için geçerli bunlar varyasyon olarak tanımlanmalı mı yoksa bu şekilde devam mı?---->
                                <cfif len(arguments.MarketPlaceAktif)><ns:MarketPlaceAktif>#arguments.MarketPlaceAktif#</ns:MarketPlaceAktif></cfif>
                                <cfif len(arguments.MarketPlaceAktif2)><ns:MarketPlaceAktif2>#arguments.MarketPlaceAktif2#</ns:MarketPlaceAktif2></cfif>
                                <cfif len(arguments.MarketPlaceAktif3)><ns:MarketPlaceAktif3>#arguments.MarketPlaceAktif3#</ns:MarketPlaceAktif3></cfif>
                                <cfif len(arguments.MarketPlaceAktif4)><ns:MarketPlaceAktif4>#arguments.MarketPlaceAktif4#</ns:MarketPlaceAktif4></cfif>
                                <cfif len(arguments.MarketPlaceAktif5)><ns:MarketPlaceAktif5>#arguments.MarketPlaceAktif5#</ns:MarketPlaceAktif5></cfif>
                                <ns:Ozellikler>
                                    <ns:VaryasyonOzellik>
                                    <ns:Deger>#arguments.Deger#</ns:Deger>
                                    <ns:Tanim>#arguments.Tanim#</ns:Tanim>
                                    <cfif len(arguments.Tur)><ns:Tur>#arguments.Tur#</ns:Tur></cfif>
                                    <cfif len(arguments.XmlKod)><ns:XmlKod>#arguments.XmlKod#</ns:XmlKod></cfif>
                                    </ns:VaryasyonOzellik>
                                </ns:Ozellikler>
                                <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                <cfif len(arguments.ParaBirimi10Id)><ns:ParaBirimi10Id>#arguments.ParaBirimi10Id#</ns:ParaBirimi10Id></cfif>                    
                                <cfif len(arguments.ParaBirimi11Id)><ns:ParaBirimi11Id>#arguments.ParaBirimi11Id#</ns:ParaBirimi11Id></cfif>
                                <cfif len(arguments.ParaBirimi12Id)><ns:ParaBirimi12Id>#arguments.ParaBirimi12Id#</ns:ParaBirimi12Id></cfif>
                                <cfif len(arguments.ParaBirimi13Id)><ns:ParaBirimi13Id>#arguments.ParaBirimi13Id#</ns:ParaBirimi13Id></cfif>
                                <cfif len(arguments.ParaBirimi14Id)><ns:ParaBirimi14Id>#arguments.ParaBirimi14Id#</ns:ParaBirimi14Id></cfif>
                                <cfif len(arguments.ParaBirimi15Id)><ns:ParaBirimi15Id>#arguments.ParaBirimi15Id#</ns:ParaBirimi15Id></cfif>
                                <cfif len(arguments.ParaBirimi16Id)><ns:ParaBirimi16Id>#arguments.ParaBirimi16Id#</ns:ParaBirimi16Id></cfif>
                                <cfif len(arguments.ParaBirimi17Id)><ns:ParaBirimi17Id>#arguments.ParaBirimi17Id#</ns:ParaBirimi17Id></cfif>
                                <cfif len(arguments.ParaBirimi18Id)><ns:ParaBirimi18Id>#arguments.ParaBirimi18Id#</ns:ParaBirimi18Id></cfif>
                                <cfif len(arguments.ParaBirimi19Id)><ns:ParaBirimi19Id>#arguments.ParaBirimi19Id#</ns:ParaBirimi19Id></cfif>
                                <cfif len(arguments.ParaBirimi1Id)><ns:ParaBirimi1Id>#arguments.ParaBirimi1Id#</ns:ParaBirimi1Id></cfif>
                                <cfif len(arguments.ParaBirimi20Id)><ns:ParaBirimi20Id>#arguments.ParaBirimi20Id#</ns:ParaBirimi20Id></cfif>
                                <cfif len(arguments.ParaBirimi2Id)><ns:ParaBirimi2Id>#arguments.ParaBirimi2Id#</ns:ParaBirimi2Id></cfif>
                                <cfif len(arguments.ParaBirimi3Id)><ns:ParaBirimi3Id>#arguments.ParaBirimi3Id#</ns:ParaBirimi3Id></cfif>
                                <cfif len(arguments.ParaBirimi4Id)><ns:ParaBirimi4Id>#arguments.ParaBirimi4Id#</ns:ParaBirimi4Id></cfif>
                                <cfif len(arguments.ParaBirimi5Id)><ns:ParaBirimi5Id>#arguments.ParaBirimi5Id#</ns:ParaBirimi5Id></cfif>
                                <cfif len(arguments.ParaBirimi6Id)><ns:ParaBirimi6Id>#arguments.ParaBirimi6Id#</ns:ParaBirimi6Id></cfif>
                                <cfif len(arguments.ParaBirimi7Id)><ns:ParaBirimi7Id>#arguments.ParaBirimi7Id#</ns:ParaBirimi7Id></cfif>
                                <cfif len(arguments.ParaBirimi8Id)><ns:ParaBirimi8Id>#arguments.ParaBirimi8Id#</ns:ParaBirimi8Id></cfif>
                                <cfif len(arguments.ParaBirimi9Id)><ns:ParaBirimi9Id>#arguments.ParaBirimi9Id#</ns:ParaBirimi9Id></cfif>
                                <ns:ParaBirimiID>#arguments.ParaBirimiID#</ns:ParaBirimiID>
                                <cfif len(arguments.ParaBirimiKodu)><ns:ParaBirimiKodu>#arguments.ParaBirimiKodu#</ns:ParaBirimiKodu></cfif>                    
                                <ns:Resimler>
                                    <cfif len(arguments.Resimler)><arr:string>#arguments.Resimler#</arr:string></cfif>
                                </ns:Resimler>
                                <ns:SatisFiyati>#arguments.VaryasyonSatisFiyati#</ns:SatisFiyati>
                                <cfif len(arguments.SatisFiyati1)><ns:SatisFiyati1>#arguments.SatisFiyati1#</ns:SatisFiyati1></cfif>
                                <cfif len(arguments.SatisFiyati10)><ns:SatisFiyati10>#arguments.SatisFiyati10#</ns:SatisFiyati10></cfif>
                                <cfif len(arguments.SatisFiyati11)><ns:SatisFiyati11>#arguments.SatisFiyati11#</ns:SatisFiyati11></cfif>
                                <cfif len(arguments.SatisFiyati12)><ns:SatisFiyati12>#arguments.SatisFiyati12#</ns:SatisFiyati12></cfif>
                                <cfif len(arguments.SatisFiyati13)><ns:SatisFiyati13>#arguments.SatisFiyati13#</ns:SatisFiyati13></cfif>
                                <cfif len(arguments.SatisFiyati14)><ns:SatisFiyati14>#arguments.SatisFiyati14#</ns:SatisFiyati14></cfif>
                                <cfif len(arguments.SatisFiyati15)><ns:SatisFiyati15>#arguments.SatisFiyati15#</ns:SatisFiyati15></cfif>
                                <cfif len(arguments.SatisFiyati16)><ns:SatisFiyati16>#arguments.SatisFiyati16#</ns:SatisFiyati16></cfif>
                                <cfif len(arguments.SatisFiyati17)><ns:SatisFiyati17>#arguments.SatisFiyati17#</ns:SatisFiyati17></cfif>
                                <cfif len(arguments.SatisFiyati18)><ns:SatisFiyati18>#arguments.SatisFiyati18#</ns:SatisFiyati18></cfif>
                                <cfif len(arguments.SatisFiyati19)><ns:SatisFiyati19>#arguments.SatisFiyati19#</ns:SatisFiyati19></cfif>
                                <cfif len(arguments.SatisFiyati2)><ns:SatisFiyati2>#arguments.SatisFiyati2#</ns:SatisFiyati2></cfif>
                                <cfif len(arguments.SatisFiyati20)><ns:SatisFiyati20>#arguments.SatisFiyati20#</ns:SatisFiyati20></cfif>
                                <cfif len(arguments.SatisFiyati3)><ns:SatisFiyati3>#arguments.SatisFiyati3#</ns:SatisFiyati3></cfif>
                                <cfif len(arguments.SatisFiyati4)><ns:SatisFiyati4>#arguments.SatisFiyati4#</ns:SatisFiyati4></cfif>
                                <cfif len(arguments.SatisFiyati5)><ns:SatisFiyati5>#arguments.SatisFiyati5#</ns:SatisFiyati5></cfif>
                                <cfif len(arguments.SatisFiyati6)><ns:SatisFiyati6>#arguments.SatisFiyati6#</ns:SatisFiyati6></cfif>
                                <cfif len(arguments.SatisFiyati7)><ns:SatisFiyati7>#arguments.SatisFiyati7#</ns:SatisFiyati7></cfif>
                                <cfif len(arguments.SatisFiyati8)<ns:SatisFiyati8>#arguments.SatisFiyati8#</ns:SatisFiyati8></cfif>
                                <cfif len(arguments.SatisFiyati9)><ns:SatisFiyati9>#arguments.SatisFiyati9#</ns:SatisFiyati9></cfif>
                                <cfif len(arguments.StokAdedi)><ns:StokAdedi>#arguments.StokAdedi#</ns:StokAdedi></cfif>
                                <cfif len(arguments.StokGuncellemeTarihi)><ns:StokGuncellemeTarihi>#arguments.StokGuncellemeTarihi#</ns:StokGuncellemeTarihi></cfif>
                                <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                <!-----tahmini teslim süresi yukarıda ürün için tanımlanmış varyasyon için tanımlayıp onu mu almam gerekiyor yoksa aynı argumentden devam mı şu an yaptığım aynısı ------>
                                <cfif len(arguments.TahminiTeslimSuresi)><ns:TahminiTeslimSuresi>#arguments.TahminiTeslimSuresi#</ns:TahminiTeslimSuresi></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiAyniGun)><ns:TahminiTeslimSuresiAyniGun>#arguments.TahminiTeslimSuresiAyniGun#</ns:TahminiTeslimSuresiAyniGun></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiGoster)><ns:TahminiTeslimSuresiGoster>#arguments.TahminiTeslimSuresiGoster#</ns:TahminiTeslimSuresiGoster></cfif>
                                <cfif len(arguments.TahminiTeslimSuresiTarih)><ns:TahminiTeslimSuresiTarih>#arguments.TahminiTeslimSuresiTarih#</ns:TahminiTeslimSuresiTarih></cfif>
                                <cfif len(arguments.TedarikciKodu)><ns:TedarikciKodu>#arguments.TedarikciKodu#</ns:TedarikciKodu></cfif>
                                <cfif len(arguments.TedarikciKodu2)><ns:TedarikciKodu2>#arguments.TedarikciKodu2#</ns:TedarikciKodu2></cfif>
                                <cfif len(arguments.UpdateKey)><ns:UpdateKey>#arguments.UpdateKey#</ns:UpdateKey></cfif>
                                <cfif len(arguemnts.UrunAgirligi)><ns:UrunAgirligi>#arguments.UrunAgirligi#</ns:UrunAgirligi></cfif>
                                <cfif len(arguments.UrunKartiAktif)><ns:UrunKartiAktif>#arguments.UrunKartiAktif#</ns:UrunKartiAktif></cfif>
                                <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                <cfif len(arguments.UyeTipiFiyat1)><ns:UyeTipiFiyat1>#arguments.UyeTipiFiyat1#</ns:UyeTipiFiyat1></cfif>
                                <cfif len(arguments.UyeTipiFiyat10)><ns:UyeTipiFiyat10>#arguments.UyeTipiFiyat10#</ns:UyeTipiFiyat10></cfif>
                                <cfif len(arguments.UyeTipiFiyat11)><ns:UyeTipiFiyat11>#arguments.UyeTipiFiyat11#</ns:UyeTipiFiyat11></cfif>
                                <cfif len(arguments.UyeTipiFiyat12)><ns:UyeTipiFiyat12>#arguments.UyeTipiFiyat12#</ns:UyeTipiFiyat12></cfif>
                                <cfif len(arguments.UyeTipiFiyat13)><ns:UyeTipiFiyat13>#arguments.UyeTipiFiyat13#</ns:UyeTipiFiyat13></cfif>
                                <cfif len(arguments.UyeTipiFiyat14)><ns:UyeTipiFiyat14>#arguments.UyeTipiFiyat14#</ns:UyeTipiFiyat14></cfif>
                                <cfif len(arguments.UyeTipiFiyat15)><ns:UyeTipiFiyat15>#arguments.UyeTipiFiyat15#</ns:UyeTipiFiyat15></cfif>
                                <cfif len(arguments.UyeTipiFiyat16)><ns:UyeTipiFiyat16>#arguments.UyeTipiFiyat16#</ns:UyeTipiFiyat16></cfif>
                                <cfif len(arguments.UyeTipiFiyat17)><ns:UyeTipiFiyat17>#arguments.UyeTipiFiyat17#</ns:UyeTipiFiyat17></cfif>
                                <cfif len(arguments.UyeTipiFiyat18)><ns:UyeTipiFiyat18>#arguments.UyeTipiFiyat18#</ns:UyeTipiFiyat18></cfif>
                                <cfif len(arguments.UyeTipiFiyat19)><ns:UyeTipiFiyat19>#arguments.UyeTipiFiyat19#</ns:UyeTipiFiyat19></cfif>
                                <cfif len(arguments.UyeTipiFiyat2)><ns:UyeTipiFiyat2>#arguments.UyeTipiFiyat2#</ns:UyeTipiFiyat2></cfif>
                                <cfif len(arguments.UyeTipiFiyat20)><ns:UyeTipiFiyat20>#arguments.UyeTipiFiyat20#</ns:UyeTipiFiyat20></cfif>
                                <cfif len(arguments.UyeTipiFiyat3)><ns:UyeTipiFiyat3>#arguments.UyeTipiFiyat3#</ns:UyeTipiFiyat3></cfif>
                                <cfif len(arguments.UyeTipiFiyat4)><ns:UyeTipiFiyat4>#arguments.UyeTipiFiyat4#</ns:UyeTipiFiyat4></cfif>
                                <cfif len(arguments.UyeTipiFiyat5)><ns:UyeTipiFiyat5>#arguments.UyeTipiFiyat5#</ns:UyeTipiFiyat5></cfif>
                                <cfif len(arguments.UyeTipiFiyat6)><ns:UyeTipiFiyat6>#arguments.UyeTipiFiyat6#</ns:UyeTipiFiyat6></cfif>
                                <cfif len(arguments.UyeTipiFiyat7)><ns:UyeTipiFiyat7>#arguments.UyeTipiFiyat7#</ns:UyeTipiFiyat7></cfif>
                                <cfif len(arguments.UyeTipiFiyat8)><ns:UyeTipiFiyat8>#arguments.UyeTipiFiyat8#</ns:UyeTipiFiyat8></cfif>
                                <cfif len(arguments.UyeTipiFiyat9)><ns:UyeTipiFiyat9>#arguments.UyeTipiFiyat9#</ns:UyeTipiFiyat9></cfif>
                                </ns:Varyasyon>
                            </tem:urunler>
                        </tem:StokAdediGuncelle>
                    </soapenv:Body>
                    </soapenv:Envelope>
            </cfoutput>
        </cfxml>
    </cffunction>
</cfcomponent>
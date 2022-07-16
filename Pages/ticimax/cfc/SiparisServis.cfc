<cfcomponent>
    <cfset UyeKodu="4SRYTUATO1QM23K6OBQ9AXTB42PZKX">
    <cfset web_service_url="https://ashleyturkiye.ticimaxdemo.com/Servis/SiparisServis.svc">
    <cffunction  name="SaveSiparis">
        <cfargument  name="Siparis" required="true" hint="Sipariş bilgilerini içeren WebSiparisSaveRequest sınıfı.">
        <cfargument  name="FaturaAdresId" required="true" hint=" Kayıtlı fatura adres id.">
        <cfargument  name="IndirimTutari" hint="İndirim tutar değeri.">
        <cfargument  name="KargoAdresId" required="true" hint="Kayıtlı kargo adres id.">
        <cfargument  name="KargoFirmaId" required="true" hint="Kayıtlı kargo firma id.">
        <cfargument  name="KargoTutari" hint="Kargo tutarı.">
        <cfargument  name="Odeme" required="true" hint="Ödeme sınıfı">
        <cfargument  name="ParaBirimi" hint="Para birimi değeri.">
        <cfargument  name="SiparisKaynagi" hint="Sipariş kaynağı değeri.">
        <cfargument  name="SiparisNotu" hint="Sipariş notu.">
        <cfargument  name="Urunler" required="true" hint="Sipariş içerisindeki ürünlerin listesi.">
        <cfargument  name="UrunTutari" required="true" hint="Tutar">
        <cfargument  name="UrunTutariKdv" hint="Kdv değeri.">
        <cfargument  name="UyeId" required="true" hint="Siparişi veren üyenin id değeri.">
        <cfargument  name="BankaKomisyonu" hint="Banka komisyon değeri.">
        <cfargument  name="HavaleHesapID" hint="Kayıtlı havale hesap id">
        <cfargument  name="KapidaOdemeTutari" hint="Kapıda ödeme tutarı.">
        <cfargument  name="OdemeDurumu" required="true" hint="Ödeme Durumu Değişkenleri">
        <cfargument  name="OdemeIndirimi" hint="Ödeme indirim.">
        <cfargument  name="OdemeNotu" hint="Ödeme notu.">
        <cfargument  name="OdemeSecenekID" required="true" hint="Tanımlı olan ödeme seçenek id değeri.">
        <cfargument  name="OdemeTipi" required="true" hint="Ödeme Tipi Değişkenleri">
        <cfargument  name="TaksitSayisi" hint="Taksit sayısı.">
        <cfargument  name="Tarih" hint="Tarih değeri.">
        <cfargument  name="Tutar" required="true" hint="Tutar2">
        <cfargument  name="Adet" required="true" hint="Sipariş edilen ürün adedi.">
        <cfargument  name="KdvOrani" hint="Kdv oranı">
        <cfargument  name="KdvTutari" hint="Kdv tutarı değeri">
        <cfargument  name="Maliyet" hint="Maliyet değeri.">
        <cfargument  name="Tutar2" required="true" hint="Ürün tutarı.">
        <cfargument  name="UrunID" required="true" hint="Ürün id değeri.">
        <cfargument  name="Adres" default="">
        <cfargument  name="AdresTarifi" default="">
        <cfargument  name="AliciTelefon" default="">
        <cfargument  name="EntegrasyonId" default="">
        <cfargument  name="FirmaAdi" default="">
        <cfargument  name="Il" default="">
        <cfargument  name="Ilce" default="">
        <cfargument  name="Mahalle" default="">
        <cfargument  name="PostaKodu" default="">
        <cfargument  name="Semt" default="">
        <cfargument  name="Ulke" default="">
        <cfargument  name="VergiDairesi" default="">
        <cfargument  name="VergiNo" default="">
        <cfargument  name="isKurumsal" default="">
        <cfargument  name="KdvOraniniSiparisUrundenAl" default="">
        <cfargument  name="MaliyetiSiparisUrundenAl" default="">
        <cfargument  name="MarketplaceKampanyaKodu" default="">
        <cfargument  name="OzelAlan1" default="">
        <cfargument  name="OzelAlan2" default="">
        <cfargument  name="OzelAlan3" default="">
        <cfargument  name="ReferansNo" default="">
        <cfargument  name="SiparisNo" default="">
        <cfargument  name="AliciAdi" default="">
        <cfargument  name="TeslimatSaati" default="">
        <cfargument  name="TeslimatTarihi" default="">
        <cfargument  name="MagazaId" default="">
        <cfargument  name="UyeAdi" default="">
        <cfargument  name="UyeCep" default="">
        <cfargument  name="UyeKazanimAktif" default="">
        <cfargument  name="UyeMail" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveSiparis>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparis>
                                <ns:FaturaAdres>
                                <cfif len(arguments.Adres)><ns:Adres>#arguments.Adres#</ns:Adres></cfif>
                                <cfif len(arguments.AdresTarifi)><ns:AdresTarifi>#arguments.AdresTarifi#</ns:AdresTarifi></cfif>
                                <cfif len(arguments.AliciTelefon)><ns:AliciTelefon>#arguments.AliciTelefon#</ns:AliciTelefon></cfif>
                                <cfif len(arguments.EntegrasyonId)><ns:EntegrasyonId>#arguments.EntegrasyonId#</ns:EntegrasyonId></cfif>
                                <cfif len(arguments.FirmaAdi)><ns:FirmaAdi>#arguments.FirmaAdi#</ns:FirmaAdi></cfif>
                                <cfif len(arguments.Il)><ns:Il>#arguments.Il#</ns:Il></cfif>
                                <cfif len(arguments.Ilce)><ns:Ilce>#arguments.Ilce#</ns:Ilce></cfif>
                                <cfif len(arguments.Mahalle)><ns:Mahalle>#arguments.Mahalle#</ns:Mahalle></cfif>
                                <cfif len(arguments.PostaKodu)><ns:PostaKodu>#arguments.PostaKodu#</ns:PostaKodu></cfif>
                                <cfif len(arguments.Semt)><ns:Semt>#arguments.Semt#</ns:Semt></cfif>
                                <cfif len(arguments.Ulke)><ns:Ulke>#arguments.Ulke#</ns:Ulke></cfif>
                                <cfif len(arguments.VergiDairesi)><ns:VergiDairesi>#arguments.VergiDairesi#</ns:VergiDairesi></cfif>
                                <cfif len(arguments.VergiNo)><ns:VergiNo>#arguments.VergiNo#</ns:VergiNo></cfif>
                                <cfif len(arguments.isKurumsal)><ns:isKurumsal>#arguments.isKurumsal#</ns:isKurumsal></cfif>
                                </ns:FaturaAdres>
                                <ns:FaturaAdresId>#arguments.FaturaAdresId#</ns:FaturaAdresId>
                                <cfif len(arguments.IndirimTutari)><ns:IndirimTutari>#arguments.IndirimTutari#</ns:IndirimTutari></cfif>
                                <ns:KargoAdresId>#arguments.KargoAdresId#</ns:KargoAdresId>
                                <ns:KargoFirmaId>#arguments.KargoFirmaId#</ns:KargoFirmaId>
                                <cfif len(arguments.KargoTutari)><ns:KargoTutari>#arguments.KargoTutari#</ns:KargoTutari></cfif>
                                <cfif len(arguments.KdvOraniniSiparisUrundenAl)><ns:KdvOraniniSiparisUrundenAl>#arguments.KdvOraniniSiparisUrundenAl#</ns:KdvOraniniSiparisUrundenAl></cfif>
                                <cfif len(arguments.MaliyetiSiparisUrundenAl)><ns:MaliyetiSiparisUrundenAl>#arguments.MaliyetiSiparisUrundenAl#</ns:MaliyetiSiparisUrundenAl></cfif>
                                <cfif len(arguments.MarketplaceKampanyaKodu)><ns:MarketplaceKampanyaKodu>#arguments.MarketplaceKampanyaKodu#</ns:MarketplaceKampanyaKodu></cfif>
                                <ns:Odeme>
                                <cfif len(arguments.BankaKomisyonu)><ns:BankaKomisyonu>#arguments.BankaKomisyonu#</ns:BankaKomisyonu></cfif>
                                <cfif len(arguments.HavaleHesapID)><ns:HavaleHesapID>#arguments.HavaleHesapID#</ns:HavaleHesapID></cfif>
                                <cfif len(arguments.KapidaOdemeTutari)><ns:KapidaOdemeTutari>#arguments.KapidaOdemeTutari#</ns:KapidaOdemeTutari></cfif>
                                <ns:OdemeDurumu>#argumnets.OdemeDurumu#</ns:OdemeDurumu>
                                <cfif len(arguments.OdemeIndirimi)><ns:OdemeIndirimi>#arguments.OdemeIndirimi#</ns:OdemeIndirimi></cfif>
                                <cfif len(arguments.OdemeNotu)><ns:OdemeNotu>#arguments.OdemeNotu#</ns:OdemeNotu></cfif>
                                <ns:OdemeSecenekID>#arguments.OdemeSecenekID#</ns:OdemeSecenekID>
                                <ns:OdemeTipi>#arguments.OdemeTipi#</ns:OdemeTipi>
                                <cfif len(arguments.TaksitSayisi)><ns:TaksitSayisi>#arguments.TaksitSayisi#</ns:TaksitSayisi></cfif>
                                <cfif len(arguments.Tarih)><ns:Tarih>#arguments.Tarih#</ns:Tarih></cfif>
                                <ns:Tutar>#arguments.Tutar#</ns:Tutar>
                                </ns:Odeme>
                                <ns:Odemeler>
                                <ns:WebSiparisSaveOdeme>
                                    <cfif len(arguments.BankaKomisyonu)><ns:BankaKomisyonu>#arguments.BankaKomisyonu#</ns:BankaKomisyonu></cfif>
                                    <cfif len(arguments.HavaleHesapID)><ns:HavaleHesapID>#arguments.HavaleHesapID#</ns:HavaleHesapID></cfif>
                                    <cfif len(arguments.KapidaOdemeTutari)><ns:KapidaOdemeTutari>#arguments.KapidaOdemeTutari#</ns:KapidaOdemeTutari></cfif>
                                    <ns:OdemeDurumu>#arguments.OdemeDurumu#</ns:OdemeDurumu>
                                    <cfif len(arguments.OdemeIndirimi)><ns:OdemeIndirimi>#arguments.OdemeIndirimi#</ns:OdemeIndirimi></cfif>
                                    <cfif len(arguments.OdemeNotu)><ns:OdemeNotu>#arguments.OdemeNotu#</ns:OdemeNotu></cfif>
                                    <ns:OdemeSecenekID>#arguments.OdemeSecenekID#</ns:OdemeSecenekID>
                                    <ns:OdemeTipi>#arguments.OdemeTipi#</ns:OdemeTipi>
                                    <cfif len(arguments.TaksitSayisi)><ns:TaksitSayisi>#arguments.TaksitSayisi#</ns:TaksitSayisi></cfif>
                                    <cfif len(arguments.Tarih)><ns:Tarih>#arguments.Tarih#</ns:Tarih></cfif>
                                    <ns:Tutar>#argumnets.Tutar#</ns:Tutar>
                                </ns:WebSiparisSaveOdeme>
                                </ns:Odemeler>
                                <cfif len(arguments.OzelAlan1)><ns:OzelAlan1>#arguments.OzelAlan1#</ns:OzelAlan1></cfif>
                                <cfif len(arguments.OzelAlan2)><ns:OzelAlan2>#arguments.OzelAlan2#</ns:OzelAlan2></cfif>
                                <cfif len(arguments.OzelAlan3)><ns:OzelAlan3>#arguments.OzelAlan3#</ns:OzelAlan3></cfif>
                                <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                <cfif len(arguments.ReferansNo)><ns:ReferansNo>#arguments.ReferansNo#</ns:ReferansNo></cfif>
                                <cfif len(arguments.SiparisKaynagi)><ns:SiparisKaynagi>#arguments.SiparisKaynagi#</ns:SiparisKaynagi></cfif>
                                <cfif len(arguments.SiparisNo)><ns:SiparisNo>#arguments.SiparisNo#</ns:SiparisNo></cfif>
                                <cfif len(arguments.SiparisNotu)><ns:SiparisNotu>#arguments.SiparisNotu#</ns:SiparisNotu></cfif>
                                <ns:TeslimatAdres>
                                <cfif len(arguments.Adres)><ns:Adres>#arguments.Adres#</ns:Adres></cfif>
                                <cfif len(arguments.AdresTarifi)><ns:AdresTarifi>#arguments.AdresTarifi#</ns:AdresTarifi></cfif>
                                <cfif len(arguments.AliciAdi)><ns:AliciAdi>#arguments.AliciAdi#</ns:AliciAdi></cfif>
                                <cfif len(arguments.AliciTelefon)><ns:AliciTelefon>#arguments.AliciTelefon#</ns:AliciTelefon></cfif>
                                <cfif len(arguments.Il)><ns:Il>#arguments.Il#</ns:Il></cfif>
                                <cfif len(arguments.Ilce)><ns:Ilce>#arguments.Ilce#</ns:Ilce></cfif>
                                <cfif len(arguments.Mahalle)><ns:Mahalle>#arguments.Mahalle#</ns:Mahalle></cfif>
                                <cfif len(arguments.PostaKodu)><ns:PostaKodu>#arguments.PostaKodu#</ns:PostaKodu></cfif>
                                <cfif len(arguments.Semt)><ns:Semt>#arguments.Semt#</ns:Semt></cfif>
                                <cfif len(arguments.Ulke)><ns:Ulke>#arguments.Ulke#</ns:Ulke></cfif>
                                </ns:TeslimatAdres>
                                <cfif len(arguments.TeslimatSaati)><ns:TeslimatSaati>#arguments.TeslimatSaati#</ns:TeslimatSaati></cfif>
                                <cfif len(arguments.TeslimatTarihi)><ns:TeslimatTarihi>#arguments.TeslimatTarihi#</ns:TeslimatTarihi></cfif>
                                <ns:UrunTutari>#arguments.UrunTutari#</ns:UrunTutari>
                                <cfif len(arguments.UrunTutariKdv)><ns:UrunTutariKdv>#arguments.UrunTutariKdv#</ns:UrunTutariKdv></cfif>
                                <ns:Urunler>
                                <ns:WebSiparisSaveUrun>
                                    <ns:Adet>#arguments.Adet#</ns:Adet>
                                    <cfif len(arguments.KdvOrani)><ns:KdvOrani>#arguments.KdvOrani#</ns:KdvOrani></cfif>
                                    <cfif len(arguments.KdvTutari)><ns:KdvTutari>#arguments.KdvTutari#</ns:KdvTutari></cfif>
                                    <cfif len(arguments.MagazaId)><ns:MagazaId>#arguments.MagazaId#</ns:MagazaId></cfif>
                                    <cfif len(arguments.Maliyet)><ns:Maliyet>#arguments.Maliyet#</ns:Maliyet></cfif>
                                    <ns:Tutar>#arguments.Tutar2#</ns:Tutar>
                                    <ns:UrunID>#arguments.UrunID#</ns:UrunID>
                                </ns:WebSiparisSaveUrun>
                                </ns:Urunler>
                                <cfif len(arguments.UyeAdi)><ns:UyeAdi>#arguments.UyeAdi#</ns:UyeAdi></cfif>
                                <cfif len(arguments.UyeCep)><ns:UyeCep>#arguments.UyeCep#</ns:UyeCep></cfif>
                                <ns:UyeId>#arguments.UyeId#</ns:UyeId>
                                <cfif len(arguments.UyeKazanimAktif)><ns:UyeKazanimAktif>#arguments.UyeKazanimAktif#</ns:UyeKazanimAktif></cfif>
                                <cfif len(arguments.UyeMail)><ns:UyeMail>#arguments.UyeMail#</ns:UyeMail></cfif>
                            </tem:siparis>
                        </tem:SaveSiparis>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SaveSiparis"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveSiparisKargoPaket">
        <cfargument  name="SiparisId" required="true" hint="Paketlenecek siparişe ait id değeri">
        <cfargument  name="SiparisUrunDurumId" required="true" hint="Tanımlı sipariş ürün durum id değeri.">
        <cfargument  name="KargoEntegrasyonId" required="true" hint="Tanımlı kargo entegrasyon id değeri">
        <cfargument  name="Urunler" required="true" hint="Siparişteki ürün idlerini içeren List<int> tipinde liste.">
        <cfargument  name="KargoTakipNo" required="true" hint="Kargo takip numarası değeri">
        <cfargument  name="KontrolEtme" required="true" hint="Sipariş paketlenme durumunu kontrol parametresi.True gönderilirse aynı sipariş için birden fazla paket oluşturulabilir.">
        <cfargument  name="MailGonder" required="true" hint="Paket oluştuğunda mail gönderilmesi için true gönderilmelidir.">
        <cfargument  name="SmsGonder" required="true" hint="Paket oluştuğunda sms gönderilmesi için true gönderilmelidir.">
        <cfargument  name="BarkodBilgisi" required="true" hint="Sipariş için kargo tarafında eşleştirilecek barkod bilgisi. Boş gönderilir ise otomatik oluşur.">
        <cfargument  name="KargoTakipLink" required="true" hint="Siparişin kargo takip link değeri. Link yoksa boş gönderilebilir.">
        <cfargument  name="KargoTakipLinkGoster" required="true" hint="Kargo takip link girildi ise kullanılma durumunu belirleyen parametre. True gönderilir ise ve KargoTakipLink dolu ise Hesabım > Siparişlerim ve siparistakip.aspx sayfalarında kargom nerede butonuna tıklandığında takip linkteki adres yeni sekmede açılır.">
        <cfargument  name="PaketID" default="">
            <cfxml  variable="xmlData">
                <cfoutput>
                    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                        <soapenv:Header/>
                        <soapenv:Body>
                            <tem:SaveSiparisKargoPaket>
                                <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                                <tem:SiparisID>#arguments.SiparisID#</tem:SiparisID>
                                <tem:SiparisUrunDurumID>#arguments.SiparisUrunDurumID#</tem:SiparisUrunDurumID>
                                <tem:KargoEntegrasyonID>#arguments.KargoEntegrasyonID#</tem:KargoEntegrasyonID>
                                <tem:Urunler>
                                    <arr:int>#arguments.Urunler#</arr:int>
                                </tem:Urunler>
                                <tem:KargoTakipNo>#arguments.KargoTakipNo#</tem:KargoTakipNo>
                                <tem:KontrolEtme>#arguments.KontrolEtme#</tem:KontrolEtme>
                                <tem:MailGonder>#arguments.MailGonder#</tem:MailGonder>
                                <tem:SmsGonder>#arguments.SmsGonder#</tem:SmsGonder>
                                <tem:BarkodBilgisi>#arguments.BarkodBilgisi#</tem:BarkodBilgisi>
                                <cfif len(arguments.PaketID)><tem:PaketID>#arguments.PaketID#</tem:PaketID></cfif>
                                <tem:KargoTakipLink>#arguments.KargoTakipLink#</tem:KargoTakipLink>
                                <tem:KargoTakipLinkGoster>#arguments.KargoTakipLinkGoster#</tem:KargoTakipLinkGoster>
                            </tem:SaveSiparisKargoPaket>
                        </soapenv:Body>
                    </soapenv:Envelope>
                </cfoutput>
            </cfxml>
            <cftransaction>
                <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                    <cfhttpparam type="header" name="mimetype" value="text/xml" />
                    <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SaveSiparisKargoPaket"\'>
                    <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                    <cfhttpparam type="xml"   value="#trim(xmlData)#">            
                </cfhttp>
            </cftransaction>
            <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveSiparisKargoPaketKargoTakipNo">
        <cfargument  name="SiparisId" required="true" hint="Sipariş kargo paket tablosundaki Sipariş id değeri.">
        <cfargument  name="PaketId" required="true" hint="Sipariş kargo paket tablosundaki id değeri.">
        <cfargument  name="KargoTakipNo" required="true" hint="Eklenmek istenen kargo takip numarası.">
        <cfargument  name="KargoTakipLink" required="true" hint="Siparişin kargo takip link değeri. Link yoksa boş gönderilebilir">
        <cfargument  name="KargoTakipLinkGoster" required="true" hint="Kargo takip link girildi ise kullanılma durumunu belirleyen parametre. True gönderilir ise ve KargoTakipLink dolu ise Hesabım > Siparişlerim ve siparistakip.aspx sayfalarında kargom nerede butonuna tıklandığında takip linkteki adres yeni sekmede açılır.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveSiparisKargoPaketKargoTakipNo>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.siparisId#</tem:siparisId>
                            <tem:paketId>#arguments.paketId#</tem:paketId>
                            <tem:kargoTakipNo>#arguments.kargoTakipNo#</tem:kargoTakipNo>
                            <tem:kargoTakipLink>#arguments.kargoTakipLink#</tem:kargoTakipLink>
                            <tem:KargoTakipLinkGoster>#arguments.KargoTakipLinkGoster#</tem:KargoTakipLinkGoster>
                        </tem:SaveSiparisKargoPaketKargoTakipNo>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SaveSiparisKargoPaketKargoTakipNo"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectSiparis">
        <cfargument  name="WebSiparisFiltre" required="true" hint="Filtre bilgilerini içeren WebSiparisFiltre sınıfı.">
        <cfargument  name="WebSiparisSayfalama" required="true" hint="Sayfalama değerlerini içeren WebSiparisSayfalama sınıfı">
        <cfargument  name="EntegrasyonAktarildi" hint="Entegrasyon aktarılma durumu.">
        <cfargument  name="EntegrasyonParams" required="true" hint="Siparişin entegrasyon parametreleri.">
        <cfargument  name="IptalEdilmisUrunler" hint="ptal edilmiş ürünlerin getirilme durumu.">
        <cfargument  name="FaturaNo" hint="Fatura numarası.">
        <cfargument  name="OdemeDurumu" hint="Ödeme durumu">
        <cfargument  name="OdemeTipi" hint="Ödeme tipi.">
        <cfargument  name="SiparisDurumu" hint="Sipariş durumu">
        <cfargument  name="SiparisID" hint="Sipariş id değeri.">
        <cfargument  name="SiparisKaynagi" hint="Sipariş kaynağı.">
        <cfargument  name="SiparisKodu" hint="Sipariş kodu.">
        <cfargument  name="SiparisTarihiBas" hint="Filtreleme sipariş başlangıç tarihi">
        <cfargument  name="SiparisTarihiSon" hint="Filtreleme sipariş bitiş tarihi">
        <cfargument  name="StrSiparisDurumu" hint="Sipariş durumu string değeri.">
        <cfargument  name="TedarikciID" hint="Tedarikçi id değeri">
        <cfargument  name="UyeID" hint="Üye id değeri.">
        <cfargument  name="SiparisNo" hint="Sipariş numarası.">
        <cfargument  name="UyeTelefon" hint="Üye telefon">
        <cfargument  name="AlanDeger" hint="Alan değer.">
        <cfargument  name="Deger" hint="Değer">
        <cfargument  name="EntegrasyonKodu" hint="Entegrasyon kodu.">
        <cfargument  name="EntegrasyonParamsAktif" hint="Entegryon parametreleri aktiflik durumu.">
        <cfargument  name="TabloAlan" hint="Tablo alan.">
        <cfargument  name="Tanim" hint="Tanım">
        <cfargument  name="BaslangicIndex" hint="Sayfalama başlangıç değeri.">
        <cfargument  name="KayitSayisi" hint="Getirilecek kayıt sayısı.">
        <cfargument  name="SiralamaDeger" hint="Sıralama değeri. Örn: “Id”">
        <cfargument  name="SiralamaYonu" hint="Sıralama yönü. Artan için “ASC” azalan için “DESC”">
        <cfargument  name="DuzenlemeTarihiBas" default="">
        <cfargument  name="DuzenlemeTarihiSon" default="">
        <cfargument  name="KampanyaGetir" default="">
        <cfargument  name="KargoFirmaID" default="">
        <cfargument  name="OdemeGetir" default="">
        <cfargument  name="OdemeTamamlandi" default="">
        <cfargument  name="PaketlemeDurumu" default="">
        <cfargument  name="StrPaketlemeDurumu" default="">
        <cfargument  name="StrSiparisID" default="">
        <cfargument  name="TeslimatGunuBas" default="">
        <cfargument  name="TeslimatGunuSon" default="">
        <cfargument  name="TeslimatMagazaID" default="">
        <cfargument  name="UrunGetir" default="">
        <cfargument  name="SiralamaDegeri" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectSiparis>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:f>
                                <cfif len(arguments.DuzenlemeTarihiBas)><ns:DuzenlemeTarihiBas>#arguments.DuzenlemeTarihiBas#</ns:DuzenlemeTarihiBas></cfif>
                                <cfif len(arguments.DuzenlemeTarihiSon)><ns:DuzenlemeTarihiSon>#arguments.DuzenlemeTarihiSon#</ns:DuzenlemeTarihiSon></cfif>
                                <cfif len(arguments.EntegrasyonAktarildi)><ns:EntegrasyonAktarildi>#arguments.EntegrasyonAktarildi#</ns:EntegrasyonAktarildi></cfif>
                                <ns:EntegrasyonParams>
                                    <cfif len(arguments.AlanDeger)><ns:AlanDeger>#arguments.AlanDeger#</ns:AlanDeger></cfif>
                                    <cfif len(arguments.Deger)><ns:Deger>#arguments.Deger#</ns:Deger></cfif>
                                    <cfif len(arguments.EntegrasyonKodu)><ns:EntegrasyonKodu>#arguments.EntegrasyonKodu#</ns:EntegrasyonKodu></cfif>
                                    <cfif len(arguments.EntegrasyonParamsAktif)><ns:EntegrasyonParamsAktif>#arguments.EntegrasyonParamsAktif#</ns:EntegrasyonParamsAktif></cfif>
                                    <cfif len(arguments.TabloAlan)><ns:TabloAlan>#arguments.TabloAlan#</ns:TabloAlan></cfif>
                                    <cfif len(arguments.Tanim)><ns:Tanim>#arguments.Tanim#</ns:Tanim></cfif>
                                </ns:EntegrasyonParams>
                                <cfif len(arguments.FaturaNo)><ns:FaturaNo>#arguments.FaturaNo#</ns:FaturaNo></cfif>
                                <cfif len(arguments.IptalEdilmisUrunler)><ns:IptalEdilmisUrunler>#arguments.IptalEdilmisUrunler#</ns:IptalEdilmisUrunler></cfif>
                                <cfif len(arguments.KampanyaGetir)><ns:KampanyaGetir>#arguments.KampanyaGetir#</ns:KampanyaGetir></cfif>
                                <cfif len(arguments.KargoFirmaID)><ns:KargoFirmaID>#arguments.KargoFirmaID#</ns:KargoFirmaID></cfif>
                                <cfif len(arguments.OdemeDurumu)><ns:OdemeDurumu>#arguments.OdemeDurumu#</ns:OdemeDurumu></cfif>
                                <cfif len(arguments.OdemeGetir)><ns:OdemeGetir>#arguments.OdemeGetir#</ns:OdemeGetir></cfif>
                                <cfif len(arguments.OdemeTamamlandi)><ns:OdemeTamamlandi>#arguments.OdemeTamamlandi#</ns:OdemeTamamlandi></cfif>
                                <cfif len(arguments.OdemeTipi)><ns:OdemeTipi>#arguments.OdemeTipi#</ns:OdemeTipi></cfif>
                                <cfif len(arguments.PaketlemeDurumu)><ns:PaketlemeDurumu>#arguments.PaketlemeDurumu#</ns:PaketlemeDurumu></cfif>
                                <cfif len(arguments.SiparisDurumu)><ns:SiparisDurumu>#arguments.SiparisDurumu#</ns:SiparisDurumu></cfif>
                                <cfif len(arguments.SiparisID)><ns:SiparisID>#arguments.SiparisID#</ns:SiparisID></cfif>
                                <cfif len(arguments.SiparisKaynagi)><ns:SiparisKaynagi>#arguments.SiparisKaynagi#</ns:SiparisKaynagi></cfif>
                                <cfif len(arguments.SiparisKodu)><ns:SiparisKodu>#arguments.SiparisKodu#</ns:SiparisKodu></cfif>
                                <cfif len(arguments.SiparisNo)><ns:SiparisNo>#arguments.SiparisNo#</ns:SiparisNo></cfif>
                                <cfif len(arguments.SiparisTarihiBas)><ns:SiparisTarihiBas>#arguments.SiparisTarihiBas#</ns:SiparisTarihiBas></cfif>
                                <cfif len(arguments.SiparisTarihiSon)><ns:SiparisTarihiSon>#arguments.SiparisTarihiSon#</ns:SiparisTarihiSon></cfif>
                                <cfif len(arguments.StrPaketlemeDurumu)><ns:StrPaketlemeDurumu>#arguments.StrPaketlemeDurumu#</ns:StrPaketlemeDurumu></cfif>
                                <cfif len(arguments.StrSiparisDurumu)><ns:StrSiparisDurumu>#arguments.StrSiparisDurumu#</ns:StrSiparisDurumu></cfif>
                                <cfif len(arguments.StrSiparisID)><ns:StrSiparisID>#arguments.StrSiparisID#</ns:StrSiparisID></cfif>
                                <cfif len(arguments.TedarikciID)><ns:TedarikciID>#arguments.TedarikciID#</ns:TedarikciID></cfif>
                                <cfif len(arguments.TeslimatGunuBas)><ns:TeslimatGunuBas>#arguments.TeslimatGunuBas#</ns:TeslimatGunuBas></cfif>
                                <cfif len(arguments.TeslimatGunuSon)><ns:TeslimatGunuSon>#arguments.TeslimatGunuSon#</ns:TeslimatGunuSon></cfif>
                                <cfif len(arguments.TeslimatMagazaID)><ns:TeslimatMagazaID>#arguments.TeslimatMagazaID#</ns:TeslimatMagazaID></cfif>
                                <cfif len(arguments.UrunGetir)><ns:UrunGetir>#arguments.UrunGetir#</ns:UrunGetir></cfif>
                                <cfif len(arguments.UyeID)><ns:UyeID>#arguments.UyeID#</ns:UyeID></cfif>
                                <cfif len(arguments.UyeTelefon)><ns:UyeTelefon>#arguments.UyeTelefon#</ns:UyeTelefon></cfif>
                            </tem:f>
                            <tem:s>
                                <cfif len(arguments.BaslangicIndex)><ns:BaslangicIndex>#arguments.BaslangicIndex#</ns:BaslangicIndex></cfif>
                                <cfif len(arguments.KayitSayisi)><ns:KayitSayisi>#arguments.KayitSayisi#</ns:KayitSayisi></cfif>
                                <cfif len(arguments.SiralamaDegeri)><ns:SiralamaDegeri>#arguments.SiralamaDegeri#</ns:SiralamaDegeri></cfif>
                                <cfif len(arguments.SiralamaYonu)><ns:SiralamaYonu>#arguments.SiralamaYonu#</ns:SiralamaYonu></cfif>
                            </tem:s>
                        </tem:SelectSiparis>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectSiparis"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectSiparisKargoPaket">
        <cfargument  name="Filtre" required="true" hint="Filtre bilgilerini içeren WebSiparisKargoFiltreSınıfı">
        <cfargument  name="KargoEntegrasyonID" hint="Kayıtlı kargo entegrasyon id değeri">
        <cfargument  name="KargoTakipNoDurum" hint="Karga takip no durum">
        <cfargument  name="PaketlemeTarihiBas" hint="Paketleme tarihi başlangıç değeri">
        <cfargument  name="PakelemeTarihiBit" hint="Paketleme tarihi bitiş değeri">
        <cfargument  name="SiparisID" hint="Sipariş ıd">
        <cfargument  name="SiparisKargoPaketID" hint="Sipariş kargo paket id değeri">
        <cfargument  name="SiparisDurumIptal" default="">
        <cfargument  name="SiparisIDList" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectSiparisKargoPaket>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:filtre>
                                <cfif len(arguments.KargoEntegrasyonID)><ns:KargoEntegrasyonID>#arguments.KargoEntegrasyonID#</ns:KargoEntegrasyonID></cfif>
                                <cfif len(arguments.KargoTakipNoDurum)><ns:KargoTakipNoDurum>#arguments.KargoTakipNoDurum#</ns:KargoTakipNoDurum></cfif>
                                <cfif len(arguments.PaketlenmeTarihBas)><ns:PaketlenmeTarihBas>#arguments.PaketlenmeTarihBas#</ns:PaketlenmeTarihBas></cfif>
                                <cfif len(arguments.PakelemeTarihiBit)><ns:PaketlenmeTarihBit>#arguments.PakelemeTarihiBit#</ns:PaketlenmeTarihBit></cfif>
                                <cfif len(arguments.SiparisDurumIptal)><ns:SiparisDurumIptal>#arguments.SiparisDurumIptal#</ns:SiparisDurumIptal></cfif>
                                <cfif len(arguments.SiparisID)><ns:SiparisID>#arguments.SiparisID#</ns:SiparisID></cfif>
                                <ns:SiparisIDList>
                                <cfif len(arguments.SiparisIDList)><arr:int>#arguments.SiparisIDList#</arr:int></cfif>
                                </ns:SiparisIDList>
                                <cfif len(arguments.SiparisKargoPaketID)><ns:SiparisKargoPaketID>#arguments.SiparisKargoPaketID#</ns:SiparisKargoPaketID></cfif>
                            </tem:filtre>
                        </tem:SelectSiparisKargoPaket>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectSiparisKargoPaket"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectSiparisOdeme">
        <cfargument  name="SiparisId" required="true" hint="Ödemesi getirilmek istenen siparişin id değeri">
        <cfargument  name="OdemeId" hint="0 gönderilebilir." default="0">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectSiparisOdeme>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.siparisId#</tem:siparisId>
                            <cfif len(arguments.OdemeId)><tem:odemeId>#arguments.OdemeId#</tem:odemeId></cfif>
                        </tem:SelectSiparisOdeme>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectSiparisOdeme"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectSiparisUrun">
        <cfargument  name="SiparisId" required="true" hint="Ürünleri getirilmek istenen siparişin id si">
        <cfargument  name="IptalEdilmisUrunler" required="true" hint="İptal edilen ürünlerin getirilip getirilmeyeceği bilgisi">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectSiparisUrun>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.siparisId#</tem:siparisId>
                            <tem:iptalEdilmisUrunler>#arguments.iptalEdilmisUrunler#</tem:iptalEdilmisUrunler>
                        </tem:SelectSiparisUrun>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectSiparisUrun"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectSiparisUrunDurumlari">
        <cfargument  name="SiparisDurumId" required="true" hint="Kayıtlı sipariş durum id değeri.">
        <cfargument  name="Islem" required="true" hint="Getirilmek istemen işlem numarası">
        <cfargument  name="Aktif" required="true" hint="Aktiflik durumu 1 = aktif , 0 = aktif olmayan , -1 = hepsi">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectSiparisUrunDurumlari>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:SiparisUrunDurumID>#arguments.SiparisDurumId#</tem:SiparisUrunDurumID>
                            <tem:Islem>#arguments.Islem#</tem:Islem>
                            <tem:Aktif>#arguments.Aktif#</tem:Aktif>
                        </tem:SelectSiparisUrunDurumlari>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectSiparisUrunDurumlari"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetSiparisAktarildi">
        <cfargument  name="SiparisId" required="true" hint="Aktarılmak istenen siparişe ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetSiparisAktarildi>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.SiparisId#</tem:siparisId>
                        </tem:SetSiparisAktarildi>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetSiparisAktarildi"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetSiparisAktarildiIptal">
        <cfargument  name="SiparisId" required="true" hint="Aktarımı iptal edilmek istenen siparişe ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetSiparisAktarildiIptal>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.SiparisId#</tem:siparisId>
                        </tem:SetSiparisAktarildiIptal>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetSiparisAktarildiIptal"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetSiparisDurum">
        <cfargument  name="SetSiparisDurumRequest" required="true" hint="Sipariş ve durum bilgilerini içeren sınıf.">
        <cfargument  name="Durum" required="true" hint="Sipariş durumu">
        <cfargument  name="KargoTakipNo" hint="Kargo takip numarası">
        <cfargument  name="MailBilgilendir" hint="Mail ile bilgilendirme durumu">
        <cfargument  name="SiparisID" required="true" hint="Sipariş id">
        <cfargument  name="KargoTakipLink" default="">
        <cfargument  name="SiparisNo" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetSiparisDurum>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <ns:Durum>#arguments.Durum#</ns:Durum>
                                <cfif len(arguments.KargoTakipLink)><ns:KargoTakipLink>#arguments.KargoTakipLink#</ns:KargoTakipLink></cfif>
                                <cfif len(arguments.KargoTakipNo)><ns:KargoTakipNo>#arguments.KargoTakipNo#</ns:KargoTakipNo></cfif>
                                <cfif len(arguments.MailBilgilendir)><ns:MailBilgilendir>#arguments.MailBilgilendir#</ns:MailBilgilendir></cfif>
                                <ns:SiparisID>#arguments.SiparisID#</ns:SiparisID>
                                <cfif len(arguments.SiparisNo)><ns:SiparisNo>#arguments.SiparisNo#</ns:SiparisNo></cfif>
                            </tem:request>
                        </tem:SetSiparisDurum>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetSiparisDurum"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetSiparisKargoyaVerildi">
        <cfargument  name="SiparisId" required="true" hint="Kargoya verildi yapılmak istenen siparişe ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetSiparisKargoyaVerildi>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.SiparisId#</tem:siparisId>
                        </tem:SetSiparisKargoyaVerildi>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetSiparisKargoyaVerildi"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetSiparisTeslimEdildi">
        <cfargument  name="SiparisId" required="true" hint="Teslim edildi yapılmak istenen siparişe ait id değeri.">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetSiparisTeslimEdildi>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.SiparisId#</tem:siparisId>
                        </tem:SetSiparisTeslimEdildi>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetSiparisTeslimEdildi"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="GetKargoSecenek">
        <cfargument  name="GetKargoSecenekRequest" required="true" hint="Sorgu bilgilerini içeren GetKargoSecenekReques sınıfı">
        <cfargument  name="ParaBirimi" required="true" hint="Para birimi değeri">
        <cfargument  name="SehirId" required="true" hint="Iller tablosundaki id değeri. Örn: 1 = Adana">
        <cfargument  name="Sepet" required="true" hint="Yeni bir ServisSepet nesnesi oluşturulup gönderilebilir.">
        <cfargument  name="IlceId" default="">
        <cfargument  name="MahalleId" default="">
        <cfargument  name="SemtId" default="">
        <cfargument  name="GenelKDVToplam" default="">
        <cfargument  name="GenelToplam" default="">
        <cfargument  name="HediyeCekiKodu" default="">
        <cfargument  name="HediyeCekiTutari" default="">
        <cfargument  name="HediyeCekiZubizuKampanyaId" default="">
        <cfargument  name="HediyePaketiTutari" default="">
        <cfargument  name="HopiIndirimi" default="">
        <cfargument  name="IndirimlerToplami" default="">
        <cfargument  name="KampanyaID" default="">
        <cfargument  name="KampanyaIndirimKDV" default="">
        <cfargument  name="KampanyaIndirimTutari" default="">
        <cfargument  name="KampanyasizUrunlerToplami" default="">
        <cfargument  name="OverrateSahipId" default="">
        <cfargument  name="SahipID" default="">
        <cfargument  name="SepetID" default="">
        <cfargument  name="SepetParaBirimiDilKodu" default="">
        <cfargument  name="ToplamKDV" default="">
        <cfargument  name="ToplamTutar" default="">
        <cfargument  name="ToplamUrunAdedi" default="">
        <cfargument  name="UrunOzellestirmeFiyatlari" default="">
        <cfargument  name="ASortiUrunKartiID" default="">
        <cfargument  name="Adet" default="">
        <cfargument  name="Desi" default="">
        <cfargument  name="EkSecenekOzellik" default="">
        <cfargument  name="EtiketId" default="">
        <cfargument  name="Fiyati" default="">
        <cfargument  name="FormId" default="">
        <cfargument  name="FormIdList" default="">
        <cfargument  name="ID" default="">
        <cfargument  name="IndirimTutari" default="">
        <cfargument  name="KDVOrani" default="">
        <cfargument  name="KDVTutari" default="">
        <cfargument  name="KampanyaBagliUrunID" default="">
        <cfargument  name="KampanyaIleEklendi" default="">
        <cfargument  name="KampanyaKaynakliIndirimTutari" default="">
        <cfargument  name="KampanyaTanimlari" default="">
        <cfargument  name="KargoIndirimi" default="">
        <cfargument  name="KargoUcreti" default="">
        <cfargument  name="Kategoriler" default="">
        <cfargument  name="MaksTaksitSayisi" default="">
        <cfargument  name="Marka" default="">
        <cfargument  name="MarkaID" default="">
        <cfargument  name="OzellestirmeTutari" default="">
        <cfargument  name="ParaBirimiDilKodu" default="">
        <cfargument  name="SanalUrun" default="">
        <cfargument  name="SepetAlimMaks" default="">
        <cfargument  name="SepetAlimMin" default="">
        <cfargument  name="SpotResim" default="">
        <cfargument  name="StokKodu" default="">
        <cfargument  name="ToplamIndirimTutari" default="">
        <cfargument  name="ToplamKDVTutari" default="">
        <cfargument  name="ToplamSatisFiyati" default="">
        <cfargument  name="ToplamUrunSepetFiyati" default="">
        <cfargument  name="ToplamUrunSepetFiyatiKDVli" default="">
        <cfargument  name="Url" default="">
        <cfargument  name="UrunAdediKademeDeger" default="">
        <cfargument  name="UrunAdediMinimumDeger" default="">
        <cfargument  name="UrunAdediOndalikliSayiGirilebilir" default="">
        <cfargument  name="UrunAdi" default="">
        <cfargument  name="UrunID" default="">
        <cfargument  name="UrunKampanyaliEklendi" default="">
        <cfargument  name="UrunKartiID" default="">
        <cfargument  name="UrunKategoriId" default="">
        <cfargument  name="UrunNotu" default="">
        <cfargument  name="UrunSatisFiyati" default="">
        <cfargument  name="UrunSatisFiyatiKDV" default="">
        <cfargument  name="UrunSepetFiyati" default="">
        <cfargument  name="UrunSepetFiyatiKDV" default="">
        <cfargument  name="UrunSepetFiyatiKDVli" default="">
        <cfargument  name="isSepetUcretsizKargo" default="">
        <cfargument  name="isUcretsizKargo" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:GetKargoSecenek>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <cfif len(arguments.IlceId)><ns:IlceId>#arguments.IlceId#</ns:IlceId></cfif>
                                <cfif len(arguments.MahalleId)><ns:MahalleId>#arguments.MahalleId#</ns:MahalleId></cfif>
                                <ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi>
                                <ns:SehirId>#arguments.SehirId#</ns:SehirId>
                                <cfif len(arguments.SemtId)><ns:SemtId>#arguments.SemtId#</ns:SemtId></cfif>
                                <ns:Sepet>
                                    <cfif len(arguments.GenelKDVToplam)><ns:GenelKDVToplam>#arguments.GenelKDVToplam#</ns:GenelKDVToplam></cfif>
                                    <cfif len(arguments.GenelToplam)><ns:GenelToplam>#arguments.GenelToplam#</ns:GenelToplam></cfif>
                                    <cfif len(arguments.HediyeCekiKodu)><ns:HediyeCekiKodu>#arguments.HediyeCekiKodu#</ns:HediyeCekiKodu></cfif>
                                    <cfif len(arguments.HediyeCekiTutari)><ns:HediyeCekiTutari>#arguments.HediyeCekiTutari#</ns:HediyeCekiTutari></cfif>
                                    <cfif len(arguments.HediyeCekiZubizuKampanyaId)><ns:HediyeCekiZubizuKampanyaId>#arguments.HediyeCekiZubizuKampanyaId#</ns:HediyeCekiZubizuKampanyaId></cfif>
                                    <cfif len(arguments.HediyePaketiTutari)><ns:HediyePaketiTutari>#arguments.HediyePaketiTutari#</ns:HediyePaketiTutari></cfif>
                                    <cfif len(arguments.HopiIndirimi)><ns:HopiIndirimi>#arguments.HopiIndirimi#</ns:HopiIndirimi></cfif>
                                    <cfif len(arguments.HopiParacikKullanimi)><ns:HopiParacikKullanimi>#arguments.HopiParacikKullanimi#</ns:HopiParacikKullanimi></cfif>
                                    <cfif len(arguments.IndirimlerToplami)><ns:IndirimlerToplami>#arguments.IndirimlerToplami#</ns:IndirimlerToplami></cfif>
                                    <cfif len(arguments.KampanyaID)><ns:KampanyaID>#arguments.KampanyaID#</ns:KampanyaID></cfif>
                                    <cfif len(arguments.KampanyaIndirimKDV)><ns:KampanyaIndirimKDV>#arguments.KampanyaIndirimKDV#</ns:KampanyaIndirimKDV></cfif>
                                    <cfif len(arguments.KampanyaIndirimTutari)><ns:KampanyaIndirimTutari>#arguments.KampanyaIndirimTutari#</ns:KampanyaIndirimTutari></cfif>
                                    <cfif len(arguments.KampanyasizUrunlerToplami)><ns:KampanyasizUrunlerToplami>#arguments.KampanyasizUrunlerToplami#</ns:KampanyasizUrunlerToplami></cfif>
                                    <cfif len(arguments.OverrateSahipId)><ns:OverrateSahipId>#arguments.OverrateSahipId#</ns:OverrateSahipId></cfif>
                                    <cfif len(arguments.SahipID)><ns:SahipID>#arguments.SahipID#</ns:SahipID></cfif>
                                    <cfif len(arguments.SepetID)><ns:SepetID>#arguments.SepetID#</ns:SepetID></cfif>
                                    <cfif len(arguments.SepetParaBirimiDilKodu)><ns:SepetParaBirimiDilKodu>#arguments.SepetParaBirimiDilKodu#</ns:SepetParaBirimiDilKodu></cfif>
                                    <cfif len(arguments.ToplamKDV)><ns:ToplamKDV>#arguments.ToplamKDV#</ns:ToplamKDV></cfif>
                                    <cfif len(arguments.ToplamTutar)><ns:ToplamTutar>#arguments.ToplamTutar#</ns:ToplamTutar></cfif>
                                    <cfif len(arguments.ToplamUrunAdedi)><ns:ToplamUrunAdedi>#arguments.ToplamUrunAdedi#</ns:ToplamUrunAdedi></cfif>
                                    <cfif len(arguments.UrunOzellestirmeFiyatlari)><ns:UrunOzellestirmeFiyatlari>#arguments.UrunOzellestirmeFiyatlari#</ns:UrunOzellestirmeFiyatlari></cfif>
                                    <ns:Urunler>
                                        <ns:ServisSepetUrun>
                                            <cfif len(arguments.ASortiUrunKartiID)><ns:ASortiUrunKartiID>#arguments.ASortiUrunKartiID#</ns:ASortiUrunKartiID></cfif>
                                            <cfif len(arguments.Adet)><ns:Adet>#arguments.Adet#</ns:Adet></cfif>
                                            <cfif len(arguments.Desi)><ns:Desi>#arguments.Desi#</ns:Desi></cfif>
                                            <cfif len(arguments.EkSecenekOzellik)><ns:EkSecenekOzellik>#arguments.EkSecenekOzellik#</ns:EkSecenekOzellik></cfif>
                                            <cfif len(arguments.EtiketId)><ns:EtiketId>#arguments.EtiketId#</ns:EtiketId></cfif>
                                            <cfif len(arguments.Fiyati)><ns:Fiyati>#arguments.Fiyati#</ns:Fiyati></cfif>
                                            <cfif len(arguments.FormId)><ns:FormId>#arguments.FormId#</ns:FormId></cfif>
                                            <ns:FormIdList>
                                                <arr:int>#arguments.FormIdList#</arr:int>
                                            </ns:FormIdList>
                                            <cfif len(arguments.ID)><ns:ID>#arguments.ID#</ns:ID></cfif>
                                            <cfif len(arguments.IndirimTutari)><ns:IndirimTutari>#arguments.IndirimTutari#</ns:IndirimTutari></cfif>
                                            <cfif len(arguments.KDVOrani)><ns:KDVOrani>#arguments.KDVOrani#</ns:KDVOrani></cfif>
                                            <cfif len(arguments.KDVTutari)><ns:KDVTutari>#arguments.KDVTutari#</ns:KDVTutari></cfif>
                                            <cfif len(arguments.KampanyaBagliUrunID)><ns:KampanyaBagliUrunID>#arguments.KampanyaBagliUrunID#</ns:KampanyaBagliUrunID></cfif>
                                            <cfif len(arguments.KampanyaID)><ns:KampanyaID>#arguments.KampanyaID#</ns:KampanyaID></cfif>
                                            <cfif len(arguments.KampanyaIleEklendi)><ns:KampanyaIleEklendi>#arguments.KampanyaIleEklendi#</ns:KampanyaIleEklendi></cfif>
                                            <cfif len(arguments.KampanyaKaynakliIndirimTutari)><ns:KampanyaKaynakliIndirimTutari>#arguments.KampanyaKaynakliIndirimTutari#</ns:KampanyaKaynakliIndirimTutari></cfif>
                                            <ns:KampanyaTanimlari>
                                                <cfif len(arguments.KampanyaTanimlari)><arr:string>#arguments.KampanyaTanimlari#</arr:string></cfif>
                                            </ns:KampanyaTanimlari>
                                            <cfif len(arguments.KargoIndirimi)><ns:KargoIndirimi>#arguments.KargoIndirimi#</ns:KargoIndirimi></cfif>
                                            <cfif len(arguments.KargoUcreti)><ns:KargoUcreti>#arguments.KargoUcreti#</ns:KargoUcreti></cfif>
                                            <ns:Kategoriler>
                                                <cfif len(arguments.Kategoriler)><arr:int>#arguments.Kategoriler#</arr:int></cfif>
                                            </ns:Kategoriler>
                                            <cfif len(arguments.MaksTaksitSayisi)><ns:MaksTaksitSayisi>#arguments.MaksTaksitSayisi#</ns:MaksTaksitSayisi></cfif>
                                            <cfif len(arguments.Marka)><ns:Marka>#arguments.Marka#</ns:Marka></cfif>
                                            <cfif len(arguments.MarkaID)><ns:MarkaID>#arguments.MarkaID#</ns:MarkaID></cfif>
                                            <cfif len(arguments.OzellestirmeTutari)><ns:OzellestirmeTutari>#arguments.OzellestirmeTutari#</ns:OzellestirmeTutari></cfif>
                                            <ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi>
                                            <cfif len(arguments.ParaBirimiDilKodu)><ns:ParaBirimiDilKodu>#arguments.ParaBirimiDilKodu#</ns:ParaBirimiDilKodu></cfif>
                                            <cfif len(arguments.SanalUrun)><ns:SanalUrun>#arguments.SanalUrun#</ns:SanalUrun></cfif>
                                            <cfif len(arguments.SepetAlimMaks)><ns:SepetAlimMaks>#arguments.SepetAlimMaks#</ns:SepetAlimMaks></cfif>
                                            <cfif len(arguments.SepetAlimMin)><ns:SepetAlimMin>#arguments.SepetAlimMin#</ns:SepetAlimMin></cfif>
                                            <cfif len(arguments.SpotResim)><ns:SpotResim>#arguments.SpotResim#</ns:SpotResim></cfif>
                                            <cfif len(arguments.StokKodu)><ns:StokKodu>#arguments.StokKodu#</ns:StokKodu></cfif>
                                            <cfif len(arguments.ToplamIndirimTutari)><ns:ToplamIndirimTutari>#arguments.ToplamIndirimTutari#</ns:ToplamIndirimTutari></cfif>
                                            <cfif len(arguments.ToplamKDVTutari)><ns:ToplamKDVTutari>#arguments.ToplamKDVTutari#</ns:ToplamKDVTutari></cfif>
                                            <cfif len(arguments.ToplamSatisFiyati)><ns:ToplamSatisFiyati>#arguments.ToplamSatisFiyati#</ns:ToplamSatisFiyati></cfif>
                                            <cfif len(arguments.ToplamUrunSepetFiyati)><ns:ToplamUrunSepetFiyati>#arguments.ToplamUrunSepetFiyati#</ns:ToplamUrunSepetFiyati></cfif>
                                            <cfif len(arguments.ToplamUrunSepetFiyatiKDVli)><ns:ToplamUrunSepetFiyatiKDVli>#arguments.ToplamUrunSepetFiyatiKDVli#</ns:ToplamUrunSepetFiyatiKDVli></cfif>
                                            <cfif len(arguments.Url)><ns:Url>#arguments.Url#</ns:Url></cfif>
                                            <cfif len(arguments.UrunAdediKademeDeger)><ns:UrunAdediKademeDeger>#arguments.UrunAdediKademeDeger#</ns:UrunAdediKademeDeger></cfif>
                                            <cfif len(arguments.UrunAdediMinimumDeger)><ns:UrunAdediMinimumDeger>#arguments.UrunAdediMinimumDeger#</ns:UrunAdediMinimumDeger></cfif>
                                            <cfif len(arguments.UrunAdediOndalikliSayiGirilebilir)><ns:UrunAdediOndalikliSayiGirilebilir>#arguments.UrunAdediOndalikliSayiGirilebilir#</ns:UrunAdediOndalikliSayiGirilebilir></cfif>
                                            <cfif len(arguments.UrunAdi)><ns:UrunAdi>#arguments.UrunAdi#</ns:UrunAdi></cfif>
                                            <cfif len(arguments.UrunID)><ns:UrunID>#arguments.UrunID#</ns:UrunID></cfif>
                                            <cfif len(arguments.UrunKampanyaliEklendi)><ns:UrunKampanyaliEklendi>#arguments.UrunKampanyaliEklendi#</ns:UrunKampanyaliEklendi></cfif>
                                            <cfif len(arguments.UrunKartiID)><ns:UrunKartiID>#arguments.UrunKartiID#</ns:UrunKartiID></cfif>
                                            <cfif len(arguments.UrunKategoriId)><ns:UrunKategoriId>#arguments.UrunKategoriId#</ns:UrunKategoriId></cfif>
                                            <cfif len(arguments.UrunNotu)><ns:UrunNotu>#arguments.UrunNotu#</ns:UrunNotu></cfif>
                                            <cfif len(arguments.UrunSatisFiyati)><ns:UrunSatisFiyati>#arguments.UrunSatisFiyati#</ns:UrunSatisFiyati></cfif>
                                            <cfif len(arguments.UrunSatisFiyatiKDV)><ns:UrunSatisFiyatiKDV>#arguments.UrunSatisFiyatiKDV#</ns:UrunSatisFiyatiKDV></cfif>
                                            <cfif len(arguments.UrunSepetFiyati)><ns:UrunSepetFiyati>#arguments.UrunSepetFiyati#</ns:UrunSepetFiyati></cfif>
                                            <cfif len(arguments.UrunSepetFiyatiKDV)><ns:UrunSepetFiyatiKDV>#arguments.UrunSepetFiyatiKDV#</ns:UrunSepetFiyatiKDV></cfif>
                                            <cfif len(arguments.UrunSepetFiyatiKDVli)><ns:UrunSepetFiyatiKDVli>#arguments.UrunSepetFiyatiKDVli#</ns:UrunSepetFiyatiKDVli></cfif>
                                            <cfif len(arguments.isSepetUcretsizKargo)><ns:isSepetUcretsizKargo>#arguments.isSepetUcretsizKargo#</ns:isSepetUcretsizKargo></cfif>
                                            <cfif len(arguments.isUcretsizKargo)><ns:isUcretsizKargo>#arguments.isUcretsizKargo#</ns:isUcretsizKargo></cfif>
                                        </ns:ServisSepetUrun>
                                    </ns:Urunler>
                                </ns:Sepet>
                            </tem:request>
                        </tem:GetKargoSecenek>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/GetKargoSecenek"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SaveKargoTakipNo">
        <cfargument  name="SiparisId" required="true" hint="Kargo takip numarası eklenmek istenen sipariş id değeri">
        <cfargument  name="KargoKodu" required="true" hint="Boş gönderilebilir">
        <cfargument  name="KargoTakipNo" required="true" hint="Kaydedilmek istenen kargo takip numarası değeri">
        <cfargument  name="KargoTakipLink" required="true" hint="Siparişin kargo takip link değeri. Link yoksa boş gönderilebilir.">
        <cfargument  name="BarkodBilgisi" required="true" hint="Sipariş için kargo tarafında eşleştirilecek barkod bilgisi.Boş gönderilir ise otomatik oluşur.">
        <cfargument  name="KargoTakipLinkGoster" required="true" hint="Kargo takip link girildi ise kullanılma durumunu belirleyen parametre. True gönderilir ise ve KargoTakipLink dolu ise Hesabım > Siparişlerim ve siparistakip.aspx sayfalarında kargom nerede butonuna tıklandığında takip linkteki adres yeni sekmede açılır. ">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SaveKargoTakipNo>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:siparisId>#arguments.siparisId#</tem:siparisId>
                            <tem:kargoKodu>#arguments.kargoKodu#</tem:kargoKodu>
                            <tem:kargoTakipNo>#arguments.kargoTakipNo#</tem:kargoTakipNo>
                            <tem:kargoTakipLink>#arguments.kargoTakipLink#</tem:kargoTakipLink>
                            <tem:BarkodBilgisi>#arguments.BarkodBilgisi#</tem:BarkodBilgisi>
                            <tem:KargoTakipLinkGoster>#arguments.KargoTakipLinkGoster#</tem:KargoTakipLinkGoster>
                        </tem:SaveKargoTakipNo>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SaveKargoTakipNo"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="GetOdemeTipleri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:GetOdemeTipleri>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                        </tem:GetOdemeTipleri>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/GetOdemeTipleri"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="GetSepet">
        <cfargument  name="GetSepetRequest" required="true" hint="Sorgu bilgilerini içeren GetSepetRequest sınıfı">
        <cfargument  name="KampanyaID"hint="Kampanya ID değeri">
        <cfargument  name="SepetID" required="true" hint="Sepet id değeri(Uye id girildiyse gönderilmeyebilir)">
        <cfargument  name="UyeID" required="true" hint="Uye id değeri(SepetID girildiyse gönderilmeyebilir)">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:GetSepet>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <cfif len(arguments.KampanyaID)><ns:KampanyaID>#arguments.KampanyaID#</ns:KampanyaID></cfif>
                                <ns:SepetID>#arguments.SepetID#</ns:SepetID>
                                <ns:UyeID>#arguments.UyeID#</ns:UyeID>
                            </tem:request>
                        </tem:GetSepet>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/GetSepet"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectCariOdeme">
        <cfargument  name="WebSiparisOdemeFiltre" required="true" hint="Ödeme filtre bilgilerini içeren WebSiparisOdemeFiltre sınıfı">
        <cfargument  name="OdemeDurumu" hint="Ödeme durumu değeri">
        <cfargument  name="OdemeID" hint="Ödeme id">
        <cfargument  name="OdemeTarihiBas" hint="Filtre ödeme tarihi başlangıç">
        <cfargument  name="OdemeTarihiSon" hint="Filtre ödeme tarihi bitiş">
        <cfargument  name="OdemeTipi" hint="Ödeme tipi">
        <cfargument  name="SiparisID" hint="Sipariş id değeri">
        <cfargument  name="UyeID" hint="Uye id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectCariOdeme>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:filtre>
                                <cfif len(arguments.OdemeDurumu)><ns:OdemeDurumu>#arguments.OdemeDurumu#</ns:OdemeDurumu></cfif>
                                <cfif len(arguments.OdemeID)><ns:OdemeID>#arguments.OdemeID#</ns:OdemeID></cfif>
                                <cfif len(arguments.OdemeTarihiBas)><ns:OdemeTarihiBas>#arguments.OdemeTarihiBas#</ns:OdemeTarihiBas></cfif>
                                <cfif len(arguments.OdemeTarihiSon)><ns:OdemeTarihiSon>#arguments.OdemeTarihiSon#</ns:OdemeTarihiSon></cfif>
                                <cfif len(arguments.OdemeTipi)><ns:OdemeTipi>#arguments.OdemeTipi#</ns:OdemeTipi></cfif>
                                <cfif len(arguments.SiparisID)><ns:SiparisID>#arguments.SiparisID#</ns:SiparisID></cfif>
                                <cfif len(arguments.UyeID)><ns:UyeID>#arguments.UyeID#</ns:UyeID></cfif>
                            </tem:filtre>
                        </tem:SelectCariOdeme>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectCariOdeme"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectSepet">
        <cfargument  name="SepetId" required="true" hint="Sepet id değeri">
        <cfargument  name="UyeId" required="true" hint="Uye id">
        <cfargument  name="BaslangicTarihi" required="true" hint="Başlangıç tarihi">
        <cfargument  name="BitisTarihi" required="true" hint="Bitiş tarihi">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectSepet>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:sepetId>#arguments.sepetId#</tem:sepetId>
                            <tem:uyeId>#arguments.uyeId#</tem:uyeId>
                            <tem:BaslangicTarihi>#arguments.BaslangicTarihi#</tem:BaslangicTarihi>
                            <tem:BitisTarihi>#arguments.BitisTarihi#</tem:BitisTarihi>
                        </tem:SelectSepet>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectSepet"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SelectWebSepet">
        <cfargument  name="SelectWebSepetRequest" required="true" hint="Sorgu için gerekli bilgileri içeren SelectWebSepetRequest sınıfı">
        <cfargument  name="Dil" hint="Dil değeri boş gönderilir ise “TR” kabul edilir">
        <cfargument  name="ParaBirimi" hint="Para birimi">
        <cfargument  name="SepetId" hint="Kayıtlı sepet id">
        <cfargument  name="UyeId" hint="Kayıtlı uye id">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SelectWebSepet>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <cfif len(arguments.Dil)><ns:Dil>#arguments.Dil#</ns:Dil></cfif>
                                <cfif len(arguments.ParaBirimi)><ns:ParaBirimi>#arguments.ParaBirimi#</ns:ParaBirimi></cfif>
                                <cfif len(arguments.SepetId)><ns:SepetId>#arguments.SepetId#</ns:SepetId></cfif>
                                <cfif len(arguments.UyeId)><ns:UyeId>#arguments.UyeId#</ns:UyeId></cfif>
                            </tem:request>
                        </tem:SelectWebSepet>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SelectWebSepet"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetFaturaNo">
        <cfargument  name="SiparisId" required="true" hint="Fatura numarası eklenecek sipariş id değeri.">
        <cfargument  name="FaturaNo" required="true" hint="Eklenecek fatura numarası">
        <cfargument  name="FaturaTarihi" default="">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetFaturaNo>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:SiparisID>#arguments.SiparisID#</tem:SiparisID>
                            <tem:FaturaNo>#arguments.FaturaNo#</tem:FaturaNo>
                            <cfif len(arguments.FaturaTarihi)><tem:FaturaTarihi>#arguments.FaturaTarihi#</tem:FaturaTarihi></cfif>
                        </tem:SetFaturaNo>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetFaturaNo"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
    <cffunction  name="SetSiparisUrunDurum">
        <cfargument  name="Request" required="true" hint="İşlem için gerekli bilgileri içeren SetSiparisUrunDurumRequest sınıfı">
        <cfargument  name="SiparisID" required="true" hint="Siparis id değeri">
        <cfargument  name="SiparisUrunID" required="true" hint="Sipariş ürün id değeri.">
        <cfargument  name="DurumId" required="true" hint="Siparis ürün durum id değeri">
        <cfargument  name="Islem" required="true" hint="İşlem id">
        <cfargument  name="Adet" hint="Gönerilen ürün id li kaç ürünün durumu değişeceğini belirten parametre">
        <cfargument  name="IadeNedenID" hint="İade nedeni id değeri">
        <cfxml  variable="xmlData">
            <cfoutput>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                        <tem:SetSiparisUrunDurum>
                            <tem:UyeKodu>#UyeKodu#</tem:UyeKodu>
                            <tem:request>
                                <cfif len(arguments.Adet)><ns:Adet>#arguments.Adet#</ns:Adet></cfif>
                                <ns:DurumID>#arguments.DurumID#</ns:DurumID>
                                <cfif len(arguments.IadeNedenID)><ns:IadeNedenID>#arguments.IadeNedenID#</ns:IadeNedenID></cfif>
                                <ns:Islem>#arguments.Islem#</ns:Islem>
                                <ns:SiparisID>#arguments.SiparisID#</ns:SiparisID>
                                <ns:SiparisUrunID>#arguments.SiparisUrunID#</ns:SiparisUrunID>
                            </tem:request>
                        </tem:SetSiparisUrunDurum>
                    </soapenv:Body>
                </soapenv:Envelope>
            </cfoutput>
        </cfxml>
        <cftransaction>
            <cfhttp url="#web_service_url#" method="post" result="httpResponse">
                <cfhttpparam type="header" name="mimetype" value="text/xml" />
                <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/ISiparisServis/SetSiparisUrunDurum"\'>
                <cfhttpparam type="header" name="Content-Length" value="#len(xmlData)#">
                <cfhttpparam type="xml"   value="#trim(xmlData)#">            
            </cfhttp>
        </cftransaction>
        <cfreturn httpResponse>
    </cffunction>
</cfcomponent>
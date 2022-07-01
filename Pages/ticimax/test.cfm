

<cfscript>
    i={
        Id:0,
        Pid:0,
        Tanim:"Mobilya",
        Kod:"HM"

    };
</cfscript>



<cfxml variable="tt">
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:SelectKategori>
         <tem:UyeKodu>4SRYTUATO1QM23K6OBQ9AXTB42PZKX</tem:UyeKodu>
         <tem:kategoriID>0</tem:kategoriID>
      </tem:SelectKategori>
   </soapenv:Body>
</soapenv:Envelope>
</cfxml>
<cfset web_service_url="https://ashleyturkiye.ticimaxdemo.com/Servis/UrunServis.svc">
<cftransaction>
<cfhttp url="#web_service_url#" method="post" result="httpResponse">
    <cfhttpparam type="header" name="mimetype" value="text/xml" />
    <cfhttpparam type="header" name="SOAPAction" value='\"http://tempuri.org/IUrunServis/SelectKategori"\'>
    <cfhttpparam type="header" name="Content-Length" value="#len(tt)#">
    <cfhttpparam type="xml"   value="#trim(tt)#">

</cfhttp>
</cftransaction>
CultureSettings=H4sIAAAAAAAEAAXB3aJCMAAA4AdyETlOc9EFEvnLNJx1J9baFuav0tOf7%2fPUQCvf81ihLCA56M10XhPmEHq8zXUJyZW8nfGxiuDV3HylpRcDCGw39tN7cnHAuPLPMJH1hf00P7GXMsVRTpu5mHSQLOe5UlBxnmnb7IJH72%2fr8iQXyxSrHob%2bRJJwlzRHaDL9NR7JgfAH8dG0aszanqZjd824FneblyeGl91t3WUs1nCEnzsGNYusFt%2b9t9%2fDD7pbq75xtAK6dCy5QK5JrJgLK7lnf670rlRFi5wMZUES6IOxSZHSm7Y9ysSFMQ5xStWZfyO2gm%2fNAJA5ceb8ccqM7G3FUagMgEeqHcrK9uxI8srs8G3IrzyqBoi73PB%2fI5Or1EHCtNqRUUb3%2b38WkLXJWAEAAA%3d%3d; __cf_bm=RDFsKV4DV_Xwgd57ToIKKbicn9ePn_TNQmmEFgSSdBA-1656584693-0-AdBSInSZeBVGvsHIdsXgV+szu0RRF38CAr+97J+Zoy0XuiYFdQIwcB5GWib/HLC2LE5IWnL8mkr2x6NjDO4rL9Y=

<cfdump var="#tt#">

<cfdump var="#httpResponse#">
 
Web Servis
https://www.ticimax.com/dokumanlar/SiparisServis.pdf

https://www.ticimax.com/dokumanlar/UrunServis.pdf

https://www.ticimax.com/dokumanlar/UyeServis.pdf

https://www.ticimax.com/dokumanlar/CustomServis.pdf

Ek olarak https://dev.azure.com/ticimax/TicimaxWebService/_git/TicimaxWebService linkte ticimax servislerindeki metodların örnek c# kullanımlarının bulunduğu bir proje bulunmaktadır.



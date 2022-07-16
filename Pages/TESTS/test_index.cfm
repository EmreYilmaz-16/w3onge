<div style="display:flex">
<input type="number" id="dakika" value="0" onclick="getme(this)"><input type="number" onclick="getme(this)" id="saniye" value="0" ></div>
<button onclick="counterS()">Başlat</button>

<script>
var dakika=0;
var saniye=0;
  function getme(el) {
    var eee=el.getAttribute("id");

    var ii=el.value;
    if(parseInt(ii)>60){
      //preventDefault();
      el.value=0;
    }
    if(parseInt(ii)<0){
      //preventDefault();
      el.value=60;
    }
    if(eee=='dakika'){
      dakika=parseInt(el.value)
    }
    if(eee=='saniye'){
      saniye=parseInt(el.value)
    }
  }
  function counterS(){
var s=setInterval(() => {
  saniye--;
  var sf=saniye;
  if(saniye==0){
    dakika--;
  //  saniye=60
  };
  yaz(dakika,saniye)
if(dakika<=0 && saniye<=0){
  clearInterval(s)
 
  yaz(0,0);
  dakika=0;
  saniye=0;
  alert("Bitti");
}
if(saniye==0){
  saniye=60;
}
}, 1000);

  }
  function yaz(dak,san){
    var delem=document.getElementById("dakika");
    var selem=document.getElementById("saniye");

    delem.value=dak;
    selem.value=san;

  }
</script>

<cfabort>
<!----<cfoutput>
  <cfset index_folder=expandPath(".")>
  <cfset gitUrl="https://github.com/EmreYilmaz-16/w3onge.git">
  <cfset git_username="emre.yilmaz@hotmail.co.uk">
  <cfset git_password="J6F2ATaWpvGu3Lx">
</cfoutput>

<cfscript>
    		
    cfGit = createObject( "component", "/wcloud/cfcGit" );
    cfGit.init( 
        argGit_path : "git", 
        argGit_folder : index_folder,
        argGit_url : gitUrl,
        argGit_username : git_username,
        argGit_password : git_password
    );
    writeDump(cfGit.status());
</cfscript>


---->

<cfscript>
  u={
    CepTelefonu : "054",
    CinsiyetID: "0",
    DogumTarihi: "2022-01-01",
    Mail:"emre.yilmaz@hotmail.co.uk"
  };
  u1={
    CepTelefonu : "055",
    CinsiyetID: "0",
    DogumTarihi: "2022-01-01",
    Mail:"emre.yilmaz@hotmail.co.uk"
  };
  u2={
    CepTelefonu : "056",
    CinsiyetID: "0",
    DogumTarihi: "2022-01-01",
    Mail:"emre.yilmaz@hotmail.co.uk"
  };

  uyeArr=arrayNew(1);
  arrayAppend(uyeArr,u);
  arrayAppend(uyeArr,u1);
  arrayAppend(uyeArr,u2);
  ayar={
    CepTelefonuGuncelle : "0",
    CinsiyetGuncelle :"0",
    DogumTarihiGuncelle: "0"
  };
  SaveUye ={
    UyeKodu :"000000005",
    u:uyeArr,
    ayar:ayar
  };
 cdata["SaveUye"]=SaveUye;
</cfscript>


<cfdump var="#cdata#">













<cfscript>
//  xmlData= StructToXml(cdata);
</cfscript>




<!----
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
  
  
  ------->


<cffunction name="StructToXml">
  <cfargument name="Str">
  <cfset cData=Str>
  <cfset KeyArr=structKeyArray(cDATA)>
  <cfxml variable="xmlData">
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
      <soapenv:Header/>
      <soapenv:Body>
        <cfoutput>
        <cfloop array="#KeyArr#" item="item" index="i">
          <tem:#item#>
          <cfset InnerStruct=evaluate("cDATA.#item#")>
          <cfset InnerKeyArr=structKeyArray(InnerStruct)>
          <cfloop array="#InnerKeyArr#" item="item1" index="ix">
            <tem:#item1#>
            <cfset InnerStruct2=evaluate("cDATA.#item#.#item1#")>
            <cfif isStruct(InnerStruct2)>
              <cfset InnerKeyArr2=structKeyArray(InnerStruct2)>
              <cfloop array="#InnerKeyArr2#" item="item2" index="ixx">
                <cfset InnerStruct3=evaluate("cDATA.#item#.#item1#.#item2#")>        
              <ns:#item2#>
                <cfif isStruct(InnerStruct3)>
                <cfelse>
                  #InnerStruct3#
                </cfif>
              </ns:#item2#>
              </cfloop>
            <cfelse>
              #InnerStruct2#
            </cfif>
            </tem:#item1#>
          </cfloop>
          </tem:#item#>
        </cfloop>
        </cfoutput>
      </soapenv:Body>
    </soapenv:Envelope>
  </cfxml>
  <cfreturn xmlData>
</cffunction>
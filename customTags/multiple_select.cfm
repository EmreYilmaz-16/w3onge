<cfparam name="attributes.name" default="txt_search">
<cfparam name="attributes.query">
<cfparam name="attributes.value_column">
<cfparam name="attributes.text_column">
<cfif thisTag.executionMode eq "start">
<cfoutput>
    <input type="text" name="txt_search" id="txt_search" onkeyup="search(this,event)">
    <input type="text" name="#attributes.name#" id="#attributes.name#">
    <div class="pos-relative">
        <div   data-role="dropdown"
                id="drp">
               <table class="table subcompact">
                <thead>
                   <tr>
                    <th></th>
                    <th>Çalışan</th>
                   </tr>
                   <tbody id="resArea">

                   </tbody>
                </thead>
               </table>
        </div>
    </div>
</cfoutput>
</cfif>






<cfoutput>
    <script>
        var datas=[
            <cfloop query="#attributes.query#">
                {valued:'#evaluate(attributes.value_column)#',
                textd:'#evaluate(attributes.text_column)#'},
            </cfloop>
        ]
    </script>

</cfoutput>

<script>
var ela="";
var valArr=arrayNew();
$(document).ready(function(){
     ela = Metro.getPlugin('#drp','dropdown');
})
    function search(el,ev) {
        
            var ret=datas.filter(function(d){
              return d.textd.toLowerCase().includes(el.value.toLowerCase())
            })
            var resArea=document.getElementById("resArea");
            $(resArea).html("")
            for(let i=0;i<ret.length;i++){
                console.log(ret[i].textd)
                var tr=document.createElement("tr");
                var td=document.createElement("td");
                td.innerText=i+1;
                tr.appendChild(td);
                var td=document.createElement("td")
                var a=document.createElement("a");
                a.innerText=ret[i].textd;
                a.setAttribute("onclick","selData("+ret[i].valued+",'"+ret[i].textd+"')");
                td.appendChild(a);
                tr.appendChild(td);
                resArea.appendChild(tr)
            }
      
ela.open();
    }

function selData(){
    console.log(arguments)
}
</script>
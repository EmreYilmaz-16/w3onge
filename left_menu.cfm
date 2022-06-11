<cfquery name="getMenu" datasource="#dsn#">
    SELECT * FROM MODULES
</cfquery>
<ul class="sidenav-m3" style="width:100%">
    <li class="title"></li>
    <cfoutput query="getMenu">
        <cfquery name="getPages" datasource="#dsn#">
            SELECT * FROM PAGES WHERE MODULE_ID=#MODULE_ID#
        </cfquery>
        <cfif getPages.recordCount>
            <li class="">
                <a class="dropdown-toggle" href="##">#MODULE#</a>
                <ul class="d-menu" data-role="dropdown" style="display: none;">
                    <cfloop query="getPages">
                        <li><a href="#request.self#?fuseaction=#FUSEACTION#"><span class="mif-vpn-lock icon"></span> #PAGE_HEAD#</a></li>
                    </cfloop>
                </ul>
        <cfelse>
            <li class="active"><a href="##">#MODULE#</a></li>
        </cfif>
    </cfoutput>
    
  <!--
    <li class="stick-right bg-red"><a href="#"><span class="mif-cog icon"></span>Layouts</a></li>
    <li class="stick-left bg-green">
        <a class="dropdown-toggle" href="#"><span class="mif-tree icon"></span>Sub menu</a>
        <ul class="d-menu" data-role="dropdown" style="display: none;">
            <li><a href=""><span class="mif-vpn-lock icon"></span> Subitem 1</a></li>
            <li><a href="">Subitem 2</a></li>
            <li><a href="">Subitem 3</a></li>
            <li><a href="">Subitem 4</a></li>
            <li class="disabled"><a href="">Subitem 5</a></li>
        </ul>
    </li>
    <li class=""><a href="#">Thread item</a></li>
    <li class="disabled"><a href="#">Disabled item</a></li>

    <li class="title">Title 2</li>
    <li><a href="#">Other Item 1</a></li>
    <li><a href="#">Other item 2</a></li>
    <li><a href="#">Other item 3</a></li>-->
</ul>

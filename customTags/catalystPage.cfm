<cfif thisTag.executionMode eq "start">
    <cfparam name="attributes.ajaxFunction" default="">
    <cfif caller.attributes.totalrecords gt caller.attributes.maxrows>
        <cfoutput>
            <nav aria-label="...">
                <span class="pull-left margin-left-5">
                    #caller.getLang('main',128)# : #caller.attributes.totalrecords# - #caller.getLang('main',169)# : #attributes.page#
                </span>
                <ul class="pager pull-right margin-right-5">
                    <cfif attributes.page eq 1>
                        <li class="disabled"><a>#caller.getLang('main',20)#</a></li>
                    <cfelse>
                        <li><a onclick="<cfif len(attributes.ajaxFunction)>control('down');<cfelse>callPage('#attributes.page-1#','#attributes.formName#')</cfif>">#caller.getLang('main',20)#</a></li>
                    </cfif>
                    <cfif (attributes.page * caller.attributes.maxrows) gt caller.attributes.totalrecords>
                        <li class="disabled"><a>#caller.getLang('main',1431)#</a></li>
                    <cfelse>
                        <li><a onclick="<cfif len(attributes.ajaxFunction)>control('up');<cfelse>callPage('#attributes.page+1#','#attributes.formName#')</cfif>">#caller.getLang('main',1431)#</a></li>
                    </cfif>
                </ul>
            </nav>
        </cfoutput>
    </cfif>
    <cfif len(attributes.ajaxFunction)>
        <script type="text/javascript">
        function control(upDown)
        {
            <cfoutput>
            if(upDown == 'up')
                $("form[name='#attributes.formName#'] input[name='page']").val(parseFloat($("form[name='#attributes.formName#'] input[name='page']").val())+1);
            else
                $("form[name='#attributes.formName#'] input[name='page']").val(parseFloat($("form[name='#attributes.formName#'] input[name='page']").val())-1);
                console.log($("form[name='#attributes.formName#'] input[name='page']").val());
                window[#attributes.ajaxFunction#];
            </cfoutput>
        }
        </script>
    </cfif>
</cfif>
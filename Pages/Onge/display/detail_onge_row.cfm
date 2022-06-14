<div class="row">
<div class="cell-9">
<cfquery name="getDetail" datasource="#dsn#">
    	   select ROW_HEADER,ROW_DESCRIPTION,STAGE,RECORD_DATE,dbo.GET_EMPLOYEE(RECORD_EMP) AS RECORDED_EMP,ONGE_ROW_ID from ONGE_ROWS AS ORR
		LEFT JOIN PROCESS_TYPE_ROWS AS PT ON ORR.ROW_STAGE=PT.PROCESS_ROW_ID where ONGE_ROW_ID=#attributes.row_id#
</cfquery>
<cfoutput query="getDetail">
<p style="font-weight:bold">#ROW_HEADER#</p>
<div>
    <blockquote>
        #ROW_DESCRIPTION#
    </blockquote>
</div>


</cfoutput>
</div>
<div class="cell-3">
    <div data-role="panel"
    data-title-caption="Ekip"
    data-title-icon="<span class='mif-apps'></span>">
    <cfquery name="getEkip" datasource="#dsn#">
select dbo.GET_EMPLOYEE(EMP_ID) AS E,dbo.GET_ONGE_ROLE(ROLE_ID) AS R from ONGE_ROW_EMPLOYEE WHERE ONGE_ROW_ID=#attributes.row_id#
    </cfquery>
    <table class="table striped subcompact">
        <cfoutput query="getEkip">
            <tr>
                <td>
                    #E#
                </td>
                <td>
#R#
                </td>
            </tr>
        </cfoutput>
    </table>
</div>
</div>
</div>
<cfparam name="attributes.action_section" default="">
<cfparam name="attributes.company_id" default="1">
<cfparam name="attributes.period_id" default="">
<cfparam name="attributes.action_id" default="">
<cfparam name="attributes.asset_cat_id" default="">

<cfset getNotesComponent = createObject('component','cfc.components')>
<cfset getNotes = getNotesComponent.getNotes(action_section:attributes.action_section,action_id:attributes.action_id)>

<div class="slimScrollDiv padding-LR-10" style="position: relative;overflow: auto;width: auto;max-height: 550px;">

    <ul class="chats">
    	<cfoutput query="getNotes">
        
            <li class="<cfif len(EMPLOYEE)>in<cfelse>out</cfif> main">
            	<cfif len(EMPLOYEE)>
                    <img class="avatar" alt="" src="documents/hr/#PHOTO#">
                <cfelse>
                    <img class="avatar" alt="" src="images/noProfile.png">
                </cfif>
                <div class="message">
                    <span class="arrow"></span>
                    <a href="javascript:;" class="name"><cfif len(EMPLOYEE)>#EMPLOYEE#<cfelse>#COMPANY_PARTNER#</cfif></a>
                    <span class="datetime"> #TimeFormat(caller.date_add('h',session.pp.time_zone,record_date),'HH:MM')# - #Dateformat(record_date,'dd/mm/yyyy')#</span>
                    <span class="body">#BODY#</span>
                    <span class="bodyChatButton">
                        <a onclick="$(this).parent('span').parent('div').find('div.chat-form').toggle();$(this).parent('span').parent('div').find('div.chat-form input.messageField').focus()"><i class="fa fa-comment"></i>#caller.getLang('objects2',178,'Yanıtla')#</a>
                        <cfset getDocuments = getNotesComponent.getDocuments(action_section:'note',action_id:note_id)>
                        <cfif GETDOCUMENTS.RECORDCOUNT>
                            <a onclick="$(this).next('.attacmentBody').toggle();"><i class="fa fa-paperclip"></i>#caller.getLang('objects',199,'Ek')#:<span class="badge badge-danger">#GETDOCUMENTS.RECORDCOUNT#</span></a>
                            <div class="attacmentBody" style="display:none;">
                                <ul class="attacmentList">
                                    <cfloop query="getDocuments">
                                        <li>
                                            <i class="fa fa-file-o"></i><a href="documents/#PATH#" download>#ASSET_NAME#</a>
                                            <i class="fa fa-times"></i>
                                        </li>
                                       
                                    </cfloop>
                                </ul>
                            </div>
                        </cfif>
                         
                    </span>	
                    <div id="bodyAnswer#currentrow#" class="bodyAnswers">
                    	<cfset getNotesComment = getNotesComponent.getNotes(action_section:'NOTE',action_id:NOTE_ID)>
                     
						<ul class="chatsAnwars">
                       
							<cfif getNotesComment.recordcount>
                            	<cfloop query="getNotesComment">
                                    <li class="<cfif len(EMPLOYEE)>in<cfelse>out</cfif>">
										<cfif len(EMPLOYEE)>
                                            <img class="avatar" alt="" src="documents/hr/#PHOTO#">
                                        <cfelse>
                                            <img class="avatar" alt="" src="images/noProfile.png">
                                        </cfif>
                                        <div class="message">
                                            <span class="arrow"> </span>
                                            <a href="javascript:;" class="name"><cfif len(EMPLOYEE)>#EMPLOYEE#<cfelse>#COMPANY_PARTNER#</cfif></a>
                                            <span class="datetime"> #TimeFormat(caller.date_add('h',session.pp.time_zone,record_date),'HH:MM')# - #Dateformat(record_date,'dd/mm/yyyy')#</span>
                                            <span class="body">#BODY#</span>	
                                            <span class="bodyChatButton">
                                                <cfset getDocumentsComment = getNotesComponent.getDocuments(action_section:'note',action_id:note_id)>
                                                <cfif getDocumentsComment.RECORDCOUNT>
                                                    <a onclick="$(this).next('.attacmentBody').toggle();"><i class="fa fa-paperclip"></i>#caller.getLang('objects',199,'Ek')#:<span class="badge badge-danger">#getDocumentsComment.RECORDCOUNT#</span></a>
                                                    <div class="attacmentBody" style="display:none;">
                                                        <ul class="attacmentList">
                                                            <cfloop query="getDocumentsComment">
                                                                <li>
                                                                    <i class="fa fa-file-o"></i><a href="documents/#PATH#" download>#ASSET_NAME#</a>
                                                                    <i class="fa fa-times"></i>
                                                                </li>
                                                            </cfloop>
                                                        </ul>
                                                    </div>
                                                </cfif>
                                            </span>
                                        </div>
                                    </li>
                                </cfloop>
                            </cfif>
                        </ul>
                        <div class="chat-form" style="display:none;">
                            <div class="input-group searchInput col-md-12">
                                <input type="hidden" class="noteId" name="noteId" value="#NOTE_ID#">
                                <input type="text" class="form-control messageField" name="messageField" placeholder="Mesajınızı yazınız...">
                                <div class="input-group-btn">
                                    <button type="button" class="btn default" onclick="fileUploadModal(this);">
                                        <i class="fa fa-paperclip icon-white"></i><span class="badge"></span>
                                    </button>
                                    <button id="emin#currentrow#" type="button" class="btn btn-info" onclick="saveNote(this,'#currentrow#')">
                                        <i class="fa fa-check icon-white"></i>
                                    </button>	
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </cfoutput>
    </ul>
</div>
<cfoutput>
	<div class="chat-form">
		<div class="input-group searchInput col-md-12">
			<input type="hidden" class="noteId" name="noteId" value="#attributes.action_id#">
			<input type="text" class="form-control messageField" name="messageField" placeholder="Mesajınızı yazınız...">
			<div class="input-group-btn">
				<button type="button" class="btn default" onclick="fileUploadModal(this);">
					<i class="fa fa-paperclip icon-white"></i><span class="badge"></span>
				</button>
				<button type="button" class="btn btn-info" onclick="saveNote(this)">
					<i class="fa fa-check icon-white"></i>
				</button>	
			</div>
		</div>
	</div>
</cfoutput>

<li class="out" id="base" style="display:none;">
    <img class="avatar" alt="" src="images/noProfile.png">
    <div class="message">
        <span class="arrow"></span>
        <a href="javascript:;" class="name"></a>
        <span class="datetime"></span>
        <span class="body"></span>	
        <span class="bodyChatButton">
			<a class="attach" style="display:none;" onclick="$(this).next('.attacmentBody').toggle();"><i class="fa fa-paperclip"></i><cfoutput>#caller.getLang('objects',199,'Ek')#</cfoutput>:<span class="badge badge-danger"></span></a>
            <div class="attacmentBody" style="display:none;">
                <ul class="attacmentList">
                </ul>
            </div>
        </span>
    </div>
</li>

<li class="out main" id="mainBase" style="display:none;">
	<img class="avatar" alt="" src="images/noProfile.png">
    <div class="message">
        <span class="arrow"></span>
        <a href="javascript:;" class="name"></a>
        <span class="datetime"></span>
        <span class="body"></span>
        <span class="bodyChatButton">
            <a onclick="$(this).parent('span').parent('div').find('div.chat-form').toggle();$(this).parent('span').parent('div').find('div.chat-form input.messageField').focus()"><i class="fa fa-comment"></i>Yanıtla</a>
        </span>	
        <div class="bodyAnswers">
            <ul class="chatsAnwars"></ul>
            <div class="chat-form" style="display:none;">
                <div class="input-group searchInput col-md-12">
                    <input type="hidden" class="noteId" name="noteId" value="">
                    <input type="text" class="form-control messageField" name="messageField" placeholder="Mesajınızı yazınız...">
                    <div class="input-group-btn">
                        <button type="button" class="btn default" onclick="fileUploadModal(this);">
                            <i class="fa fa-paperclip icon-white"></i><span class="badge"></span>
                        </button>
                        <button type="button" class="btn btn-info" onclick="saveNote(this)"
                            <i class="fa fa-check icon-white"></i>
                        </button>	
                    </div>
                </div>
            </div>
        </div>
    </div>
</li>

<script type="text/javascript">

$( function() {
	$('select#assetcat_id option[value='+<cfoutput>#attributes.asset_cat_id#</cfoutput>+']').attr('selected','selected');}
);
function saveNote(obj,rowNumber)
{
  
    
	attachment = 0;
	files = [];
	myDropzone.processQueue();
	attachmentReturn = '';
	fileRealNameList = '';
	fileRealNameFullList = '';
	fileSystemNameList = '';

		try{
			// attachmentReturn = $.parseJSON( returningValue );
			// console.log(attachmentReturn);
			// for(k=0;k<attachmentReturn.length;k++)
			// {
			// 	if(fileRealNameList.length)
			// 	{
			// 		fileRealNameList = fileRealNameList + ',' + myDropzone.files[k]._newFileName.value;
			// 		fileRealNameFullList = fileRealNameFullList + ',' + myDropzone.files[k]._newFileName.value+'.'+attachmentReturn[k]['ext'];
			// 		fileSystemNameList = fileSystemNameList + ',' + attachmentReturn[k]['systemName'];
			// 	}
			// 	else
			// 	{
			// 		fileRealNameList = myDropzone.files[k]._newFileName.value;
			// 		fileRealNameFullList = myDropzone.files[k]._newFileName.value+'.'+attachmentReturn[k]['ext'];
			// 		fileSystemNameList = attachmentReturn[k]['systemName'];
			// 	}	
			// }
            console.log("Burayakadar")
			noteBody = $(obj).parent("div").parent('div').find('input.messageField').val();
			actionId = $(obj).parent("div").parent('div').find('input.noteId').val();
			
			
			if(rowNumber)
			{
				assetCatId = '<cfoutput>#attributes.ASSET_CAT_ID#</cfoutput>';
				noteHead = 'comment';
                actionSection = 'NOTE';
			}
			else
			{
				assetCatId = '<cfoutput>#attributes.ASSET_CAT_ID#</cfoutput>';
				noteHead = 'comment';
                 actionSection = 'WORK_ID';
			}
			propertyId = $("#property_id").val();
			assetDescription = $("#asset_description").val();
			assetDetail = $("#asset_detail").val();
		console.log("Burayakadar2")
			$.ajax({ url :'cfc/components.cfc?method=SAVENOTES', data : {noteBody : noteBody, actionId:actionId, actionSection:actionSection, noteHead:noteHead, fileRealNameList:fileRealNameList, fileRealNameFullList:fileRealNameFullList,fileSystemNameList:fileSystemNameList , assetCatId : assetCatId,propertyId:propertyId,assetDescription:assetDescription, assetDetail:assetDetail  }, async:false,success : function(res){ 
				data = $.parseJSON( res );
				if ( data['DATA'].length ) {
						if(rowNumber)
						{
							var temp = $("li#base").clone();
							temp.removeAttr('style').removeAttr('id');
							$(temp).find('a.name').html(data['DATA'][0][8]);
							$(temp).find('span.body').html(data['DATA'][0][3]);
							$(temp).find('span.datetime').html(data['DATA'][0][4]);
							if(data['DATA'][0][9].length)
							{
								$(temp).find('a.attach').removeAttr('style');
								$(temp).find('a.attach span.badge').html(data['DATA'][0][9].split(',').length);
								for(i=0;i<data['DATA'][0][9].split(',').length;i++)
								{
									$("<li>").append(
														$("<i>").attr('class','fa fa-file-o'),
														$("<a>").attr({'href':'documents/notes/'+list_getat(data['DATA'][0][10],i+1,',').trim(),'download':''}).html(list_getat(data['DATA'][0][9].trim(),i+1,',')),
														$("<i>").attr('class','fa fa-times')
													).appendTo($(temp).find("ul.attacmentList"));
								}							
							}
							$(obj).parent('div').parent('div').parent('div').parent('div').find('ul').append(temp);
							$(obj).parent("div").parent('div').find('input.messageField').val('');
						}
						else
						{
							var temp = $("li#mainBase").clone();
							temp.removeAttr('style').removeAttr('id');
							$(temp).find('a.name').html(data['DATA'][0][8]);
							$(temp).find('span.body').html(data['DATA'][0][3]);
							$(temp).find('span.datetime').html(data['DATA'][0][4]);
							$(temp).find('input.noteId').val(data['DATA'][0][1]);
							$(temp).find('button.btn-info').attr('onclick',"saveNote(this,'"+($("ul.chats li.main").length+1)+"')");
						}
					}
				} 
			});
		}
		catch(e){console.log(e)}
	
}
</script>
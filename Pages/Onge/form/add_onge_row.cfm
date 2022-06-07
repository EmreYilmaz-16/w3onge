<cfquery name="getstages" datasource="#dsn#">
    SELECT * FROM PROCESS_TYPE_ROWS WHERE PROCESS_TYPE_ID IN (SELECT PROCESS_TYPE_ID FROM PROCESS_TYPE WHERE FACTION LIKE '%#attributes.fuseaction#%')
</cfquery>
<style>
    .ck-editor__editable_inline {
min-height: 250px;
}
</style>
<input type="checkbox" data-role="switch" data-material="true" data-caption="Aktif">
<p>Başlık</p>
<input type="text" data-role="input" name="ROW_HEADER" class="">

<p>Süreç</p>
<select  data-role="select" name="stage" data-filter="false">      
    <cfoutput query="getstages">
        <option value="#PROCESS_ROW_ID#">#STAGE#</option>
    </cfoutput>
</select>

<p>Açıklama</p>
<input type="text" id="editor" name="ROW_DESCRIPTION" class="">

<input type="submit">


<script src="/ckeditor/ckeditor.js"></script>
<script>
    ClassicEditor
        .create( document.querySelector( '#editor' ), {
            // toolbar: [ 'heading', '|', 'bold', 'italic', 'link' ]
        } )
        .then( editor => {
            window.editor = editor;
        } )
        .catch( err => {
            console.error( err.stack );
        } );
</script>
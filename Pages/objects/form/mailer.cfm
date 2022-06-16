<style>
    .ck-editor__editable_inline {
min-height: 350px;
}
</style>
<p>Konu</p>
<input type="text" name="ONGE_HEADER" data-role="input" class="">
<p>Kime</p>
<input type="text" name="ONGE_HEADER" data-role="input" class="">

<p>Açıklama</p>
<textarea id="editor" name="editor">
    <p>The editor content goes here.</p>
</textarea>
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

<cfif isDefined("attributes.is_form")>
<cfelse>
    <cfset MAIL_LIST =attributes.mail_list>
    <cfset SUBJE =attributes.subje>
    <cfset MESSAGE =attributes.message>
</cfif>

<cffunction name="sendMail">
    <cfargument name="mail_list" default="">
    <cfargument name="subje" default="">
    <cfargument name="message" default="">
</cffunction>
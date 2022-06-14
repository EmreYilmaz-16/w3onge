
/**
*
* @file  c:\inetpub\devcatalyst\cfc\cfGit_helper.cfc
* @author  Uğur Hamurpet<ugurhamurpet@workcube.com>
* @description CfGit helper component
*
*/

component output="true" displayname="cfGit Helper Component"  {

    public function init(){
        return this;
    }

    public any function getPages( string allPages, excluding ) {
        
        pages = [];
        
        if( len( allPages ) ){

            items = ListToArray( trim( allPages ), Chr(10), true );
            pages = arrayFilter( items, function( elm ){
                return ( FindNoCase( excluding[1], elm ) eq 0 ) && ( FindNoCase( excluding[2], elm ) eq 0 ) && ( FindNoCase( excluding[3], elm ) eq 0 );
            } );

        }

        return pages;

    }
    
    
    
}

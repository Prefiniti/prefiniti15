<cfinclude template="/contentManager/cm_udf.cfm">

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat;">
    <div style="float:left">
        <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Upload File</h3>
    </div>

    <cfif URL.mode EQ "user">
        <cfset base = "/UserContent/">
    <cfelse>
        <cfset base = "/SiteContent/">
    </cfif>

    <cfset uploadPath = base & URL.username & "/" & URL.basedir & "/" & URL.subdir>


    <div style="clear: both;">
        <cfoutput>
            <form action="/contentManager/components/process_upload.cfm?mode=#url.mode#&site_id=#url.site_id#&user_id=#url.user_id#&basedir=#url.basedir#&subdir=#url.subdir#" method="POST" target="html5upload" enctype="multipart/form-data">
                <table width="100%">
                    <tr>
                        <td>File:</td>
                        <td><input type="file" name="Filedata"></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <input type="submit" name="Submit" value="Submit">
                        </td>
                    </tr>
                </table>
            </form>
        </cfoutput>                
    </div>


    <iframe style="border: 0; background-image: none;" name="html5upload" id="html5upload">
            
    </iframe>

    
</div>

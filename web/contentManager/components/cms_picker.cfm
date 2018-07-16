<cfif isDefined("attributes.height")>
    <cfset height = attributes.height>
<cfelse>
    <cfset height = -1>
</cfif>

<cfoutput>
    <input type="hidden" name="#attributes.element_name#" id="cms-picker-#attributes.element_name#-selection" value="0">
    <div class="text-right p-2">
        <div class="btn-group">
            <button type="button" class="btn btn-primary btn-xs" onclick="Prefiniti.CMS.enableUpload('#attributes.element_name#');"><i class="fa fa-upload"></i></button>
            <button type="button" class="btn btn-primary btn-xs" onclick="Prefiniti.CMS.refreshPicker('#attributes.element_name#', #height#);"><i class="fa fa-redo"></i></button>
        </div>
    </div>

    <div id="cms-picker-#attributes.element_name#-container">
        
        <cfmodule template="/contentManager/components/cms_picker_inner.cfm" element_name="#attributes.element_name#" height="#height#">
    </div>
    
</cfoutput>
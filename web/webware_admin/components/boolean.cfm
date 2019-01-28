<cfoutput>
    <select id="#attributes.fieldprefix#_#attributes.fieldname#" class="custom-select" onchange="Prefiniti.Admin.setBooleanField(#attributes.userid#, '#attributes.fieldname#', '#attributes.fieldprefix#');">
        <option value="1" <cfif attributes.fieldval EQ 1>selected</cfif>>Yes</option>
        <option value="0" <cfif attributes.fieldval EQ 0>selected</cfif>>No</option>
    </select>    
</cfoutput>
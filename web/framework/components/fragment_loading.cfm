<cfif isDefined("attributes.base_id")>
    <cfset baseId = attributes.base_id>
<cfelse>
    <cfset baseId = url.base_id>
</cfif>

<cfoutput>
    <div class="row">
        <div class="col-lg-12 text-center m-8">
            <div class="p-3" style="border: 1px solid ##efefef">
                <h3 id="#baseId#-loading">Loading...</h3>
                <h1><i class="fa fa-spinner fa-spin"></i></h1>
            </div>
        </div>
    </div>
</cfoutput>
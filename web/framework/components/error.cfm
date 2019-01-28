<cfset err_template = "/error_templates/" & lcase(attributes.error_code) & ".cfm">

<div class="wrapper wrapper-content animated fadeInUp">
    <div class="row">
        <div class="col-lg-4">
        </div>
        <div class="col-lg-4">
            <div class="ibox m-5">            
                <div class="ibox-content text-center p-5">
                    <h1>Oops!</h1>
                    <img src="/graphics/sick_pc.jpg">
                    <cftry>
                        <cfmodule template="#err_template#">
                        <cfcatch type="any">
                            <p>An unexpected error has occurred.</p>
                            <cfoutput>
                            <p>#cfcatch.message#</p>
                            <p>#cfcatch.detail#</p>
                            </cfoutput>
                        </cfcatch>
                    </cftry>
                    <button type="button" class="btn btn-primary btn-lg" onclick="Prefiniti.home();"><i class="fa fa-home"></i> Home</button>
                </div>
            </div>
        </div>
        <div class="col-lg-4"></div>
    </div>
</div>


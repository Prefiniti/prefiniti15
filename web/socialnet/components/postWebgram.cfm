<div class="wwaf-metadata">
    <wwaftitle>Post WebGram</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,System Admin,Post WebGram</wwafbreadcrumbs>
</div>


<cfoutput>
    <form name="post-webgram" id="post-webgram" method="POST" action="/socialnet/components/post_webgram_sub.cfm">
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Webgram Body</label>
            <div class="col-lg-10">
                <textarea name="webgram_body" class="form-control summernote" rows="15">
                   
                </textarea>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('post-webgram');">Post WebGram</button>
            </div>
        </div>
    </form>
</cfoutput>

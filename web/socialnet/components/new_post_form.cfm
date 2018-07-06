
<form id="user-post-comment-form">
    <cfoutput>
        <input type="hidden" id="comment-parent-#attributes.base_id#" name="parent_post_id" value="0">
        <input type="hidden" id="comment-from-#attributes.base_id#" name="author_id" value="#attributes.author_id#">
        <input type="hidden" id="comment-to-#attributes.base_id#" name="recipient_id" value="#attributes.recipient_id#">
        <input type="hidden" id="comment-post-class-#attributes.base_id#" name="post_class" value="#attributes.post_class#">
    </cfoutput>
    <div class="input-group mb-5">
        <cfoutput>
            <input class="form-control" type="text" id="comment-body-copy-#attributes.base_id#" name="body_copy" placeholder="Enter your post...">
        </cfoutput>
        <div class="input-group-append">
            <cfoutput>
                <button type="button" class="btn btn-primary" onclick="Prefiniti.submitComment('#attributes.base_id#');">Post</button>
                <button type="button" class="btn btn-primary" onclick="Prefiniti.cancelComment('#attributes.base_id#');">Cancel</button>
            </cfoutput>
        </div>
    </div>
</form>

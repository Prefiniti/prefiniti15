<cfset prefiniti = new Prefiniti.Base()>
<cfset post = new Prefiniti.SocialNetworking.Post().retrieve(attributes.id)>

<cfset replies = post.getChildPosts()>
<cfoutput>

    <div class="row mb-3">
        <div class="col-sm-1">
            <div class="thumbnail">
                <img class="img-thumbnail avatar" src="#post.author.getPicture()#">
            </div><!-- /thumbnail -->
        </div><!-- /col-sm-1 -->

        <div class="col-sm-11">
            <div class="card card-default mb-3">
                <div class="card-header">
                    <a href="##" onclick="Prefiniti.viewProfile(#post.author_id#);"><strong>#post.author.longName#</strong></a> <span class="text-muted">commented #prefiniti.getFriendlyDuration(post.post_date)# - #dateFormat(post.post_date, "mmm d, yyyy")#</span>
                </div>
                <div class="card-body">
                    <p class="card-text">
                        #post.body_copy#
                    </p>
                    <div class="float-right post-buttons mb-3">
                        <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-light" onclick="Prefiniti.likePost(#post.id#, #post.recipient_id#);"><i class="fa fa-thumbs-up"></i> <span class="badge">#post.reactionCount("like")#</span></button>
                            <button type="button" class="btn btn-sm btn-light" onclick="Prefiniti.dislikePost(#post.id#, #post.recipient_id#);"><i class="fa fa-thumbs-down"></i> <span class="badge">#post.reactionCount("dislike")#</span></button>
                            <button type="button" class="btn btn-sm btn-light" onclick="Prefiniti.revealPostReply(#post.id#);"><i class="fa fa-reply"></i></button>  
                            <cfif post.author_id EQ session.user.id OR post.recipient_id EQ session.user.id>
                                <button type="button" class="btn btn-sm btn-light" onclick="Prefiniti.deletePost(#post.id#, #post.recipient_id#);"><i class="fa fa-trash-alt"></i></button>                          
                            </cfif>
                        </div>
                    </div>
                    

                </div><!-- /card-body -->
            </div><!-- /card card-default -->

            <div class="row mb-5" id="post-reply-#post.id#" style="display: none; clear:both;">
                <div class="col-md-12">
                    <form class="mt-3">
                        <cfoutput>
                            <input type="hidden" id="post-reply-parent-#post.id#" value="#post.id#">
                            <input type="hidden" id="post-reply-author-#post.id#" value="#session.userid#">
                            <input type="hidden" id="post-reply-recipient-#post.id#" value="#post.recipient_id#">
                            <input type="hidden" id="post-reply-post-class-#post.id#" value="#post.post_class#">
                        </cfoutput>
                        <div class="input-group mb-1">
                            <input class="form-control" type="text" id="post-reply-body-#post.id#" name="body_copy" placeholder="Enter your reply...">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-primary" onclick="Prefiniti.replyPost(#post.id#);">Post</button>
                                <button type="button" class="btn btn-primary" onclick="Prefiniti.cancelReply(#post.id#);">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div> <!-- reply form -->

            
            <cfloop array="#replies#" item="reply">
                <cfmodule template="/socialnet/components/view_post.cfm" id="#reply.id#">            
            </cfloop>
            
        </div><!-- /col-sm-5 -->
    </div>

</cfoutput>
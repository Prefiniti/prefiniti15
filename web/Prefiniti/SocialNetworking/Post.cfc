component extends="Prefiniti.Base" output="false" {

    public Prefiniti.SocialNetworking.Post function init() output=false {

        this.id = 0;
        this.post_class = "USER";
        this.parent_post_id = 0;
        this.author_id = 0;
        this.recipient_id = 0;
        this.post_date = createODBCDateTime(now());
        this.edit_date = createODBCDateTime(now());
        this.post_read = 0;
        this.body_copy = "";

        this.saved = false;

        return this;
    
    }

    public Prefiniti.SocialNetworking.Post function create() output=false {

        var qrySql = "INSERT INTO posts(post_class, parent_post_id, author_id, recipient_id, post_read, body_copy) ";
        qrySql = qrySql & "VALUES (:post_class, :parent_post_id, :author_id, :recipient_id, :post_read, :body_copy)";

        var q = queryExecute(qrySql, {post_class=this.post_class,
                                        parent_post_id=this.parent_post_id,
                                        author_id=this.author_id,
                                        recipient_id=this.recipient_id,                                        
                                        post_read=0,
                                        body_copy=this.body_copy}, {datasource="webwarecl"});

        this.saved = true;

        var author = new Prefiniti.Authentication.UserAccount({id: this.author_id}, false);
        var recipient = new Prefiniti.Authentication.UserAccount({id: this.recipient_id}, false)

        var notification = new Prefiniti.Notification(recipient, "SN_COMMENT_POSTED", {
            postAuthor: author.id,
            postRecipient: this.recipient_id,
            parent_post_id: this.parent_post_id,
            post_class: this.post_class,
            body_copy: this.body_copy
        });

        notification.send();        

        return this;
    }

    public Prefiniti.SocialNetworking.Post function retrieve(required numeric id) output=false {

        var q = queryExecute("SELECT * FROM posts WHERE id=:id", {id=arguments.id}, {datasource="webwarecl"})

        this.id = q.id;
        this.post_class = q.post_class;
        this.parent_post_id = q.parent_post_id;
        this.author_id = q.author_id;
        this.recipient_id = q.recipient_id;
        this.post_date = q.post_date;
        this.edit_date = q.edit_date;
        this.post_read = q.post_read;
        this.body_copy = q.body_copy;

        this.author = new Prefiniti.Authentication.UserAccount({id: this.author_id}, false);

        return this;
    }

    

    public Prefiniti.SocialNetworking.Post function update() output=false {

        var qrySql = "UPDATE posts SET post_class=:post_class, parent_post_id=:parent_post_id, author_id=:author_id, ";
        qrySql = qrySql & "recipient_id=:recipient_id, edit_date=:edit_date, post_read=:post_read, body_copy=:body_copy) ";
        qrySql = qrySql & "WHERE id=:id"

       
        var q = queryExecute(qrySql, {post_class=this.post_class,
                                        parent_post_id=this.parent_post_id,
                                        author_id=this.author_id,
                                        recipient_id=this.recipient_id,
                                        edit_date=createODBCDateTime(now()),
                                        post_read=this.post_read,
                                        body_copy=this.body_copy,
                                        id=this.id}, {datasource="webwarecl"});

        this.saved = true;

        return this;
    }

    public Prefiniti.SocialNetworking.Post function delete() output=false {

        var qrySql = "DELETE FROM posts WHERE id=:id";

        var q = queryExecute(qrySql, {id=this.id}, {datasource="webwarecl"});

        var qrySql = "DELETE FROM posts WHERE parent_post_id=:id";

        var q = queryExecute(qrySql, {id=this.id}, {datasource="webwarecl"});

        this.saved = false;

        return this;
    }

    public array function getChildPosts() output=false {

        var result = [];
        var qrySql = "SELECT id FROM posts WHERE parent_post_id=:id ORDER BY post_date DESC";
        var posts = queryExecute(qrySql, {id=this.id}, {datasource="webwarecl"});

        for(post in posts) {
            var postObj = new Prefiniti.SocialNetworking.Post().retrieve(post.id);

            result.append(postObj);
        } 

        return result;

    }


    public void function react(required Prefiniti.Authentication.UserAccount user, required string reaction) output=false {

        queryExecute("DELETE FROM post_reactions WHERE post_id=:post_id AND user_id=:user_id", 
                    {post_id=this.id,
                    user_id=arguments.user.id}, {datasource="webwarecl"});

        var qrySql = "INSERT INTO post_reactions(post_id, reaction, user_id) ";
        qrySql = qrySql & " VALUES (:post_id, :reaction, :user_id)";

        queryExecute(qrySql, {
            post_id=this.id,
            reaction=arguments.reaction,
            user_id=arguments.user.id
        }, {datasource="webwarecl"});

        switch(arguments.reaction) {
            case "like":
                var notification = new Prefiniti.Notification(arguments.user, "SN_POST_LIKED", {
                    reactor: arguments.user,
                    author: this.author,
                    body_copy: this.body_copy                
                });

                notification.send();
                
                break;
            case "dislike":
                var notification = new Prefiniti.Notification(arguments.user, "SN_POST_DISLIKED", {
                    author: this.author,
                    reactor: arguments.user,
                    body_copy: this.body_copy
                });

                notification.send();         

                break;
        }

    }

    public numeric function reactionCount(required string reaction) output=false {
        var qrySql = "SELECT id FROM post_reactions WHERE post_id=:post_id AND reaction=:reaction";

        return queryExecute(qrySql, {post_id=this.id, reaction=arguments.reaction}, {datasource="webwarecl"}).recordCount;
    }

}
<cfquery name="pwg" datasource="webwarecl">
	INSERT INTO webgrams
    	(user_id,
        w_body,
        post_date)
	VALUES
    	(#url.user_id#,
        '#url.w_body#',
        #CreateODBCDateTime(Now())#)        
</cfquery>

<h1>Posted.</h1>
<cfcomponent extends="Prefiniti.Base" output="false">

    <cffunction name="init" returntype="Prefiniti.Collaboration.Resolution" output="false" access="public">
        <cfargument name="id" type="numeric" required="false">
    
        <cfscript>
            this.id = arguments.id;
            this.site_id = 0;
            this.sponsor_assoc_id = 0;
            this.res_carry_threshold = 0;
            this.res_quorum = 0;
            this.res_eligibility = 0;
            this.res_tabled = 0;
            this.res_voting_open = createODBCDateTime(now());
            this.res_voting_close = createODBCDateTime(now());
            this.res_create_date = createODBCDateTime(now());
            this.res_title = "";
            this.res_text = "";
            this.res_repeals = 0;
            this.create_id = createUUID();
            this.saved = false;
        </cfscript>

        <cfif isDefined("arguments.id")>
            <cfquery name="getResolution" datasource="sites">
                SELECT * 
                FROM res_resolutions 
                WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            </cfquery>

            <cfif getResolution.recordCount GT 0>
                <cfscript>            
                    this.site_id = getResolution.site_id;
                    this.sponsor_assoc_id = getResolution.sponsor_assoc_id;
                    this.res_carry_threshold = getResolution.res_carry_threshold;
                    this.res_quorum = getResolution.res_quorum;
                    this.res_eligibility = getResolution.res_eligibility;
                    this.res_tabled = getResolution.res_tabled;
                    this.res_voting_open = getResolution.res_voting_open;
                    this.res_voting_close = getResolution.res_voting_close;
                    this.res_create_date = getResolution.res_create_date;
                    this.res_title = getResolution.res_title;
                    this.res_text = getResolution.res_text;
                    this.res_repeals = getResolution.res_repeals;
                    this.create_id = getResolution.create_id; 
                    this.saved = true;           
                </cfscript>        
            </cfif>
        </cfif>

        <cfreturn this>
    </cffunction>

    <cffunction name="save" returntype="Prefiniti.Collaboration.Resolution" output="false" access="public">
        <cfif this.saved>
            <cfreturn this.updateExisting()>
        <cfelse>
            <cfreturn this.saveAsNew()>
        </cfif>
    </cffunction>

    <cffunction name="saveAsNew" returntype="Prefiniti.Collaboration.Resolution" output="false" access="public">

        <cfif this.saved EQ true>
            <cfreturn this>
        </cfif>

        <cfset this.create_id = createUUID()>

        <cfquery name="c_res" datasource="sites">
            INSERT INTO res_resolutions
                (site_id,
                sponsor_assoc_id,
                res_carry_threshold,
                res_quorum,
                res_eligibility,
                res_tabled,
                res_voting_open,
                res_voting_close,
                res_title,
                res_text,
                res_repeals,
                create_id)
            VALUES
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.site_id#">,
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.sponsor_assoc_id#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_carry_threshold#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#this.res_quorum#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_eligibility#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_tabled#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_open#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_close#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(this.res_title)#" maxlength="255">,
                <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(this.res_text)#">,
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.res_repeals#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="get_r" datasource="sites">
            SELECT id, res_create_date FROM res_resolutions WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.create_id#" maxlength="255">
        </cfquery>

        <cfset this.id = get_r.id>
        <cfset this.res_create_date = get_r.res_create_date>
        <cfset this.saved = true>

        <cfset initialAmendmentID = this.createAmendment(this.sponsor_assoc_id, "Initial Text", this.res_text)>
        <cfset this.adoptAmendment(initialAmendmentID)>

        <cfreturn this>
    </cffunction>

    <cffunction name="updateExisting" returntype="Prefiniti.Collaboration.Resolution" access="public" output="false">

        <cfif this.saved EQ false>
            <cfreturn this.saveAsNew()>
        </cfif>

        <cfquery name="upd_r" datasource="sites">
            UPDATE res_resolutions
            SET site_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.site_id#">,
                sponsor_assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.sponsor_assoc_id#">,
                res_carry_threshold=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_carry_threshold#">,
                res_quorum=<cfqueryparam cfsqltype="cf_sql_integer" value="#this.res_quorum#">,
                res_eligibility=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_eligibility#">,
                res_tabled=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_tabled#">,
                res_voting_open=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_open#">,
                res_voting_close=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_close#">,
                res_title=<cfqueryparam cfsqltype="cf_sql_varchar" value="#htmlEditFormat(this.res_title)#" maxlength="255">,
                res_text=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#htmlEditFormat(this.res_text)#" maxlength="255">,
                res_repeals=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.res_repeals#">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.saved = true>

        <cfreturn this>
    </cffunction>

    <cffunction name="getComments" returntype="array" output="false">
        <cfset result = []>

        <cfquery name="getComments" datasource="webwarecl">
            SELECT id FROM posts WHERE recipient_id=#this.id# AND post_class="RESO" AND parent_post_id=0 ORDER BY post_date DESC
        </cfquery>

        <cfoutput query="getComments">
            <cfset result.append(new Prefiniti.SocialNetworking.Post().retrieve(id))>
        </cfoutput>

        <cfreturn result>
    </cffunction>

    <cffunction name="getAmendmentComments" returntype="array" output="false">
        <cfargument name="amendment_id" type="numeric" required="true">

        <cfset result = []>

        <cfquery name="getComments" datasource="webwarecl">
            SELECT id FROM posts WHERE recipient_id=#arguments.amendment_id# AND post_class="AMND" AND parent_post_id=0 ORDER BY post_date DESC
        </cfquery>

        <cfoutput query="getComments">
            <cfset result.append(new Prefiniti.SocialNetworking.Post().retrieve(id))>
        </cfoutput>

        <cfreturn result>
    </cffunction>

    <cffunction name="createAmendment" returntype="numeric" access="public" output="false">
        <cfargument name="author_assoc_id" type="numeric" required="true">
        <cfargument name="am_title" type="string" required="true">
        <cfargument name="am_text" type="string" required="true">

        <cfset create_id = createUUID()>

        <cfquery name="am_c" datasource="sites">
            INSERT INTO res_amendments
                        (res_id,
                        author_assoc_id,
                        am_title,
                        am_text,
                        create_id)
            VALUES      (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">,
                        <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.author_assoc_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.am_title#" maxlength="255">,
                        <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#htmlEditFormat(arguments.am_text)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="am_g" datasource="sites">
            SELECT id
            FROM res_amendments
            WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">
        </cfquery>

        <cfreturn am_g.id>
    </cffunction>

    <cffunction name="getAmendments" returntype="query" access="public" output="false">
        <cfquery name="am_g" datasource="sites">
            SELECT * FROM res_amendments 
            WHERE res_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            ORDER BY am_create_date
            DESC
        </cfquery>

        <cfreturn am_g>
    </cffunction>

    <cffunction name="getAmendment" returntype="query" access="public" output="false">
        <cfargument name="amendment_id" type="numeric" required="true">

        <cfquery name="get_a" datasource="sites" maxrows="1">
            SELECT *
            FROM res_amendments
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.amendment_id#">
        </cfquery>

        <cfreturn get_a>
    </cffunction>

    <cffunction name="getLatestAmendment" returntype="numeric" access="public" output="false">

        <cfquery name="am_l" datasource="sites" maxrows="1">
            SELECT id
            FROM res_amendments
            WHERE am_accepted = 1
            ORDER BY am_create_date
            DESC
        </cfquery>

        <cfreturn am_l.id>
    </cffunction>

    <cffunction name="getPriorAmendment" returntype="numeric" access="public" output="false">
        <cfargument name="amendment_id" type="numeric" required="true">

        <cfquery name="am_this" datasource="sites">
            SELECT am_create_date
            FROM res_amendments
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.amendment_id#">
        </cfquery>

        <cfset origDate = am_this.am_create_date>

        <cfquery name="am_previous" datasource="sites" maxrows="1">
            SELECT id
            FROM res_amendments
            WHERE am_create_date < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#origDate#">
            AND am_accepted = 1
            ORDER BY am_create_date
            DESC
        </cfquery>

        <cfreturn am_previous.id>
    </cffunction>

    <cffunction name="adoptAmendment" returntype="struct" access="public" output="false">
        <cfargument name="id" type="numeric" required="true">

        <cfif session.current_association EQ this.sponsor_assoc_id>
            <cftry>
                <cfquery name="am_ad" datasource="sites">
                    UPDATE res_amendments
                    SET am_accepted=1
                    WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
                </cfquery>

                <cfreturn {
                    ok: true,
                    message: "Amendment adopted."
                }>

                <cfcatch type="any">
                    <cfreturn {
                        ok: false,
                        message: "Error adopting amendment."
                    }>
                </cfcatch>
            </cftry>
        <cfelse>
            <cfreturn {
                ok: false,
                message: "Only the resolution sponsor may adopt an amendment."
            }>
        </cfif>
    </cffunction>

    <cffunction name="withdraw" returntype="boolean" access="public" output="false">

        <cfif session.current_association EQ this.sponsor_assoc_id>
            <cfif (this.getTally().carried EQ false) AND (this.getTally().failed EQ false)>
                <cfquery name="wdr_r" datasource="sites">
                    DELETE FROM res_resolutions
                    WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
                </cfquery>

                <cfreturn true>
            <cfelse>
                <cfreturn false>
            </cfif>
        <cfelse>
            <cfreturn false>
        </cfif>

    </cffunction>

    <cffunction name="repeals" returntype="struct" access="public" output="false">

        <cfif this.res_repeals NEQ 0>
            <cfset rep = new Prefiniti.Collaboration.Resolution(this.res_repeals)>
            <cfif rep.getTally().carried EQ true>
                <cfreturn {
                    result: true,
                    resolution: rep
                }>
            <cfelse>
                <cfreturn {
                    result: false
                }>
            </cfif>
        <cfelse>
            <cfreturn {
                result: false
            }>
        </cfif>

    </cffunction>

    <cffunction name="repealedBy" returntype="struct" access="public" output="false">

        <cfquery name="rep_q" datasource="sites">
            SELECT id 
            FROM res_resolutions
            WHERE res_repeals=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfif rep_q.recordCount EQ 1>
            <cfset rep = new Prefiniti.Collaboration.Resolution(rep_q.id)>
            <cfif rep.getTally().carried EQ true>
                <cfreturn {
                    result: true,
                    resolution: new Prefiniti.Collaboration.Resolution(rep_q.id)
                }>
            <cfelse>
                <cfreturn {
                    result: false
                }>
            </cfif>
        <cfelse>
            <cfreturn {
                result: false
            }>
        </cfif>

    </cffunction>

    <cffunction name="canVote" returntype="boolean" access="public" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">

        <cfif NOT this.inVotingWindow()>
            <cfreturn false>
        </cfif>

        <cfif NOT this.getPermissionByKey("RES_VOTE", arguments.assoc_id)>            
            <cfreturn false>
        </cfif>
       
        <cfloop array="#this.getEligibleVoters()#" index="idx" item="voter">
            <cfif voter.association.id EQ arguments.assoc_id>
                <cfif this.getMemberVote(arguments.assoc_id).code EQ -1>
                    <cfreturn true>
                <cfelse>
                    <cfreturn false>
                </cfif>
            </cfif>
        </cfloop>

        <cfreturn false>

    </cffunction>

    <cffunction name="castVote" returntype="struct" access="public" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="password" type="string" required="true">
        <cfargument name="vote_type" type="numeric" required="true">

        <cfset user = this.getUserByAssociationID(arguments.assoc_id)>

        <cfset result = {
            success: false,
            message: ""
        }>

        <cfif this.res_tabled EQ 1>
            <cfreturn {
                success: false,
                message: "Cannot vote on a tabled resolution."
            }>
        </cfif>

        <cfif (arguments.vote_type LT 0) OR (arguments.vote_type GT 2)>
            <cfset result.success = false>
            <cfset result.message = "Internal error">

            <cfreturn result>
        </cfif>


        <cfset password_hash = hash(arguments.password, "SHA-512")>
        <cfif password_hash NEQ user.password>
            <cfset result = {
                success: false,
                message: "Vote not cast: invalid password"
            }>

            <cfreturn result>
        </cfif>

        <cflock scope="Application" timeout="30">
            <cfif NOT this.canVote(arguments.assoc_id)>
                <cfset result.success = false>
                <cfset result.message = "User has already cast a vote, or does not have permissions to vote on this resolution.">
            
                <cfreturn result>
            </cfif>

            <cfset create_id = createUUID()>
            <cfquery name="cast_vote" datasource="sites">
                INSERT INTO res_votes
                    (res_id,
                    voter_assoc_id,
                    vote_type,
                    create_id)
                VALUES
                    (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">,
                    <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#">,
                    <cfqueryparam cfsqltype="cf_sql_tinyint" value="#arguments.vote_type#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
            </cfquery>
        </cflock>

        <cfset result = {
            success: true,
            message: "Your vote has been cast"
        }>

        <cfreturn result>
    </cffunction>

    <cffunction name="getEligibility" returntype="string" access="public" output="false">

        <cfswitch expression="#this.res_eligibility#">
            <cfcase value="0">
                <cfreturn "Employees Only">
            </cfcase>
            <cfcase value="1">
                <cfreturn "Clients Only">
            </cfcase>
            <cfcase value="2">
                <cfreturn "Employees &amp; Clients">
            </cfcase>
        </cfswitch>

    </cffunction>

    <cffunction name="getCarryThreshold" returntype="string" access="public" output="false">

        <cfswitch expression="#this.res_carry_threshold#">
            <cfcase value="0">
                <cfreturn "Simple Majority">
            </cfcase>
            <cfcase value="75">
                <cfreturn "Two-Thirds Majority">
            </cfcase>
            <cfcase value="100">
                <cfreturn "Unanimous">
            </cfcase>
        </cfswitch>

    </cffunction>

    <cffunction name="getStatus" returntype="string" access="public" output="false">       
        <cfset s = "">

        <cfif this.repealedBy().result EQ true>
            <cfreturn '<span class="label label-danger mr-2">Repealed</span>'>
        </cfif>

        <cfif this.getTally().carried>
            <cfreturn '<span class="label label-primary mr-2">Adopted</span>'>
        </cfif>

        <cfif this.res_tabled EQ 1>
            <cfset s = s & '<span class="label label-dark mr-2">Tabled</span>'>
            <cfreturn s>
        </cfif>        

        <cfif this.daysUntilOpen() GT 0>
            <cfset s = s & '<span class="label label-info mr-2">In Debate</span>'>
        <cfelse>
            <cfif this.inVotingWindow()>
                <cfset s = s & '<span class="label label-primary mr-2">Voting Open</span>'>
            <cfelse>
                <cfset s = s & '<span class="label label-warning mr-2">Voting Closed</span>'>
            </cfif>
        </cfif>

        <cfif (this.daysUntilOpen() LE 0) AND (this.getTally().carried EQ false) AND (this.inVotingWindow() EQ false)>
            <cfreturn '<span class="label label-danger mr-2">Failed</span>'>
        </cfif>

        <cfreturn s>
    </cffunction>

    <cffunction name="daysUntilOpen" returntype="numeric" access="public" output="false">
        <cfreturn dateDiff("d", now(), this.res_voting_open)>
    </cffunction>

    <cffunction name="inVotingWindow" returntype="boolean" access="public" output="false">
        
        <cfscript>

            var today = now();

            if((dateDiff("d", this.res_voting_open, today) >= 0 ) AND (dateDiff("d", today, this.res_voting_close) >= 0)) {
                return true;
            }
            else {
                return false;
            }

        </cfscript>

    </cffunction>

    <cffunction name="getResolutionNumber" returntype="string" access="public" output="false">
        <cfset site = new Prefiniti.Authentication.Site(this.site_id)>

        <cfreturn "#site.SiteID#-#this.id#">
    </cffunction>

    <cffunction name="getMemberVote" returntype="struct" access="public" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">

        <cfset result = {}>

        <cfquery name="get_vote" datasource="sites">
            SELECT vote_type, vote_date 
            FROM res_votes
            WHERE voter_assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#">
            AND res_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfif get_vote.recordCount EQ 0>
            <cfset result.code = -1>
            <cfset result.desc = "has not voted">
            <cfset result.date = now()>
            <cfset result.icon = "fa-question">
            <cfset result.class = "btn-white">

            <cfreturn result>
        </cfif>

        <cfset result.date = get_vote.vote_date>
        <cfset result.code = get_vote.vote_type>

        <cfswitch expression="#get_vote.vote_type#">
            <cfcase value="0">
                <cfset result.desc = "abstains">
                <cfset result.icon = "fa-circle">
                <cfset result.class = "btn-secondary">
            </cfcase>
            <cfcase value="1">
                <cfset result.desc = "votes yea">
                <cfset result.icon = "fa-vote-yea">
                <cfset result.class = "btn-success">
            </cfcase>
            <cfcase value="2">
                <cfset result.desc = "votes nay">
                <cfset result.icon = "fa-vote-nay">
                <cfset result.class = "btn-primary">
            </cfcase>
        </cfswitch> 

        <cfreturn result>
    </cffunction>


    <cffunction name="getEligibleVoters" returntype="array" access="public" output="false">
        <cfset site = new Prefiniti.Authentication.Site(this.site_id)>

        <cfswitch expression="#this.res_eligibility#">
            <cfcase value="0"> <!--- employees --->
                <cfset voters = site.employees()>
            </cfcase>
            <cfcase value="1"> <!--- customers --->
                <cfset voters = site.clients()>
            </cfcase>
            <cfcase value="2"> <!--- both --->
                <cfset voters = site.everyone()>
            </cfcase>
        </cfswitch>

        <cfreturn voters>
    </cffunction>

    <cffunction name="getTally" returntype="struct" access="public" output="false">

        <cfset result = {
            abstain: 0,
            yea: 0,
            nay: 0,
            undecided: 0,
            totalVoters: 0,
            totalVotes: 0,
            carried: false,
            failed: false
        }>

        <cfset voters = this.getEligibleVoters()>
        <cfset result.totalVoters = voters.len()>

        <cfloop array="#voters#" item="voter">

            <cfquery name="get_vote" datasource="sites">
                SELECT vote_type 
                FROM res_votes
                WHERE res_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> 
                AND voter_assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#voter.association.id#">
            </cfquery>

            <cfif get_vote.recordCount EQ 1>
                <cfset result.totalVotes = result.totalVotes + 1>
                <cfswitch expression="#get_vote.vote_type#">
                    <cfcase value="0">
                        <cfset result.abstain = result.abstain + 1>
                    </cfcase>
                    <cfcase value="1">
                        <cfset result.yea = result.yea + 1>
                    </cfcase>
                    <cfcase value="2">
                        <cfset result.nay = result.nay + 1>
                    </cfcase>
                </cfswitch>
            <cfelse>
                <cfset result.undecided = result.undecided + 1>
            </cfif>
        </cfloop>

        <cfif result.totalVotes GT 0>            
            <cfset pctYea = int((result.yea * 100) / result.totalVotes)>
            <cfset pctNay = int((result.nay * 100) / result.totalVotes)>     
        <cfelse>
            <cfset pctYea = 0>
            <cfset pctNay = 0>
        </cfif>

        <cfif result.totalVotes GE this.res_quorum>    
            <cfif this.res_carry_threshold LT 100>
                <cfif (pctYea GT pctNay) AND (pctYea GE this.res_carry_threshold) AND (this.inVotingWindow() EQ false) AND (this.daysUntilOpen() LE 0)>
                    <cfset result.carried = true>
                <cfelse>
                    <cfset result.carried = false>
                </cfif>
            <cfelse>
                <cfif result.nay GT 0>
                    <cfset result.carried = false>
                <cfelse>
                    <cfif (pctYea GT pctNay) AND (pctYea GE this.res_carry_threshold) AND (this.inVotingWindow() EQ false) AND (this.daysUntilOpen() LE 0)>
                        <cfset result.carried = true>
                    <cfelse>
                        <cfset result.carried = false>
                    </cfif>
                </cfif>
            </cfif>
        <cfelse>
            <cfset result.carried = false>
        </cfif>

        <cfif (this.inVotingWindow() EQ false) AND (this.daysUntilOpen() LE 0) AND (result.carried EQ false)>
            <cfset result.failed = true>
        </cfif>

        <cfreturn result>
    </cffunction>
</cfcomponent>
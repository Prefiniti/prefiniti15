<cfcomponent extends="Prefiniti.Base" output="false">

    <cffunction name="init" returntype="Prefiniti.Collaboration.Resolution" output="false" access="public">
        <cfargument name="id" type="numeric" required="false">
    
        <cfscript>
            this.id = arguments.id;
            this.site_id = 0;
            this.sponsor_assoc_id = 0;
            this.res_carry_threshold = 0;
            this.res_eligibility = 0;
            this.res_tabled = 0;
            this.res_voting_open = createODBCDateTime(now());
            this.res_voting_close = createODBCDateTime(now());
            this.res_create_date = createODBCDateTime(now());
            this.res_title = "";
            this.res_text = "";
            this.create_id = createUUID();
            this.saved = false;
        </cfscript>

        <cfif isDefined("arguments.id")>
            <cfquery name="getResolution" datasource="sites">
                SELECT * FROM res_resolutions WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            </cfquery>

            <cfif getResolution.recordCount GT 0>
                <cfscript>            
                    this.site_id = getResolution.site_id;
                    this.sponsor_assoc_id = getResolution.sponsor_assoc_id;
                    this.res_carry_threshold = getResolution.res_carry_threshold;
                    this.res_eligibility = getResolution.res_eligibility;
                    this.res_tabled = getResolution.res_tabled;
                    this.res_voting_open = getResolution.res_voting_open;
                    this.res_voting_close = getResolution.res_voting_close;
                    this.res_create_date = getResolution.res_create_date;
                    this.res_title = getResolution.res_title;
                    this.res_text = getResolution.res_text;
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
                res_eligibility,
                res_tabled,
                res_voting_open,
                res_voting_close,
                res_title,
                res_text,
                create_id)
            VALUES
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.site_id#">,
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.sponsor_assoc_id#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_carry_threshold#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_eligibility#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_tabled#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_open#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_close#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(this.res_title)#" maxlength="255">,
                <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(this.res_text)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="get_r" datasource="sites">
            SELECT id, res_create_date FROM res_resolutions WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.create_id#" maxlength="255">
        </cfquery>

        <cfset this.id = get_r.id>
        <cfset this.res_create_date = get_r.res_create_date>
        <cfset this.saved = true>

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
                res_eligibility=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_eligibility#">,
                res_tabled=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.res_tabled#">,
                res_voting_open=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_open#">,
                res_voting_close=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.res_voting_close#">,
                res_title=<cfqueryparam cfsqltype="cf_sql_varchar" value="#htmlEditFormat(this.res_title)#" maxlength="255">,
                res_text=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#htmlEditFormat(this.res_text)#" maxlength="255">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.saved = true>

        <cfreturn this>
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

        <cfif this.res_tabled EQ 1>
            <cfset s = s & '<span class="label label-danger mr-2">Tabled</span>'>
            <cfreturn s>
        </cfif>        

        <cfif this.daysUntilOpen() GT 0>
            <cfset s = s & '<span class="label label-warning mr-2">In Debate</span>'>
        <cfelse>
            <cfif this.inVotingWindow()>
                <cfset s = s & '<span class="label label-primary mr-2">Voting Open</span>'>
            <cfelse>
                <cfset s = s & '<span class="label label-warning mr-2">Voting Closed</span>'>
            </cfif>
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

            <cfreturn result>
        </cfif>

        <cfset result.date = get_vote.vote_date>
        <cfset result.code = get_vote.vote_type>

        <cfswitch expression="#get_vote.vote_type#">
            <cfcase value="0">
                <cfset result.desc = "abstains">
                <cfset result.icon = "fa-circle">
            </cfcase>
            <cfcase value="1">
                <cfset result.desc = "votes yea">
                <cfset result.icon = "fa-vote-yea">
            </cfcase>
            <cfcase value="2">
                <cfset result.desc = "votes nay">
                <cfset result.icon = "fa-vote-nay">
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
            nay: 0
        }>

        <cfset voters = this.getEligibleVoters()>

        <cfloop array="#voters#" item="voter">

            <cfquery name="get_vote" datasource="sites">
                SELECT vote_type 
                FROM res_votes
                WHERE res_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> 
                AND voter_assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#voter.association.id#">
            </cfquery>

            <cfif get_vote.recordCount EQ 1>
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
            </cfif>
        </cfloop>

        <cfreturn result>
    </cffunction>
</cfcomponent>
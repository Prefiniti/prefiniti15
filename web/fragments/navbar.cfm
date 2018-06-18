<cfinclude template="/menus/menu_udf.cfm">

<cfset menus = getMenus()>

<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="#" onclick="loadHomeView();"><img src="graphics/prefiniti-logo-white.png" alt="Prefiniti logo"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-default" aria-controls="navbar-default" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar-default">
        <ul class="navbar-nav mr-auto">

            <cfoutput query="menus">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="dropdown-#id#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">#caption#</a>
                    <div class="dropdown-menu" arial-labelledby="dropdown-#id#">
                        #getMenuItems(id, handle)#
                    </div>
                </li>
            </cfoutput>

        </ul>

    </div>
</nav>
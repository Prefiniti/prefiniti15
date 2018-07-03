<cfinclude template="/socialnet/socialnet_udf.cfm">
<!--
<wwaftitle>Friend Search</wwaftitle>
<wwafbreadcrumbs>Prefiniti,Social Networking,Friend Search</wwafbreadcrumbs>
-->


<div style="padding-left:30px;">
    <form name="searchUsers" id="searchUsers" method="post" action="/socialnet/components/search_users_sub.cfm">
    <table width="100%" cellspacing="0" cellpadding="5">
        <tr>
            <td>Search By:</td>
            <td><p>
              <label>
                <input type="radio" name="search_field" value="longName" id="search_field_0" checked>
                Name Contains</label>
              <br>
              <label>
                <input type="radio" name="search_field" value="lastName" id="search_field_1">
                Last Name</label>
              <br>
              <label>
                <input type="radio" name="search_field" value="email" id="search_field_2">
                E-Mail Address</label>
              <br>
            </p></td>
        </tr>
        <tr>
          <td>Search For:</td>
          <td><input type="text" name="search_value" id="search_value"></td>
        </tr>
        <tr>
          <td colspan="2" align="right"><input type="button" class="normalButton" name="submit" value="Search" onclick="javascript:AjaxSubmitForm(AjaxGetElementReference('searchUsers'), '/socialnet/components/search_users_sub.cfm', 'tcTarget');"></td>
      </tr>      
    </table>
    </form>
</div>
                                            
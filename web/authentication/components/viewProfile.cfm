
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfquery name="profile" datasource="webwarecl">
	SELECT * FROM users WHERE id=#url.userid#
</cfquery>

<cfoutput>
<!--
<wwafcomponent>#profile.longName#'s Profile</wwafcomponent>
<wwafsidebar>sb_Home.cfm</wwafsidebar>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>webware-16x16.png</wwaficon>
-->
</cfoutput>

<cfquery name="gpCount" datasource="webwarecl">
	SELECT id FROM projects WHERE clientID=#url.userid#
</cfquery>


<cfoutput query="profile">
						<table width="100%">
							<tr>
								<td rowspan="2" align="left" valign="top" width="150">
									
                                    <div style="width:150px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
                                    	<img src="#getPicture(id)#" width="150"  />
                                    	<div style="padding-top:3px;">
                                        <cfswitch expression="#online#">
                                            <cfcase value="0"><img src="/graphics/status_offline.png" align="absmiddle"/> <font color="red">User is offline</font></cfcase>
                                            <cfcase value="1"><img src="/graphics/status_online.png" align="absmiddle"/> <font color="green">User is online</font></cfcase>
                                        </cfswitch>
                                        </div>
                                        <br /><br />
                                        
                                        <cfif isFriend(#url.calledByUser#, #id#) EQ false AND url.calledByUser NEQ id>
                                        	<img src="/graphics/heart_add.png" align="absmiddle"/> <span id="frBlock_#id#"><a href="javascript:requestFriend(#id#);">Add Friend</a></span>
                                        <br />
                                        </cfif>
                                        <cfif isFriend(#url.calledByUser#, #id#) EQ true>
                                        	<cfif #url.calledByUser# EQ #id#>
                                            	<img src="/graphics/photos.png" align="absmiddle" /> <a href="javascript:viewPictures(#id#, true);"> View Photos</a><br />
                                            <cfelse>
                                            	<img src="/graphics/photos.png" align="absmiddle" /> <a href="javascript:viewPictures(#id#, false);"> View Photos</a><br />
                                            </cfif>
                                        	<img src="/graphics/heart_delete.png" align="absmiddle" /> <a href="javascript:confirmDeleteFriend(#url.calledByUser#, #id#);">Delete Friend</a><br />
                                            <img src="/graphics/email_add.png" align="absmiddle"/> <a href="javascript:mailTo(#id#, '#longName#');">Send Message</a><br />
                                            <img src="/graphics/phone_add.png" align="absmiddle" /> <a href="javascript:showDiv('sendText_#id#');">Send Text Message</a>
										</cfif>                                            
                                        <div id="sendText_#id#" style="display:none;">
					<br>
					<label>Message Body: <input type="text" name="text_#id#" id="text_#id#" width="10"></label><br>
					<input type="button" class="normalButton" name="sendMsg_#id#" id="sendMsg_#id#" value="Go" onclick="sendText('#id#', GetValue('text_#id#'));">
				</div>
                                   	</div>
                                    
                                    <br>
													
								</td>
								<td valign="top" align="left"><h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:##3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-bottom:0px;">#longName#</h3>
                                <div class="homeHeader"><img src="/graphics/page.png" align="absmiddle" /> User Information</div>
                                <div style="padding-left:30px;">
                                <table width="100%" cellspacing="0" cellpadding="1">
                                  	<tr>
                                    	<td><strong>Last Login:</strong></td>
                                        <td>#DateFormat(last_login, "mm/dd/yyyy")# #TimeFormat(last_login, "h:mm tt")#</td>
									</tr>                                        
                                    <tr>
                                    	<td><strong>Age:</strong></td>
                                        <td>#DateDiff("yyyy", birthday, Now())# years old</td>
                                    </tr>
                                    <tr>
                                    	<td><strong>Gender:</strong></td>
                                        <td>
                                        	<cfif #gender# EQ "m">
                                            	Male
                                            <cfelse>
                                            	Female
                                            </cfif>    
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td><strong>Prefiniti Orders:</strong></td>
                                        <td>#gpCount.RecordCount#</td>
                                    </tr>
                                    <tr>
                                    	<td valign="top"><strong>Site Memberships:</strong></td>
                                        <td valign="top"><cfmodule template="/socialnet/components/view_memberships.cfm" user_id="#id#"></td>
									</tr> 
                                    <tr>
                                    	<td valign="top"><strong>Public Locations:</strong></td>
                                        <td valign="top"><cfmodule template="/socialnet/components/profile_manager/view_public_locations.cfm" user_id="#id#">
                                        </td>
									</tr>                                                                                  
                                  </table>
                                </div>
                                <cfif isFriend(#url.calledByUser#, #id#) EQ true OR #url.calledByUser# EQ #id#>
                                <div class="homeHeader"><img src="/graphics/newspaper.png" align="absmiddle" /> News Feed</div>
                                <div id="nf">
                                <cfmodule template="/socialnet/components/view_user_events.cfm" user_id="#id#" start_row="1" records_per_page="5" load_to="nf"></div>
                                
                                <div class="homeHeader"><img src="/graphics/comments.png" align="absmiddle" /> Comments</div>
                                
                                <div id="postCommentDiv">
                                <cfmodule template="/socialnet/components/post_comment.cfm" from_id="#url.calledByUser#" to_id="#id#">
                                </div>
                                <div id="cm">
                                 <cfmodule template="/socialnet/components/read_comments.cfm" user_id="#id#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="10" load_to="cm"></div>
                                <div class="homeHeader"><img src="/graphics/heart.png" align="absmiddle" /> Friends</div>
                                <div id="frl"> 
            	<cfmodule template="/socialnet/components/friends_list.cfm"  user_id="#id#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="10" load_to="frl" >
                </div>
                                <cfelse>
                                <div style="padding:30px;">
                                	<strong>You must add this person as a friend before viewing this profile.</strong>
                                </div>
								</cfif>                                    
                                 
                                
                                </td>
							</tr>
							
						</table>
					</cfoutput>
				
<link href="../../css/gecko.css" rel="stylesheet" type="text/css">
<cfparam name="captcha" default="">
<cfset captcha="#Left(CreateUUID(), 6)#">

	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Register New Prefiniti Account</h3>
        </div>
    </div>
    <br />
    <br />

	<form name="regAcct">
		<div class="homeHeader"><img src="/graphics/user.png" align="absmiddle" /> My Name</div>
        <div style="width:780px; padding:20px;">
        <table width="100%" cellspacing="0" cellpadding="3px">
			<tr>
				<td>Your name:</td>
				<td>
                	<label>First: <input type="text" name="firstName" id="firstName" maxlength="255" /></label>
                    <label>Middle Initial: <input name="middleInitial" type="text" id="middleInitial" maxlength="1"/>
                    </label>
                    <label>Last: <input type="text" name="lastName" id="lastName" maxlength="255"/></label>                </td>
			</tr>

			
			<tr>
			  <td>Your e-mail address:</td>
			  <td>
			  	<input type="text" name="email" id="email" onkeyup="companyNameChanged();" maxlength="255"><br />
				<label><input type="checkbox" name="email_billing" id="email_billing" checked/>I would like to be billed at this e-mail address</label>			  </td>
		  </tr>
			<tr>
			  <td>Gender:</td>
			  <td><p>
			    <label>
			      <input type="radio" name="gender" value="M" checked>
			      Male</label>
			    <br>
			    <label>
			      <input type="radio" name="gender" value="F">
			      Female</label>
			    <br>
			    </p>			  </td>
		  </tr>
			<tr>
			  <td>Mobile phone number: </td>
			  <td><input type="text" name="smsnumber" id="smsnumber" maxlength="45"></td>
		  </tr>
			<tr>
			  <td>Phone number:</td>
			  <td><input type="text" name="phone" id="phone" maxlength="45" /></td>
		  </tr>
			<tr>
			  <td>Fax number:</td>
			  <td><input type="text" name="fax" id="fax" maxlength="45" /></td>
		  </tr>
			<tr>
			  <td>Birthday:</td>
			  <td><cfmodule template="/controls/date_picker.cfm" ctlname="birthday" startdate="#Now()#"></td>
		  </tr>
          </table>
          </div>
          
          <div class="homeHeader"><img src="/graphics/map.png" align="absmiddle" /> My Locations</div>
          <div style="width:780px; padding:20px;">
          <table width="100%" cellspacing="0" cellpadding="3px">

			<tr>
			<td>Physical Address:</td>
			<td>
				<table>
					<tr>
						<td>Street:</td>
						<td><input type="text" name="mailing_address" id="mailing_address" maxlength="255" ></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="mailing_city" id="mailing_city" maxlength="255" ></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="mailing_state" id="mailing_state" maxlength="2" ></td>
					</tr>
					<tr>
						<td>ZIP Code:</td>
						<td><input type="text" name="mailing_zip" id="mailing_zip" maxlength="255" ></td>
					</tr>
				</table>			</td>
		</tr>
				<tr>
			<td>Billing Address:</td>
			<td>&nbsp;
				
				<label>
				<input type="checkbox" name="chkCopyAddress" id="chkCopyAddress" value="checkbox" onclick="copyAddress();">
				My billing address is the same as my physical address</label>
				<table>
					<tr>
						<td>Street:</td>
						<td><input type="text" name="billing_address" id="billing_address" maxlength="255" ></td>
					</tr>
					<tr>
						<td>City:</td>
						<td><input type="text" name="billing_city" id="billing_city" maxlength="255" ></td>
					</tr>
					<tr>
						<td>State:</td>
						<td><input type="text" name="billing_state" id="billing_state" maxlength="2" ></td>
					</tr>
					<tr>
						<td>ZIP Code:</td>
						<td><input type="text" name="billing_zip" id="billing_zip" maxlength="255"></td>
					</tr>
				</table>			</td>
		</tr>
        </table>
        </div>
        <div class="homeHeader"><img src="/graphics/shield.png" align="absmiddle" /> Login Information</div>
        <div style="width:780px; padding:20px;">
        <table width="100%" cellspacing="0" cellpadding="3px">
	
				 <tr>
				 	<td>Login Name:</td>
					<td>
						<input type="text" name="username" id="username" maxlength="45"/>
						<input type="button" name="checkAvailabilityx" id="checkAvailabilityx" class="normalButton" onClick="checkAvailability(GetValue('username'));" value="Check Availability" />
						<span id="availability"></span>					</td>
				 </tr>
				 <tr>
				   <td>Privacy:</td>
				   <td><label><input type="checkbox" name="allowSearch" id="allowSearch" />Allow users to search for me</label></td>
	      </tr>
          		<tr>
                	<td>Verification:</td>
                    <td><p style="color:red;">The image below is used to prevent computers from creating accounts and spamming our users.</p>
                    	<cfimage action="captcha"  width="200" height="60" text="#captcha#"
    fonts="Arial,Verdana,Courier New"><br />
    					<label style="color:red;">Please enter the text found in the image above: <input type="text" name="captcha" id="captcha" /></label> <span id="captcha_status"></span>
                    </td>
                    
    			
                </tr>
				<tr>
					<td colspan="2" align="right">
					<!--function registerAccount(firstName, middleInitial, lastName, email, email_billing, gender, smsnumber, phone, fax, mailEqualsBill,
						 mailing_address, mailing_city, mailing_state, mailing_zip,
						 billing_address, billing_city, billing_state, billing_zip, username, availability)-->
						<cfoutput><input type="button" name="submit" class="normalButton" value="Create Account" onclick="registerAccount(GetValue('firstName'), GetValue('middleInitial'), GetValue('lastName'), GetValue('email'), IsChecked('email_billing'), AjaxGetCheckedValue('gender'), GetValue('smsnumber'), GetValue('phone'), GetValue('fax'), IsChecked('chkCopyAddress'), GetValue('mailing_address'), GetValue('mailing_city'), GetValue('mailing_state'), GetValue('mailing_zip'), GetValue('billing_address'), GetValue('billing_city'), GetValue('billing_state'), GetValue('billing_zip'), GetValue('username'), GetInnerHTML('availability'), IsChecked('allowSearch'), GetValue('birthday'), GetValue('captcha'), '#captcha#');"/></cfoutput>					</td>
				</tr>
		</table>
        </div>
	</form>


  <!-- Fixed navbar -->
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><img src="/EnergyCert/img/DHL_Logo.png" height="23" /></a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="/EnergyCert">Home</a></li>
            <% String usertype = (String) session.getAttribute("usertype");
            if (usertype!=null) {
            	if (!usertype.contains("Admin")) { %>
            <!-- questionnaire dropdown -->
            <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Questionnaire <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="/EnergyCert/form/CreateQuestionnaire.jsp">Create New Questionnaire</a></li>
	            <li><a href="/EnergyCert/form/EditQuestionnaire.jsp">Edit Questionnaires</a></li>
	            <li><a href="/EnergyCert/form/ViewPastQuestionnaire.jsp">View Past Questionnaires</a></li>
	          </ul>
	        </li>
	        <!-- KC: should we have a view dropdown? -->
	        
            <!-- visualization dropdown -->
            <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Site Analysis <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="/EnergyCert/visual/paybackOutput.jsp">Payback Analysis</a></li>
	            <li><a href="/EnergyCert/visual/historicalTrend">View Historical Trends</a></li>
	          </ul>
	        </li> 
            <!-- analysis dropdown -->
            <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Portfolio Analysis <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	          	<li><a href="/EnergyCert/visual/portfolio">Manage Site Portfolio</a></li>
	            <li><a href="#">Global Visualization of Sites</a></li>
	          </ul>
	        </li>  
	        <% }
            else if (usertype.equals("DHL Admin")) { %>
	        <!-- admin dropdown -->
            <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administration <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="/EnergyCert/admin/viewco.jsp">Manage Company Accounts</a></li>
	            <li><a href="/EnergyCert/admin/editformula.jsp">Edit Formula</a></li>
	            <li><a href="/EnergyCert/admin/editweather.jsp">Manage Weather</a></li>
	            <li><a href="/EnergyCert/admin/editpayback.jsp">Edit Payback Formula</a></li>
	          </ul>
	        </li>  
	        <% } else { %>
	        <!-- client admin dropdown -->
            <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administration <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="/EnergyCert/client/viewacct.jsp">Manage Accounts</a></li>
	            <li><a href="/EnergyCert/client/viewwh.jsp">Manage Sites</a></li>
	            <li><a href="/EnergyCert/client/manageperiod.jsp">Manage Period</a></li>
	            <li><a href="/EnergyCert/client/uploadlogo.jsp">Upload Company Logo</a></li>
	          </ul>
	        </li>  
	        <% }%>
            <!-- account dropdown -->
            <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Account <span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="/EnergyCert/account/changepwd.jsp">Change Password</a></li>
	          </ul>
	        </li>  
	        <% } %>
          </ul>
            <% String user = (String) session.getAttribute("userid");
            if (user!=null) { %>
	          <form action="/EnergyCert/processlogout">
	          	<button type="submit" class="navbar-right btn btn-danger navbar-btn">Logout</button>
	          </form>
	          <% } else { %>
	          <p class="navbar-text">Please login to view more options</p>
	          <% } %>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>

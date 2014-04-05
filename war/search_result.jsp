<%@page import="com.google.appengine.repackaged.org.codehaus.jackson.map.ser.FilterProvider"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
    	<link type="text/css" rel="stylesheet" href="/css/main.css" />
    	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3&amp;key=&amp;sensor=true"> </script>  	
       <!--  <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=true"></script> -->
        <script type="text/javascript" src="/js/parking_map.js"> </script>
  	</head>
    <body>

<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    String startDateString = request.getParameter("startdatepicker");
    String endDateString = request.getParameter("enddatepicker");
    
    SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
	  
	  Date startDate = formatter.parse(startDateString);
	  Date endDate = formatter.parse(endDateString);
	  

%>
	<div class="greeting">
		<%    

    if (user != null) {
        pageContext.setAttribute("user", user);
%>
		Hello, ${fn:escapeXml(user.nickname)}! (You can <a
			href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign
			out</a>.)
		<%
    } else {
%>
		Hello! <a
			href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign
			in</a> to post or reserve a spot.
		<%
    }
		
		pageContext.setAttribute("search_location", request.getParameter("location"));
		
%>

		
 		<p><b>Location entered:</b>
   <%= request.getParameter("location")%> 


</p>

	</div>
	<div class="left">
		<div id="guestbook_header">
			<%
				
				DatastoreService datastore = DatastoreServiceFactory
						.getDatastoreService();
				Key parkingSpotsKey = KeyFactory.createKey("ParkingSpots",
						"allParkingSpots");

				// Get parking spots from the system
				
				Query query = new Query("ParkingSpot", parkingSpotsKey)
						.addSort("startDate", Query.SortDirection.DESCENDING)
						.addSort("endDate", Query.SortDirection.ASCENDING);
						
				
				// Add a filter that checks the start and end date
		       Filter startDateFilter = new FilterPredicate("startDate", FilterOperator.LESS_THAN_OR_EQUAL, startDate);
		        query.setFilter(startDateFilter);
		
		        
		        Filter endDateFilter = new FilterPredicate("endDate", FilterOperator.GREATER_THAN_OR_EQUAL, endDate);
		        
		        //Filter dateRangeFilter = CompositeFilterOperator.and(startDateFilter, endDateFilter);
		        //query.setFilter(endDateFilter); 
		        //query.setFilter(dateRangeFilter); 

		        
				List<Entity> parkingSpots = datastore.prepare(query).asList(
						FetchOptions.Builder.withLimit(3));
				if (parkingSpots.isEmpty()) {
			%>
			<p>There is no parking spots available nearby.</p>
			<%
    } else {
%>
			<p>Available parking spots.</p>
			<%
    }
%>

			
		</div>
		<div id="guestbook_body">
			<%
            
    if (!parkingSpots.isEmpty()) {

        for (Entity parkingSpot : parkingSpots) {
            pageContext.setAttribute("greeting_content", parkingSpot.getProperty("description"));               
            pageContext.setAttribute("greeting_latitude", (parkingSpot.getProperty("latitude")==null? "0": parkingSpot.getProperty("latitude")));
        	pageContext.setAttribute("greeting_longitude", (parkingSpot.getProperty("longitude")==null? "0": parkingSpot.getProperty("longitude")));
        	pageContext.setAttribute("greeting_accuracy", (parkingSpot.getProperty("accuracy")==null? "0": parkingSpot.getProperty("accuracy")));
        	pageContext.setAttribute("start_date", parkingSpot.getProperty("startDate"));
        	pageContext.setAttribute("end_date", parkingSpot.getProperty("endDate"));
            String name;    
            

        	if (parkingSpot.getProperty("owner") == null) {
                name = "Anonymous";
%>
			<p>An anonymous person posted a parking spot:</p>
			<%
            } else {
                pageContext.setAttribute("greeting_user", parkingSpot.getProperty("owner"));
                name = pageContext.getAttribute("greeting_user").toString();
               //startDate = pageContext.getAttribute("start_date").toString();
%>

			<p>
				<b>${fn:escapeXml(greeting_user.nickname)}</b> posted a parking
				spot:
			</p>
			<%
            }
%>
			<blockquote>${fn:escapeXml(greeting_content)}</blockquote>
			<p>(Location: ${fn:escapeXml(greeting_latitude)},
				${fn:escapeXml(greeting_longitude)}. )
				Start Date: ....${fn:escapeXml(start_date)} End Date: ${fn:escapeXml(end_date)}</p>

			<script type="text/javascript"> 
                var userName = "<%=name%>";
                var sAddress = "${fn:escapeXml(search_location)}";
          
                codeAddress(sAddress);
                addMarker(new google.maps.LatLng(${fn:escapeXml(greeting_latitude)}, ${fn:escapeXml(greeting_longitude)}), userName); 
                addInfoWindow(); 
                </script>
			<%
        }
    }
%>

		</div>
	</div>
	<div id="map-canvas"> </div>
  </body>
</html>
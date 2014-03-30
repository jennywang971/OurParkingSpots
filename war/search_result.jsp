<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
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
        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=true"></script>
        <script type="text/javascript" src="/js/parking_map.js"> </script>
  	</head>
    <body>

<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
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
				Query query = new Query("ParkingSpot", parkingSpotsKey).addSort(
						"date", Query.SortDirection.DESCENDING);
				List<Entity> parkingSpots = datastore.prepare(query).asList(
						FetchOptions.Builder.withLimit(10));
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

			<form action="/post_parking_spot" method="post">
				<div>
					<textarea name="content" rows="5" cols="60" style="resize: none"></textarea>
				</div>
				<div>
					<input type="submit" value="Post Parking Spot" />
				</div>
				<input type="hidden" id="latitude" name="latitude" value="0" /> <input
					type="hidden" id="longitude" name="longitude" value="0" /> <input
					type="hidden" id="accuracy" name="accuracy" value="0" />
			</form>
		</div>
		<div id="guestbook_body">
			<%
            
    if (!parkingSpots.isEmpty()) {

        for (Entity parkingSpot : parkingSpots) {
            pageContext.setAttribute("greeting_content", parkingSpot.getProperty("description"));               
            pageContext.setAttribute("greeting_latitude", (parkingSpot.getProperty("latitude")==null? "0": parkingSpot.getProperty("latitude")));
        	pageContext.setAttribute("greeting_longitude", (parkingSpot.getProperty("longitude")==null? "0": parkingSpot.getProperty("longitude")));
        	pageContext.setAttribute("greeting_accuracy", (parkingSpot.getProperty("accuracy")==null? "0": parkingSpot.getProperty("accuracy")));
            String name;           

        	if (parkingSpot.getProperty("owner") == null) {
                name = "Anonymous";
%>
			<p>An anonymous person posted a parking spot:</p>
			<%
            } else {
                pageContext.setAttribute("greeting_user", parkingSpot.getProperty("owner"));
                name = pageContext.getAttribute("greeting_user").toString();
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
				${fn:escapeXml(greeting_longitude)}. Accuracy:
				${fn:escapeXml(greeting_accuracy)} meters)</p>

			<script type="text/javascript"> 
                var userName = "<%=name%>";
                var sAddress = "${fn:escapeXml(search_location)}";
          
                codeAddress(sAddress);
                addMarker(new google.maps.LatLng(${fn:escapeXml(greeting_latitude)}, ${fn:escapeXml(greeting_longitude)}), userName); </script>
			<%
        }
    }
%>

		</div>
	</div>
	<div id="map-canvas"> </div>
  </body>
</html>
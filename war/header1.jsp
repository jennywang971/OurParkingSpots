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
<%@ page isELIgnored="false" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    if (user != null) {
        pageContext.setAttribute("user", user); 
    } else {  %>
        <c:redirect url="<%= userService.createLoginURL(request.getRequestURI()) %>" />
<%  } %> 

<%--  <c:choose>
	<c:when test="${ post_parking eq true && empty user }">
		<% System.out.println("EMPTY"); %>
		<c:redirect url="<%= userService.createLoginURL(request.getRequestURI()) %>" />
	</c:when>
	<c:otherwise>
		<% pageContext.setAttribute("user", user); %>
    </c:otherwise>
</c:choose> --%> 


<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/css/datepicker3.css" />
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/main1.css" />
        <link rel='stylesheet' href='//fonts.googleapis.com/css?family=Quintessential'>
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
        <script src="//maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3&amp;key=&amp;sensor=true"> </script>    
        <script src="/js/jquery.geocomplete.min.js"></script>
        <script src="/js/bootstrap-datepicker.js"></script>
    </head>
    <body>
    
        <div class="navbar navbar-inverse navbar-static-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">MyParkingSpots</a>
                </div>
                <div class="navbar-collapse collapse">
                        <form class="navbar-form navbar-right btn-success" role="form">
                            Hello, ${fn:escapeXml(user.nickname)}! (You can
                            <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)
                        </form>
                </div>
            </div>
        </div>
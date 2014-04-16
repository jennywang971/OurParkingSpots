<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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
<%@ page import="com.google.appengine.repackaged.org.codehaus.jackson.map.ser.FilterProvider"%>
<%@ page import="sun.org.mozilla.javascript.internal.regexp.SubString"%>
<%@ page isELIgnored="false" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    String uri = request.getAttribute("javax.servlet.forward.request_uri").toString();
    String queryString = request.getQueryString();

    if (queryString != null && !queryString.equals("null"))
    	uri = uri + "?" + queryString;
    
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    pageContext.setAttribute("user", user); 
    pageContext.setAttribute("loginURL", userService.createLoginURL(uri));
    pageContext.setAttribute("logoutURL", userService.createLogoutURL("/"));
%>

<c:set var='gaeUser' scope='application' value="${user}"/>

<!DOCTYPE html>
<html>
    <head>
        <link rel='stylesheet' href='//fonts.googleapis.com/css?family=Quintessential'>
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
        <link rel="stylesheet" href="/css/datepicker3.css" />
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/main1.css" />
        <script src="//maps.googleapis.com/maps/api/js?sensor=true&amp;libraries=places&v=3"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script src="/js/jquery.geocomplete.min.js"></script>
        <script src="/js/bootstrap-datepicker.js"></script>
    </head>
    <body>
    
        <div class="navbar navbar-inverse navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/">MyParkingSpots</a>
			</div>
			<div class="navbar-collapse collapse navbar-form navbar-right">
				<c:choose>
					<c:when test="${empty user}">
						<a href="${loginURL}" class="btn btn-success">Sign in</a>
					</c:when>
					<c:otherwise>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown">
								${fn:escapeXml(user.nickname)} <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/my_account">My Account</a></li>
								<li><a href="/post_parking_spot">Post a Spot</a></li>
								<li><a href="${logoutURL}">Sign out</a></li>
							</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
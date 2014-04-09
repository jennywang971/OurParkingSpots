package com.eece417.mss.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class MyAccount extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parkingSpotsKey = KeyFactory.createKey("ParkingSpots", "allParkingSpots");
		Query query = new Query("ParkingSpot", parkingSpotsKey)
			.addSort("startDate", Query.SortDirection.DESCENDING)
			.addSort("endDate", Query.SortDirection.ASCENDING);

		Filter startDateFilter = new FilterPredicate("owner", FilterOperator.EQUAL, user);
		query.setFilter(startDateFilter);

		List<Entity> parkingSpots = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
		req.setAttribute("parkingSpots", parkingSpots);
		req.getRequestDispatcher("/WEB-INF/MyAccount.jsp").forward(req, res);
	}

	@Override 
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

	}

}

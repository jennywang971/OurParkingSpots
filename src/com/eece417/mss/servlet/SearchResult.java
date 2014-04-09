package com.eece417.mss.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;

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

public class SearchResult extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private final static String SEARCH_RESULT_URL = "/WEB-INF/SearchResult.jsp";
	private final static Logger LOGGER = Logger.getLogger(SearchResult.class.getName()); 
	private final static SimpleDateFormat FORMATTER = new SimpleDateFormat("MM/dd/yyyy");
	private Date startDate, endDate;

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parkingSpotsKey = KeyFactory.createKey("ParkingSpots", "allParkingSpots");

		try {

			String startDateString = req.getParameter("startdatepicker");
			String endDateString = req.getParameter("enddatepicker");

			startDate = FORMATTER.parse(startDateString);
			endDate = FORMATTER.parse(endDateString);

			Query query = new Query("ParkingSpot", parkingSpotsKey)
				.addSort("startDate", Query.SortDirection.DESCENDING)
				.addSort("endDate", Query.SortDirection.ASCENDING);

			Filter startDateFilter = new FilterPredicate("startDate", FilterOperator.LESS_THAN_OR_EQUAL, startDate);
			query.setFilter(startDateFilter);

			List<Entity> parkingSpots = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));

			for (Iterator<Entity> iter = parkingSpots.listIterator(); iter.hasNext(); ) {
				Entity e = iter.next();
				Date end = (Date) e.getProperty("endDate");

				if (end != null && end.after(endDate))
					// remove search results where the end date is after the search query specified
					iter.remove();
			}

			req.setAttribute("parkingSpots", parkingSpots);
			req.setAttribute("location", req.getParameter("location"));
			req.setAttribute("startdatepicker", startDate);
			req.setAttribute("enddatepicker", endDate);
			req.getRequestDispatcher(SEARCH_RESULT_URL).forward(req, res);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			LOGGER.warning("Search Result Exception: " + e.getMessage());
		}
	}

	@Override 
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

		req.getRequestDispatcher(SEARCH_RESULT_URL).forward(req, res);
	}
}

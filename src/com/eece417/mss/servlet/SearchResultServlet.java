package com.eece417.mss.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.Days;

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

public class SearchResultServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final static String SEARCH_RESULT_URL = "/WEB-INF/SearchResult.jsp";
	private final static Logger LOGGER = Logger.getLogger(SearchResultServlet.class.getName()); 
	private final static SimpleDateFormat FORMATTER = new SimpleDateFormat("MM/dd/yyyy");
	private Date startDate, endDate;

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key parkingSpotsKey = KeyFactory.createKey("ParkingSpots", "allParkingSpots");
		
		Key reservationKey  = KeyFactory.createKey("ReservedSpots", "allReservedSpots");

		Calendar today = Calendar.getInstance();

		try {

			String startDateString = req.getParameter("startdatepicker");
			String endDateString = req.getParameter("enddatepicker");

			startDate = validate(startDateString) ? FORMATTER.parse(startDateString) : FORMATTER.parse(FORMATTER.format(today.getTime()));

			today.add(Calendar.DATE, 7);
			endDate = validate(endDateString) ? FORMATTER.parse(startDateString) : FORMATTER.parse(FORMATTER.format(today.getTime()));

			int dayDiff = Days.daysBetween(new DateTime(startDate), new DateTime(endDate)).getDays() + 1;

			Query query = new Query("ParkingSpot", parkingSpotsKey)
			.addSort("startDate", Query.SortDirection.DESCENDING)
			.addSort("endDate", Query.SortDirection.ASCENDING);

			Filter startDateFilter = new FilterPredicate("startDate", FilterOperator.LESS_THAN_OR_EQUAL, startDate);
			query.setFilter(startDateFilter);

			List<Entity> parkingSpots = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
			
			// query reservation 
			Query queryReservation = new Query("ReservedSpot", reservationKey);
			List<Entity> reservedSpots = datastore.prepare(queryReservation).asList(FetchOptions.Builder.withLimit(100));
			
			Set<Long> reservedIdSet = new HashSet<>();
			
			// get a set of parking spot ids that are conflicting with the desired start or end date
			for (Entity e : reservedSpots) {
				Date start = (Date) e.getProperty("startDate");
				Date end = (Date) e.getProperty("endDate");
				Long spotId = (Long) e.getProperty("parkingSpotId");
				if ((!end.before(startDate) && !end.after(endDate)) ||
						(!start.before(startDate) && !start.after(endDate))) {
					reservedIdSet.add(spotId);
				}
			}

			for (Iterator<Entity> iter = parkingSpots.listIterator(); iter.hasNext(); ) {
				Entity e = iter.next();
				Date end = (Date) e.getProperty("endDate");
				Long id = (Long) e.getProperty("id");

				// remove search results where the end date is after the search query specified
				// or the ids that have conflicting reservations
				if ((end != null && endDate.after(end)) || reservedIdSet.contains(id)){
					
					iter.remove();
				}
				
				else {
					String description = e.getProperty("description").toString();
					String escapeDescription = description
							.replace("\r", "")
							.replace("\n", "\\n")
							.replace("\t", "    ");
					e.setProperty("description", escapeDescription);
				}
			}


			req.setAttribute("parkingSpots", parkingSpots);
			req.setAttribute("duration", dayDiff);
			req.setAttribute("startDate", FORMATTER.format(startDate));
			req.setAttribute("endDate", FORMATTER.format(endDate));
			req.getRequestDispatcher(SEARCH_RESULT_URL).forward(req, res);

		} catch (ParseException e) {

			LOGGER.warning("Search Result Exception: " + e.getMessage());
		}
	}

	public boolean validate (String str) {

		Pattern r = Pattern.compile("\\d{2}/\\d{2}/\\d{4}");
		Matcher m = r.matcher(str);

		return m.find() ? true : false; 
	}
}

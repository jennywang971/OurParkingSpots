package com.eece417.mss.servlet;

import java.io.IOException;
import java.util.Iterator;
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

public class DeleteReservation extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override 
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key reservationKey = KeyFactory.createKey("ReservedSpots", "allReservedSpots");

		try {
			Query query = new Query("Reservation", reservationKey);

			Filter filter = new FilterPredicate("id", FilterOperator.EQUAL, Long.parseLong(req.getParameter("reservationId")));
			query.setFilter(filter);

			List<Entity> parkingSpots = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(1));

		  	for (Iterator<Entity> iter = parkingSpots.listIterator(); iter.hasNext(); ) {
				Entity e = iter.next();
				datastore.delete(e.getKey());
			} 
		  	
		} catch (Exception e) {
			System.out.println("Delete parking error: " + e.getLocalizedMessage());
		}
	}
}

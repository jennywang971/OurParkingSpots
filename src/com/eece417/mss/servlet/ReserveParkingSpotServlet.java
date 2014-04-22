package com.eece417.mss.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class ReserveParkingSpotServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
 
        // for reserving
        Key reservationKey  = KeyFactory.createKey("ReservedSpots", "allReservedSpots");
        
        int rate = Integer.parseInt(req.getParameter("rate"));
        int total = Integer.parseInt(req.getParameter("total"));
        Entity reservation = new Entity("Reservation",reservationKey );
        Date date = new Date();
        reservation.setProperty("id", date.getTime());
        reservation.setProperty("renter", user);
        reservation.setProperty("date", date);
        reservation.setProperty("rate", rate);
        reservation.setProperty("total", total);
      
        String startDateString = req.getParameter("startdatepicker");
        String endDateString = req.getParameter("enddatepicker");
        Date startDate = convertStringToDate(startDateString);
        Date endDate = convertStringToDate(endDateString);
        reservation.setProperty("startDate", startDate);
        reservation.setProperty("endDate", endDate);

        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        datastore.put(reservation);

        resp.sendRedirect("WEB-INF/MyAccount.jsp"); // change to other page?
	}

	
    public Date convertStringToDate(String dateString){
  	  SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
  	  
  	  Date date = null;
  	  
  	  try {
			date = formatter.parse(dateString);
		
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
  	
  	  return date;
  }
}

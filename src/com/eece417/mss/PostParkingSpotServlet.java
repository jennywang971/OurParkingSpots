package com.eece417.mss;

import java.io.IOException;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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

@SuppressWarnings("serial")
public class PostParkingSpotServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
 
        // for parking
        Key parkingSpotsKey = KeyFactory.createKey("ParkingSpots", "allParkingSpots");
        String parkingDescription = req.getParameter("content");
        Entity parkingSpot = new Entity("ParkingSpot",parkingSpotsKey );
        Date date = new Date();
        parkingSpot.setProperty("owner", user);
        parkingSpot.setProperty("date", date);
        parkingSpot.setProperty("description", parkingDescription);
      
        // getting Latitude, Longitude, available start and end date
        String latitude = req.getParameter("latitude");
        String longitude = req.getParameter("longitude");
        parkingSpot.setProperty("latitude", latitude);
        parkingSpot.setProperty("longitude", longitude);
        
  
        String startDateString = req.getParameter("startdatepicker");
        String endDateString = req.getParameter("enddatepicker");
        Date startDate = convertStringToDate(startDateString);
        Date endDate = convertStringToDate(endDateString);
        parkingSpot.setProperty("startDate", startDate);
        parkingSpot.setProperty("endDate", endDate);

        DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
        datastore.put(parkingSpot);

        resp.sendRedirect("/index.jsp");
    }
    
    private Date convertStringToDate(String dateString){
    	  SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
    	  
    	  Date date = null;
    	  
    	  try {
			date = formatter.parse(dateString);
			System.out.println("the original date String: "+ dateString);
			System.out.println("the date in Date format: " +date);
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
    	
    	  return date;
    }


}

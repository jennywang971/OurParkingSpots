package com.eece417.mss.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Logger;

import javax.servlet.ServletException;
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


public class PostParkingSpotServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private final static String POST_PARKING_URL = "/WEB-INF/PostParkingSpot.jsp";
	private final static Logger LOGGER = Logger.getLogger(PostParkingSpotServlet.class.getName()); 

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(POST_PARKING_URL).forward(req, resp);
	}

	@Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        Date date = new Date();
 
        // for parking
        Key parkingSpotsKey = KeyFactory.createKey("ParkingSpots", "allParkingSpots");
        String parkingDescription = req.getParameter("content").trim();
        int rate = Integer.parseInt(req.getParameter("rate"));
        Entity parkingSpot = new Entity("ParkingSpot", parkingSpotsKey);
        parkingSpot.setProperty("id", date.getTime());
        parkingSpot.setProperty("owner", user);
        parkingSpot.setProperty("date", date);
        parkingSpot.setProperty("description", parkingDescription);
        parkingSpot.setProperty("rate", rate);
      
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

        resp.sendRedirect("/my_account");
    }
    
    public Date convertStringToDate(String dateString){
    	SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

    	Date date = null;

    	try {
    		date = formatter.parse(dateString);
    		//System.out.println("the original date String: "+ dateString);
    		//System.out.println("the date in Date format: " +date);
    	} catch (ParseException e) {
			LOGGER.warning("Post Parking Exception: " + e.getLocalizedMessage());
    	}

    	return date;
    }
}

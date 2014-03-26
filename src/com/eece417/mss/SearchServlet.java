package com.eece417.mss;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@SuppressWarnings("serial")
public class SearchServlet extends HttpServlet {
	  public void doPost(HttpServletRequest req, HttpServletResponse resp)
              throws IOException {
		  // TODO: not done yet
		  
		  String cityName = req.getParameter("hard_coded_city");
	  }
}

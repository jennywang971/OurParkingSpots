package com.eece417.mss.model;

import java.util.Date;

import com.google.gson.annotations.SerializedName;

public class ParkingSpot {

	@SerializedName("id")
	private int id;
	
	@SerializedName("description")
	private String description;
	
	@SerializedName("startDate")
	private Date startDate;

	@SerializedName("endDate")
	private Date endDate;

	@SerializedName("reportTime")
	private Date reportTime;

	@SerializedName("latitude")
	private Float latitude;

	@SerializedName("longitude")
	private Float longitude;

	@SerializedName("accuracy")
	private Float accuracy;

	public int getId() {
		return id;
	}

	public String getDescription() {
		return description;
	}

	public Date getStartDate() {
		return startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public Date getReportTime() {
		return reportTime;
	}

	public Float getLatitude() {
		return latitude;
	}

	public Float getLongitude() {
		return longitude;
	}

	public Float getAccuracy() {
		return accuracy;
	}
}

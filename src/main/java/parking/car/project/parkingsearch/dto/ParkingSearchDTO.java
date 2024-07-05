package parking.car.project.parkingsearch.dto;

import lombok.Data;

@Data
public class ParkingSearchDTO {
	private int parking_code;
	private String parking_name;
	private String parking_address;
	private double parking_latitude;
	private double parking_longitude;
	private String parking_base_fee;
	private String parking_hourly_rate;
	private String parking_type;
	private String parking_photo_path;
}

package parking.car.project.calculate.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CalculateDTO {
	private int calculate_code;
	private Date calculate_date;
	private String calculate_amount;
	private String calculate_status;
	private int parking_code;
	private int records_code;
	private String parking_base_fee;
	private String parking_hourly_rate;
	private String records_start;
	private String records_end;
	private int member_code;
	private String member_id;
}
package parking.car.project.payment.dto;

import lombok.Data;

@Data
public class PaymentDTO {

	private int payment_code;
	
	private String payment_name;
	
	private String payment_total;
	
	private String payment_status;

	private int parking_code;
	
	private int ticket_code;
	
	private int member_code;
	
	private int calculate_code;
	
}
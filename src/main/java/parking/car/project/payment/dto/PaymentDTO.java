package parking.car.project.payment.dto;

import lombok.Data;

@Data
public class PaymentDTO {

	private String payment_code;
	
	private String payment_name;
	
	private int payment_total;
	
	private String payment_success;

	private int parking_code;
	
	private int ticket_code;
	
	private int coupon_code;
	
	private int member_code;
}
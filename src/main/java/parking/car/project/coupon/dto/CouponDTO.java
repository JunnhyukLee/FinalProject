package parking.car.project.coupon.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CouponDTO {
	
	private int coupon_code;
	
	private String coupon_type;
	
	private String coupon_name;
	
	private LocalDateTime coupon_start;
	
	private LocalDateTime coupon_end;
	
	private int coupon_price;

	private String coupon_use;
	
	private int parking_code;

}
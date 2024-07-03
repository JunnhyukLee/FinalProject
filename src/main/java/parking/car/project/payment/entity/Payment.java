package parking.car.project.payment.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//기본 생성자로 자동으로 생성한다.
@NoArgsConstructor
@Getter
@Setter

//클래스가 JPA 엔티티임을 나타낸다.
@Entity
//@Table(name = "payment")
public class Payment {

	// 엔티티의 기본키
	@Id
    private String payment_code; // payment_code를 식별자로 사용
    private String payment_name;
    private int payment_total;
	
    private int parking_code;
	
	private int ticket_code;
	
	private int coupon_code;
	
	private int member_code;
}
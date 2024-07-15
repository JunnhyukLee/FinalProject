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
    private Integer payment_code;
    private String payment_name;
    private String payment_total;
    private String payment_status;
	
    private Integer parking_code;
    private Integer ticket_code;
    private Integer member_code;

	private Integer calculate_code;
	
}
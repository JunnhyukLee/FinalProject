package parking.car.project.coupon.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//기본 생성자로 자동으로 생성한다.
@NoArgsConstructor
@Getter
@Setter

//클래스가 JPA 엔티티임을 나타낸다.
@Entity
public class Coupon {
	
	//엔티티의 기본키
		@Id
		@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "coupon_code_seq")
		@SequenceGenerator(name = "coupon_code_seq", sequenceName = "coupon_code_seq", allocationSize = 1)
		private int coupon_code;
		
		private String coupon_type;
		
		private String coupon_name;
		
		@Column(name = "coupon_start", nullable = false)
		private LocalDateTime coupon_start;
		
		@Column(name = "coupon_end", nullable = false)
		private LocalDateTime coupon_end;
		
		private int coupon_price;
		
		private String coupon_use;

		private int parking_code;
		
}
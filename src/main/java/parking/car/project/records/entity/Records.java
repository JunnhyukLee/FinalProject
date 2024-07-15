package parking.car.project.records.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import parking.car.project.member.entity.Member;
import parking.car.project.parking.entity.Parking;

@NoArgsConstructor
@Setter
@Getter
@Entity
public class Records {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "records_sequence")
	@SequenceGenerator(name = "records_sequence", sequenceName = "records_seq", allocationSize = 1, initialValue = 1000000000)
	private Integer records_code; // 주차 기록 코드 번호
	private String  records_start; // 입차 시간
	private String  records_end; // 출차 시간
	// private Integer member_code; // 등록한 고객 코드 (외래키)
	private String member_car_num; // 주차된 차량 번호, 회원 차량 번호
	// private Integer parking_code; // 주차장 코드 (외래키)
	private String parking_name; // 주차 기록 등록 당시 등록되어있던 주차장 이름

	@ManyToOne
	@JoinColumn(name = "member_code", referencedColumnName = "member_code")
	private Member member; // 회원정보 외래키
	
	@ManyToOne
	@JoinColumn(name = "parking_code", referencedColumnName = "parking_code")
	private Parking parking; // 주차장 정보 외래키

}
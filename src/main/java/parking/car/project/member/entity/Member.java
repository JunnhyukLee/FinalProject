package parking.car.project.member.entity;

import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
//import jakarta.persistence.SequenceGenerator;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@Entity
//@SequenceGenerator(name = "member_seq_gen", sequenceName = "member_seq", initialValue = 1, allocationSize = 1)
public class Member {
	
	@Id
	//@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "member_seq_gen")
	private Integer member_code;
	private String member_id;
	private String member_name;
	private String member_password;
	private String member_email;
	private String member_callnumber;
	private String member_birthday;
	private String member_gender;
	private String member_joinday;
	private String member_car_num1;
	private String member_car_num2;
	private String member_car_num3;
	private String member_rating;
}

package parking.car.project.member.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberDTO {
	 private Integer member_code;
	    private String member_id;
	    private String member_name;
	    private String member_password;
	    private String member_email;
	    private String member_callnumber;
	    
	    @DateTimeFormat(pattern = "yyyyMMdd")
	    private LocalDate member_birthday; // 변경된 부분
	    private String member_gender;
	    
	    @DateTimeFormat(pattern = "yyyyMMdd")
	    private LocalDate member_joinday; // 변경된 부분
	    private String member_car_num1;
	    private String member_car_num2;
	    private String member_car_num3;
	    private String member_rating;
}
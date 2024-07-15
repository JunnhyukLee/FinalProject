package parking.car.project.member.entity;

import java.time.LocalDate;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@Entity
public class Member {
    @Id
    private Integer member_code;
    private String member_id;
    private String member_name;
    private String member_password;
    private String member_email;
    private String member_callnumber;
    private LocalDate member_birthday;
    private String member_gender;
    private LocalDate member_joinday;
    private String member_car_num1;
    private String member_car_num2;
    private String member_car_num3;
    private String member_rating;
}

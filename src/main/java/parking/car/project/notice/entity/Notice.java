package parking.car.project.notice.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@Entity
public class Notice {
	@Id
	private int notice_code;
	private String notice_title;
	private String notice_content;
	private Date notice_date;
	private String notice_type;
	private int notice_view;
}
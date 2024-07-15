package parking.car.project.notice.dto;

import lombok.Data;

@Data
public class NoticeDTO {
	private int notice_code;
	private String notice_title;
	private String notice_content;
	private String notice_date;
	private String notice_type;
	private int notice_view;
}
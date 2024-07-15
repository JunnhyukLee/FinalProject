package parking.car.project.records.dto;

import lombok.Data;

@Data
public class RecordsDTO {
	
	private int records_code; // 주차 기록 코드 번호
	private String records_start; // 입차 시간
	private String records_end; // 출차 시간
	private int member_code; // 등록한 고객 코드 (외래키)
	private String member_car_num; // 주차된 차량 번호, 회원 차량 번호
	private int parking_code; // 주차장 코드 (외래키)
	private String parking_name; // 주차장 정보 중 주차장 이름

}
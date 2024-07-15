package parking.car.project.parking.dto;

import lombok.Data;

@Data
public class ParkingDTO {
	
	private int parking_code; // 주차장 코드 > 기본키 (시퀀스)
	private String parking_name; // 주차장 이름
	private String parking_address; // 주차장 주소
	private double parking_latitude; // 주차장 위도
	private double parking_longitude; // 주차장 경도
	private String parking_operation; // 주차장 운영일정 및 시간
	private String parking_type; // 주차장 종류(실내, 실외, 공용 등)
	private String parking_total_spaces; // 총 주차 가능 공간
	private String parking_electriccar_check; // 전기차 충전 가능 여부
	private String parking_electriccar_spaces; // 전기차 충전 가능 공간
	private String parking_pay_type; // 정기권, 시간권 결제 유형
	private String parking_base_fee; // 기본 요금
	private String parking_hourly_rate; // 시간 당 추가요금
	
	private String parking_photo1_name; // 사진 
	private String parking_photo1_path;
	private String parking_photo2_name;
	private String parking_photo2_path;
	private String parking_photo3_name;
	private String parking_photo3_path;
	private String parking_photo4_name;
	private String parking_photo4_path;
	private String parking_photo5_name;
	private String parking_photo5_path;
	
	private String parking_document_name; // 서류
	private String parking_document_path;
	
	private String parking_approval; // 주차장 등록 승인 상태
	
	private String parking_registration; // 등록일시
	private String parking_edit; // 수정일시
	
	private int member_code; // 등록한 고객 코드 > 외래키

}
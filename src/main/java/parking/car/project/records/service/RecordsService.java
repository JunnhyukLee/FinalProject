package parking.car.project.records.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.records.entity.Records;
import parking.car.project.records.repository.RecordsRepository;

@Service
public class RecordsService {
	
	@Inject
	private RecordsRepository recordsRepository;
	
	// member_code로 등록된 주차장 전체 이력 확인
	// * recordsSelectUser -> select records_code, member_car_num, records_start, records_end from records where member_code = ?
	@Transactional(readOnly = true)
	public List<Records> findByMemberCode (Integer member_code) {
		return recordsRepository.findByMemberCode(member_code);
	}
	
	// ParkingService 내 findByMemberCode 메서드 활용
	// * recordsSelectParkingCode -> select parking_code, parking_name from parking where member_code = ?
	
	// parking_code로 등록된 주차장 전체 이력 확인
	// * recordsSelectParking -> select records_code, member_car_num, to_char(records_start, 'YYYY-MM-DD hh24:mi:SS') records_start, 
	// to_char(records_end, 'YYYY-MM-DD hh24:mi:SS') records_end from records where parking_code = ?
	@Transactional(readOnly = true)
	public List<Records> findByParkingCode (Integer parking_code) {
		return recordsRepository.findByParkingCode(parking_code);
	}
	
	// 특정 records_code로 주차 기록 상세 정보 조회
	// * recordsSelectDetailUser> -> select records_code, member_code, member_car_num, parking_name, 
	// to_char(records_start, 'YYYY-MM-DD hh24:mi:SS') records_start, to_char(records_end, 'YYYY-MM-DD hh24:mi:SS') records_end, payment_total from records 
	// where records_code = ?
	// * recordsSelectDetailParking -> select records_code, member_code, member_car_num, parking_code, parking_name, 
	// to_char(records_start, 'YYYY-MM-DD hh24:mi:SS') records_start, to_char(records_end, 'YYYY-MM-DD hh24:mi:SS') records_end, payment_total from records 
	// where records_code = ?
	@Transactional(readOnly = true)
	public Records findByRecordsCode (Integer records_code) {
		return recordsRepository.findById(records_code).orElse(null);
	}
	
	// insert, update 시 데이터 저장 메서드
	// * recordsInsert -> insert into records (records_code, member_code, member_car_num, parking_code, parking_name, records_start) 
	// values (records_seq.NEXTVAL, ?, ?, ?, ?, sysdate)
	// * recordsUpdate -> update records set records_end = sysdate, payment_total = ? where records_code = ?
	@Transactional
	public Records saveRecords(Records records) {
		return recordsRepository.save(records);
	}
	
	// * recordsDelete -> delete from records where records_code = ?
	@Transactional
	public void deleteRecords(Integer records_code) {
		recordsRepository.deleteById(records_code);
	}
	
	// 입력된 records_code의 값이 DB에 존재하는지 확인하는 메서드
	public boolean existsByRecords_code(Integer records_code) {
		return recordsRepository.existsById(records_code);
	}

}
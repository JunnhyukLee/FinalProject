package parking.car.project.records.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.inject.Inject;
import lombok.RequiredArgsConstructor;
import parking.car.project.member.entity.Member;
import parking.car.project.member.service.MemberService;
import parking.car.project.parking.entity.Parking;
import parking.car.project.parking.service.ParkingService;
import parking.car.project.records.dto.RecordsDTO;
import parking.car.project.records.entity.Records;
import parking.car.project.records.service.RecordsService;

@RestController
@RequiredArgsConstructor
public class RecordsRestController {
	
	private static final Logger logger = LogManager.getLogger(RecordsRestController.class);
	
	@Inject
	private final RecordsService recordsService;
	
	@Inject
	private final ParkingService parkingService;
	
	@Inject
	private final MemberService memberService;
	
	@GetMapping("/recordsSelectAllParking")
	public ResponseEntity<List<Parking>> recordsSelectAllParking() {
		
		List<Parking> list = parkingService.findAllParking();
		logger.info("recordsSelectAllParking - {}", list);
		
		if (list != null) {
			return new ResponseEntity<>(list, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
	
	@GetMapping("/recordsSelectUser/{member_code}")
	public ResponseEntity<List<Records>> recordsSelectUser(@PathVariable("member_code") Integer member_code) {
		
		List<Records> list = recordsService.findByMemberCode(member_code);
		logger.info("recordsSelectUser - {}", list);
		
		if (list != null) {
			return new ResponseEntity<>(list, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
	
	@GetMapping("/recordsSelectParkingCode/{member_code}")
	public ResponseEntity<List<Parking>> recordsSelectParkingCode(@PathVariable("member_code") Integer member_code) {
		
		List<Parking> list = parkingService.findByMemberCode(member_code);
		logger.info("member_code - {}, recordsSelectParkingCode - {}", member_code, list);
		
		if (list != null) {
			return new ResponseEntity<>(list, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
	
	@GetMapping("/recordsSelectParking/{parking_code}")
	public ResponseEntity<Map<String, Object>> recordsSelectParking(@PathVariable("parking_code") Integer parking_code) {
		
		List<Records> list = recordsService.findByParkingCode(parking_code);
		Parking parking = parkingService.findByParkingCode(parking_code);
		
		Map<String, Object> response = new HashMap<>();
		
		if (list != null) {
			
			response.put("list", list);
			response.put("parking", parking);
			
			return new ResponseEntity<>(response, HttpStatus.OK);
			
		} else {
			
			response.put("parking", parking);
			
			return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
		}
		
	}
	
	@GetMapping("/recordsSelectDetailUser/{records_code}")
	public ResponseEntity<Records> recordsSelectDetailUser(@PathVariable("records_code") Integer records_code) {
		
		Records records = recordsService.findByRecordsCode(records_code);
		
		if (records != null) {
			return new ResponseEntity<>(records, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
	
	@GetMapping("/recordsSelectDetailParking/{records_code}")
	public ResponseEntity<Records> recordsSelectDetailParking(@PathVariable("records_code") Integer records_code) {
		
		Records records = recordsService.findByRecordsCode(records_code);
		
		if (records != null) {
			return new ResponseEntity<>(records, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
	}
	
	@PostMapping("/recordsInsert")
    public ResponseEntity<Map<String, Object>> recordsInsert(@RequestBody RecordsDTO recordsDTO) {
		
        Records records = new Records();
        records.setRecords_code(recordsDTO.getRecords_code());
        records.setRecords_start(recordsDTO.getRecords_start());
        records.setRecords_end(recordsDTO.getRecords_end());
        records.setMember_car_num(recordsDTO.getMember_car_num());
        
        Member member = memberService.findMemberByCarNum(recordsDTO.getMember_car_num());
        records.setMember(member);
        
        Parking parking = parkingService.findByParkingCode(recordsDTO.getParking_code());
        records.setParking(parking);
        
        records.setParking_name(recordsDTO.getParking_name());
        
        recordsService.saveRecords(records);
        
        Map<String, Object> response = new HashMap<>();
        response.put("recordsDTO", records);
        
        logger.info("recordsInsert - {}", response);
        
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }
	
	@PutMapping("/recordsUpdate")
    public ResponseEntity<Map<String, Object>> recordsUpdate(@RequestBody RecordsDTO recordsDTO) {
		
		Records records = recordsService.findByRecordsCode(recordsDTO.getRecords_code());
		logger.info("주차 기록 코드 - {}", records);
		
		if (records == null) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
        //records.setRecords_code(recordsDTO.getRecords_code());
        
        Parking parking = parkingService.findByParkingCode(recordsDTO.getParking_code());
        records.setParking(parking);
        
        records.setParking_name(recordsDTO.getParking_name());
        
        Member member = memberService.findMemberByCarNum(recordsDTO.getMember_car_num());
        records.setMember(member);
        
        records.setMember_car_num(recordsDTO.getMember_car_num());
        records.setRecords_start(recordsDTO.getRecords_start());
        records.setRecords_end(recordsDTO.getRecords_end());
        
        recordsService.saveRecords(records);
        
        Map<String, Object> response = new HashMap<>();
        response.put("recordsDTO", records);
        
        logger.info("recordsUpdate - {}", response);
        
        String calculateRedirect = "/CalculateInsert?records_code=" + records.getRecords_code() + "&parking_code=" + records.getParking().getParking_code();
        response.put("calculateRedirect", calculateRedirect);
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
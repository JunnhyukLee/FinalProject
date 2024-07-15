package parking.car.project.records.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import parking.car.project.member.entity.Member;
import parking.car.project.member.service.CustomMemberDetails;
import parking.car.project.member.service.MemberService;
import parking.car.project.parking.entity.Parking;
import parking.car.project.parking.service.ParkingService;
import parking.car.project.records.dto.RecordsDTO;
import parking.car.project.records.entity.Records;
import parking.car.project.records.service.RecordsService;

@Controller
@RequiredArgsConstructor
public class RecordsController {
	
	private static final Logger logger = LogManager.getLogger(RecordsController.class);
	
	@Inject
	private final RecordsService recordsService;
	
	@Inject
	private final ParkingService parkingService;
	
	@Inject
	private final MemberService memberService;
	
	// RestController 사용하는 view 페이지로 이동 user
	@GetMapping("/RecordsRestUser")
	public String RecordsRestUser(HttpServletRequest request, Model model) {
	    CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession().getAttribute("customMemberDetails");

	    if (customMemberDetails != null) {
	        Integer member_code = customMemberDetails.getMemberCode();
	        logger.info("Fetching records for member_code: {}", member_code);
	        List<Records> records = recordsService.findByMemberCode(member_code);
	        model.addAttribute("list", records);
	        model.addAttribute("member_code", member_code);
	        return "records/records_rest_user";
	    } else {
	        model.addAttribute("loginRequired", true);
	        return "records/records_rest_user";
	    }
	}
	
	// RestController 사용하는 view 페이지로 이동 manager
	@GetMapping("/RecordsRestManager")
	public String RecordsRestManager() {
		logger.info("RecordsRestManager 진입");
		return "records/records_rest_manager"; 
	}
		
	// RestController 사용하는 view 페이지로 이동 admin
	@GetMapping("/RecordsRestAdmin")
	public String RecordsRestAdmin() {
		logger.info("RecordsRestManager 진입");
		return "records/records_rest_admin"; 
	}
	
	@GetMapping("/RecordsSelectUser")
	public String recordsSelectUser(Model model, @RequestParam("member_code") Integer member_code) {
		
		model.addAttribute("list", recordsService.findByMemberCode(member_code));
		logger.info("recordsSelectUser - {}", model);
		
		return "records/records_select_user";
	}
	
	@GetMapping("/RecordsSelectParkingCode")
	public String recordsSelectParkingCode(Model model, @RequestParam("member_code") Integer member_code) {
		
		model.addAttribute("list", parkingService.findByMemberCode(member_code));
		logger.info("recordsSelectParkingCode - {}", model);
		
		return "records/records_select_parking_code";
	}
	
	@GetMapping("/RecordsSelectParking")
	public String recordsSelectParking(Model model, @RequestParam("parking_code") Integer parking_code) {
		
		model.addAttribute("list", recordsService.findByParkingCode(parking_code));
		model.addAttribute("parking", parkingService.findByParkingCode(parking_code)); // 주차장 코드 및 이름 전달
		logger.info("recordsSelectParking - {}", model);
		
		return "records/records_select_parking";
	}
	
	@GetMapping("/RecordsSelectDetailUser")
	public String recordsSelectDetailUser(Model model, @RequestParam("records_code") Integer records_code) {
		
		model.addAttribute("recordsDTO", recordsService.findByRecordsCode(records_code));
		logger.info("recordsSelectDetailUser - ", model);
		
		return "records/records_select_detail_user";
	}
	
	@GetMapping("/RecordsSelectDetailParking")
	public String recordsSelectDetailParking(Model model, @RequestParam("records_code") Integer records_code) {
		
		model.addAttribute("recordsDTO", recordsService.findByRecordsCode(records_code));
		logger.info("recordsSelectDetailParking - ", model);
		
		return "records/records_select_detail_parking";
	}
	
	@GetMapping("/RecordsInsert")
	public String recordsInsert(Model model, @RequestParam("parking_code") Integer parking_code) {
		
		model.addAttribute("parking", parkingService.findByParkingCode(parking_code)); // 주차장 정보 확인
		logger.info("주차 기록 등록 화면 진입");
		
		return "records/records_insert_input";
	}
	
	@PostMapping("/RecordsInsert")
	public String recordsInsert(Model model, RecordsDTO recordsDTO) {
		
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
		
		model.addAttribute("recordsDTO", records);
		
		return "records/records_insert";
	}
	
	@GetMapping("/RecordsUpdate")
	public String recordsUpdate(Model model, @RequestParam("records_code") Integer records_code) {
		
		Records records = recordsService.findByRecordsCode(records_code);
		
		if (records != null) {
			
			RecordsDTO recordsDTO = new RecordsDTO();
			recordsDTO.setRecords_code(records.getRecords_code());
			recordsDTO.setRecords_start(records.getRecords_start().toString());
			recordsDTO.setRecords_end(records.getRecords_end().toString());
			recordsDTO.setMember_code(records.getMember().getMember_code());
			recordsDTO.setMember_car_num(records.getMember_car_num());
			recordsDTO.setParking_code(records.getParking().getParking_code());
			recordsDTO.setParking_name(records.getParking_name());
			
			model.addAttribute("recordsDTO", recordsDTO);
			
		}
		
		logger.info("주차 기록 수정 화면 진입");
		return "records/records_update_input";
	}
	
	@PostMapping("/RecordsUpdate")
	public String recordsUpdate(RecordsDTO recordsDTO) {
		
		Records records = new Records();
		records.setRecords_code(recordsDTO.getRecords_code());
		
		Parking parking = parkingService.findByParkingCode(recordsDTO.getParking_code());
		records.setParking(parking);
		
		records.setParking_name(recordsDTO.getParking_name());
		
		Member member = memberService.findMemberById(recordsDTO.getMember_code());
		records.setMember(member);
		
		records.setMember_car_num(recordsDTO.getMember_car_num());
		records.setRecords_start(recordsDTO.getRecords_start());
		records.setRecords_end(recordsDTO.getRecords_end());
		
		recordsService.saveRecords(records);
		
		return "records/records_update";
	}
	
	@GetMapping("/RecordsDelete")
	public String recordsDelete(Model model, @RequestParam("records_code") Integer records_code) {
		
		Records records = recordsService.findByRecordsCode(records_code);
		
		if (records != null) {
			
			RecordsDTO recordsDTO = new RecordsDTO();
			recordsDTO.setRecords_code(records.getRecords_code());
			recordsDTO.setRecords_start(records.getRecords_start().toString());
			recordsDTO.setRecords_end(records.getRecords_end().toString());
			recordsDTO.setMember_code(records.getMember().getMember_code());
			recordsDTO.setMember_car_num(records.getMember_car_num());
			recordsDTO.setParking_code(records.getParking().getParking_code());
			recordsDTO.setParking_name(records.getParking_name());
			
			model.addAttribute("recordsDTO", recordsDTO);
			
		}
		
		logger.info("주차 기록 삭제 화면 진입");
		return "records/records_delete_process";
	}
	
	@PostMapping("/RecordsDelete")
	public String recordsDelete(RecordsDTO recordsDTO) {
		
		Records records = new Records();
		records.setRecords_code(recordsDTO.getRecords_code());
		
		Parking parking = parkingService.findByParkingCode(recordsDTO.getParking_code());
		records.setParking(parking);
		
		recordsService.deleteRecords(records.getRecords_code());
		
		return "records/records_delete";
	}

}
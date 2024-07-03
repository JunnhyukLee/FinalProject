package parking.car.project.parking.controller;

//import java.io.IOException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.multipart.MultipartFile;

import jakarta.inject.Inject;
import lombok.RequiredArgsConstructor;
import parking.car.project.member.entity.Member;
import parking.car.project.member.service.MemberService;
import parking.car.project.parking.dto.ParkingDTO;
import parking.car.project.parking.entity.Parking;
import parking.car.project.parking.service.ParkingService;

@Controller
@RequiredArgsConstructor
public class ParkingController {

	private static final Logger logger = LogManager.getLogger(ParkingController.class);

	@Inject
	private final ParkingService parkingService;

	@Inject
	private final MemberService memberService;

	@GetMapping("/Menu")
	public String menu() {
		logger.info("메뉴 진입");
		return "./menu/menu";
	}

	@GetMapping("/map")
	public String map() {
		return "./parking/map";
	}

	@GetMapping("/ParkingSelectAll") // member_code로 주차장 등록 기록 확인
	public String parkingSelectAll(Model model, @RequestParam("member_code") Integer member_code) {

		model.addAttribute("list", parkingService.findByMemberCode(member_code));
		logger.info("parkingSelectAll list - {}", model);

		return "./parking/parking_select_all";
	}

	@GetMapping("/ParkingSelectAdmin") // 등록된 주차장 목록 전체 조회
	public String parkingSelectAdmin(Model model) {

		model.addAttribute("list", parkingService.findAllParking());
		logger.info("parkingSelectAdmin list - ", model);

		return "./parking/parking_select_admin";
	}

	@GetMapping("/ParkingSelectDetail") // parking_code로 주차장 상세 정보 조회
	public String parkingSelectDetail(Model model, @RequestParam("parking_code") Integer parking_code) {

		model.addAttribute("parkingDTO", parkingService.findByParkingCode(parking_code));
		logger.info("parkingSelectDetail - ", model);

		return "./parking/parking_select_detail";
	}

	@GetMapping("/ParkingInsert") // 주차장 등록 화면 이동
	public String parkingInsert() {
		logger.info("주차장 등록 화면 진입");
		return "./parking/parking_insert_input";
	}
	
	@PostMapping("/ParkingInsert") // 주차장 등록 처리
	public String parkingInsert(Model model, ParkingDTO parkingDTO) {

		// 세션 추가 시 세션으로 member_code 받아서 적용 예정
		parkingDTO.setMember_code(10001);

		logger.info("parkingDTO - {}", parkingDTO);

		Parking parking = new Parking();
		parking.setParking_code(parkingDTO.getParking_code());
		parking.setParking_name(parkingDTO.getParking_name());
		parking.setParking_address(parkingDTO.getParking_address());
		parking.setParking_latitude(parkingDTO.getParking_latitude());
		parking.setParking_longitude(parkingDTO.getParking_longitude());
		parking.setParking_operation(parkingDTO.getParking_operation());
		parking.setParking_type(parkingDTO.getParking_type());
		parking.setParking_total_spaces(parkingDTO.getParking_total_spaces());
		parking.setParking_electriccar_check(parkingDTO.getParking_electriccar_check());
		parking.setParking_electriccar_spaces(parkingDTO.getParking_electriccar_spaces());
		parking.setParking_pay_type(parkingDTO.getParking_pay_type());
		parking.setParking_base_fee(parkingDTO.getParking_base_fee());
		parking.setParking_hourly_rate(parkingDTO.getParking_hourly_rate());
		// 주차장 사진 및 서류 이미지 추가 필요
		
		parking.setParking_approval(parkingDTO.getParking_approval());
		parking.setParking_registration(parkingDTO.getParking_registration());
		parking.setParking_edit(parkingDTO.getParking_edit());

		Member member = memberService.findMemberById(parkingDTO.getMember_code());
		parking.setMember(member);

		logger.info("parking - {}", parking);

		parkingService.saveParking(parking);

		model.addAttribute("parkingDTO", parkingDTO);
		model.addAttribute("list", parkingService.findByMemberCode(parkingDTO.getMember_code()));

		return "./parking/parking_insert";
	}

//	@PostMapping("/ParkingInsert") // 주차장 등록 처리
//	public String parkingInsert(Model model, @ModelAttribute ParkingDTO parkingDTO,
//			@RequestParam("parking_photo") MultipartFile[] parking_photos,
//			@RequestParam("parking_document") MultipartFile parking_document) throws IllegalStateException, IOException {
//
//		// 세션 추가 시 세션으로 member_code 받아서 적용 예정
//		parkingDTO.setMember_code(10001);
//
//		logger.info("parkingDTO - {}", parkingDTO);
//
//		// 주차장 사진 업로드 처리
//		for (int i = 0; i < parking_photos.length; i++) {
//			
//			MultipartFile parking_photo = parking_photos[i];
//			
//			if (!parking_photo.isEmpty()) {
//				String url = parkingService.fileUpload(parking_photo, parkingDTO.getMember_code());
//				switch (i) {
//				case 0:
//					parkingDTO.setParking_photo1_name(parking_photo.getOriginalFilename());
//					parkingDTO.setParking_photo1_path(url);
//					break;
//				case 1:
//					parkingDTO.setParking_photo2_name(parking_photo.getOriginalFilename());
//					parkingDTO.setParking_photo2_path(url);
//					break;
//				case 2:
//					parkingDTO.setParking_photo3_name(parking_photo.getOriginalFilename());
//					parkingDTO.setParking_photo3_path(url);
//					break;
//				case 3:
//					parkingDTO.setParking_photo4_name(parking_photo.getOriginalFilename());
//					parkingDTO.setParking_photo4_path(url);
//					break;
//				case 4:
//					parkingDTO.setParking_photo5_name(parking_photo.getOriginalFilename());
//					parkingDTO.setParking_photo5_path(url);
//					break;
//				}
//			}
//		}
//
//		// 서류 업로드 처리
//		if (!parking_document.isEmpty()) {
//			String documentUrl = parkingService.fileUpload(parking_document, parkingDTO.getMember_code());
//			parkingDTO.setParking_document_name(parking_document.getOriginalFilename());
//			parkingDTO.setParking_document_path(documentUrl);
//		}
//
//		Parking parking = new Parking();
//		parking.setParking_code(parkingDTO.getParking_code());
//		parking.setParking_name(parkingDTO.getParking_name());
//		parking.setParking_address(parkingDTO.getParking_address());
//		parking.setParking_latitude(parkingDTO.getParking_latitude());
//		parking.setParking_longitude(parkingDTO.getParking_longitude());
//		parking.setParking_operation(parkingDTO.getParking_operation());
//		parking.setParking_type(parkingDTO.getParking_type());
//		parking.setParking_total_spaces(parkingDTO.getParking_total_spaces());
//		parking.setParking_electriccar_check(parkingDTO.getParking_electriccar_check());
//		parking.setParking_electriccar_spaces(parkingDTO.getParking_electriccar_spaces());
//		parking.setParking_pay_type(parkingDTO.getParking_pay_type());
//		parking.setParking_base_fee(parkingDTO.getParking_base_fee());
//		parking.setParking_hourly_rate(parkingDTO.getParking_hourly_rate());
//		// 주차장 사진 및 서류 이미지 추가 필요
//		parking.setParking_photo1_name(parkingDTO.getParking_photo1_name());
//		parking.setParking_photo1_path(parkingDTO.getParking_photo1_path());
//		parking.setParking_photo2_name(parkingDTO.getParking_photo2_name());
//		parking.setParking_photo2_path(parkingDTO.getParking_photo2_path());
//		parking.setParking_photo3_name(parkingDTO.getParking_photo3_name());
//		parking.setParking_photo3_path(parkingDTO.getParking_photo3_path());
//		parking.setParking_photo4_name(parkingDTO.getParking_photo4_name());
//		parking.setParking_photo4_path(parkingDTO.getParking_photo4_path());
//		parking.setParking_photo5_name(parkingDTO.getParking_photo5_name());
//		parking.setParking_photo5_path(parkingDTO.getParking_photo5_path());
//		parking.setParking_document_name(parkingDTO.getParking_document_name());
//		parking.setParking_document_path(parkingDTO.getParking_document_path());
//		
//		parking.setParking_approval(parkingDTO.getParking_approval());
//		parking.setParking_registration(parkingDTO.getParking_registration());
//		parking.setParking_edit(parkingDTO.getParking_edit());
//
//		Member member = memberService.findMemberById(parkingDTO.getMember_code());
//		parking.setMember(member);
//
//		logger.info("parking - {}", parking);
//
//		parkingService.saveParking(parking);
//
//		model.addAttribute("parkingDTO", parkingDTO);
//		model.addAttribute("list", parkingService.findByMemberCode(parkingDTO.getMember_code()));
//
//		return "./parking/parking_insert";
//	}

	@GetMapping("/ParkingUpdate") // 주차장 수정 화면 이동
	public String parkingUpdate(Model model, @RequestParam("parking_code") Integer parking_code) {

		Parking parking = parkingService.findByParkingCode(parking_code);

		if (parking != null) {

			ParkingDTO parkingDTO = new ParkingDTO();
			parkingDTO.setParking_code(parking.getParking_code());
			parkingDTO.setParking_name(parking.getParking_name());
			parkingDTO.setParking_address(parking.getParking_address());
			parkingDTO.setParking_latitude(parking.getParking_latitude());
			parkingDTO.setParking_longitude(parking.getParking_longitude());
			parkingDTO.setParking_operation(parking.getParking_operation());
			parkingDTO.setParking_type(parking.getParking_type());
			parkingDTO.setParking_total_spaces(parking.getParking_total_spaces());
			parkingDTO.setParking_electriccar_check(parking.getParking_electriccar_check());
			parkingDTO.setParking_electriccar_spaces(parking.getParking_electriccar_spaces());
			parkingDTO.setParking_pay_type(parking.getParking_pay_type());
			parkingDTO.setParking_base_fee(parking.getParking_base_fee());
			parkingDTO.setParking_hourly_rate(parking.getParking_hourly_rate());
			// 주차장 사진 및 서류 이미지 추가 필요
			parkingDTO.setParking_approval(parking.getParking_approval());
			parkingDTO.setParking_registration(parking.getParking_registration());
			parkingDTO.setParking_edit(parkingDTO.getParking_edit());
			parkingDTO.setMember_code(parking.getMember().getMember_code());

			model.addAttribute("parkingDTO", parkingDTO);

		}

		logger.info("주차장 수정 화면 진입");
		return "./parking/parking_update_input";
	}

	@PostMapping("/ParkingUpdate") // 주차장 수정 처리
	public String parkingUpdate(ParkingDTO parkingDTO) {

		Parking parking = new Parking();
		parking.setParking_code(parkingDTO.getParking_code());
		parking.setParking_name(parkingDTO.getParking_name());
		parking.setParking_address(parkingDTO.getParking_address());
		parking.setParking_latitude(parkingDTO.getParking_latitude());
		parking.setParking_longitude(parkingDTO.getParking_longitude());
		parking.setParking_operation(parkingDTO.getParking_operation());
		parking.setParking_type(parkingDTO.getParking_type());
		parking.setParking_total_spaces(parkingDTO.getParking_total_spaces());
		parking.setParking_electriccar_check(parkingDTO.getParking_electriccar_check());
		parking.setParking_electriccar_spaces(parkingDTO.getParking_electriccar_spaces());
		parking.setParking_pay_type(parkingDTO.getParking_pay_type());
		parking.setParking_base_fee(parkingDTO.getParking_base_fee());
		parking.setParking_hourly_rate(parkingDTO.getParking_hourly_rate());
		// 주차장 사진 및 서류 이미지 추가 필요
		parking.setParking_approval(parkingDTO.getParking_approval());
		parking.setParking_registration(parkingDTO.getParking_registration());
		parking.setParking_edit(parkingDTO.getParking_edit());

		Member member = memberService.findMemberById(parkingDTO.getMember_code());
		parking.setMember(member);

		parkingService.saveParking(parking);

		return "./parking/parking_update";
	}

	@GetMapping("/ParkingDelete") // 주차장 삭제 화면 이동
	public String parkingDelete(Model model, @RequestParam("parking_code") Integer parking_code) {

		Parking parking = parkingService.findByParkingCode(parking_code);

		if (parking != null) {

			ParkingDTO parkingDTO = new ParkingDTO();
			parkingDTO.setParking_code(parking.getParking_code());
			parkingDTO.setParking_name(parking.getParking_name());
			parkingDTO.setParking_address(parking.getParking_address());
			parkingDTO.setParking_latitude(parking.getParking_latitude());
			parkingDTO.setParking_longitude(parking.getParking_longitude());
			parkingDTO.setParking_operation(parking.getParking_operation());
			parkingDTO.setParking_type(parking.getParking_type());
			parkingDTO.setParking_total_spaces(parking.getParking_total_spaces());
			parkingDTO.setParking_electriccar_check(parking.getParking_electriccar_check());
			parkingDTO.setParking_electriccar_spaces(parking.getParking_electriccar_spaces());
			parkingDTO.setParking_pay_type(parking.getParking_pay_type());
			parkingDTO.setParking_base_fee(parking.getParking_base_fee());
			parkingDTO.setParking_hourly_rate(parking.getParking_hourly_rate());
			// 주차장 사진 및 서류 이미지 추가 필요
			parkingDTO.setParking_approval(parking.getParking_approval());
			parkingDTO.setParking_registration(parking.getParking_registration());
			parkingDTO.setParking_edit(parkingDTO.getParking_edit());
			parkingDTO.setMember_code(parking.getMember().getMember_code());

			model.addAttribute("parkingDTO", parkingDTO);

		}

		logger.info("주차장 삭제 화면 진입");
		return "./parking/parking_delete_process";
	}

	@PostMapping("/ParkingDelete") // 주차장 삭제 처리
	public String parkingDelete(ParkingDTO parkingDTO) {

		Parking parking = new Parking();
		parking.setParking_code(parkingDTO.getParking_code());

		Member member = memberService.findMemberById(parkingDTO.getMember_code());
		parking.setMember(member);

		parkingService.deleteParking(parking.getParking_code());

		return "./parking/parking_delete";
	}

	@GetMapping("/ParkingApprove") // 주차장 승인 화면 이동
	public String parkingApprove(Model model, @RequestParam("parking_code") Integer parking_code) {

		Parking parking = parkingService.findByParkingCode(parking_code);

		if (parking != null) {

			ParkingDTO parkingDTO = new ParkingDTO();
			parkingDTO.setParking_code(parking.getParking_code());
			parkingDTO.setParking_name(parking.getParking_name());
			parkingDTO.setParking_address(parking.getParking_address());
			parkingDTO.setParking_latitude(parking.getParking_latitude());
			parkingDTO.setParking_longitude(parking.getParking_longitude());
			parkingDTO.setParking_operation(parking.getParking_operation());
			parkingDTO.setParking_type(parking.getParking_type());
			parkingDTO.setParking_total_spaces(parking.getParking_total_spaces());
			parkingDTO.setParking_electriccar_check(parking.getParking_electriccar_check());
			parkingDTO.setParking_electriccar_spaces(parking.getParking_electriccar_spaces());
			parkingDTO.setParking_pay_type(parking.getParking_pay_type());
			parkingDTO.setParking_base_fee(parking.getParking_base_fee());
			parkingDTO.setParking_hourly_rate(parking.getParking_hourly_rate());
			// 주차장 사진 및 서류 이미지 추가 필요
			parkingDTO.setParking_approval(parking.getParking_approval());
			parkingDTO.setParking_registration(parking.getParking_registration());
			parkingDTO.setParking_edit(parkingDTO.getParking_edit());
			parkingDTO.setMember_code(parking.getMember().getMember_code());

			model.addAttribute("parkingDTO", parkingDTO);

		}

		logger.info("주차장 승인 화면 진입");
		return "./parking/parking_approve_process";
	}

	@PostMapping("/ParkingApprove") // 주차장 승인 처리
	public String parkingApprove(ParkingDTO parkingDTO) {

		Parking parking = new Parking();
		parking.setParking_code(parkingDTO.getParking_code());
		parking.setParking_name(parkingDTO.getParking_name());
		parking.setParking_address(parkingDTO.getParking_address());
		parking.setParking_latitude(parkingDTO.getParking_latitude());
		parking.setParking_longitude(parkingDTO.getParking_longitude());
		parking.setParking_operation(parkingDTO.getParking_operation());
		parking.setParking_type(parkingDTO.getParking_type());
		parking.setParking_total_spaces(parkingDTO.getParking_total_spaces());
		parking.setParking_electriccar_check(parkingDTO.getParking_electriccar_check());
		parking.setParking_electriccar_spaces(parkingDTO.getParking_electriccar_spaces());
		parking.setParking_pay_type(parkingDTO.getParking_pay_type());
		parking.setParking_base_fee(parkingDTO.getParking_base_fee());
		parking.setParking_hourly_rate(parkingDTO.getParking_hourly_rate());
		// 주차장 사진 및 서류 이미지 추가 필요
		parking.setParking_approval(parkingDTO.getParking_approval());
		parking.setParking_registration(parkingDTO.getParking_registration());
		parking.setParking_edit(parkingDTO.getParking_edit());

		Member member = memberService.findMemberById(parkingDTO.getMember_code());
		parking.setMember(member);

		parkingService.saveParking(parking);

		return "./parking/parking_approve";
	}

}

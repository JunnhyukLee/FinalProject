package parking.car.project.parking.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import jakarta.inject.Inject;
import parking.car.project.parking.entity.Parking;
import parking.car.project.parking.repository.ParkingRepository;

@Service
public class ParkingService {

	@Inject
	private ParkingRepository parkingRepository;

	// 회원 member_code로 등록된 주차장 전체 이력 확인
	// parkingSelectAll -> select parking_code, parking_name, parking_approval from
	// parking where member_code = ?
	@Transactional(readOnly = true)
	public List<Parking> findByMemberCode(Integer member_code) {
		return parkingRepository.findByMemberCode(member_code);
	}

	// 주차장 전체 목록 조회
	// parkingSelectAdmin -> select parking_code, parking_name, parking_approval
	// from parking
	@Transactional(readOnly = true)
	public List<Parking> findAllParking() {
		return parkingRepository.findAll();
	}

	// 특정 parking_code로 주차장 상세 정보 조회
	// parkingSelectDetail -> select parking_name, parking_address,
	// parking_latitude, parking_longitude, parking_operation,
	// parking_type, parking_total_spaces, parking_electriccar_check,
	// parking_electriccar_spaces, parking_pay_type, parking_base_fee,
	// parking_hourly_rate,
	// parking_approval, to_char(parking_registration, 'YYYY\"년\" MM\"월\" DD\"일\"')
	// parking_registration,
	// to_char(parking_edit, 'YYYY\"년\" MM\"월\" DD\"일\"') parking_edit from parking
	// where parking_code = ?
	@Transactional(readOnly = true)
	public Parking findByParkingCode(Integer parking_code) {
		return parkingRepository.findById(parking_code).orElse(null);
	}

	// insert, update 시 데이터 저장 메서드
	// insert 시에는 등록/수정 일시 둘다 저장되나 update 시에는 수정일시만 변경 필요!! > 만약 구현 안될 경우 마이바티스로 구현
	// 필요 > 뷰에서 전달할 때 등록/수정일시를 히든으로 넣어서 특정 값만 들어가도록 해보자!!
	// parkingInsert -> insert into parking (parking_code, parking_name,
	// parking_address, parking_latitude, parking_longitude, parking_operation,
	// parking_type, parking_total_spaces, parking_electriccar_check,
	// parking_electriccar_spaces, parking_pay_type, parking_base_fee,
	// parking_hourly_rate,
	// parking_photo1_name, parking_photo1_path, parking_photo2_name,
	// parking_photo2_path, parking_photo3_name, parking_photo3_path,
	// parking_photo4_name, parking_photo4_path,
	// parking_photo5_name, parking_photo5_path, parking_document_name,
	// parking_document_path, parking_registration, parking_edit, member_code)
	// parking_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
	// ?, ?, ?, ?, ?, sysdate, sysdate, ?)

	// parkingUpdate -> update parking set parking_name = ?, parking_address = ?,
	// parking_latitude = ?, parking_longitude = ?, parking_operation = ?,
	// parking_type = ?, parking_total_spaces = ?, parking_electriccar_check = ?,
	// parking_electriccar_spaces = ?,
	// parking_pay_type = ?, parking_base_fee = ?, parking_hourly_rate = ?,
	// parking_edit = sysdate where parking_code = ?

	// parkingApprove -> update parking set parking_approval = ?, parking_edit =
	// sysdate where parking_code = ?
	@Transactional
	public Parking saveParking(Parking parking) {
		return parkingRepository.save(parking);
	}

	// parkingDelete -> DELETE FROM parking WHERE parking_code = ?
	@Transactional
	public void deleteParking(Integer parking_code) {
		// parking 데이터 삭제 시 records 테이블에 자식 레코드가 있는 경우 Records에 parking_code 값을 null로
		// 만드는 코드
		parkingRepository.nullParkingCodeInRecords(parking_code);
		// 특정 parking 데이터 삭제 코드
		parkingRepository.deleteById(parking_code);
	}

	// 입력된 parking_code의 값이 DB에 존재하는지 확인하는 메서드
	public boolean existsByParking_code(Integer parking_code) {
		return parkingRepository.existsById(parking_code);
	}

	// 주차장 이미지 업로드 코드
	private static final String BASE_DIRECTORY = "./src/main/webapp/resources/Parking/";

	public String[] fileUpload(MultipartFile file, int member_code) throws IllegalStateException, IOException {

		// 회원 코드번호가 기재된 폴더 생성
		File member_directory = new File(BASE_DIRECTORY + member_code);
		if (!member_directory.exists()) {
			member_directory.mkdirs();
		}

		// 원본 파일 이름 가져오기
		String originalFileName = file.getOriginalFilename();
		if (originalFileName == null) {
			throw new IllegalStateException("파일 이름을 가져올 수 없습니다.");
		}

		// 파일 저장 경로 생성
		String filePath = member_directory.getAbsolutePath() + File.separator + originalFileName;
		File dest = new File(filePath);

		// 파일 이름이 중복될 경우 UUID를 추가하여 새로운 파일 이름 생성
		String savedFileName = originalFileName;
		
		if (dest.exists()) {
			savedFileName = UUID.randomUUID().toString() + "_" + originalFileName;
			filePath = member_directory.getAbsolutePath() + File.separator + savedFileName;
			dest = new File(filePath);
		}

		// 파일 저장
		file.transferTo(dest);

		// 저장된 파일의 상대 경로 반환
		return new String[] {"/Parking/" + member_code + "/" + savedFileName, savedFileName};

	}

}
package parking.car.project.coupon.fildupload;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileUpDownDTO {
	private String name;
	private String subject;
	
	private MultipartFile file;
}
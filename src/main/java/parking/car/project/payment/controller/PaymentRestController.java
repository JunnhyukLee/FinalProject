package parking.car.project.payment.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.inject.Inject;
import lombok.RequiredArgsConstructor;
import parking.car.project.payment.dto.PaymentDTO;
import parking.car.project.payment.entity.Payment;
import parking.car.project.payment.service.PaymentService;

//빈으로 컨트롤러 스캔을 구성하고 컨트롤러를 구현한다.
@Controller
//final 필드의 파라미터 생성자를 자동으로 생성한다.
@RequiredArgsConstructor
public class PaymentRestController {
	private static final Logger logger = LogManager.getLogger(PaymentRestController.class);

// 의존관계를 자동으로 설정
	@Inject
	private final PaymentService paymentService;
	
//모든 결제 목록을 조회한다.
	@GetMapping("/PaymentSelect")
	public String list(Model model) {
		
		//모든 결제 목록을 모델에 추가한다.
		model.addAttribute("list", paymentService.findAllPayments());
		logger.info("list",  model);
		return "payment/payment_select_view";
	}
	
	
	@GetMapping("/PaymentSelectDetail")
	public String detail(Model model, @RequestParam("payment_code") int payment_code) {
		
		//특정 결제 상세 정보를 모델에 추가한다.
		model.addAttribute("paymentDTO", paymentService.findPaymentById(payment_code));
	return "payment/payment_select_detail_view";
	}
	
	//결제를 추가하는 페이지를 표시한다.
	@GetMapping("/PaymentInsert")
	public String insert() {
		return "payment/payment_insert";
	}
	
	@PostMapping("/PaymentInsert")
    @ResponseBody
    public ResponseEntity<String> savePayment(@RequestBody PaymentDTO paymentDTO) {
        try {
            Payment payment = new Payment();
            payment.setPayment_code(paymentDTO.getPayment_code());
            payment.setPayment_name(paymentDTO.getPayment_name());
            payment.setPayment_total(paymentDTO.getPayment_total());

            // 결제 성공 여부에 따라 상태 설정
            if (paymentDTO.getPayment_status().equals("결제완료")) {
                payment.setPayment_status("결제완료");
            } else {
                payment.setPayment_status("결제실패");
            }

            payment.setParking_code(paymentDTO.getParking_code());
            
            payment.setCalculate_code(paymentDTO.getCalculate_code());
            

            paymentService.savePayment(payment);

            return new ResponseEntity<>("Payment saved successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error saving payment: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	//결제 정보를 수정하는 페이지를 표시한다.
	
	
	//결제 정보를 수정한다.
	@PostMapping("/PaymentUpdate")
	public String update(PaymentDTO paymentDTO) {
		Payment payment = new Payment();
		payment.setPayment_code(paymentDTO.getPayment_code());
		payment.setPayment_name(paymentDTO.getPayment_name());
		payment.setPayment_total(paymentDTO.getPayment_total());
		payment.setParking_code(paymentDTO.getParking_code());
		
		payment.setCalculate_code(paymentDTO.getCalculate_code());
		
		paymentService.savePayment(payment);
		return "payment/payment_update_view";
	}
	
	//결제 삭제 페이지를 표시한다.
	@GetMapping("/PaymentDelete")
	public String delete() {
		return "payment/payment_delete";
	}
	
	//결제 정보를 삭제한다.
	@PostMapping("/PaymentDelete")
	public String delete(@RequestParam("payment_code") int payment_code) {
		
		//특정 결제정보를 삭제한다.
		paymentService.deletePaymentById(payment_code);
		return "payment/payment_delete_view";
	}	
}
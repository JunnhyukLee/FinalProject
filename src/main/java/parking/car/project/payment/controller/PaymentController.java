package parking.car.project.payment.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import parking.car.project.payment.entity.Payment;
import parking.car.project.payment.service.PaymentService;
@Controller
public class PaymentController {
	
    @Autowired
    private PaymentService paymentService;
	
    
	 @GetMapping("/payment")
	public String selectAllView() {

	 return "payment/payment_insert";
 }
	    @GetMapping("/paymentAll")
	    public String getAllPayments(Model model) {
	        List<Payment> payments = paymentService.findAllPayments();
	        model.addAttribute("payments", payments);
	        return "payment/payment_select_view"; // payment_web_select.jsp 뷰를 렌더링합니다.
	    }	 
}
//package parking.car.project.payment.controller;
//
//import java.util.List;
//import java.util.Optional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.PutMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import parking.car.project.payment.entity.Payment;
//import parking.car.project.payment.service.PaymentServiceCopy;
//
//@RestController
//@RequestMapping("/api/payments")
//public class PaymentRestControllerCopy {
//
//    @Autowired
//    private PaymentServiceCopy paymentService;
//
//    @PostMapping("/save")
//    public String savePayment(@RequestBody Payment payment) {
//        paymentService.savePayment(payment);
//        return "결제가 성공적으로 저장되었습니다.";
//    }
//    
//    @GetMapping("/all")
//    public List<Payment> getAllPayments() {
//        return paymentService.getAllPayments();
//    }
//    
//    @GetMapping("/{paymentCode}")
//    public Optional<Payment> getPaymentByCode(@PathVariable String payment_code) {
//        return paymentService.getPaymentByCode(payment_code);
//    }
//    
//    @PutMapping("/update")
//    public String updatePayment(@RequestBody Payment payment) {
//        paymentService.updatePayment(payment);
//        return "결제가 성공적으로 업데이트되었습니다.";
//    }
//
//    @DeleteMapping("/delete/{paymentCode}")
//    public String deletePayment(@PathVariable String payment_code) {
//        paymentService.deletePayment(payment_code);
//        return "결제가 성공적으로 삭제되었습니다.";
//    }
//}
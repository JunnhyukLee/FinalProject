//package parking.car.project.payment.service;
//
//import java.util.List;
//import java.util.Optional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import parking.car.project.payment.entity.Payment;
//import parking.car.project.payment.repository.PaymentRepository;
//
//@Service
//public class PaymentServiceCopy {
//    @Autowired
//    private PaymentRepository paymentRepository;
//
//    public void savePayment(Payment payment) {
//        paymentRepository.save(payment);
//    }
//
//    public List<Payment> getAllPayments() {
//        return paymentRepository.findAll();
//    }
//    
//    public Optional<Payment> getPaymentByCode(String payment_code) {
//        return paymentRepository.findById(payment_code);
//    }
//
//    public void updatePayment(Payment payment) {
//        Optional<Payment> existingPayment = paymentRepository.findById(payment.getPayment_code());
//        if (existingPayment.isPresent()) {
//            Payment updatedPayment = existingPayment.get();
//            updatedPayment.setPayment_name(payment.getPayment_name());
//            updatedPayment.setPayment_total(payment.getPayment_total());
//            paymentRepository.save(updatedPayment);
//        } else {
//            throw new IllegalArgumentException("결제 정보를 찾을 수 없습니다.");
//        }
//    }
//
//    public void deletePayment(String payment_code) {
//        paymentRepository.deleteById(payment_code);
//    }
//}
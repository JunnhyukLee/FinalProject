package parking.car.project.payment.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.payment.entity.Payment;
import parking.car.project.payment.repository.PaymentRepository;

@Service
public class PaymentService {
	

	@Inject
	private PaymentRepository paymentRepository;
	
//메서드 실행 시 트랜잭션이 시작되고 정상적으로 종료되면 트랜잭션이 커밋된다.
	@Transactional
	public Payment savePayment(Payment payment) {
//Payment 엔티티를 저장하고 저장된 엔티티를 반환한다.
		return paymentRepository.save(payment);
	}
	
//읽기 전용 트랜잭션으로 데이터 변경 작업을 허용하지 않으며 성능 최적화에 도움이 된다.
	@Transactional(readOnly = true)
	public List<Payment> findAllPayments() {
		
		return paymentRepository.findAll();
	}
	
	@Transactional(readOnly = true)
	public Payment findPaymentById(int payment_code) {
		// ID로 Payment 엔티티를 조회하고 존재하지 않으면 null을 반환한다.
		return paymentRepository.findById(payment_code).orElse(null);
	}
	
	@Transactional
	public void deletePaymentById(int payment_code) {
		// ID로 Payment 엔티티를 삭제한다.
		paymentRepository.deleteById(payment_code);
	}
	
	public boolean existsByPayment_code(int payment_code) {
		// ID로 Payment 엔티티의 존재 여부를 확인하고, 결과를 반환한다.
		return paymentRepository.existsById(payment_code);
	}
}
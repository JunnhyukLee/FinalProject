package parking.car.project.payment.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import parking.car.project.payment.entity.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Integer>{

}
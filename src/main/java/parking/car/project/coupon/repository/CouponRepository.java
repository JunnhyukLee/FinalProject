package parking.car.project.coupon.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import parking.car.project.coupon.entity.Coupon;

public interface CouponRepository extends JpaRepository<Coupon, Integer> {

}
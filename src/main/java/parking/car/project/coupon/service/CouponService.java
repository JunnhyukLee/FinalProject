package parking.car.project.coupon.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.coupon.entity.Coupon;
import parking.car.project.coupon.repository.CouponRepository;

@Service
public class CouponService {

	@Inject
	private CouponRepository couponRepository;

	// 메서드 실행 시 트랜잭션이 시작되고 정상적으로 종료되면 트랜잭션이 커밋된다.
	@Transactional
	public Coupon saveCoupon(Coupon coupon) {
		// 현재 날짜로 시작 날짜 설정
		LocalDateTime startDate = LocalDateTime.now();
		coupon.setCoupon_start(startDate);

		// 시작 날짜로부터 30일 후 날짜 계산하여 종료 날짜 설정
		LocalDateTime endDate = startDate.plusDays(30);
		coupon.setCoupon_end(endDate);

		// Coupon 엔티티를 저장하고 저장된 엔티티를 반환한다.
		return couponRepository.save(coupon);
	}

	// 읽기 전용 트랜잭션으로 데이터 변경 작업을 허용하지 않으며 성능 최적화에 도움이 된다.
	@Transactional(readOnly = true)
	public List<Coupon> findAllCoupons() {

		return couponRepository.findAll();
	}

	@Transactional(readOnly = true)
	public Coupon findCouponById(Integer coupon_code) {
		// ID로 Coupon 엔티티를 조회하고 존재하지 않으면 null을 반환한다.
		return couponRepository.findById(coupon_code).orElse(null);
	}

	@Transactional
	public void deleteCouponById(Integer coupon_code) {
		// ID로 Coupon 엔티티를 삭제한다.
		couponRepository.deleteById(coupon_code);
	}

	public Boolean existsByCoupon_code(Integer coupon_code) {
		// ID로 Coupon 엔티티의 존재 여부를 확인하고, 결과를 반환한다.
		return couponRepository.existsById(coupon_code);
	}
}
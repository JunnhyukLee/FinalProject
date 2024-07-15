package parking.car.project.coupon.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.inject.Inject;
import lombok.RequiredArgsConstructor;
import parking.car.project.coupon.dto.CouponDTO;
import parking.car.project.coupon.entity.Coupon;
import parking.car.project.coupon.service.CouponService;

//빈으로 컨트롤러 스캔을 구성하고 컨트롤러를 구현한다.
@Controller
//final 필드의 파라미터 생성자를 자동으로 생성한다.
@RequiredArgsConstructor
public class CouponController {
	private static final Logger logger = LogManager.getLogger(CouponController.class);
	
	// 의존관계를 자동으로 설정
		@Inject
		private final CouponService couponService;	
		
	// 모든 쿠폰 목록을 조회한다.
		@GetMapping("/CouponSelect")
		public String list(Model model) {
			
			//모든 쿠폰 목록을 모델에 추가한다.
			model.addAttribute("list", couponService.findAllCoupons());
			return "coupon/coupon_select_view";
		}
		
		@GetMapping("/CouponSelectDetail")
		public String detail(Model model, @RequestParam("coupon_code") Integer coupon_code) {
			
			//특정 쿠폰 상제 정보를 모델에 추가한다.
			model.addAttribute("couponDTO", couponService.findCouponById(coupon_code));
			return "coupon/coupon_select_detail_view";
		}
		
		//쿠폰을 추가하는 페이지를 표시한다.
		@GetMapping("/CouponInsert")
		public String insert() {
			return "coupon/coupon_insert";
		}
		
		//쿠폰을 추가한다.
		@PostMapping("/CouponInsert")
		public String insert(Model model, CouponDTO couponDTO) {
			
			//CouponDTO를 Coupon 엔티티로 변환한다.
			Coupon coupon = new Coupon();
			coupon.setCoupon_type(couponDTO.getCoupon_type());
			coupon.setCoupon_name(couponDTO.getCoupon_name());
			coupon.setCoupon_price(couponDTO.getCoupon_price());
			coupon.setCoupon_use(couponDTO.getCoupon_use());
			coupon.setParking_code(couponDTO.getParking_code());
			
			//모든 쿠폰 목록을 모델에 추가한다.
			model.addAttribute("list", couponService.findAllCoupons());
			
			//쿠폰 정보를 저장한다.
			couponService.saveCoupon(coupon);
			return "coupon/coupon_insert_view";
		}
		
		//쿠폰 정보를 수정하는 페이지를 표시한다.
		@GetMapping("/CouponUpdate")
		public String update(Model model, @RequestParam("coupon_code") Integer coupon_code) {
			if (coupon_code != null) {
				
				//Coupon 엔티티를 CouponDTO로 변환하여 모델에 추가한다.
				CouponDTO couponDTO = new CouponDTO();
				couponDTO.setCoupon_type(couponDTO.getCoupon_type());
				couponDTO.setCoupon_name(couponDTO.getCoupon_name());
				couponDTO.setCoupon_price(couponDTO.getCoupon_price());
				couponDTO.setCoupon_use(couponDTO.getCoupon_use());
				couponDTO.setParking_code(couponDTO.getParking_code());
				model.addAttribute("couponDTO", couponDTO);
			}
			return "coupon/coupon_update";
		}
		
		//쿠폰 정보를 수정한다.
		@PostMapping("/CouponUpdate")
		public String update(CouponDTO couponDTO) {
			Coupon coupon = new Coupon();
			coupon.setCoupon_type(couponDTO.getCoupon_type());
			coupon.setCoupon_name(couponDTO.getCoupon_name());
			coupon.setCoupon_price(couponDTO.getCoupon_price());
			coupon.setCoupon_use(couponDTO.getCoupon_use());
			coupon.setParking_code(couponDTO.getParking_code());
			
			couponService.saveCoupon(coupon);
			return "coupon/coupon_update_view";
		}
		
		//쿠폰 삭제 페이지를 표지한다.
		@GetMapping("/CouponDelete")
		public String delete() {
			return "coupon/coupon_delete";
		}
		
		//쿠폰 정보를 삭제한다.
		@PostMapping("/CouponDelete")
		public String delete(@RequestParam("coupon_code") Integer coupon_code) {
			
			//특정 쿠폰정보를 삭제한다.
			couponService.deleteCouponById(coupon_code);
			return "coupon/coupon_delete_view";
		}
		
		//@RestController 에서는 <a> 태그로 매핑명에 접근할 수 없으므로 @Controller 어노테이션에서 설정한다.
		/*
		 * @GetMapping("CouponSelectView") public String selectAllView() {
		 * return "./coupon/coupon.ajax";
		 * } */
}
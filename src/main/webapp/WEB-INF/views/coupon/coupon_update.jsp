<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쿠폰 정보 수정</title>
<link rel="stylesheet" type="text/css"
	href="./css/bootstrap.min_4.5.0.css">
<link rel="stylesheet" type="text/css" href="./css/global.css">
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<script src="./js/jquery.validate.min.js" type="text/javascript"></script>
<script src="./js/dept_validity.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
    $("#sign_coupon").submit(function() {
        var couponCode = $("#coupon_code").val();
        if (!couponCode || isNaN(couponCode) || couponCode < 1 || couponCode > 1000) {
            alert("쿠폰 코드 번호를 1에서 1000 사이의 숫자로 입력하세요.");
            $("#coupon_code").focus();
            return false;
        }
        
        var couponType = $("#coupon_type").val();
        if (couponType === "----- 선택하세요 -----") {
            alert("쿠폰 종류를 선택하세요.");
            $("#coupon_type").focus();
            return false;
        }
        
        var couponName = $("#coupon_name").val();
        if (couponName === "----- 선택하세요 -----") {
            alert("쿠폰 이름을 선택하세요.");
            $("#coupon_name").focus();
            return false;
        }
        
        var couponPrice = $("#coupon_price").val();
        if (!couponPrice || isNaN(couponPrice)) {
            alert("쿠폰 금액을 숫자로 입력하세요.");
            $("#coupon_price").focus();
            return false;
        }
        
        var couponUse = $("input[name='coupon_use']:checked").val();
        if (!couponUse) {
            alert("쿠폰 사용 여부를 선택하세요.");
            return false;
        }
        
        return true;
    });
});

</script>
</head>
<body>
	<header id="main-header" class="py-2 btn-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>쿠폰 정보 수정</h1>
				</div>
			</div>
		</div>
	</header>
	<section class="py-4 mb-4 bg-light"></section>
	<section id="coupon">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h5>쿠폰 수정</h5>
						</div>
						<div class="card-body"></div>
						<form action="./CouponUpdate" method="post" id="sign_coupon">
							<fieldset>
								<div class="form-group row">
									<label for="coupon_code" class="ml-sm-3 col-form-label">
										쿠폰 코드 번호 </label>
									<div class="ml-sm-3">
										<input type="text" name="coupon_code" id="coupon_code"
											class="form-control form-control-sm bg-white"
											value="${param.coupon_code}" readonly>
									</div>
								</div>
								<div class="form-group row">
									<label for="coupon_type" class="ml-sm-3 col-form-label">
										쿠폰 종류 </label>
									<div class="ml-sm-3">
										<select name="coupon_type" id="coupon_type"
											class="form-control form-control-sm">
											<option>----- 선택하세요 -----</option>
											<option value="2시간할인"
												${couponDTO.coupon_type == '2시간할인' ? 'selected' : ''}>
												2시간할인권</option>
											<option value="종일"
												${couponDTO.coupon_type == '종일' ? 'selected' : ''}>종일권
											</option>
										</select>
									</div>
								</div>
								<div class="form-group row">
									<label for="coupon_name" class="ml-sm-3 col-form-label">
										쿠폰 이름 </label>
									<div class="ml-sm-3">
										<select name="coupon_name" id="coupon_name"
											class="form-control form-control-sm">
											<option>----- 선택하세요 -----</option>
											<option value="할인권"
												${couponDTO.coupon_name == '할인권' ? 'selected' : ''}>할인권</option>
											<option value="종일권"
												${couponDTO.coupon_name == '종일권' ? 'selected' : ''}>종일권</option>
										</select>
									</div>
								</div>
								<div class="form-group row">
									<label for="coupon_price" class="ml-sm-3 col-form-label">
										쿠폰 금액 </label>
									<div class="ml-sm-3">
										<input type="text" name="coupon_price" id="coupon_price"
											class="form-control form-control-sm"
											value="${couponDTO.coupon_price}">
									</div>
								</div>
								<label for="coupon_price" class="ml-sm-3 col-form-label">
									사용 여부 </label>
								<div class="ml-sm-3">
									<input type="radio" name="coupon_use" id="coupon_use_available"
										value="사용가능"
										${couponDTO.coupon_use == '사용가능' ? 'checked' : ''}>
									사용가능 <input type="radio" name="coupon_use" id="coupon_use_used"
										value="사용불가능"
										${couponDTO.coupon_use == '사용불가능' ? 'checked' : ''}>
									이미사용된쿠폰
								</div>

								<div class="form-group row">
									<label for="parking_code" class="ml-sm-3 col-form-label">
										주차장 코드 </label>
									<div class="ml-sm-3">
										<input type="text" name="parking_code" id="parking_code"
											class="form-control form-control-sm"
											value="${couponDTO.parking_code}">
									</div>
								</div>

								<button type="submit" class="btn btn-secondary">등록</button>
								<button type="reset" class="btn btn-secondary">취소</button>
							</fieldset>
						</form>

						<a href="./CouponSelect" class="btn btn-danger btn-block"> 쿠폰
							목록 </a> <a href="./CouponDelete?coupon_code=${param.coupon_code}"
							class="btn btn-danger btn-block"> 쿠폰 목록 삭제 </a>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
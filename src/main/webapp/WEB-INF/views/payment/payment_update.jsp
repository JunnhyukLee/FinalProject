<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 정보 수정</title>
<link rel="stylesheet" type="text/css"
	href="./css/bootstrap.min_4.5.0.css">
<link rel="stylesheet" type="text/css" href="./css/global.css">
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<script src="./js/jquery.validate.min.js" type="text/javascript"></script>
<script src="./js/dept_validity.js" type="text/javascript"></script>
</head>
<body>
	<header id="main-header" class="py-2 btn-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>결제 정보 수정</h1>
				</div>
			</div>
		</div>
	</header>
	<section class="py-4 mb-4 bg-light"></section>
	<section id="payment">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header"></div>
						<div class="card-body">
							<form action="./PaymentUpdate" method="post" id="sign_payment">
								<fieldset>
									<div class="form-group row">
										<label for="payment_code"> 결제 고유 번호 </label>
										<div class="ml-sm-3">
											<input type="text" name="payment_code" id="payment_code"
												class="form-control form-control-sm"
												value="${param.payment_code}" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="payment_name"> 결제 이름 </label>
										<div class="ml-sm-3">
											<select name="payment_name" id="payment_name"
												class="form-control form-control-sm">
												<option value="종일권"
													${paymentDTO.payment_name == '종일권' ? 'selected' : ''}>종일권</option>
												<option value="할인권"
													${paymentDTO.payment_name == '할인권' ? 'selected' : ''}>할인권</option>
											</select>
										</div>
									</div>
									<div class="form-group row">
										<label for="payment_card_company"> 결제금액 </label>
										<div class="ml-sm-3">
											<input type="text" name="payment_total" id="payment_total"
												class="form-control form-control-sm"
												value="${paymentDTO.payment_total}">
										</div>
									</div>
									<div class="form-group row">
										<label for="parking_code"> 주차장 코드 </label>
										<div class="ml-sm-3">
											<input type="text" name="parking_code" id="parking_code"
												class="form-control form-control-sm"
												value="${paymentDTO.parking_code}">
										</div>
									</div>
									<div class="form-group row">
										<label for="ticket_code"> 티켓 코드 </label>
										<div class="ml-sm-3">
											<input type="text" name="ticket_code" id="ticket_code"
												class="form-control form-control-sm"
												value="${paymentDTO.ticket_code}">
										</div>
									</div>
									<div class="form-group row">
										<label for="coupon_code"> 쿠폰 코드 </label>
										<div class="ml-sm-3">
											<input type="text" name="coupon_code" id="coupon_code"
												class="form-control form-control-sm"
												value="${paymentDTO.coupon_code}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_code"> 회원 코드 </label>
										<div class="ml-sm-3">
											<input type="text" name="member_code" id="member_code"
												class="form-control form-control-sm"
												value="${paymentDTO.member_code}">
										</div>
									</div>
									<div class="form-group">
										<button type="submit" class="btn btn-secondary">등록</button>
										<button type="reset" class="btn btn-secondary">취소</button>
									</div>
								</fieldset>
							</form>
							<div class="col-md-4">
								<a href="./PaymentSelect" class="btn btn-danger btn-block">
									결제 내역 </a> <a
									href="./PaymentDeleteView?payment_code=${param.payment_code}"
									class="btn btn-danger btn-block"> 결제 내역 삭제 </a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
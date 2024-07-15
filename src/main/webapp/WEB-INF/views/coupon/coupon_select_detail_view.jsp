<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세 쿠폰 정보</title>
<link rel="stylesheet" type="text/css"
	href="./css/bootstrap.min_4.5.0.css">
<link rel="stylesheet" type="text/css" href="./css/global.css">
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
</head>
<body>
	<header id="main-header" class="py-2 btn-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>상세 쿠폰 정보</h1>
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
							<h5>상세 쿠폰 정보</h5>
						</div>
						<div class="card-body">
							<table class="table table-hover">
								<thead class="thead-light">
									<tr class="text-center">
										<th>쿠폰 코드번호</th>
										<th>쿠폰 종류</th>
										<th>쿠폰 이름</th>
										<th>유효 기간 (시작일)</th>
										<th>유효 기간 (종료일)</th>
										<th>가격</th>
										<th>사용여부</th>
										<th>주차장 코드</th>
									</tr>
								</thead>
								<tbody>
									<tr class="text-center">
										<td>${couponDTO.coupon_code}</td>
										<td>${couponDTO.coupon_type}</td>
										<td>${couponDTO.coupon_name}</td>
										<td>${couponDTO.coupon_start}</td>
										<td>${couponDTO.coupon_end}</td>
										<td>${couponDTO.coupon_price}</td>
										<td>${couponDTO.coupon_use}</td>
										<td>${couponDTO.parking_code}</td>
									</tr>
								</tbody>
							</table>
							<div class="row">
								<div class="col-md-4">
									<a href="./CouponSelect" class="btn btn-primary btn-block">
										쿠폰 목록 </a>
								</div>
								<div class="col-md-4">
									<a href="./CouponUpdate?coupon_code=${couponDTO.coupon_code}"
										class="btn btn-warning btn-block"> 쿠폰 수정 </a>
								</div>
								<div class="col-md-4">
									<a href="./CouponDelete?coupon_code=${couponDTO.coupon_code}"
										class="btn btn-danger btn-block"> 쿠폰 삭제 </a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
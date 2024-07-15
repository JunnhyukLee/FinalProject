<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쿠폰 정보 삭제</title>
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
					<h1>쿠폰 정보 삭제</h1>
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
							<h5>쿠폰 정보 삭제</h5>
						</div>
						<form action="./CouponDelete" method="post" id="delete_coupon">
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
								<div class="form-group">
									<button type="submit">삭제</button>
									<button type="reset">취소</button>
								</div>
							</fieldset>
						</form>
						<div class="row">
							<div class="col-md-4">
								<a href="./CouponSelect" class="btn btn-primary btn-block">
									쿠폰 정보 목록 </a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
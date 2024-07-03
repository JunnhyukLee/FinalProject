<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 정보 관리</title>
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
					<h1>결제 정보 관리</h1>
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
						<div class="card-header">
							<h5>결제 정보 목록</h5>
							</div>
							<div class="card-body">
							<table class="table table-hover"> <thead class="thead-light"> <tr class="text-center">
									<tr>
										<th>결제 고유 번호</th>
										<th>결제 이름</th>
										<th>결제금액</th>
										<th>주차장 코드</th>
                                        <th>티켓 코드</th>
                                        <th>쿠폰 코드</th>
                                        <th>회원 코드</th>
										<th></th>
									</tr>
								</thead>
								<c:forEach var="list" items="${list}">
									<tr class="text-center">
										<td>${list.payment_code}</td>
										<td>${list.payment_name}</td>
										<td>${list.payment_total}</td>
										<td>${list.parking_code}</td>
                                        <td>${list.ticket_code}</td>
                                        <td>${list.coupon_code}</td>
                                        <td>${list.member_code}</td>
										<td><a
											href="./PaymentSelectDetail?payment_code=${list.payment_code}" class="btn btn-outline-info">
												결제 상세 보기 </a></td>
									</tr>
								</c:forEach>
								<c:if test="${empty list}">
									<tr>
										<td colspan="4">등록된 결제가 없습니다.</td>
									</tr>
								</c:if>
							</table>
							<a href="./PaymentInsert" class="btn btn-success btn-block"> 결제 정보 입력 </a>
							</div> </div> </div> </div> </div></section>
</body>
</html>
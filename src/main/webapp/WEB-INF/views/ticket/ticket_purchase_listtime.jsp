<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>정기권</title>
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
					<h1>정기권</h1>
				</div>
				<div class="col-md-6 text-right">
					<a href="./TicketListDays" class="btn btn-primary mr-2">월권
						보기</a> <a href="./TickstListTime" class="btn btn-success">시간권
						보기</a> <a href="./Mainpage.jh" class="navbar-brand">홈</a>
				</div>
			</div>
		</div>
	</header>
	<section class="py-4 mb-4 bg-light"></section>
	<section id="department">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h5>정기권 목록</h5>
						</div>
						<div class="card-body">
							<table class="table table-hover">
								<thead class="thead-light">
									<tr class="text-center">
										<th></th>
										<th>정기권 이름</th>
										<th>정기권 종류</th>
										<th>적용 기간(시간)</th>
										<th>가격</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="list" items="${TicketListTime}">
										<tr class="text-center">
											<td><input type="radio" name="ticketIds"
												value="${list.ticket_code}"></td>
											<td>${list.ticket_name}</td>
											<td>${list.ticket_type}</td>
											<td>${list.ticket_time}</td>
											<td>${list.ticket_price}</td>
										</tr>
									</c:forEach>

									
								</tbody>
							</table>
							<div>
								<a href="./TicketInsertView.hk"
									class="btn btn-success btn-block"> 구매하기 </a>
								<!-- 미구현 -->
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>

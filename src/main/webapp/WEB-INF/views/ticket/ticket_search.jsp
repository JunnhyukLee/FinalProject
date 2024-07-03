
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
	<nav class="navbar navbar-expand-md bg-dark navbar-dark text-white">
		<div class="container">
			<div class="col-md-6">
				<h1>
					<i class="fas fa-users"></i> 정기권 관리(관리자)
				</h1>
			</div>
			<div id="toggle" class="navbar-collapse collapse">
				<ul class="navbar-nav">
				</ul>
				<ul class="navbar-nav py-2 mb-2 pl-3 pr-3">
					<li><a href="./Mainpage.jh" class="navbar-brand"> <i
							class="fa fa-home"></i>홈
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
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
										<th>정기권 코드</th>
										<th>정기권 이름</th>
										<th>정기권 종류</th>
										<th>적용 기간(일)</th>
										<th>적용 기간(시간)</th>
										<th>가격</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="list" items="${TicketList}">
										<tr class="text-center">
											<td>${list.ticket_code}</td>
											<td>${list.ticket_name}</td>
											<td>${list.ticket_type}</td>
											<td>${list.ticket_days}</td>
											<td>${list.ticket_time}</td>
											<td>${list.ticket_price}</td>
											<td><a
												href="./TicketDetailSearch?ticket_code=${list.ticket_code}"
												class="btn btn-outline-info"> 정기권 상세 보기 </a></td>
										</tr>
									</c:forEach>

									<c:if test="${empty list}">
										<tr>
											<td colspan="4">등록된 정기권이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<div>
								<a href="./TicketInsert"
									class="btn btn-success btn-block"> 정기권 입력 </a>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
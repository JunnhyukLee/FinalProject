<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>정기권 상세 정보</title>
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
					<h1>정기권 상세 정보</h1>
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
							<h5>정기권 상세 보기</h5>
						</div>
						<div class="card-body">
							<table class="table table-hover">
								<thead class="thead-light">
									<tr class="text-center">
										<th>정기권 코드번호</th>
										<th>정기권 종류</th>
										<th>정기권 이름</th>
										<th>정기권 적용기간(일)</th>
										<th>정기권 적용기간(시간)</th>
										<th>정기권 가격</th>
									</tr>
								</thead>
								<tbody>
									<tr class="text-center">
										<td>${TicketDetailSearch.ticket_code}</td>
										<td>${TicketDetailSearch.ticket_type}</td>
										<td>${TicketDetailSearch.ticket_name}</td>
										<td>${TicketDetailSearch.ticket_days}</td>
										<td>${TicketDetailSearch.ticket_time}</td>
										<td>${TicketDetailSearch.ticket_price}</td>
									</tr>
								</tbody>
							</table>
							<div class="row">
								<div class="col-md-4">
									<a href="./TicketSearch" class="btn btn-primary btn-block">
										정기권 목록 </a>
								</div>
								<div class="col-md-4">
									<a href="./TicketUpdate?ticket_code=${TicketDetailSearch.ticket_code}"
										class="btn btn-warning btn-block"> 정기권 수정 </a>
								</div>
								<div class="col-md-4">
									<form action="./TicketDelete" method="post" id="deleteForm">
										<input type="hidden" name="ticket_code"
											value="${TicketDetailSearch.ticket_code}">
										<button type="submit" class="btn btn-danger btn-block" onclick="confirmDelete()">정기권
											삭제</button>
									</form>
									<script>
										function confirmDelete() {
											if (confirm("정기권을 삭제하시겠습니까?")) {
												document.getElementById("deleteForm").submit();
											}
										}
									</script>
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

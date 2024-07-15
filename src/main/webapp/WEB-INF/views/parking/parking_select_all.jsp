<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member 주차장 전체 조회</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css"
	href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709"
	type="text/javascript"></script>
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

main {
	flex: 1;
}

footer {
	background-color: #6c757d;
	color: white;
	padding: 10px 0;
}

/* 버튼 스타일 */
button {
	background-color: #6c757d; /* 헤더의 배경색과 같은색으로 설정 */
	color: white; /* 글자색 흰색으로 설정 */
	border: none; /* 테두리 제거 */
	padding: 10px 20px; /* 버튼 내부 여백 설정 */
	cursor: pointer; /* 커서 모양 변경 */
	margin-bottom: 10px; /* 버튼 아래 여백 설정 */
	margin-left: 30px;
}

button:hover {
	background-color: #5a6268; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

/* 버튼 컨테이너 */
.button-container {
	text-align: left; /* 가운데 정렬 */
	margin-top: 20px; /* 위 여백 설정 */
}
</style>
<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = '<c:url value="/logout" />';
        }
    }
</script>
</head>
<body>
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	<header id="main-header" class="py-2 bg-secondary text-white">
		<div class="container">
			<div class="row align-items-start justify-content-between">
				<div class="col-md-4 text-left">
					<h1>
						<i class="fas fa-lock-open"></i>P.K.-Management
					</h1>
				</div>
				<div class="col-md-7 d-flex align-items-center">
					<div>
						<c:if test="${not empty sessionScope.customMemberDetails}">
							<div>환영합니다, ${sessionScope.customMemberDetails.username}님</div>
						</c:if>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<div>
						<c:choose>
							<c:when test="${empty sessionScope.customMemberDetails}">
								<button onclick="location.href='<c:url value='/login' />'"
									style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
									<i class="fa fa-user"></i> 로그인
								</button>
								<button
									onclick="location.href='<c:url value='/MemberInsert' />'"
									style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
									<i class="fa fa-user"></i> 회원가입
								</button>
							</c:when>
							<c:otherwise>
								<button onclick="confirmLogout()"
									style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
									<i class="fa fa-user"></i> 로그아웃
								</button>
								<button
									onclick="location.href='<c:url value='/MemberSelectDetail'/>'"
									style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
									<i class="fa fa-user"></i> 내정보 보기
								</button>
								<c:if
									test="${sessionScope.customMemberDetails.memberRating == 'ADMIN'}">
									<button onclick="location.href='<c:url value='/AdminView'/>'"
										style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
										<i class="fa fa-user"></i> 어드민 메뉴 보기
									</button>
								</c:if>
								<c:if
									test="${sessionScope.customMemberDetails.memberRating == 'MANAGER'}">
									<button onclick="location.href='<c:url value='/ManagerView'/>'"
										style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
										<i class="fa fa-user"></i> 매니저 메뉴 보기
									</button>
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</header>

	<main>

		<header id="main-header" class="py-2 btn-dark text-white">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1>주차장 관리</h1>
					</div>
				</div>
			</div>
		</header>

		<div class="button-container">
			<button onclick="location.href ='./Menu'">메뉴</button>
			<button onclick="location.href ='./ParkingInsert'">주차장 등록</button>
		</div>

		<section id="member">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<h3 class="text-muted">
									<i class="fas fa-user-edit mr-sm-1"></i> 주차장 목록
								</h3>
							</div>
							<div class="card-body">

								<table class="table table-hover">

									<thead class="thead-light">
										<tr class="text-center">
											<th>코드 번호</th>
											<th>이름</th>
											<th>승인상태</th>
											<th></th>
										</tr>
									</thead>

									<tbody>

										<c:forEach var="list" items="${list}">
											<tr class="text-center">
												<td>${list.parking_code}</td>
												<td>${list.parking_name}</td>
												<td><c:choose>
														<c:when test="${list.parking_approval eq 'AP'}">승인</c:when>
														<c:otherwise>미승인</c:otherwise>
													</c:choose></td>
												<td>
													<button
														onclick="location.href ='./ParkingSelectDetail?parking_code=${list.parking_code}'">상세
														정보</button>
												</td>
											</tr>
										</c:forEach>
										<c:if test="${empty list}">
											<tr>
												<td colspan="4">등록된 주차장이 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</section>

	</main>

	<footer id="main-footer" class="py-2 bg-secondary text-black">
		<div class="container">
			<div class="row align-items-start justify-content-between">
				<div class="col-md-8">
					<div>
						<button onclick="location.href = './TermSelect'"
							style="padding: 5px 10px; font-size: 15px; background-color: transparent; border: none; color: white;">
							<i class="fa fa-user"></i> 이용약관
						</button>
					</div>
				</div>
				<div class="col-md-4 text-right">
					<h1 style="font-size: 15px">
						<i class="fas fa-lock"></i>e1i4 제작
					</h1>
				</div>
			</div>
		</div>
	</footer>
	<sec:authorize access="hasRole('ADMIN')">
		<p>권한이 없습니다</p>
	</sec:authorize>
</body>
</html>
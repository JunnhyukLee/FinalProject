<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세 회원 정보</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
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

form {
	text-align: center;
	margin-top: 10px;
}

.button-container {
	text-align: left;
	margin-top: 10px;
	margin-left: 10px;
}

.button-container button {
	margin-right: 10px;
	background-color: black; /* 배경색 검정색으로 설정 */
	color: white; /* 글자색 흰색으로 설정 */
	border: none; /* 테두리 제거 */
	padding: 5px 10px; /* 버튼 내부 여백 설정 */
	cursor: pointer; /* 커서 모양 변경 */
}

.button-container button:hover {
	background-color: #333; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

.card-header {
	background-color: #343a40;
	color: white;
}

.btn-block {
	margin-top: 10px;
}

.table-hover tbody tr:hover {
	background-color: #f5f5f5;
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
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'ADMIN'}">
                           <button onclick="location.href='<c:url value='/AdminView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 어드민 메뉴 보기
                           </button>
                        </c:if>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'MANAGER'}">
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
	<header id="main-header" class="py-2 bg-secondary text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>상세 회원 정보</h1>
				</div>
			</div>
		</div>
	</header>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card mt-4">
						<div class="card-header">
							<h5>회원 상세 보기</h5>
						</div>
						<div class="card-body">
							<table class="table table-hover">
								<thead class="thead-light">
									<tr class="text-center">
										<th>회원 코드</th>
										<th>회원 아이디</th>
										<th>회원 이름</th>
										<th>회원 비밀번호</th>
										<th>회원 이메일</th>
										<th>회원 전화번호</th>
										<th>회원 생년월일</th>
										<th>회원 성별</th>
										<th>회원 가입년도</th>
										<th>회원 차번호1</th>
										<th>회원 차번호2</th>
										<th>회원 차번호3</th>
										<th>회원 등급</th>
									</tr>
								</thead>
								<tbody>
									<tr class="text-center">
										<td>${memberDTO.member_code}</td>
										<td>${memberDTO.member_id}</td>
										<td>${memberDTO.member_name}</td>
										<td>${memberDTO.member_password}</td>
										<td>${memberDTO.member_email}</td>
										<td>${memberDTO.member_callnumber}</td>
										<td>${memberDTO.member_birthday}</td>
										<td>${memberDTO.member_gender}</td>
										<td>${memberDTO.member_joinday}</td>
										<td>${memberDTO.member_car_num1}</td>
										<td>${memberDTO.member_car_num2}</td>
										<td>${memberDTO.member_car_num3}</td>
										<td>${memberDTO.member_rating}</td>
									</tr>
								</tbody>
							</table>
							<div class="row">
								<div class="col-md-6">
									<a href="./MemberUpdate?member_code=${memberDTO.member_code}" class="btn btn-warning btn-block">회원 수정</a>
								</div>
								<div class="col-md-6">
									<a href="./MemberDelete?member_code=${memberDTO.member_code}" class="btn btn-danger btn-block">회원 삭제</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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

</body>
</html>

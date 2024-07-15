<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 수정</title>
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
</style>
<script type="text/javascript">
	function confirmUpdate() {
		if (confirm("수정을 완료하시겠습니까?")) {
			alert("수정이 완료되었습니다.");
			document.getElementById("sign_dept").submit();
		}
	}
</script>
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

	<header id="main-header" class="py-2 btn-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h1>회원 정보 수정</h1>
				</div>
			</div>
		</div>
	</header>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h5>회원 수정</h5>
					</div>
					<div class="card-body">
						<form action="./AdminUpdate" method="post" id="sign_dept">
							<fieldset>
								<div class="form-group row">
									<label for="member_code" class="ml-sm-3 col-form-label">회원
										코드</label>
									<div class="ml-sm-3">
										<input type="text" name="member_code" id="member_code"
											class="form-control form-control-sm bg-white"
											value="${param.member_code}" readonly>
									</div>
								</div>
										<input type="hidden" name="member_id" id="member_id"
											class="form-control form-control-sm bg-white"
											value="${memberDTO.member_id}">
									
								
										<input type="hidden" name="member_name" id="member_name"
											class="form-control form-control-sm"
											value="${memberDTO.member_name}">
									
										<input type="hidden" name="member_password" id="member_password"
											class="form-control form-control-sm"
											value="${memberDTO.member_password}">
									
										<input type="hidden" name="member_email" id="member_email"
											class="form-control form-control-sm"
											value="${memberDTO.member_email}">
									
										<input type="hidden" name="member_callnumber"
											id="member_callnumber" class="form-control form-control-sm"
											value="${memberDTO.member_callnumber}">
									
										<input type="hidden" name="member_birthday" id="member_birthday"
											class="form-control form-control-sm"
											value="${memberDTO.member_birthday}">
									
										<input type="hidden" name="member_gender" id="member_gender"
											class="form-control form-control-sm"
											value="${memberDTO.member_gender}">
									
										<input type="hidden" name="member_car_num1" id="member_car_num1"
											class="form-control form-control-sm"
											value="${memberDTO.member_car_num1}">
									
										<input type="hidden" name="member_car_num2" id="member_car_num2"
											class="form-control form-control-sm"
											value="${memberDTO.member_car_num2}">
									
										<input type="hidden" name="member_car_num3" id="member_car_num3"
											class="form-control form-control-sm"
											value="${memberDTO.member_car_num3}">
								<div class="form-group row">
									<label for="member_rating" class="ml-sm-3 col-form-label">회원
										등급</label>
									<div class="ml-sm-3">
										<select name="member_rating" id="member_rating"
											class="form-control form-control-sm">
											<option value="MEMBER"
												${memberDTO.member_rating == 'MEMBER' ? 'selected' : ''}>MEMBER</option>
											<option value="MANAGER"
												${memberDTO.member_rating == 'MANAGER' ? 'selected' : ''}>MANAGER</option>
											<option value="ADMIN"
												${memberDTO.member_rating == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<button type="button" class="btn btn-secondary"
										onclick="confirmUpdate()">등록</button>
									<button type="reset" class="btn btn-secondary">취소</button>
								</div>
							</fieldset>
						</form>
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
	<sec:authorize access="hasRole('ADMIN')">
		<p>권한이 없습니다</p>
	</sec:authorize>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 승인 처리</title>
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
					<h1>주차장 관리</h1>
				</div>
			</div>
		</div>
	</header>

	<section id="member">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-header">
							<h3 class="text-muted">
								<i class="fas fa-user-edit mr-sm-1"></i> 주차장 승인 처리
							</h3>
						</div>
						<div class="card-body">

<form action="./ParkingApprove" method="post" name="parking_approve" id="approve">

<fieldset>

<div class="form-group row">
										<label for="parking_code" class="col-4 col-form-label pr-0">
											<i class="fas fa-user-plus mr-sm-1"></i>주차장 코드 : 
										</label>
										<div class="col-8 pl-0">
											<input type="text" name="parking_code" id="parking_code"
												class="form-control" value="${parkingDTO.parking_code}" readonly>
										</div>
										<div class="col-4"></div>
										<div class="col-8 pl-0">주차장을 승인 하시겠습니까?</div>
									</div>
									
									<div class="form-group row">
										<label for="parking_approval"
											class="col-4 col-form-check-label pr-0"> <i
											class="fas fa-restroom mr-sm-1"></i>주차장 승인 여부 : 
										</label>
										<div class="col-md-7 form-check form-check-inline text-left">
											<input type="radio" name="parking_approval" id="parking_approval"
												class="form-check-input" value="AP" <c:if test="${parkingDTO.parking_approval eq 'AP'}">checked</c:if>>승인 <input
												type="radio" name="parking_approval" id="parking_approval" 
												class="ml-sm-3 form-check-input" value="NAP" <c:if test="${parkingDTO.parking_approval eq 'NAP'}">checked</c:if>>미승인
										</div>
									</div>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" name="parking_name" id="parking_name" value="${parkingDTO.parking_name}">
<input type="hidden" name="parking_address" id="parking_address" value="${parkingDTO.parking_address}">
<input type="hidden" name="parking_latitude" id="parking_latitude" value="${parkingDTO.parking_latitude}">
<input type="hidden" name="parking_longitude" id="parking_longitude" value="${parkingDTO.parking_longitude}">
<input type="hidden" name="parking_operation" id="parking_operation" value="${parkingDTO.parking_operation}">
<input type="hidden" name="parking_type" id="parking_type" value="${parkingDTO.parking_type}">
<input type="hidden" name="parking_total_spaces" id="parking_total_spaces" value="${parkingDTO.parking_total_spaces}">
<input type="hidden" name="parking_electriccar_check" id="parking_electriccar_check" value="${parkingDTO.parking_electriccar_check}">
<input type="hidden" name="parking_electriccar_spaces" id="parking_electriccar_spaces" value="${parkingDTO.parking_electriccar_spaces}">
<input type="hidden" name="parking_pay_type" id="parking_pay_type" value="${parkingDTO.parking_pay_type}">
<input type="hidden" name="parking_base_fee" id="parking_base_fee" value="${parkingDTO.parking_base_fee}">
<input type="hidden" name="parking_hourly_rate" id="parking_hourly_rate" value="${parkingDTO.parking_hourly_rate}">
<input type="hidden" name="parking_photo1_name" id="parking_photo1_name" value="${parkingDTO.parking_photo1_name}">
<input type="hidden" name="parking_photo1_path" id="parking_photo1_path" value="${parkingDTO.parking_photo1_path}">
<input type="hidden" name="parking_photo2_name" id="parking_photo2_name" value="${parkingDTO.parking_photo2_name}">
<input type="hidden" name="parking_photo2_path" id="parking_photo2_path" value="${parkingDTO.parking_photo2_path}">
<input type="hidden" name="parking_photo3_name" id="parking_photo3_name" value="${parkingDTO.parking_photo3_name}">
<input type="hidden" name="parking_photo3_path" id="parking_photo3_path" value="${parkingDTO.parking_photo3_path}">
<input type="hidden" name="parking_photo4_name" id="parking_photo4_name" value="${parkingDTO.parking_photo4_name}">
<input type="hidden" name="parking_photo4_path" id="parking_photo4_path" value="${parkingDTO.parking_photo4_path}">
<input type="hidden" name="parking_photo5_name" id="parking_photo5_name" value="${parkingDTO.parking_photo5_name}">
<input type="hidden" name="parking_photo5_path" id="parking_photo5_path" value="${parkingDTO.parking_photo5_path}">
<input type="hidden" name="parking_document_name" id="parking_document_name" value="${parkingDTO.parking_document_name}">
<input type="hidden" name="parking_document_path" id="parking_document_path" value="${parkingDTO.parking_document_path}">
<input type="hidden" name="parking_registration" id="parking_registration" value="${parkingDTO.parking_registration}">

<!-- 현재 날짜 추출 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set> 
<input type="hidden" name="parking_edit" id="parking_edit" value="${date}">

<input type="hidden" name="member_code" id="member_code" value="${parkingDTO.member_code}">

									<nav class="navbar justify-content-end">
										<button type="submit" class="btn btn-outline-primary mr-sm-1">
											<i class="fas fa-save mr-sm-1"></i> 저장
										</button>
										<button type="reset" id="clear" onclick="location.href='./ParkingSelectAdmin'"
											class="btn btn-outline-warning mr-sm-1">
											<i class="fas fa-share-square mr-sm-1"></i>취소(주차장 목록으로 이동(admin))
										</button>
									</nav>

</fieldset>

</form>
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

</body>
</html>
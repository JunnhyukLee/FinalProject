<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 상세 조회</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script src="./js/popper.min.js?20240704"></script>
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
								<i class="fas fa-user-edit mr-sm-1"></i> 주차장 정보
							</h3>
						</div>
						<div class="card-body">

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주차장 코드 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_code}</span>
							</div>
							
							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주차장 이름 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_name}</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주소 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_address}</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>위도 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_latitude}</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>경도 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_longitude}</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>운영시간 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_operation}</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주차장 종류 :
								</div>
								<span class="col-8 pl-0 form-control"> <c:choose>
										<c:when test="${parkingDTO.parking_type} == 'public'">공영 주차장</c:when>
										<c:otherwise>민영(민간) 주차장</c:otherwise>
									</c:choose>
								</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주차 공간 :
								</div>
								<div class="col-8 pl-0 input-group">
									<div class="form-control">${parkingDTO.parking_total_spaces}</div>
									<div class="input-group-append">
										<span class="input-group-text">석</span>
									</div>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>전기차 충전 가능 여부 :
								</div>
								<span class="col-8 pl-0 form-control"> <c:choose>
										<c:when test="${parkingDTO.parking_electriccar_check == 'Y'}">가능</c:when>
										<c:otherwise>불가능</c:otherwise>
									</c:choose>
								</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>전기차 충전 가능 공간 :
								</div>
								<div class="col-8 pl-0 input-group">
									<div class="form-control">${parkingDTO.parking_electriccar_spaces}</div>
									<div class="input-group-append">
										<span class="input-group-text">석</span>
									</div>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>적용 가능 할인권 :
								</div>
								<span class="col-8 pl-0 form-control"> <c:choose>
										<c:when test="${parkingDTO.parking_pay_type == 'R'}">정기권</c:when>
										<c:when test="${parkingDTO.parking_pay_type == 'T'}">시간권</c:when>
										<c:otherwise>정기권, 시간권</c:otherwise>
									</c:choose>
								</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>기본요금(1시간) :
								</div>
								<div class="col-8 pl-0 input-group">
									<div class="form-control">${parkingDTO.parking_base_fee}</div>
									<div class="input-group-append">
										<span class="input-group-text">원</span>
									</div>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>추가 요금(10분 경과 시) :
								</div>
								<div class="col-8 pl-0 input-group">
									<div class="form-control">${parkingDTO.parking_hourly_rate}</div>
									<div class="input-group-append">
										<span class="input-group-text">원</span>
									</div>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주차장 이미지 :
								</div>
								<span class="col-8 pl-0"> 
								
								<c:if test="${not empty parkingDTO.parking_photo1_path}">
								<img alt="주차장 사진 1" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_photo1_name}"
								onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_photo1_name}')">
								</c:if>
								
								<c:if test="${not empty parkingDTO.parking_photo2_path}">
								<img alt="주차장 사진 2" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_photo2_name}"
								onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_photo2_name}')">
								</c:if>
								
								<c:if test="${not empty parkingDTO.parking_photo3_path}">
								<img alt="주차장 사진 3" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_photo3_name}"
								onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_photo3_name}')">
								</c:if>
								
								<c:if test="${not empty parkingDTO.parking_photo4_path}">
								<img alt="주차장 사진 4" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_photo4_name}"
								onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_photo4_name}')">
								</c:if>
								
								<c:if test="${not empty parkingDTO.parking_photo5_path}">
								<img alt="주차장 사진 5" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_photo5_name}"
								onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_photo5_name}')">
								</c:if>
								
								</span>
							</div>

							<c:if test="${sessionScope.customMemberDetails.memberRating eq 'ADMIN'}">
							<div class="form-group row"> <!-- admin만 볼 수 있도록 세팅 필요 -->
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>주차장 인증 서류 :
								</div>
								<span class="col-8 pl-0">
								<c:if test="${not empty parkingDTO.parking_document_path}">
								<img alt="주차장 인증 서류" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_document_name}"
								onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_document_name}')">
								</c:if>
								</span>
							</div>
							</c:if>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>승인 여부 :
								</div>
								<span class="col-8 pl-0 form-control"> <c:choose>
										<c:when test="${parkingDTO.parking_approval eq 'AP'}">승인</c:when>
										<c:otherwise>미승인</c:otherwise>
									</c:choose>
								</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>등록일시 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_registration}</span>
							</div>

							<div class="form-group row">
								<div class="col-4 col-form-label pr-0">
									<i class="fas fa-user-plus mr-sm-1"></i>수정일시 :
								</div>
								<span class="col-8 pl-0 form-control">${parkingDTO.parking_edit}</span>
							</div>

							<div class="button-container">
									<button onclick="location.href ='./Menu'">메뉴</button>
									<c:if test="${sessionScope.customMemberDetails.memberRating eq 'MANAGER'}">
									<button onclick="location.href = '${pageContext.request.contextPath}/ParkingSelectAll?member_code=${sessionScope.customMemberDetails.memberCode}'">주차장 목록(manager)</button>
									<button onclick="location.href = './ParkingUpdate?parking_code=${parkingDTO.parking_code}'">수정(manager)</button>
									<button onclick="location.href = './ParkingDelete?parking_code=${parkingDTO.parking_code}'">삭제(manager)</button>
									</c:if>
									<c:if test="${sessionScope.customMemberDetails.memberRating eq 'ADMIN'}">
									<button onclick="location.href = './ParkingSelectAdmin'">주차장 목록(admin)</button> 
									<button onclick="location.href = './ParkingApprove?parking_code=${parkingDTO.parking_code}'">승인(admin)</button> 
									</c:if>
							</div>

<!-- 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">이미지</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="modalImage" src="" alt="큰 이미지" class="img-fluid">
            </div>
        </div>
    </div>
</div>

<script>
    function showImage(imageSrc) {
        $('#modalImage').attr('src', imageSrc);
        $('#imageModal').modal('show');
    }
</script>

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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 상세 조회</title>
<link rel="stylesheet" href="./css/bootstrap.min_4.5.0.css?20240704">
<script src="./js/jquery-3.5.1.min.js?20240704"></script>
<script src="./js/popper.min.js?20240704"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240704"></script>
</head>
<body>

<h1>주차장 관리</h1>

<h3>주차장 정보</h3>

<div>
주차장 코드 : ${parkingDTO.parking_code}
</div>

<div>
주차장 이름 : ${parkingDTO.parking_name}
</div>

<div>
주소 : ${parkingDTO.parking_address}
</div>

<div>
위도 : ${parkingDTO.parking_latitude}
</div>

<div>
경도 : ${parkingDTO.parking_longitude}
</div>

<div>
운영시간 : ${parkingDTO.parking_operation}
</div>

<div>
주차장 종류 : 
<c:choose>
<c:when test="${parkingDTO.parking_type} == 'public'">공영 주차장</c:when>
<c:otherwise>민영(민간) 주차장</c:otherwise>
</c:choose>
</div>

<div>
주차 공간 : ${parkingDTO.parking_total_spaces}석
</div>

<div>
전기차 충전 가능 여부 : 
<c:choose>
<c:when test="${parkingDTO.parking_electriccar_check == 'Y'}">가능</c:when>
<c:otherwise>불가능</c:otherwise>
</c:choose>
</div>

<div>
전기차 충전 가능 공간 : ${parkingDTO.parking_electriccar_spaces}석
</div>

<div>
적용 가능 할인권 : 
<c:choose>
<c:when test="${parkingDTO.parking_pay_type == 'R'}">정기권</c:when>
<c:when test="${parkingDTO.parking_pay_type == 'T'}">시간권</c:when>
<c:otherwise>정기권, 시간권</c:otherwise>
</c:choose>
</div>

<div>
기본요금(1시간) : ${parkingDTO.parking_base_fee}원
</div>

<div>
추가 요금(10분 경과 시) : ${parkingDTO.parking_hourly_rate}원
</div>

<div>
주차장 이미지
<br>

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

</div>

<div>
주차장 인증 서류 <!-- admin만 볼 수 있도록 세팅 필요 -->
<br>
<c:if test="${not empty parkingDTO.parking_document_path}">
<img alt="주차장 인증 서류" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member.member_code}&filename=${parkingDTO.parking_document_name}"
onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member.member_code}/${parkingDTO.parking_document_name}')">
</c:if>
</div>

<div>
승인 여부 : 
<c:choose>
<c:when test="${parkingDTO.parking_approval eq 'AP'}">승인</c:when>
<c:otherwise>미승인</c:otherwise>
</c:choose>
</div>

<div>
등록일시 : ${parkingDTO.parking_registration}
</div>

<div>
수정일시 : ${parkingDTO.parking_edit}
</div>

<div>
<button onclick="location.href = './ParkingSelectAll?member_code=${parkingDTO.member.member_code}'">주차장 목록(manager)</button>
<button onclick="location.href = './ParkingSelectAdmin'">주차장 목록(admin)</button> <!-- admin만 볼 수 있도록 세팅 필요 -->
<button onclick="location.href = '././ParkingUpdate?parking_code=${parkingDTO.parking_code}'">수정(manager)</button>
<button onclick="location.href = '././ParkingDelete?parking_code=${parkingDTO.parking_code}'">삭제(manager)</button>
<button onclick="location.href = '././ParkingApprove?parking_code=${parkingDTO.parking_code}'">승인(admin)</button> <!-- admin만 볼 수 있도록 세팅 필요 -->
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

</body>
</html>
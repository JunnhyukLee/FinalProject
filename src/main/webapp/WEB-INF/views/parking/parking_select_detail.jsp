<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 상세 조회</title>
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
<button onclick="location.href = './ParkingSelectAdmin'">주차장 목록(admin)</button>
<button onclick="location.href = '././ParkingUpdate?parking_code=${parkingDTO.parking_code}'">수정(manager)</button>
<button onclick="location.href = '././ParkingDelete?parking_code=${parkingDTO.parking_code}'">삭제(manager)</button>
<button onclick="location.href = '././ParkingApprove?parking_code=${parkingDTO.parking_code}'">승인(admin)</button>
</div>

</body>
</html>
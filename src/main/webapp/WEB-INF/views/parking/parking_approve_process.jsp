<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 승인 처리</title>
</head>
<body>

<h1>주차장 관리</h1>

<h3>주차장 승인 처리</h3>

<form action="./ParkingApprove" method="post" name="parking_approve" id="approve">

<div>
주차장 코드 : 
<input type="text" name="parking_code" id="parking_code" value="${parkingDTO.parking_code}" readonly>
<br> 주차장을 승인 하시겠습니까?
</div>


<div>
<label for="parking_name"></label>
<input type="hidden" name="parking_name" id="parking_name" value="${parkingDTO.parking_name}">
</div>

<div>
<label for="parking_address"></label>
<input type="hidden" name="parking_address" id="parking_address" value="${parkingDTO.parking_address}">
</div>

<div>
<label for="parking_latitude"></label>
<input type="hidden" name="parking_latitude" id="parking_latitude" value="${parkingDTO.parking_latitude}">
</div>

<div>
<label for="parking_longitude"></label>
<input type="hidden" name="parking_longitude" id="parking_longitude" value="${parkingDTO.parking_longitude}">
</div>

<div>
<label for="parking_operation"></label>
<input type="hidden" name="parking_operation" id="parking_operation" value="${parkingDTO.parking_operation}">
</div>

<div>
<label for="parking_type"></label>
<input type="hidden" name="parking_type" id="parking_type" value="${parkingDTO.parking_type}">
</div>

<div>
<label for="parking_total_spaces"></label>
<input type="hidden" name="parking_total_spaces" id="parking_total_spaces" value="${parkingDTO.parking_total_spaces}">
</div>

<div>
<label for="parking_electriccar_check"></label>
<input type="hidden" name="parking_electriccar_check" id="parking_electriccar_check" value="${parkingDTO.parking_electriccar_check}">
</div>

<div>
<label for="parking_electriccar_spaces"></label>
<input type="hidden" name="parking_electriccar_spaces" id="parking_electriccar_spaces" value="${parkingDTO.parking_electriccar_spaces}">
</div>

<div>
<label for="parking_pay_type"></label>
<input type="hidden" name="parking_pay_type" id="parking_pay_type" value="${parkingDTO.parking_pay_type}">
</div>

<div>
<label for="parking_base_fee"></label>
<input type="hidden" name="parking_base_fee" id="parking_base_fee" value="${parkingDTO.parking_base_fee}">
</div>

<div>
<label for="parking_hourly_rate"></label>
<input type="hidden" name="parking_hourly_rate" id="parking_hourly_rate" value="${parkingDTO.parking_hourly_rate}">
</div>

<div>
<label for="parking_approval">주차장 승인 여부 : </label>
<input type="radio" name="parking_approval" id="parking_approval" value="AP" 
<c:if test="${parkingDTO.parking_approval eq 'AP'}">checked</c:if>>승인
<input type="radio" name="parking_approval" id="parking_approval" value="NAP" 
<c:if test="${parkingDTO.parking_approval eq 'NAP'}">checked</c:if>>미승인
</div>

<div>
<label for="parking_registration"></label>
<input type="hidden" name="parking_registration" id="parking_registration" value="${parkingDTO.parking_registration}">
</div>

<!-- 현재 날짜 추출 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set> 

<div>
<label for="parking_edit"></label>
<input type="hidden" name="parking_edit" id="parking_edit" value="${date}">
</div>

<div>
<label for="member_code"></label>
<input type="hidden" name="member_code" id="member_code" value="${parkingDTO.member_code}">
</div>

<div>
<button type="submit">저장</button>
<button type="reset" onclick="location.href='./ParkingSelectAdmin'">취소(주차장 목록으로 이동(admin))</button>
</div>

</form>

</body>
</html>
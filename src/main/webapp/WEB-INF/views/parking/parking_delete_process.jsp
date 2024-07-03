<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 정보 삭제 요청</title>
</head>
<body>

<h1>주차장 관리</h1>

<h3>주차장 정보 삭제 요청</h3>

<form action="./ParkingDelete" method="post" name="parking_delete" id="delete">

<div>
주차장 코드 : 
<input type="text" name="parking_code" id="parking_code" value="${parkingDTO.parking_code}" readonly>
<br> 정보를 삭제하시겠습니까?
</div>

<div>
<label for="member_code"></label>
<input type="hidden" name="member_code" id="member_code" value="${parkingDTO.member_code}">
</div>

<div>
<button type="submit">삭제</button>
<button type="reset" onclick="location.href = './ParkingSelectAll?member_code=${parkingDTO.member_code}'">주차장 목록(manager)</button>
</div>

</form>

</body>
</html>
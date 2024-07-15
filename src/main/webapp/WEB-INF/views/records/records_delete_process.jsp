<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 삭제 요청</title>
</head>
<body>

<h1>주차 기록 관리</h1>

<h3>주차 기록 삭제 요청</h3>

<form action="./RecordsDelete" method="post" name="records_delete" id="delete">

<div>
주차장 코드 : 
<input type="text" name="records_code" id="records_code" value="${recordsDTO.records_code}" readonly>
<br> 주차 기록을 삭제하시겠습니까?
</div>

<div>
<label for="parking_code"></label>
<input type="hidden" name="parking_code" id="parking_code" value="${recordsDTO.parking_code}">
</div>

<div>
<button type="submit">삭제</button>
<button type="reset" id="clear" onclick="location.href ='./RecordsSelectParking?parking_code=${recordsDTO.parking_code}'">주차장 목록(manager)</button>
</div>

</form>

</body>
</html>
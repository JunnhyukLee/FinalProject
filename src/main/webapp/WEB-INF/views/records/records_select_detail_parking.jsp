<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차기록 상세 조회(parking)</title>
</head>
<body>

<h1>주차 기록 관리</h1>

<h3>상세 주차 기록 조회</h3>

<div>
주차 기록 코드 : ${recordsDTO.records_code}
</div>

<div>
차량 번호 : ${recordsDTO.member_car_num}
</div>

<div>
주차장 이름 : ${recordsDTO.parking_name}
</div>

<div>
입차 시간 : ${recordsDTO.records_start}
</div>

<div>
출차 시간 : ${recordsDTO.records_end}
</div>

<div>
결제 요금 : ${recordsDTO.payment_total}원
</div>

<div>
<button onclick="location.href ='./RecordsSelectParking?parking_code=${recordsDTO.parking.parking_code}'">주차 기록 목록</button> <!-- &parking_name=${recordsDTO.parking_name} -->
<button onclick="location.href ='./RecordsUpdate?records_code=${recordsDTO.records_code}'">주차 기록 수정</button>
<button onclick="location.href ='./RecordsDelete?records_code=${recordsDTO.records_code}'">주차 기록 삭제</button>
</div>

</body>
</html>
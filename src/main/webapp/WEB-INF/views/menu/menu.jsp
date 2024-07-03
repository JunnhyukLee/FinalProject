<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴</title>
</head>
<body>

<div>
<h1>[최종 버튼]</h1>
<br><br>
주차장
<button onclick="location.href = './ParkingSelectAll?member_code=${10001}'">주차장 관리(manager)</button>
<button onclick="location.href = './ParkingSelectAdmin'">주차장 및 주차기록 관리(admin)</button>
<br><br>
주차기록
<button onclick="location.href = './RecordsRestUser'">주차 기록 확인(user)</button>
<button onclick="location.href = './RecordsRestManager'">주차 기록 확인(manager)</button>
</div>
<br><br>

<div>
<h1>[개발 단계 버튼]</h1>
<br><br>
주차장
<button onclick="location.href = './ParkingSelectAll?member_code=${10001}'">주차장 관리(manager)</button>
<button onclick="location.href = './ParkingSelectAdmin'">주차장 및 주차기록 관리(admin)</button>
<br><br>
주차기록
<button onclick="location.href = './RecordsSelectUser?member_code=${10001}'">주차 기록 확인(사용자)</button>
<button onclick="location.href = './RecordsSelectParkingCode?member_code=${10001}'">주차 기록 확인(manager)</button>
<br><br>
map
<button onclick="location.href = './map'">map</button>
<br><br>
rest 주차기록
<button onclick="location.href = './RecordsRestView'">주차 기록 확인(사용자)</button>
</div>

<br><br>

<div>
<h1>[이전 세미 단계 버튼]</h1>
<br><br>
<button onclick="location.href = './RecordsSelectUser'">주차 기록 확인(사용자)</button>
<button onclick="location.href = './ParkingSelectAll'">주차장 관리(manager)</button>
<button onclick="location.href = './RecordsSelectParkingCode'">주차 기록 확인(manager)</button>
<button onclick="location.href = './ParkingSelectAdmin'">주차장 및 주차기록 관리(admin)</button>
</div>

</body>
</html>
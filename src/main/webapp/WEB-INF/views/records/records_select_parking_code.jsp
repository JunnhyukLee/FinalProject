<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 주차장 코드번호 조회</title>
</head>
<body>

<h1>주차 기록 관리</h1>

<div>
<button onclick="location.href ='./Menu'">메뉴</button>
</div>

<h3>주차장 코드 번호 조회</h3>

<div>
<table>

<thead>
<tr>
<th>회원 코드 번호</th>
<th>주차장 코드 번호</th>
<th>주차장 이름</th>
<th></th>
</tr>
</thead>

<tbody>
<c:forEach var="list" items="${list}">
<tr>
<td>${list.member.member_code}</td>
<td>${list.parking_code}</td>
<td>${list.parking_name}</td>
<td>
<button onclick="location.href ='./RecordsSelectParking?parking_code=${list.parking_code}'">주차 기록 보기</button>
</td>
</tr>
</c:forEach>

<c:if test="${empty list}">
<tr>
<td>등록된 주차장이 없습니다.</td>
</tr>
</c:if>

</tbody>

</table>
</div>

</body>
</html>
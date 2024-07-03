<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member 주차장 전체 조회</title>
</head>
<body>

<h1>주차장 관리</h1>

<div>
<button onclick="location.href ='./Menu'">메뉴</button>
<button onclick="location.href ='./ParkingInsert'">주차장 등록</button>
</div>

<h3>주차장 목록</h3>

<div>
<table>

<thead>
<tr>
<th>코드 번호</th>
<th>이름</th>
<th>승인상태</th>
<th></th>
</tr>
</thead>

<tbody>
<c:forEach var="list" items="${list}">
<tr>
<td>${list.parking_code}</td>
<td>${list.parking_name}</td>
<td><c:choose>
<c:when test="${list.parking_approval eq 'AP'}">승인</c:when>
<c:otherwise>미승인</c:otherwise>
</c:choose></td>
<td>
<button onclick="location.href ='./ParkingSelectDetail?parking_code=${list.parking_code}'">상세 정보</button>
</td>
</tr>
</c:forEach>

<c:if test="${empty list}">
<tr>
<td >등록된 주차장이 없습니다.</td>
</tr>
</c:if>

</tbody>

</table>
</div>

</body>
</html>
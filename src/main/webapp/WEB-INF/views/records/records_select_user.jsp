<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차기록 전체 조회(user)</title>
</head>
<body>

	<h1>주차 기록 관리</h1>

	<div>
		<button onclick="location.href ='./Menu'">메뉴</button>
	</div>

	<h3>주차 기록 조회</h3>

	<div>
		<table>

			<thead>
				<tr>
					<th>코드 번호</th>
					<th>차량 번호</th>
					<th>입차 시간</th>
					<th>출차 시간</th>
					<th></th>
				</tr>
			</thead>

			<tbody>

				<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.records_code}</td>
						<td>${list.member_car_num}</td>
						<td>${list.records_start}</td>
						<td>${list.records_end}</td>
						<td>
							<button
								onclick="location.href ='./RecordsSelectDetailUser?records_code=${list.records_code}'">상세
								정보</button>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty list}">
					<tr>
						<td>회원님 정보로 주차 이용 내역이 없습니다.</td>
					</tr>
				</c:if>

			</tbody>

		</table>
	</div>

</body>
</html>
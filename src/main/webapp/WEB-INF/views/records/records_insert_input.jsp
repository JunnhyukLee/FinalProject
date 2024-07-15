<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 등록(input)</title>
<script src="./js/jquery-3.5.1.min.js?20240624" type="text/javascript"></script>
</head>
<body>

<h1>주차 기록 관리</h1>

<div>
<button onclick="location.href ='./Menu'">메뉴</button>
</div>

<h3>주차 기록 등록</h3>

<form action="./RecordsInsert" method="post" name="records_insert" id="insert">
<fieldset>

<div>
<label for="parking_code">주차장 코드 : </label>
<input type="text" name="parking_code" id="parking_code" value="${parking.parking_code}" readonly>
</div>

<div>
<label for="parking_name">주차장 이름 : </label>
<input type="text" name="parking_name" id="parking_name" value="${parking.parking_name}" readonly>
</div>

<!-- 
<div>
<label for="member_code">회원 코드 : </label>
<input type="text" name="member_code" id="member_code">
</div>
 -->

<div>
<label for="member_car_num">차량번호 : </label>
<input type="text" name="member_car_num" id="member_car_num">
</div>

<!-- 현재 날짜 시간 추출 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd hh:mm:ss"/></c:set> 

<div>
<label for="records_start">입차 시간 : </label>
<input type="hidden" name="records_start" id="records_start" value="${date}">
등록시간으로 자동 입력됩니다.
</div>

<div>
<button type="submit">등록</button>
<button type="reset" id="clear" onclick="location.href ='./RecordsSelectParking?parking_code=${parking.parking_code}'">취소</button>
</div>

</fieldset>
</form>

</body>

<script type="text/javascript">
	$(function() {
		$("#insert").submit(
				function() {

					//if (!$("input[name='member_code']").val()) {
					//	alert("사용자 코드를 입력하세요.");
					//	$("input[name='member_code']").focus();
					//	return false;
					//}

					//var regexp_records_member_code = /^[0-9]{1,10}$/;
					//var records_member_code_check = $(
					//		"input[name='member_code']").val()

					//if (!regexp_records_member_code
					//		.test(records_member_code_check)) {
					//	alert("사용자 코드는 공백을 제외한 숫자 10자리까지 입력할 수 있습니다.");
					//	$("input[name='member_code']").focus();
					//	return false;
					//}

					if (!$("input[name='member_car_num']").val()) {
						alert("차량 번호를 입력하세요.");
						$("input[name='member_car_num']").focus();
						return false;
					}

					var regexp_records_member_car_num = /^\d{2,3}[가-힣]\d{4}$/;
					var records_member_car_num_check = $(
							"input[name='member_car_num']").val()

					if (!regexp_records_member_car_num
							.test(records_member_car_num_check)) {
						alert("차량번호가 유효하지 않습니다.\n작성 예시 : 123가4567");
						$("input[name='member_car_num']").focus();
						return false;
					}

				});
	});
</script>

</html>
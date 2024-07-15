<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 수정(input)</title>
<script src="./js/jquery-3.5.1.min.js?20240624" type="text/javascript"></script>
</head>
<body>

<h1>주차 기록 관리</h1>

<div>
<button onclick="location.href ='./Menu'">메뉴</button>
</div>

<h3>주차 기록 수정</h3>

<form action="./RecordsUpdate" method="post" name="records_update" id="update">
<fieldset>

<div>
<label for="records_code">주차 기록 코드 번호 : </label>
<input type="text" name="records_code" id="records_code" value="${recordsDTO.records_code}" readonly>
</div>

<div>
<label for="parking_code">주차장 코드 : </label>
<input type="text" name="parking_code" id="parking_code" value="${recordsDTO.parking_code}" readonly>
</div>

<div>
<label for="parking_name">주차장 이름 : </label>
<input type="text" name="parking_name" id="parking_name" value="${recordsDTO.parking_name}" readonly>
</div>

<div>
<label for="member_code">사용자 코드 : </label>
<input type="text" name="member_code" id="member_code" value="${recordsDTO.member_code}" readonly>
</div>

<div>
<label for="member_car_num">차량 번호 : </label>
<input type="text" name="member_car_num" id="member_car_num" value="${recordsDTO.member_car_num}" readonly>
</div>

<div>
<label for="records_start">입차 시간 : </label>
<input type="text" name="records_start" id="records_start" value="${recordsDTO.records_start}" readonly>
</div>

<!-- 현재 날짜 시간 추출 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd hh:mm:ss"/></c:set> 

<div>
<label for="records_end">출차 시간 : </label>
<input type="hidden" name="records_end" id="records_end" value="${date}">
수정 시간으로 자동 입력됩니다.
</div>

<div>
<label for="payment_total">결제 금액 : </label>
<input type="text" name="payment_total" id="payment_total">원
</div>

<div>
<button type="submit">등록</button>
<button type="reset" id="clear" onclick="location.href ='./RecordsSelectParking?parking_code=${recordsDTO.parking_code}'">취소</button>
</div>

</fieldset>
</form>

</body>

<script type="text/javascript">
	$(function() {
		$("#update")
				.submit(
						function() {

							if (!$("input[name='payment_total']").val()) {
								alert("총 결제 금액을 입력하세요.");
								$("input[name='payment_total']").focus();
								return false;
							}

							var regexp_records_payment_total = /^\d+(\,\d+)?$/;
							var records_payment_total_check = $(
									"input[name='payment_total']").val()

							if (!regexp_records_payment_total
									.test(records_payment_total_check)) {
								alert("총 결제 금액이 유효하지 않습니다.\n숫자 및 ,(쉼표)로 구분하여 기재 (ex. 10,000 or 15,000 등)");
								$("input[name='payment_total']").focus();
								return false;
							}

							if (records_payment_total_check.length > 10) {
								alert("총 결제 금액은 최대 10자리까지 가능합니다.");
								$("input[name='payment_total']").focus();
								return false;
							}

						});
	});
</script>

</html>
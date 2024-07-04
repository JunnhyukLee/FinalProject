<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 정보 수정(input)</title>
<link rel="stylesheet" href="./css/bootstrap.min_4.5.0.css?20240704">
<script src="./js/jquery-3.5.1.min.js?20240704"></script>
<script src="./js/popper.min.js?20240704"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240704"></script>

</head>
<body>

<h1>주차장 관리</h1>

<div>
<button onclick="location.href = './ParkingSelectAll?member_code=${parkingDTO.member_code}'">주차장 목록(manager)</button>
</div>

<h3>주차장 정보 수정</h3>

<form action="./ParkingUpdate" method="post" name="parking_update" id="update" enctype="multipart/form-data">
<fieldset>

<div>
<label for="parking_code">주차장 코드 : </label> 
<input type="text" name="parking_code" id="parking_code" value="${parkingDTO.parking_code}" readonly>
</div>

<div>
<label for="parking_name">주차장 이름 : 
</label> <input type="text" name="parking_name" id="parking_name" value="${parkingDTO.parking_name}">
</div>

<div>
<label for="parking_address">주차장 주소 : </label> 
<input type="text" name="parking_address" id="parking_address" value="${parkingDTO.parking_address}" readonly>
</div>

<div>
<label for="parking_latitude">주차장 위도 : </label> 
<input type="text" name="parking_latitude" id="parking_latitude" value="${parkingDTO.parking_latitude}" readonly>
</div>

<div>
<label for="parking_longitude">주차장 경도 : </label> 
<input type="text" name="parking_longitude" id="parking_longitude" value="${parkingDTO.parking_longitude}" readonly>
</div>

<div>
<label for="parking_operation">운영시간 : </label> 
<input type="text" name="parking_operation" id="parking_operation" value="${parkingDTO.parking_operation}"> 
<br>[참고] ex. 09:00~18:00
</div>

<div>
<label for="parking_type">주차장 종류 : </label> 
<input type="radio" name="parking_type" id="parking_type" value="public"
<c:if test="${parkingDTO.parking_type eq 'public'}">checked</c:if>>공영
<input type="radio" name="parking_type" id="parking_type" value="private"
<c:if test="${parkingDTO.parking_type eq 'private'}">checked</c:if>>민영
</div>

<div>
<label for="parking_total_spaces">주차 공간 : </label> 
<input type="text" name="parking_total_spaces" id="parking_total_spaces" value="${parkingDTO.parking_total_spaces}">석
</div>

<div>
<label for="parking_electriccar_check">전기차 충전 가능 여부 : </label> 
<input type="radio" name="parking_electriccar_check" id="parking_electriccar_check" value="Y"
<c:if test="${parkingDTO.parking_electriccar_check eq 'Y'}">checked</c:if>>가능
<input type="radio" name="parking_electriccar_check" id="parking_electriccar_check" value="N"
<c:if test="${parkingDTO.parking_electriccar_check eq 'N'}">checked</c:if>>불가능
</div>

<div>
<label for="parking_electriccar_spaces">전기차 충전 가능 공간 : </label> 
<input type="text" name="parking_electriccar_spaces" id="parking_electriccar_spaces" value="${parkingDTO.parking_electriccar_spaces}">석
</div>

<div>
<label for="parking_pay_type">적용 가능 할인권 : </label> 
<input type="radio" name="parking_pay_type" id="parking_pay_type" value="R"
<c:if test="${parkingDTO.parking_pay_type eq 'R'}">checked</c:if>>정기권
<input type="radio" name="parking_pay_type" id="parking_pay_type" value="T"
<c:if test="${parkingDTO.parking_pay_type eq 'T'}">checked</c:if>>시간권
<input type="radio" name="parking_pay_type" id="parking_pay_type" value="RT"
<c:if test="${parkingDTO.parking_pay_type eq 'RT'}">checked</c:if>>모두(정기권, 시간권)
</div>

<div>
<label for="parking_base_fee">1시간 당 기본요금 : </label> 
<input type="text" name="parking_base_fee" id="parking_base_fee" value="${parkingDTO.parking_base_fee}">원 
<br>[참고] 금액은 숫자 및 콤마로 구분하여 기재해주세요. (ex. 10,000 or 15,000 등)
</div>

<div>
<label for="parking_hourly_rate">10분 over time 시 추가 요금 : </label> 
<input type="text" name="parking_hourly_rate" id="parking_hourly_rate" value="${parkingDTO.parking_hourly_rate}">원 
<br>[참고] 금액은 숫자 및 콤마로 구분하여 기재해주세요. (ex. 10,000 or 15,000 등)
</div>
			
<div>

<div>
<label for="parking_photo1">주차장 이미지 1 :</label> &nbsp;
<c:if test="${not empty parkingDTO.parking_photo1_path}">
<img alt="주차장 사진 1" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member_code}&filename=${parkingDTO.parking_photo1_name}"
onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member_code}/${parkingDTO.parking_photo1_name}')"> &nbsp;
<input type="checkbox" name="delete_photo1" value="1" onclick="toggleFileInput(this, 'parking_photo1')"> 삭제
</c:if>
&nbsp;
<input type="file" name="parking_photo1" id="parking_photo1" accept="image/*">
<input type="hidden" name="parking_photo1_name" id="parking_photo1_name" value="${parkingDTO.parking_photo1_name}">
<input type="hidden" name="parking_photo1_path" id="parking_photo1_path" value="${parkingDTO.parking_photo1_path}">
</div>

<br>

<div>
<label for="parking_photo2">주차장 이미지 2 :</label> &nbsp;
<c:if test="${not empty parkingDTO.parking_photo2_path}">
<img alt="주차장 사진 2" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member_code}&filename=${parkingDTO.parking_photo2_name}"
onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member_code}/${parkingDTO.parking_photo2_name}')"> &nbsp;
<input type="checkbox" name="delete_photo2" value="1" onclick="toggleFileInput(this, 'parking_photo2')"> 삭제
</c:if>
&nbsp;
<input type="file" name="parking_photo2" id="parking_photo2" accept="image/*">
<input type="hidden" name="parking_photo2_name" id="parking_photo2_name" value="${parkingDTO.parking_photo2_name}">
<input type="hidden" name="parking_photo2_path" id="parking_photo2_path" value="${parkingDTO.parking_photo2_path}">
</div>

<br>

<div>
<label for="parking_photo3">주차장 이미지 3 :</label> &nbsp;
<c:if test="${not empty parkingDTO.parking_photo3_path}">
<img alt="주차장 사진 3" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member_code}&filename=${parkingDTO.parking_photo3_name}"
onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member_code}/${parkingDTO.parking_photo3_name}')"> &nbsp;
<input type="checkbox" name="delete_photo3" value="1" onclick="toggleFileInput(this, 'parking_photo3')"> 삭제
</c:if>
&nbsp;
<input type="file" name="parking_photo3" id="parking_photo3" accept="image/*">
<input type="hidden" name="parking_photo3_name" id="parking_photo3_name" value="${parkingDTO.parking_photo3_name}">
<input type="hidden" name="parking_photo3_path" id="parking_photo3_path" value="${parkingDTO.parking_photo3_path}">
</div>

<br>

<div>
<label for="parking_photo4">주차장 이미지 4 :</label> &nbsp;
<c:if test="${not empty parkingDTO.parking_photo4_path}">
<img alt="주차장 사진 4" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member_code}&filename=${parkingDTO.parking_photo4_name}"
onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member_code}/${parkingDTO.parking_photo4_name}')"> &nbsp;
<input type="checkbox" name="delete_photo4" value="1" onclick="toggleFileInput(this, 'parking_photo4')"> 삭제
</c:if>
&nbsp;
<input type="file" name="parking_photo4" id="parking_photo4" accept="image/*">
<input type="hidden" name="parking_photo4_name" id="parking_photo4_name" value="${parkingDTO.parking_photo4_name}">
<input type="hidden" name="parking_photo4_path" id="parking_photo4_path" value="${parkingDTO.parking_photo4_path}">
</div>

<br>

<div>
<label for="parking_photo5">주차장 이미지 5 :</label> &nbsp;
<c:if test="${not empty parkingDTO.parking_photo5_path}">
<img alt="주차장 사진 5" src="${pageContext.request.contextPath}/parkingThumbnail?member_code=${parkingDTO.member_code}&filename=${parkingDTO.parking_photo5_name}"
onclick="showImage('${pageContext.request.contextPath}/resources/Parking/${parkingDTO.member_code}/${parkingDTO.parking_photo5_name}')"> &nbsp;
<input type="checkbox" name="delete_photo5" value="1" onclick="toggleFileInput(this, 'parking_photo5')"> 삭제
</c:if>
&nbsp;
<input type="file" name="parking_photo5" id="parking_photo5" accept="image/*">
<input type="hidden" name="parking_photo5_name" id="parking_photo5_name" value="${parkingDTO.parking_photo5_name}">
<input type="hidden" name="parking_photo5_path" id="parking_photo5_path" value="${parkingDTO.parking_photo5_path}">
</div>
</div>

<!-- 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="imageModalLabel">이미지</h5>
<button type="button" class="close" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>
<div class="modal-body">
<img id="modalImage" src="" alt="큰 이미지" class="img-fluid">
</div>
</div>
</div>
</div>

<script>
    function showImage(imageSrc) {
        $('#modalImage').attr('src', imageSrc);
        $('#imageModal').modal('show');
    }

    function toggleFileInput(checkbox, fileInputId) {
        const fileInput = document.getElementById(fileInputId);
        if (checkbox.checked) {
            fileInput.disabled = true;
            fileInput.value = "";
        } else {
            fileInput.disabled = false;
        }
    }
</script>
			
<div>
<label for="parking_document_name">
<input type="hidden" name="parking_document_name" id="parking_document_name" value="${parkingDTO.parking_document_name}">
</label>
</div>
			
<div>
<label for="parking_document_path">
<input type="hidden" name="Parking_document_path" id="parking_document_path" value="${parkingDTO.parking_document_path}">
</label>
</div>

<div>
<label for="parking_approval"></label> 
<input type="hidden" name="parking_approval" id="parking_approval" value="${parkingDTO.parking_approval}">
</div>

<div>
<label for="parking_registration"></label> 
<input type="hidden" name="parking_registration" id="parking_registration" value="${parkingDTO.parking_registration}">
</div>

<!-- 현재 날짜 추출 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="date">
<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" />
</c:set>

<div>
<label for="parking_edit"></label> 
<input type="hidden" name="parking_edit" id="parking_edit" value="${date}">
</div>

<div>
<label for="member_code"></label> 
<input type="hidden" name="member_code" id="member_code" value="${parkingDTO.member_code}">
</div>

<div>
<button type="submit">등록</button>
<button type="reset" id="clear">취소</button>
</div>

</fieldset>
</form>

</body>

<script type="text/javascript">

$(function() {
	$("#update").submit(function() {
		
		if(!$("input[name='parking_name']").val()) {
			alert("주차장 이름을 입력하세요.");
			$("input[name='parking_name']").focus();
			return false;
		}
		
		var regexp_pk_name = /^[\s\S]{1,100}$/;
		var pk_name_check = $("input[name='parking_name']").val()
		
		if(!regexp_pk_name.test(pk_name_check)) {
			alert("주차장 이름은 공백을 포함한 한글, 영어, 숫자 100byte만 입력할 수 있습니다.");
			$("input[name='parking_name']").focus();
			return false;
		}
		
		if(!$("input[name='parking_address']").val()) {
			alert("주차장 주소을 입력하세요.");
			$("input[name='parking_address']").focus();
			return false;
		}
		
		var regexp_pk_address = /^[\s\S]{1,200}$/;
		var pk_address_check = $("input[name='parking_address']").val()
		
		if(!regexp_pk_address.test(pk_address_check)) {
			alert("주차장 주소는 공백을 포함한 한글, 영어, 숫자 200byte만 입력할 수 있습니다.");
			$("input[name='parking_address']").focus();
			return false;
		}
		
		if(!$("input[name='parking_latitude']").val()) {
			alert("주차장 주소의 위도를 입력하세요.");
			$("input[name='parking_latitude']").focus();
			return false;
		}
		
		var regexp_pk_latitude = /^-?([0-9]|[1-8][0-9]|90)(\.[0-9]{1,15})?$/;
		var pk_latitude_check = parseFloat($("input[name='parking_latitude']").val());
		
		if(!regexp_pk_latitude.test(pk_latitude_check) || pk_latitude_check < -90 || pk_latitude_check > 90) {
			alert("유효하지 않은 위도 입니다.");
			$("input[name='parking_latitudes']").focus();
			return false;
		}
		
		if(!$("input[name='parking_longitude']").val()) {
			alert("주차장 주소의 경도를 입력하세요.");
			$("input[name='parking_longitude']").focus();
			return false;
		}
		
		var regexp_pk_longitude = /^-?([0-9]|[1-9][0-9]|1[0-7][0-9]|180)(\.[0-9]{1,15})?$/;
		var pk_longitude_check = parseFloat($("input[name='parking_longitude']").val());
		
		if(!regexp_pk_longitude.test(pk_longitude_check) || pk_longitude_check < -180 || pk_longitude_check > 180) {
			alert("유효하지 않은 경도 입니다.");
			$("input[name='parking_longitude']").focus();
			return false;
		}
		
		if(!$("input[name='parking_operation']").val()) {
			alert("주차장 운영 시간을 입력하세요.");
			$("input[name='parking_operation']").focus();
			return false;
		}
		
		var regexp_pk_operation = /^\d{2}:\d{2}~\d{2}:\d{2}$/;
		var pk_operation_check = $("input[name='parking_operation']").val()
		
		if(!regexp_pk_operation.test(pk_operation_check)) {
			alert("주차장 운영 시간은 09:00~18:00와 동일한 형식만 입력할 수 있습니다.");
			$("input[name='parking_operation']").focus();
			return false;
		}
		
		var [startTime, endTime] = pk_operation_check.split('~');
		var [startHour, startMinute] = startTime.split(':').map(Number);
	    var [endHour, endMinute] = endTime.split(':').map(Number);
	    
	    if (isNaN(startHour) || isNaN(startMinute) || isNaN(endHour) || isNaN(endMinute) ||
	            startHour < 0 || startHour > 23 || startMinute < 0 || startMinute > 59 ||
	            endHour < 0 || endHour > 24 || endMinute < 0 || endMinute > 59) {
	    	alert("주차장 운영 시간이 유효하지 않습니다.");
			$("input[name='parking_operation']").focus();
	            return false;
	        }
	    
	    var startTotalMinutes = startHour * 60 + startMinute;
	    var endTotalMinutes = endHour * 60 + endMinute;
	    
	    if (startTotalMinutes >= endTotalMinutes) {
	    	alert("주차장 운영 시작 시간은 종료 시간보다 이전 이여야 합니다.");
			$("input[name='parking_operation']").focus();
	        return false;
	    }
	    
	    if(!$("input[name='parking_type']").is(":checked")) {
			alert("주차장 종류를 선택하세요.");
			$("input[name='parking_type']:eq(0)").focus( );
			return false;
		}
	    
	    if(!$("input[name='parking_total_spaces']").val()) {
			alert("주차 공간을 입력하세요.");
			$("input[name='parking_total_spaces']").focus();
			return false;
		}
		
		var regexp_pk_total_spaces = /^[0-9]{1,5}$/;
		var pk_total_spaces_check = $("input[name='parking_total_spaces']").val()
		
		if(!regexp_pk_total_spaces.test(pk_total_spaces_check)) {
			alert("주차 공간은 최대 5자리 숫자만 입력할 수 있습니다.");
			$("input[name='parking_total_spaces']").focus();
			return false;
		}
	    
	    if(!$("input[name='parking_electriccar_check']").is(":checked")) {
			alert("전기차 충전 가능 여부를 선택하세요.");
			$("input[name='parking_electriccar_check']:eq(0)").focus( );
			return false;
		}
	    
	    if(!$("input[name='parking_electriccar_spaces']").val()) {
			alert("전기차 주차 가능 공간을 입력하세요.");
			$("input[name='parking_electriccar_spaces']").focus();
			return false;
		}
		
		var regexp_pk_electriccar_spaces = /^[0-9]{1,5}$/;
		var pk_electriccar_spaces_check = $("input[name='parking_electriccar_spaces']").val()
		
		if(!regexp_pk_electriccar_spaces.test(pk_electriccar_spaces_check)) {
			alert("전기차 주차 공간은 최대 5자리 숫자만 입력할 수 있습니다.");
			$("input[name='parking_electriccar_spaces']").focus();
			return false;
		}
		
		if(!$("input[name='parking_pay_type']").is(":checked")) {
			alert("적용 가능 할인권을 선택하세요.");
			$("input[name='parking_pay_type']:eq(0)").focus( );
			return false;
		}
		
		if(!$("input[name='parking_base_fee']").val()) {
			alert("1시간 당 기본 요금을 입력하세요.");
			$("input[name='parking_base_fee']").focus();
			return false;
		}
		
		var regexp_pk_base_fee = /^\d+(\,\d+)?$/;
		var pk_base_fee_check = $("input[name='parking_base_fee']").val()
		
		if(!regexp_pk_base_fee.test(pk_base_fee_check)) {
			alert("기본 요금이 유효하지 않습니다.\n숫자 및 ,(쉼표)로 구분하여 기재 (ex. 10,000 or 15,000 등)");
			$("input[name='parking_base_fee']").focus();
			return false;
		}
		
		if(pk_base_fee_check.length > 10) {
			alert("기본 요금은 최대 10자리까지 가능합니다.");
			$("input[name='parking_base_fee']").focus();
			return false;
		}
		
		if(!$("input[name='parking_hourly_rate']").val()) {
			alert("10분 경과 시 추가 요금을 입력하세요.");
			$("input[name='parking_hourly_rate']").focus();
			return false;
		}
		
		var regexp_pk_hourly_rate = /^\d+(\,\d+)?$/;
		var pk_hourly_rate_check = $("input[name='parking_hourly_rate']").val()
		
		if(!regexp_pk_hourly_rate.test(pk_hourly_rate_check)) {
			alert("추가 요금이 유효하지 않습니다.\n숫자 및 ,(쉼표)로 구분하여 기재 (ex. 10,000 or 15,000 등)");
			$("input[name='parking_hourly_rate']").focus();
			return false;
		}
		
		if(pk_hourly_rate_check.length > 10) {
			alert("추가 요금은 최대 10자리까지 가능합니다.");
			$("input[name='parking_hourly_rate']").focus();
			return false;
		}
		
	});
});

</script>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 등록</title>
</head>
<body>

	<script type="text/javascript">
		alert("주차 기록 정보를 등록하였습니다. \n차량번호 : ${recordsDTO.member_car_num} , 주차장 : ${recordsDTO.parking_name}");
		location.href = "./RecordsSelectParking?parking_code=${recordsDTO.parking.parking_code}"
	</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 수정</title>
</head>
<body>

	<script type="text/javascript">
		alert("주차 기록 정보를 수정하였습니다. \n주차기록 코드번호 : ${recordsDTO.records_code}, 차량번호 : ${recordsDTO.member_car_num}");
		location.href = "./RecordsSelectParking?parking_code=${recordsDTO.parking_code}"
	</script>

</body>
</html>
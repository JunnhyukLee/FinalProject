<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차 기록 삭제</title>
</head>
<body>

	<script type="text/javascript">
		alert("${recordsDTO.records_code} 주차 기록 정보를 삭제하였습니다.");
		location.href = "./RecordsSelectParking?parking_code=${recordsDTO.parking_code}"
	</script>

</body>
</html>
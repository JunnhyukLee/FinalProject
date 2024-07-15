<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 정보 수정</title>
</head>
<body>
	
	<script type="text/javascript">
		alert("${parkingDTO.parking_code}번의 주차장 정보를 수정하였습니다.");
		location.href = "./ParkingSelectAll?member_code=${parkingDTO.member_code}";
	</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 등록</title>
</head>
<body>
        
	<script type="text/javascript">
		alert("입력하신 ${parkingDTO.parking_name}을 등록하였습니다.");
		location.href = "./ParkingSelectAll?member_code=${parkingDTO.member_code}"
	</script>

</body>
</html>
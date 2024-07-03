<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 주차관리 </title>
<link rel="stylesheet" type="text/css" href="./css/style.css">
<style>
    form {
        text-align: center; 
        margin-top: 10px; 
    }
</style>
</head>
<body>
    <div>
        <form id="searchForm" action="./ParkingSearch" method="get">
            <input type="text" name="keyword" id="keyword" placeholder="장소 검색">
            <button type="submit" id="submitBtn">검색</button>
        </form>
    </div>
</body>
</html>

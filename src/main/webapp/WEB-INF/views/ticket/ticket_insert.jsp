<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> 정기권 정보 입력 </title>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1> 정기권 정보 입력 </h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light">
</section>
<section id="department">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5> 정기권 입력 </h5>
                    </div>
                    <div class="card-body">
                        <form action="./TicketInsert" method="post" id="sign_ticket" onsubmit="return validateForm()">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="dname" class="ml-sm-3 col-form-label"> 종류 </label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_type" id="ticket_type" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="loc" class="ml-sm-3 col-form-label"> 이름 </label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_name" id="ticket_name" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="dname" class="ml-sm-3 col-form-label"> 적용기간(일) </label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_days" id="ticket_days" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="dname" class="ml-sm-3 col-form-label"> 적용기간(시간) </label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_time" id="ticket_time" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="dname" class="ml-sm-3 col-form-label"> 가격 </label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_price" id="ticket_price" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-secondary"> 등록 </button>
                                    <button type="reset" class="btn btn-secondary"> 취소 </button>
                                </div>
                            </fieldset>
                        </form>
                        <div>
                            <a href="./TicketSearch" class="btn btn-primary btn-block"> 정기권 목록 </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
function validateForm() {
    
    var numericRegex = /^[0-9]+$/;
    var typeRegex = /^[가-힣]{1,4}$/;
    var nameRegex = /^[0-9][가-힣]{1,8}$/;
    var daysRegex = /^[0-9]{0,4}$/; // 수정된 부분: 빈칸도 허용
    var timeRegex = /^[0-9]{0,3}$/; // 수정된 부분: 빈칸도 허용
    var priceRegex = /^[0-9]{1,20}$/;
    
    var ticketCode = document.getElementById("ticket_code").value;
    var ticketType = document.getElementById("ticket_type").value;
    var ticketName = document.getElementById("ticket_name").value;
    var ticketDays = document.getElementById("ticket_days").value;
    var ticketTime = document.getElementById("ticket_time").value;
    var ticketPrice = document.getElementById("ticket_price").value;
    
    
    if (ticketCode === "" || ticketType === "" || ticketName === "" || ticketPrice === "") {
        alert("빈칸을 채워주세요.");
        return false;
    }
    if (!numericRegex.test(ticketCode)) {
        alert("정기권 코드 : 숫자로 입력해주세요.");
        return false;
    }
    if (!typeRegex.test(ticketType)) {
        alert("정기권 종류 : 한글 4글자까지 입력해주세요.");
        return false;
    }
    if (!nameRegex.test(ticketName)) {
        alert("정기권 이름 : 한글 8글자까지 입력해주세요.");
        return false;
    }
    // 수정된 부분: 빈칸도 허용
    if (!daysRegex.test(ticketDays)) {
        alert("유효기간(일) : 숫자 4자리까지 입력해주세요.");
        return false;
    }
    // 수정된 부분: 빈칸도 허용
    if (!timeRegex.test(ticketTime)) {
        alert("유효기간(시간) : 숫자 3자리까지 입력해주세요.");
        return false;
    }
    if (!priceRegex.test(ticketPrice)) {
        alert("가격 : 숫자 20자리까지 입력해주세요.");
        return false;
    }
    return true;
}
</script>
</body>
</html>

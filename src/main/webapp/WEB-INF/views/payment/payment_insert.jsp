<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 정보 입력</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
var IMP = window.IMP;
IMP.init("imp75221483");

function requestPay(payment_name, payment_total) {
    IMP.request_pay({
        pg: "html5_inicis",
        merchant_uid: new Date().getTime().toString(),
        name: payment_name,
        amount: payment_total
    }, function (rsp) {
        if (rsp.success) {
            var paymentData = {
                payment_code: rsp.merchant_uid,
                payment_name: payment_name,
                payment_total: payment_total
            };

            $.ajax({
                type: "POST",
                url: "/PaymentInsert",
                contentType: "application/json",
                data: JSON.stringify(paymentData),
                success: function (response) {
                    alert("결제가 성공적으로 완료되었습니다.");
                    window.location.href = "/PaymentSelect";
                },
                error: function () {
                    alert("결제 정보 저장에 실패하였습니다.");
                }
            });
        } else {
            alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
        }
    });
}
</script>
</head>
<body>
    <button onclick="requestPay('종일 주차권', 100)">종일 주차권 (100원)</button>
    <br><br>
    <input type="number" id="hourlyQuantity" min="1" max="10" placeholder="선택">
    <button onclick="requestPay('시간당 주차권', document.getElementById('hourlyQuantity').value * 10)">시간당(10원) 주차권 구매</button>
</body>
</html>

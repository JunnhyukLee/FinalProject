<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 요금</title>
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
                    <h1>요금 정산</h1>
                </div>
            </div>
        </div>
    </header>
    <section class="py-4 mb-4 bg-light"></section>
    <section id="department">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>정산 목록</h5>
                        </div>
                        <div class="card-body">
                            <form id="selectForm">
                                <table class="table table-hover">
                                    <thead class="thead-light">
                                        <tr class="text-center">
                                            <th>선택</th>
                                            <th>사용자 id</th>
                                            <th>정산 날짜</th>
                                            <th>정산 금액</th>
                                            <th>정산 상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="list" items="${calculateList}">
                                            <tr class="text-center">
                                                <td><input type="radio" name="selectedRow"
                                                    value="${list.calculate_code}" data-amount="${list.calculate_amount}"></td>
                                                <td>${list.member_id}</td>
                                                <td>
                                                    <fmt:formatDate value="${list.calculate_date}" pattern="yyyy.MM.dd HH:mm" />
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${list.calculate_amount}" type="number" maxFractionDigits="0"/>원
                                                </td>
                                                <td>${list.calculate_status}</td>
                                            </tr>
                                        </c:forEach>
                                        
                                    </tbody>
                                </table>
                                <!-- 추가된 숨겨진 필드 -->
                                <input type="hidden" name="code" id="code" value="calculate_code">
                                <input type="hidden" name="amount" id="amount" value="calculate_amount">
                                <div class="text-right">
                                    <button type="button" class="btn btn-primary" id="payButton">결제하기</button>
                                </div>
                            </form>
                            <form id="paymentForm" method="get" action="./payment" style="display:none;">
                                <input type="hidden" name="code" id="hiddenCode">
                                <input type="hidden" name="amount" id="hiddenAmount">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#payButton').click(function(e) {
                var selectedRow = $('input[name="selectedRow"]:checked');
                if (!selectedRow.val()) {
                    alert('결제할 항목을 선택하세요.');
                    return;
                }

                var calculate_code = selectedRow.val();
                var calculate_amount = selectedRow.data('amount');

                // 숨겨진 필드에 값 설정
                $('#code').val(calculate_code);
                $('#amount').val(calculate_amount);

                // 별도의 폼 제출
                $('#hiddenCode').val(calculate_code);
                $('#hiddenAmount').val(calculate_amount);
                $('#paymentForm').submit();
            });
        });
    </script>
</body>
</html>

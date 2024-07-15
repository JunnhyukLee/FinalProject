<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>주차장 찾기</title>
    <link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
</head>
<body>

    <div class="search-container">
        <input type="text" id="searchInput" placeholder="주차장 이름 검색">
        <button onclick="search()" id="searchBtn">검색</button>
    </div>
    
    <div id="sidebar">
        <button onclick="location.href = '/'">메인 페이지</button>
        <h2>주차장 리스트</h2>
        <ul id="markerList"></ul>
    </div>
    <div id="map"></div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        var map;
        var markers = [];

        function initMap() {
            var mapElement = document.getElementById('map');
            var mapOptions = {
                center: { lat: 37.5665, lng: 126.9780 },
                zoom: 10
            };
            map = new google.maps.Map(mapElement, mapOptions);

            var arrayList = [
                <c:forEach var="parking" items="${ParkingList}" varStatus="status">
                    {
                        lat: ${parking.parking_latitude},
                        lng: ${parking.parking_longitude},
                        name: '${parking.parking_name}',
                        address: '${parking.parking_address}',
                        base_fee: '${parking.parking_base_fee}',
                        hourly_fee: '${parking.parking_hourly_rate}',
                        type: '${parking.parking_type}',
                        code: '${parking.parking_code}'
                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];

            for (var i = 0; i < arrayList.length; i++) {
                addMarker(arrayList[i]);
            }
        }

        function addMarker(parking) {
            var marker = new google.maps.Marker({
                position: { lat: parking.lat, lng: parking.lng },
                map: map,
                title: parking.name
            });
            markers.push({ marker: marker, data: parking });

            var markerListItem = document.createElement('li');
            markerListItem.textContent = parking.name;
            markerListItem.addEventListener('click', function() {
                map.setCenter(marker.getPosition());
                map.setZoom(15);
            });
            document.getElementById('markerList').appendChild(markerListItem);

            marker.addListener('click', function() {
                fetchComments(parking.code, function(contentString) {
                    var infoWindow = new google.maps.InfoWindow({
                        content: contentString
                    });
                    infoWindow.open(map, marker);
                    map.setCenter(marker.getPosition());
                    map.setZoom(15);
                });
            });
        }

        function fetchComments(parking_code, callback) {
            $.ajax({
                url: './getParkingComments',
                method: 'GET',
                data: { parking_code: parking_code },
                success: function(response) {
                    var contentString = '<div class="infowindow-content">' +
                                        '<strong>' + response.name + '</strong>' +
                                        '<div class="address">주소: ' + response.address + '</div>' +
                                        '<div class="fee">기본 요금: ' + response.base_fee + '원<br>' +
                                        '시간당 요금: ' + response.hourly_fee + '원<br>' +
                                        '유형: ' + response.type + '</div>' +
                                        '<div class="operation">운영시간: ' + response.operation + '</div>' +
                                        '<div class="spaces">주차공간: ' + response.total_spaces + '석</div>' +
                                        '<div class="electriccar_check">전기차 주차가능 여부: ' + (response.electriccar_check ? '가능' : '불가능') + '</div>' +
                                        '<div class="electriccar_spaces">전기차 주차공간: ' + response.electriccar_spaces + '석</div>' +
                                        '<h3>후기</h3><table>';

                    if (response.comments && response.comments.length > 0) {
                        for (var i = 0; i < response.comments.length; i++) {
                            var comment = response.comments[i];
                            var formattedDate = new Date(comment.comment_date).toISOString().slice(0, 19).replace('T', ' ');
                            contentString += '<tr>' +
                                                '<td>' + comment.comment_content + '</td>' +
                                                '<td>' + formattedDate + '</td>' +
                                            '</tr>';
                        }
                    } else {
                        contentString += '<tr><td colspan="2">등록된 후기가 없습니다.</td></tr>';
                    }

                    contentString += '</table>' +
                                     '<button onclick="redirectToAnotherPage()">이용권 구매하기</button></div>';
                    callback(contentString);
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 요청 실패:', status, error);
                    alert('후기를 불러오는 데 실패했습니다.');
                }
            });
        }


        function redirectToAnotherPage() {
            window.location.href = './TicketListTime';
        }

        function search() {
            var keyword = document.getElementById('searchInput').value.trim();
            if (keyword === '') {
                alert('검색어를 입력해주세요.');
                return;
            }

            var found = false;
            for (var i = 0; i < markers.length; i++) {
                if (markers[i].data.name === keyword) {
                    var marker = markers[i].marker;
                    map.setCenter(marker.getPosition());
                    map.setZoom(15);
                    found = true;
                    break;
                }
            }

            if (!found) {
                alert('"' + keyword + '" 주차장을 찾을 수 없습니다.');
            }
        }
    </script>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCIFXYz24Zfop2MDOoTrcH1MwE1eWYsWPo&callback=initMap" async defer></script>

</body>
</html>

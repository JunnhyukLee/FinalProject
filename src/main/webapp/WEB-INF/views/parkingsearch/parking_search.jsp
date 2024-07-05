<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>주차장 찾기</title>
    <link rel="stylesheet" type="text/css" href="./css/style.css">
    <script type="text/javascript">
        var contextPath = '<%= request.getContextPath() %>';
    </script>
</head>
<body>
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="장소 검색" value="${keyword}">
        <button onclick="search()" id="searchBtn">검색</button>
    </div>
    
    <div id="sidebar">
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
                    var contentString = '<div class="infowindow-content"><strong>' + response.name + '</strong><br>' +
                                        '<div class="address">주소: ' + response.address + '</div>' +
                                        '<div class="fee">기본 요금: ' + response.base_fee + '원<br>' +
                                        '시간당 요금: ' + response.hourly_fee + '원<br>' +
                                        '유형: ' + response.type + '</div>' +
                                        '<img src="' + contextPath + response.photo_path + '" alt="주차장 이미지" style="width:400px;height:auto;"><br>' +
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
            var keyword = document.getElementById('searchInput').value;
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ address: keyword }, function(results, status) {
                if (status === 'OK') {
                    var location = results[0].geometry.location;
                    map.setCenter(location);
                    map.setZoom(15);
                } else {
                    alert('장소를 찾을 수 없습니다.');
                }
            });
        }

        function clearMarkers() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].marker.setMap(null);
            }
        }
    </script>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDRoUI4ZJ0PzjfWL4pC_2e4vH0s5S63IgA&callback=initMap" async defer></script>
</body>
</html>

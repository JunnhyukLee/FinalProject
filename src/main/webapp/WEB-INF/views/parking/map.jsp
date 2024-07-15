<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Address Search</title>    
    <meta charset="utf-8">
    <script>
        function initAutocomplete() {
            var input = document.getElementById('pac-input');
            var autocomplete = new google.maps.places.Autocomplete(input);
            autocomplete.setFields(['geometry', 'name']);
            
            autocomplete.addListener('place_changed', function() {
                var place = autocomplete.getPlace();
                if (!place.geometry) {
                    window.alert("No details available for input: '" + place.name + "'");
                    return;
                }

                document.getElementById('latclick').value = place.geometry.location.lat();
                document.getElementById('lngclick').value = place.geometry.location.lng();
            });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA908IhDu2ndM4yxWsoFmwxuQdktW90N3E&libraries=places&callback=initAutocomplete" defer></script>
</head>
<body>
    <input id="pac-input" type="text" placeholder="Enter a location">
    <div>
        위도<input type="text" id="latclick" name="latclick" value="">
        경도<input type="text" id="lngclick" name="lngclick" value="">
    </div>
</body>
</html>

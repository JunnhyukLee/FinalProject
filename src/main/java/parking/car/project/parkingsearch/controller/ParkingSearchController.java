package parking.car.project.parkingsearch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import parking.car.project.commententity.Comment;
import parking.car.project.commentservice.CommentService;
import parking.car.project.parkingsearch.entity.Parking;
import parking.car.project.parkingsearch.service.ParkingSearchService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ParkingSearchController {

    private final ParkingSearchService parkingSearchService;
    private final CommentService commentService;

    @Autowired
    public ParkingSearchController(ParkingSearchService parkingSearchService, CommentService commentService) {
        this.parkingSearchService = parkingSearchService;
        this.commentService = commentService;
    }

    @GetMapping("/ParkingSearch")
    public String getParkingList(Model model) {
        List<Parking> parkingList = parkingSearchService.getAllParkings();
        model.addAttribute("ParkingList", parkingList);
        return "./parkingsearch/parking_search"; 
    }

    @GetMapping("/getParkingComments")
    @ResponseBody
    public Map<String, Object> getParkingComments(@RequestParam("parking_code") int parkingCode) {
        Parking parking = parkingSearchService.getParkingByCode(parkingCode);
        List<Comment> comments = commentService.findCommentsByParkingCode(parkingCode);

        Map<String, Object> response = new HashMap<>();
        response.put("name", parking.getParking_name());
        response.put("address", parking.getParking_address());
        response.put("base_fee", parking.getParking_base_fee());
        response.put("hourly_fee", parking.getParking_hourly_rate());
        response.put("type", parking.getParking_type());
        response.put("comments", comments);

        return response;
    }
}

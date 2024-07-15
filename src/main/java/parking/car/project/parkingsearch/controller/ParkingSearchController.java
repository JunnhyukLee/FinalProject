package parking.car.project.parkingsearch.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import parking.car.project.comment.entity.Comment;
import parking.car.project.comment.service.CommentService;
import parking.car.project.parking.entity.Parking;
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
        return "parkingsearch/parking_search"; 
    }

    @GetMapping("/getParkingComments")
    @ResponseBody
    public Map<String, Object> getParkingComments(@RequestParam("parking_code") int parking_code) {
        Parking parking = parkingSearchService.getParkingByCode(parking_code);
        List<Comment> comments = commentService.findCommentsByParkingCode(parking_code);

        Map<String, Object> response = new HashMap<>();
        response.put("name", parking.getParking_name());
        response.put("address", parking.getParking_address());
        response.put("base_fee", parking.getParking_base_fee());
        response.put("hourly_fee", parking.getParking_hourly_rate());
        response.put("type", parking.getParking_type());
        response.put("operation", parking.getParking_operation());
        response.put("total_spaces", parking.getParking_total_spaces());
        response.put("electriccar_check", parking.getParking_electriccar_check());
        response.put("electriccar_spaces", parking.getParking_electriccar_spaces());
        response.put("comments", comments);
        
        return response;
    }
}
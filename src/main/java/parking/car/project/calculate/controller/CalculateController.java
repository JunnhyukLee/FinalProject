package parking.car.project.calculate.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import parking.car.project.calculate.dao.CalculateDAO;
import parking.car.project.calculate.dto.CalculateDTO;

@Controller
public class CalculateController {
	

    @Autowired
    private CalculateDAO calculateDAO;

    @GetMapping("/CalculateInsert")
    public String calculateInsert() {
        return "calculate/calculate_insert";
    }

    @PostMapping("/CalculateFee")
    public String calculateFeeById(@RequestParam("member_code") int member_code, @RequestParam("parking_code") int parking_code, @RequestParam("records_code") int records_code, Model model) {
        
    	CalculateDTO calculateDTO2 = new CalculateDTO();
    	calculateDTO2.setMember_code(member_code);
    	calculateDTO2.setParking_code(parking_code);
    	calculateDTO2.setRecords_code(records_code);
    	
    	//calculateDAO.calculateInsert(calculateDTO2);

    	List<CalculateDTO> calculateList = calculateDAO.calculateSearch(member_code);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Timestamp currentDate = new Timestamp(System.currentTimeMillis()); 

        for (CalculateDTO calculateDTO : calculateList) {
            try {
                Timestamp startDate = new Timestamp(dateFormat.parse(calculateDTO.getRecords_start()).getTime());
                Timestamp endDate = new Timestamp(dateFormat.parse(calculateDTO.getRecords_end()).getTime());

                long elapsedTimeMillis = endDate.getTime() - startDate.getTime();
                long elapsedTimeMinutes = elapsedTimeMillis / (60 * 1000);

                double parkingFee = 0.0;
                if (elapsedTimeMinutes <= 60) {
                    parkingFee = Double.parseDouble(calculateDTO.getParking_base_fee());
                } else {
                	double baseFee = Double.parseDouble(calculateDTO.getParking_base_fee());
                    double hourlyRate = Double.parseDouble(calculateDTO.getParking_hourly_rate());
                    parkingFee = baseFee + (hourlyRate * Math.ceil((double) elapsedTimeMinutes / 60));
                }

                calculateDTO.setCalculate_amount(String.valueOf(parkingFee));
                calculateDTO.setCalculate_date(currentDate); 
                
                calculateDAO.calculateUpdate(calculateDTO);

            } catch (Exception e) {
               
            }
        }

        model.addAttribute("calculateList", calculateList);
        return "calculate/calculate_search_id";
    }
    
    @PostMapping("/UpdateCalStatus")
    @ResponseBody
    public String updateCalculateStatus(@RequestParam("calculate_code") int calculate_code) {
        boolean success = calculateDAO.updateCalculateStatus(calculate_code);
        if (success) {
            return "정산 상태 업데이트 성공";
        } else {
            
            return "정산 상태 업데이트 실패";
        }
    }
    
}
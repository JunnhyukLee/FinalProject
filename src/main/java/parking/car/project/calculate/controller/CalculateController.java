package parking.car.project.calculate.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.logging.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import parking.car.project.calculate.dao.CalculateDAO;
import parking.car.project.calculate.dto.CalculateDTO;
import parking.car.project.calculate.service.CalculateService;

@Controller
public class CalculateController {

	

    @Autowired
    private CalculateDAO calculateDAO;

    @GetMapping("/CalculateInsert")
    public String calculateInsert() {
        return "./calculate/calculate_insert";
    }

    @PostMapping("/CalculateFee")
    public String calculateFeeById(@RequestParam("member_code") int member_code, Model model) {
        

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

                
                if (calculateDTO.getCalculate_amount() != null && !calculateDTO.getCalculate_amount().isEmpty()) {
                    calculateDTO.setCalculate_status("미정산");
                }

                
                calculateDAO.calculateUpdate(calculateDTO);

            } catch (Exception e) {
               
            }
        }

        model.addAttribute("calculateList", calculateList);
        return "./calculate/calculate_search_id";
    }
    
    @PostMapping("CalculatePay")
    public String CalculatePay(@RequestParam("calculate_code") int calculate_code, Model model) {
		
    	return "./calculate/calculate_search_id";
    	
    }
    
}
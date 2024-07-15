package parking.car.project.calculate.service;

import java.util.List;

import org.springframework.stereotype.Service;

import parking.car.project.calculate.dao.CalculateDAO;
import parking.car.project.calculate.dto.CalculateDTO;

@Service
public class CalculateService {

    private final CalculateDAO calculateDAO;

    public CalculateService(CalculateDAO calculateDAO) {
        this.calculateDAO = calculateDAO;
    }
    public List<CalculateDTO> calculateSearch(int member_code) {
        return calculateDAO.calculateSearch(member_code);
    }
    public boolean updateCalculateStatus(int calculate_code) {
        return calculateDAO.updateCalculateStatus(calculate_code);
    }
}
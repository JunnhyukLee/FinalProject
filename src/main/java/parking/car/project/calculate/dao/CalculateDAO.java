package parking.car.project.calculate.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import parking.car.project.calculate.dto.CalculateDTO;

@Mapper
@Transactional
public interface CalculateDAO {

	@Select("SELECT c.calculate_code, c.calculate_date, c.calculate_amount, "
            + "c.calculate_status, p.parking_base_fee, p.parking_hourly_rate, "
            + "r.records_start, r.records_end, m.member_code , m.member_id "
            + "FROM calculate c "
            + "JOIN parking p ON c.parking_code = p.parking_code "
            + "JOIN records r ON c.records_code = r.records_code "
            + "JOIN member m ON c.member_code = m.member_code "
            + "WHERE c.member_code = #{member_code}")
    public List<CalculateDTO> calculateSearch(int member_code);

	@Update("UPDATE calculate SET "
            + "calculate_amount = #{calculate_amount, jdbcType=VARCHAR}, "
            + "calculate_date = #{calculate_date, jdbcType=DATE}, "
            + "calculate_status = #{calculate_status, jdbcType=VARCHAR} "
            + "WHERE member_code = #{member_code, jdbcType=INTEGER}")
    public void calculateUpdate(CalculateDTO calculateDTO);
    
	@Update("UPDATE calculate SET calculate_status = '정산완료' WHERE calculate_code = #{calculate_code}")
    boolean updateCalculateStatus(@Param("calculate_code") int calculate_code);
    
    @Insert("INSERT INTO calculate(calculate_code, member_code, parking_code, records_code) "
    		+ "values(calculate_seq.NEXTVAL, #{member_code}, #{parking_code}, #{records_code})")
    public void calculateInsert(CalculateDTO calculateDTO);
    
}
package parking.car.project.records.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import parking.car.project.records.entity.Records;

public interface RecordsRepository extends JpaRepository<Records, Integer> {
	
	@Query("SELECT r FROM Records r WHERE r.member.member_code = :member_code")
	List<Records> findByMemberCode(@Param("member_code") Integer member_code);
	
	@Query("SELECT r FROM Records r WHERE r.parking.parking_code = :parking_code")
	List<Records> findByParkingCode(@Param("parking_code") Integer parking_code);

}
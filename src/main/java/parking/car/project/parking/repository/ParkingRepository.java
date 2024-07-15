package parking.car.project.parking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import parking.car.project.parking.entity.Parking;

public interface ParkingRepository extends JpaRepository<Parking, Integer> {
	
	@Query("SELECT p FROM Parking p WHERE p.member.member_code = :member_code")
	//select parking_code, parking_name, parking_approval from parking where member_code = ?
	List<Parking> findByMemberCode(@Param("member_code") Integer member_code);
	
	@Modifying
	@Query("UPDATE Records r SET r.parking.parking_code = NULL WHERE r.parking.parking_code = :parking_code")
	void nullParkingCodeInRecords(@Param("parking_code") Integer parking_code);

}
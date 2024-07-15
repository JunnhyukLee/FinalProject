package parking.car.project.parkingsearch.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import parking.car.project.parking.entity.Parking;

public interface ParkingSearchRepository extends JpaRepository<Parking, Integer> {
	@Query("SELECT p FROM Parking p WHERE p.parking_code = :parking_code")
    Parking findByParkingCode(@Param("parking_code") int parking_code);
	
}
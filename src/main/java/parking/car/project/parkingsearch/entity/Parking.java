package parking.car.project.parkingsearch.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@Entity
public class Parking {
	@Id
	private Integer parking_code;
	private String parking_name;
	private String parking_address;
	private Double parking_latitude;
	private Double parking_longitude;
	private String parking_base_fee;
	private String parking_hourly_rate;
	private String parking_type;
}


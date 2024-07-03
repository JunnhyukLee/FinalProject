package parking.car.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"parking.car.project.payment", "parking.car.project.coupon"})
//@EnableJpaRepositories(basePackages = "parking.car.project.payment.repository")
//@EntityScan(basePackages = "parking.car.project.payment.entity")
public class ParkingcarprojectApplication {

	public static void main(String[] args) {
		SpringApplication.run(ParkingcarprojectApplication.class, args);
	}
}
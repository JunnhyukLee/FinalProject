package parking.car.project.member.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import parking.car.project.member.entity.Member;

public interface MemberRepository extends JpaRepository<Member, Integer>{
	
	@Query("SELECT m FROM Member m WHERE m.member_car_num1 = :member_car_num OR m.member_car_num2 = :member_car_num OR m.member_car_num3 = :member_car_num")
	Member findMemberByCarNum(@Param("member_car_num") String member_car_num);

}

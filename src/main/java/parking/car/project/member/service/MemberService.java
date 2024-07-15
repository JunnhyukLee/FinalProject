package parking.car.project.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.member.entity.Member;
import parking.car.project.member.repository.MemberRepository;

@Service
public class MemberService {
	@Inject
	private MemberRepository memberRepository;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Transactional
	public Member saveMember(Member member) {
		if (member.getMember_code() == null) {
			Integer memberId = jdbcTemplate.queryForObject("SELECT member_seq.NEXTVAL FROM dual", Integer.class);
			member.setMember_code(memberId);
		}
		return memberRepository.save(member);
	}
	
	public boolean isMemberIdExists(String member_id) {
        Member member = memberRepository.findByMemberId(member_id);
        return member != null;
    }

	@Transactional(readOnly = true)
	public List<Member> findAllMembers() {
		return memberRepository.findAll();
	}

	@Transactional(readOnly = true)
	public Member findMemberById(Integer member_code) {
		return memberRepository.findById(member_code).orElse(null);
	}

	@Transactional
	public void deleteMemberById(Integer member_code) {
		memberRepository.deleteById(member_code);
	}

	public boolean existsByMember_code(Integer member_code) {
		return memberRepository.existsById(member_code);
	}

	// 화진 만듬
	@Transactional(readOnly = true)
	public Member findMemberByCarNum(String member_car_num) {
		return memberRepository.findMemberByCarNum(member_car_num);
	}
}
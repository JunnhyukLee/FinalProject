package parking.car.project.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import parking.car.project.member.entity.Member;
import parking.car.project.member.repository.MemberRepository;

@Service
public class CustomMemberDetailsService implements UserDetailsService {

    @Autowired
    private MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Member member = memberRepository.findByMemberId(username);
        if (member == null) {
            throw new UsernameNotFoundException("member_id를 찾을수 없습니다: " + username);
        }
        return new CustomMemberDetails(member);
    }
}

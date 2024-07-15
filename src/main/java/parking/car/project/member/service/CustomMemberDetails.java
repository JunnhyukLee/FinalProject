package parking.car.project.member.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import parking.car.project.member.entity.Member;

import java.util.Collection;
import java.util.Collections;

public class CustomMemberDetails implements UserDetails {
	
	private static final long serialVersionUID = 1L;
	private final Member member;

    public CustomMemberDetails(Member member) {
        this.member = member;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority(member.getMember_rating()));
    }

    @Override
    public String getPassword() {
        return "{noop}" + member.getMember_password(); // 비밀번호 인코딩 유지
    }

    @Override
    public String getUsername() {
        return member.getMember_id();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public Integer getMemberCode() {
        return member.getMember_code();
    }

    public String getMemberRating() {
        return member.getMember_rating();
    }
    
    public String getMemberName() {
        return member.getMember_name();
    }

    @Override
    public String toString() {
        return "CustomMemberDetails{" +
                "member_code=" + member.getMember_code() +
                ", member_id='" + member.getMember_id() + '\'' +
                ", member_rating='" + member.getMember_rating() + '\'' +
                ", member_name='" + member.getMember_name() + '\''+
                '}';
    }
}

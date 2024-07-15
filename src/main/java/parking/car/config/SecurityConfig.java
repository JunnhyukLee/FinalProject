package parking.car.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

import jakarta.inject.Inject;
import parking.car.project.member.service.CustomMemberDetailsService;

@Configuration
@EnableWebSecurity(debug = true) // 디버그 모드 활성화
public class SecurityConfig {
    private final AccessDeniedHandler accessDeniedHandler;
    private final CustomMemberDetailsService customMemberDetailsService;

    @Inject
    public SecurityConfig(AccessDeniedHandler accessDeniedHandler, CustomMemberDetailsService customMemberDetailsService) {
        this.accessDeniedHandler = accessDeniedHandler;
        this.customMemberDetailsService = customMemberDetailsService;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
            .csrf(csrf -> csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())) // CSRF 보호 활성화 및 쿠키에 CSRF 토큰 저장
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/login", "/MemberInsert").permitAll() // 로그인 및 회원가입 페이지 접근 허용
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/manager/**").hasRole("MANAGER")
                .requestMatchers("/member/**").authenticated() // 필요한 경우 수정
                .anyRequest().authenticated()) // 나머지 요청은 인증 필요
            .formLogin(form -> form
                .loginPage("/login")
                .permitAll()
                .loginProcessingUrl("/login_proc") // 로그인 처리 URL 설정
                .defaultSuccessUrl("/")
                .failureUrl("/login?error=true"))
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll())
            .exceptionHandling(exception -> exception.accessDeniedHandler(accessDeniedHandler));
        
        return httpSecurity.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Inject
    public void configure(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
        authenticationManagerBuilder
            .userDetailsService(customMemberDetailsService)
            .passwordEncoder(passwordEncoder());
    }
}

package parking.car.project.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;

@Configuration

public class FilterConfig {
	
	 @Bean
	 FilterRegistrationBean<CharacterEncodingFilter> characterEncodingFilter( ) {
	 FilterRegistrationBean<CharacterEncodingFilter> filterRegistrationBean = new FilterRegistrationBean< >( );
	 CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter( );
	 characterEncodingFilter.setEncoding("UTF-8");
	 characterEncodingFilter.setForceEncoding(true);
	 filterRegistrationBean.setFilter(characterEncodingFilter);
	 filterRegistrationBean.addUrlPatterns("/*");
	 return filterRegistrationBean;
	 }
	 @Bean 
	 FilterRegistrationBean<HiddenHttpMethodFilter> hiddenHttpMethodFilter( ) {
	 FilterRegistrationBean<HiddenHttpMethodFilter> filterRegistrationBean = new FilterRegistrationBean< >( );
	 HiddenHttpMethodFilter hiddenHttpMethodFilter = new HiddenHttpMethodFilter( );
	 filterRegistrationBean.setFilter(hiddenHttpMethodFilter);
	 filterRegistrationBean.addUrlPatterns("/*");
	 return filterRegistrationBean;
	 }
}

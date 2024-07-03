package parking.car.project.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import parking.car.project.servlet.InterceptorLogin;

import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
@Configuration

@ComponentScan(basePackages = {"parking.car.project"})
public class ServletConfig implements WebMvcConfigurer {
@Override
public void addInterceptors(InterceptorRegistry interceptorRegistry) {
interceptorRegistry.addInterceptor(new InterceptorLogin( )).addPathPatterns("/admin/**");
}
}
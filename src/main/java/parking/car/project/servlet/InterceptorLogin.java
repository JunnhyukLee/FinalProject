package parking.car.project.servlet;

import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InterceptorLogin  implements HandlerInterceptor {
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(InterceptorLogin.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("세션의 admin 속성을 검사하기 시작한다.");
		if(request.getSession().getAttribute("admin") == null) {
			logger.info("admin 속성이 세션에 없으며 사용자가 로귿인 페이지로 리다이렉트된다.");
			response.sendRedirect("/");
			return false;
		}
		return true;
	}
}
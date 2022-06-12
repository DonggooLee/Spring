package org.ddongq.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	
	// 로그인 버튼 클릭시 접근이 권한에 맞게 로그인 하면 커스텀한 Handler 를 사용하게 된다
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
			log.warn("Login Success");
			
			// 권한 저장을 위한 list => 권한이 한개가 아닐 수 도 있기 때문!
			List<String> roleName = new ArrayList<String>();
			
			// Handler 는 성공 시 알아서 authentication에 매개변수를 받아줌 (권한 가져오기)
			for(GrantedAuthority auth : authentication.getAuthorities()){
				roleName.add(auth.getAuthority());
			}
			
			log.warn("ROLE NAME : " + roleName);
			
			// 높은 권한을 위에 작성해줘야 한다 => 그 이유는 높은권한은 낮은권한도 가지고 있기 때문에
			if(roleName.contains("ROLE_ADMIN")) {
				response.sendRedirect("/sample/admin");
				return;
			}
			
			if(roleName.contains("ROLE_MEMBER")) {
				response.sendRedirect("/sample/member");
				return;
			}
			
			// 둘다 없을 경우
			response.sendRedirect("/");
		
	}

}

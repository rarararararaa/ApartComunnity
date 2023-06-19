package kr.secondhand.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class WriteFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			//로그인이 안된 경우
			return "redirect:/member/loginForm.do";
		}
		
		
		return "/WEB-INF/views/secondhand/secondhandwriteForm.jsp";
	}

}

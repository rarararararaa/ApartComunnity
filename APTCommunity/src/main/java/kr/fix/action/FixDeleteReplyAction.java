package kr.fix.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.fix.dao.FixDAO;
import kr.fix.vo.FixReplyVO;

public class FixDeleteReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//전송된 데이터 반환
		int re_num = Integer.parseInt(request.getParameter("re_num"));
		
		
		System.out.println(re_num);
		Map<String,String> mapAjax = new HashMap<String,String>();
		FixDAO dao = FixDAO.getInstance();
		FixReplyVO db_reply = dao.getFixReply(re_num);
		
		HttpSession session = request.getSession();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if (user_num==null) {
			mapAjax.put("result", "logout");
		}else if (user_num!=null && user_num==db_reply.getMem_num()) {
		//로그인 되어있고, 로그인한 회원번호와 작성자 회원번호가 일치하는 경우
			dao.deleteFixReply(re_num);
			mapAjax.put("result", "success");
		}else if(user_num!=null && user_auth==9) {
		//관리자인 경우
			dao.deleteFixReply(re_num);
			mapAjax.put("result", "success");
		}
		else {
		//로그인이 되어있고, 로그인한 회원번호와 작성자 회원번호가 "불"일치하는 경우
			mapAjax.put("result", "wrongAccess");
		}
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}

package kr.notice.action;

import kr.notice.vo.NoticeVO;
import java.util.List;
import javax.servlet.http.HttpSession;
import kr.util.PageUtil2;
import kr.notice.dao.NoticeDAO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import kr.controller.Action;

public class NoticeListAction implements Action
{
    public String execute( HttpServletRequest request,  HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Integer user_num = (Integer)session.getAttribute("user_num");
        if (user_num == null) {
            return "redirect:/member/loginForm.do";
        }
         int dept = Integer.parseInt(request.getParameter("dept"));
        System.out.println(dept);
        request.setCharacterEncoding("utf-8");
        String pageNum = request.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }
         String keyword = request.getParameter("keyword");
         NoticeDAO dao = NoticeDAO.getInstance();
         int count = dao.getCount(dept, keyword);
         PageUtil2 page = new PageUtil2("1", keyword, Integer.parseInt(pageNum), count, 5, 10, "noticeList.do?dept=" + dept);
        List<NoticeVO> list = null;
        if (count > 0) {
            list = dao.getList(dept, keyword, page.getStartRow(), page.getEndRow());
        }
        request.setAttribute("dept", dept);
        request.setAttribute("count", count);
        request.setAttribute("list", list);
        request.setAttribute("page", page.getPage());
        return "/WEB-INF/views/notice/NoticeList.jsp";
    }
}
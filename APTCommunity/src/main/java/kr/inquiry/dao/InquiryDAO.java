package kr.inquiry.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.inquiry.vo.InquiryVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class InquiryDAO {
	//싱글턴 패턴
	private static InquiryDAO instance = new InquiryDAO();
	public static InquiryDAO getInstance() {
		return instance;
	}
	private InquiryDAO() {}
	
	//글 등록
	public void insertInquiry(InquiryVO inquiry)
									throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO inquiry (in_num,"
					+ "title,content,filename,ip,mem_num) "
					+ "VALUES (inquiry_seq.nextval,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터를 바인딩
			pstmt.setString(1, inquiry.getTitle());
			pstmt.setString(2, inquiry.getContent());
			pstmt.setString(3, inquiry.getFilename());
			pstmt.setString(4, inquiry.getIp());
			pstmt.setInt(5, inquiry.getMem_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//검색 레코드 수
	public int getInquiryCount(String keyfield,
            					String keyword)
            				throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE q.title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE m.dongho LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE q.content LIKE ?";
			}

			//SQL문 작성
			sql = "SELECT COUNT(*) FROM inquiry q "
					+ "JOIN member m USING(mem_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null 
					&& !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
			}

			//SQL 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}	
		return count;
	}
	
	//글 목록(검색글 목록)
	public List<InquiryVO> getListInquiry(
		      int start, int end,
	 String keyfield,String keyword)
                throws Exception{
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	List<InquiryVO> list = null;
	String sql = null;
	String sub_sql = "";
	int cnt = 0;
	
	try {
		//커넥션풀로부터 커넥션을 할당
		conn = DBUtil.getConnection();
		
		if(keyword != null && !"".equals(keyword)) {
			if(keyfield.equals("1")) sub_sql += "WHERE q.title LIKE ?";
			else if(keyfield.equals("2")) sub_sql += "WHERE m.dongho LIKE ?";
			else if(keyfield.equals("3")) sub_sql += "WHERE q.content LIKE ?";
		}
		
		//SQL문 작성
		sql = "SELECT * FROM (SELECT a.*,"
			+ "rownum rnum FROM (SELECT * "
			+ "FROM inquiry q JOIN member m "
			+ "USING(mem_num) " + sub_sql + " ORDER BY "
			+ "q.in_num DESC)a) "
			+ "WHERE rnum>=? AND rnum<=?";
		//PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);
		//?에 데이터 바인딩
		if(keyword != null 
				    && !"".equals(keyword)) {
			pstmt.setString(
					++cnt, "%" + keyword + "%");
		}
		pstmt.setInt(++cnt, start);
		pstmt.setInt(++cnt, end);
		
		//SQL문 실행
		rs = pstmt.executeQuery();
		list = new ArrayList<InquiryVO>();
		while(rs.next()) {
			InquiryVO inquiry = new InquiryVO();
			inquiry.setIn_num(
					rs.getInt("in_num"));
			inquiry.setTitle(
					StringUtil.useNoHtml(
						rs.getString("title")));
			inquiry.setReg_date(
					rs.getDate("reg_date"));
			inquiry.setDongho(rs.getString("dongho"));
			
			//자바빈을 ArrayList에 저장
			list.add(inquiry);
		}
	}catch(Exception e) {
		throw new Exception(e);
	}finally {
		//자원정리
		DBUtil.executeClose(rs, pstmt, conn);
	}
	return list;
}	
	
	//글 상세
	public InquiryVO getInquiry(int in_num)
            			throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		InquiryVO inquiry = null;
		String sql = null;

		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL 작성
			sql = "SELECT * FROM inquiry q "
					+ "JOIN member m USING(mem_num) "
					+ "LEFT OUTER JOIN member_detail d "
					+ "USING(mem_num) WHERE q.in_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터를 바인딩
			pstmt.setInt(1, in_num);
			//SQL문을 실행해서 결과행을 ResultSet에 담음
			rs = pstmt.executeQuery();
			if(rs.next()) {
				inquiry = new InquiryVO();
				inquiry.setIn_num(
						rs.getInt("in_num"));
				inquiry.setTitle(rs.getString("title"));
				inquiry.setContent(rs.getString("content"));
				inquiry.setReg_date(rs.getDate("reg_date"));
				inquiry.setModify_date(
			       rs.getDate("modify_date"));
				inquiry.setFilename(rs.getString("filename"));
				inquiry.setMem_num(rs.getInt("mem_num"));
				inquiry.setDongho(rs.getString("dongho"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return inquiry;
	}
	//파일 삭제
	
	//글 수정
	public void updateInquiry(InquiryVO inquiry)
						throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;

		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();

			if(inquiry.getFilename()!=null) {
				//파일을 업로드한 경우
				sub_sql += ",filename=?";
			}

			sql = "UPDATE inquiry SET title=?,"
					+ "content=?,modify_date=SYSDATE" 
					+ sub_sql + ",ip=? WHERE in_num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 데이터를 바인딩
			pstmt.setString(++cnt, inquiry.getTitle());
			pstmt.setString(++cnt, inquiry.getContent());
			if(inquiry.getFilename()!=null) {
				pstmt.setString(++cnt, 
						inquiry.getFilename());
			}
			pstmt.setString(++cnt, inquiry.getIp());
			pstmt.setInt(++cnt, inquiry.getIn_num());

			//SQL문 실행
			pstmt.executeUpdate();

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 삭제
	public void deleteInquiry(int in_num)
            			throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//오토커밋 해제
			conn.setAutoCommit(false);

	//댓글 삭제
	sql = "DELETE FROM inquiry_manage WHERE in_num=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, in_num);
	pstmt.executeUpdate();

	//부모글 삭제
	sql = "DELETE FROM inquiry WHERE in_num=?";
	pstmt2 = conn.prepareStatement(sql);
	pstmt2.setInt(1, in_num);
	pstmt2.executeUpdate();

	//예외 발생 없이 정상적으로 SQL문 실행
	conn.commit();			 
		}catch(Exception e) {
			//하나라도 SQL문이 실패하면
			conn.rollback();
			throw new Exception(e);
		}finally {
			//자원정리
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}

	}
	
	//댓글 등록
	
	//댓글 갯수
	
	//댓글 목록
	
	//댓글 상세
	
	//댓글 수정
	
	//댓글 삭제
}
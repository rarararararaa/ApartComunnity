package kr.question.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.question.vo.QuestionVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class QuestionDAO {
	//싱글턴 패턴
		private static QuestionDAO instance = new QuestionDAO();
		public static QuestionDAO getInstance() {
			return instance;
		}
		private QuestionDAO() {}
		
	    //회원 아이디?불러오기
	    public String getDongho(int mem_num) throws Exception{
	    	Connection conn = null;
	    	PreparedStatement pstmt = null;
	    	ResultSet rs = null;
	    	String sql = null;
	    	String dongho = null;
	    	try {
				conn = DBUtil.getConnection();
				sql = "SELECT dongho FROM member WHERE mem_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mem_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dongho = rs.getString(1);
				}
			} catch (Exception e) {
				throw new  Exception(e);
			} finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
	    	return dongho;
	    }
		
		//글 등록
		public void insertQuestion(QuestionVO question)
										throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				sql = "INSERT INTO question (que_num,"
						+ "title,content,filename,ip,mem_num) "
						+ "VALUES (question_seq.nextval,?,?,?,?,?)";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터를 바인딩
				pstmt.setString(1, question.getTitle());
				pstmt.setString(2, question.getContent());
				pstmt.setString(3, question.getFilename());
				pstmt.setString(4, question.getIp());
				pstmt.setInt(5, question.getMem_num());
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
		public int getQuestionCount(String keyfield,
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
					else if(keyfield.equals("2")) sub_sql += "WHERE q.content LIKE ?";
				}

				//SQL문 작성
				sql = "SELECT COUNT(*) FROM question q "
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
		public List<QuestionVO> getListQuestion(
			      int start, int end,
		 String keyfield,String keyword)
	                throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QuestionVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE q.title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE q.content LIKE ?";
			}
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*,"
				+ "rownum rnum FROM (SELECT * "
				+ "FROM question q JOIN member m "
				+ "USING(mem_num) " + sub_sql + " ORDER BY "
				+ "q.que_num DESC)a) "
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
			list = new ArrayList<QuestionVO>();
			while(rs.next()) {
				QuestionVO question = new QuestionVO();
				question.setQue_num(
						rs.getInt("Que_num"));
				question.setTitle(
						StringUtil.useNoHtml(
							rs.getString("title")));
				question.setReg_date(
						rs.getDate("reg_date"));
				
				//자바빈을 ArrayList에 저장
				list.add(question);
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
		public QuestionVO getQuestion(int que_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			QuestionVO question = null;
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				//SQL작성
				sql = "SELECT * FROM question q "
						+ "JOIN member m USING(mem_num) "
						+ "LEFT OUTER JOIN member_detail d "
						+ "USING(mem_num) WHERE q.que_num=?";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터를 바인딩
				pstmt.setInt(1, que_num);
				//SQL문을 실행해서 결과행을 ResultSet에 담음
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					question = new QuestionVO();
					question.setQue_num(rs.getInt("que_num"));
					question.setTitle(rs.getString("title"));
					question.setContent(rs.getString("content"));
					question.setReg_date(rs.getDate("reg_date"));
					question.setModify_date(rs.getDate("modify_date"));
					question.setFilename(rs.getString("filename"));
					question.setMem_num(rs.getInt("mem_num"));					
				}
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				//자원정리
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return question;
		}
		
		//파일 삭제
		public void deleteFile(int que_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try {
				conn = DBUtil.getConnection();
				
				sql = "UPDATE question SET filename='' WHERE que_num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, que_num);
				
				pstmt.executeUpdate();
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
		
		//글 수정
		public void updateQuestion(QuestionVO question)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			String sub_sql = "";
			int cnt = 0;
			
			try {
				conn = DBUtil.getConnection();
				
				if(question.getFilename()!=null) {
					sub_sql += ",filename=?";
				}
				
				sql = "UPDATE question SET title=?,"
						+ "content=?,modify_date=SYSDATE"
						+ sub_sql + ",ip=? WHERE que_num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(++cnt, question.getTitle());
				pstmt.setString(++cnt, question.getContent());
				if(question.getFilename()!=null) {
					pstmt.setString(++cnt, question.getFilename());
				}
				pstmt.setString(++cnt, question.getIp());
				pstmt.setInt(++cnt, question.getQue_num());
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
		
		//글 삭제
		public void deleteQuestion(int que_num)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try {
				conn = DBUtil.getConnection();
				
				sql = "DELETE FROM question WHERE que_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, que_num);
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
		
	}





























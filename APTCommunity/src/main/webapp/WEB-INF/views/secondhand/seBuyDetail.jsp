<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고구매 글 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/commuList.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sh.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sh.reply.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript"></script>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<!-- 내용 시작 -->
		<div class="inner">
			<div class="inner" id="container">
				<!-- 상단링크버튼 -->
				<div class="service-up">
					<jsp:include page="/WEB-INF/views/common/up_button.jsp" />
				</div>
				<div class="page-main">
					<ul>
						<!-- 좌측 사이드바 -->
				<li>
				<div class="page-left">
				<div class="sidebar">
					<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
					<h2>커뮤니티</h2>
				<div class="menu">
					<ul>
						<li><a href="${pageContext.request.contextPath}/board/boardList.do">자유게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/secondhand/seBuyList.do">중고구매</a></li>
						<li><a href="${pageContext.request.contextPath}/secondhand/seSaleList.do">중고판매</a></li>
					</ul>
				</div>
				</div>
				</div>
				</li>
						<!-- 우측 메인 -->
						<li>
							<div class="page-right">
								<div class="detail">
									<input type="button" value="뒤로가기" onclick="location.href='seBuyList.do'" id="back"><br>
									<div class="detail-page">
										<div class="detail-page-title">
											<ul>
												<li>
													<a href="seBuyList.do">중고구매</a>
												</li>
												<li><b>${vo.title}</b></li>
												<li><!-- &nbsp;:띄어쓰기인데, 작성자와 작성일을 위아래로 나눌지 사이에 공백을 둘지? -->
													 작성자 ${vo.dongho}&nbsp;&nbsp;&nbsp;
													 작성일 ${vo.reg_date}
												</li>
												<li class="align-right" id="st">
												<%-- 로그인한 회원번호와 작성자 회원번호가 일치하거나 관리자일경우 수정삭제 가능 --%> 
												
												<c:if test="${user_num == vo.mem_num || user_auth == 9}">
												<%-- user_num : 로그인한 회원번호 / vo.mem_num : 작성한 회원번호 --%>
													<input type="button" value="수정" onclick="location.href='seBuyUpdateForm.do?se_num=${vo.se_num}'">
													<input type="button" value="삭제" id="delete_btn">
													<script type="text/javascript">
														//글 삭제버튼
														let delete_btn = document.getElementById('delete_btn');
														//이벤트연결
														delete_btn.onclick = function() {
															let choice = confirm('삭제하시겠습니까?');
															if (choice) {
																location.replace('delete.do?se_num=${vo.se_num}');
															}
														}
													</script>
													</c:if>
												</li>
											</ul>
										</div>
										<hr size="1" width="100%" noshade="noshade" color="#e8e8e8">
										<div class="detail-page-content">
											<c:if test="${ !empty vo.filename }">
											<img src="${pageContext.request.contextPath}/upload/${ vo.filename }" class="detail-img"
												style="border:noen;">
											</c:if>
											<p>${vo.content}</p>
										</div>
								<%-- 좋아요 버튼 시작 --%>
								<div id="goodClick">
									<img id="output_fav" src="${pageContext.request.contextPath}/img/HeartBin30.jpg" 
										data-num="${vo.se_num}" style="float: left;"/>
									<p>&nbsp;&nbsp;좋아요&nbsp;&nbsp;<span id="output_favCount"></span></p>
								</div>
								<%-- 좋아요 버튼 끝 --%>
									</div>
									<!-- detail-page -->
								</div>
								<hr class="hLine" size="1" noshade="noshade" width="100%">
								<!-- 댓글 작성 시작 -->
								<div id="comment">
									<span class="comment-title">댓글 달기</span>
									<form id="re_form">
										<input type="hidden" name="se_num" value="${vo.se_num}" id="se_num">
										<textarea rows="3" cols="45" name="re_content" id="re_content" class="rep-content"
											<c:if test="${empty user_num}">disabled="disabled"</c:if>
											><c:if test="${empty user_num}">로그인 후 이용하세요</c:if></textarea>
										<c:if test="${!empty user_num}">
											<div id="re_first">
												<span class="letter-count">300/300</span>
											</div>
											<div id="re_second" class="align-right">
												<input type="submit" value="댓글 등록" id="size30">
											</div>
										</c:if>
									</form>
								</div>
								<!-- 댓글 작성 끝 -->
								<!-- 댓글 목록 출력 시작 -->
								<div id="output"></div>
								<div class="paging-button" style="display: none;">
									<input type="button" value="다음 글 보기" id="size30">
								</div>
								<div id="loading" style="display: none;">
									<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
								</div>
								<!-- 댓글 목록 출력 끝 -->
							</div>
						</li>
						<!-- 우측 메인끝 -->
					</ul>
				</div>
			</div>
		</div>
		<!-- 내용끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>

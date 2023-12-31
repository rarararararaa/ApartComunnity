<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_form').on('submit',function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
<div class="inner">
		<div id="container" class="inner">
		<!-- 상단링크버튼 -->
		<div class="service-up">
			<jsp:include page="/WEB-INF/views/common/up_button.jsp"/>
		</div>
		<div class="page-main">
		<ul>
			<!-- 좌측 사이드바 -->
			<li>
			<div class="page-left">
			<div class="sidebar">
				<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
				<h2>기타</h2>
			<div class="menu">
				<ul>
					<li><a href="${pageContext.request.contextPath}/inquiry/list.do">1:1문의</a></li>
					<li><a href="${pageContext.request.contextPath}/question/questionList.do">자주 묻는 질문</a></li>
				</ul>
			</div>
			</div>
			</div>
			</li>
			<!-- 우측메인 -->
			<li>
			<div class="page-right">
			<div class="main-img">
						<img alt="" src="${pageContext.request.contextPath}/img/sideMenuTopImg.jpg">
					</div>
			<div class="main-search">
				<!-- 검색 시작 -->
					<form id="search_form" method="get" action="list.do">
						<div class="inquiry-main-search">
							<b> 1:1문의 목록 </b>
							<ul>
								<li>
									<select name="keyfield" style="height: 30px;">
										<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
										<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>작성자</option>
										<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
									</select>
									<input type="search" size="10" name="keyword" id="keyword" 
												value="${param.keyword}" placeholder="검색어를 입력하세요">
									<input type="submit" value="검색" style="height: 30px;">
								</li>
							</ul>
						</div>
					</form>
					<!-- 검색 끝 -->
					<div class="inquiry-main-list">
						<ul>
							<li>글번호</li>
							<li>제목</li>
							<li>작성자</li>
							<li>작성일</li>
						</ul>
						<hr color="#edeff0" noshade="noshade">
						<!-- 상단 고정 시작 -->
						<div class="board-article-fixed">
						<table class="list-fixed">
						<c:forEach var="fixed" items="${ fixedList }">
							<tr>
								<td colspan="2" class="td-article">
									<div class="board-number-fixed">
										<span>공지</span>
									</div>
									<div class="board-list">
										<a class="article-fixed" href="${pageContext.request.contextPath}/notice/noticeDetail.do?no_num=${ fixed.no_num }">${ fixed.title }</a>
									</div>
								</td>
								<td class="board-name">관리자</td>
								<td class="board-date">${ fixed.reg_date }</td>
							</tr>
						</c:forEach>
						</table>
						</div>
						<!-- 상단 고정 끝 -->
						<!-- 게시글 없는 경우 -->
						<c:if test="${ count < 1 || empty count }">
							<div class="result-fix-display">
								게시글이 없습니다.
							</div>
							<hr color="#edeff0" noshade="noshade">
						</c:if>
					<!-- 게시글 있을때 목록 시작 -->
						<c:if test="${ count > 0 }">
							<div class="board-article">
								<table class="list">
									<c:forEach var="inquiry" items="${list}">
										<tr>
											<td colspan="2" class="td-article">
												<div class="board-number">
													${inquiry.in_num}
												</div>
												<div class="board-list">
													<a class="article" href="detail.do?in_num=${inquiry.in_num}">${inquiry.title}</a>
												</div>
											</td>
											<td class="board-name" >${inquiry.dongho}</td>
											<td class="board-date">${inquiry.reg_date}</td>
										</tr>
									</c:forEach>
								</table>
							</div>
							<div class="page-count">${page}</div>
						</c:if>
						<!-- 게시글 목록 끝 -->
					</div>
						<!-- 글작성버튼 -->
					<div class="list-write-btn">
						<span>
							<a href="writeForm.do">
							<img alt="" src="${pageContext.request.contextPath}/img/write_btn.png">글쓰기
							</a>
						</span>
						<!-- 자유게시판목록버튼 -->
						<span>
							<c:if test="${empty user_num}">disabled="disabled"</c:if>
							<a href="list.do">목록</a>
						</span>
					</div>
				</div>
			</div>
				</li>
				</ul>
			</div>
		<!-- 내용 끝 -->
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
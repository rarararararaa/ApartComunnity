<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제목</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/notice.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="page-main">
	<ul>
		<!-- 왼쪽 -->
		<li>
		<div class="page-left">
			<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
		</div>
		</li>
		<!-- 오른쪽 -->
		<li>
		<div class="page-right">
		<div class="detail">
			<div class="detail-page">
				<div class="detail-page-title">
					<ul>
						<li>
						<c:if test="${ notice.dept == 1 }">
							<a href="noticeList.do?dept=${ notice.dept }">관리사무소 회의 결과</a>
						</c:if>
						<c:if test="${ notice.dept == 2 }">
							<a href="noticeList.do?dept=${ notice.dept }">입대의 공지사항</a>
						</c:if>
						<c:if test="${ notice.dept == 3 }">
							<a href="noticeList.do?dept=${ notice.dept }">건의사항</a>
						</c:if>
						</li>
						<li><b>${ notice.title }</b></li>
						<li>
							관리자 |
							${ notice.reg_date }
						</li>
					</ul>
				</div>
				<hr size="1" width="100%" noshade="noshade" color="#e8e8e8">
				<div class="detail-page-content">
					<c:if test="${ !empty notice.filename }">
					<img src="${pageContext.request.contextPath}/upload/${ notice.filename }" class="d etail-img">
					</c:if>
					<p>${ notice.content }</p>
				</div>
			</div>
		</div>
		<div class="detail-btn">
			<c:if test="${user_auth == 9 }">
			<div class="detail-btn-div">
				<input type="submit" value="수정" class="write-btn">
				<input type="button" value="삭제" onclick="location.href='noticeList.do'" class="write-btn">
			</div>
			</c:if>
			<div class="detail-btn-div2">
				<input type="button" value="목록" class="list-btn" onclick="location.href='noticeList.do?dept=${ notice.dept }'">
			</div>
		</div>
		
		</div>	
		</li>
		<!-- 오른쪽 -->
	</ul>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
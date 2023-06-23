<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/registerUser.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-main">
	<!-- 내용 시작 -->
	<div class="sbLogin">
		<h2 class="sbTitle">회원가입 완료</h2>
		<div class="join_flow">
			<ul>
				<li class="jo_01"><span>약관동의</span></li>
				<li class="jo_02"><span>회원정보입력</span></li>
				<li class="jo_03 jo_o3_on"><span>가입완료</span></li>
			</ul>
		</div>
		<div class="result-display">
			<div class="align-center">
				회원가입이 완료되었습니다.
				<p>
				<input type="button" value="홈으로"
				 onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</div>
	</div>
	<!-- 내용 끝 -->
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>




<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/custom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/loginform.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
	$(function(){
		$('#login_form').submit(function(){
			if($('#dong').val().trim()==''){
				alert('동을 입력하세요');
				$('#dong').val('').focus();
				return false;
			}
			if($('#ho').val().trim()==''){
				alert('호를 입력하세요');
				$('#ho').val('').focus();
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요');
				$('#passwd').val('').focus();
				return false;
			}
	});
</script>
</head>
<body>
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- header 끝 -->

	<!-- 내용 시작 -->
	<div class="page-main">
		<div class="content-main">
			<div class="sbLogin">
				<h2 class="sbTitle">로그인</h2>
				<form class="login_box" id="login_form" action="login.do"
					method="post">
					<div class="login_input fl">
						<p class="login_dong">
							<input type="text" id="dong" name="dong" placeholder="동">
						</p>
						<p class="login_ho">
							<input type="text" id="ho" name="ho" placeholder="호">
						</p>
						<p>
							<input type="password" id="passwd" name="passwd"
								placeholder="비밀번호">
						</p>
					</div>
					<p class="login_submit fl">
						<button type="submit" class="loginBtn" id="login_btn">로그인</button>
					</p>
				</form>
				
				<!-- 하단 시작 -->
				<div class="login_info">
					<div class="btn_wrap">
						<a
							href="${pageContext.request.contextPath}/member/registerUserAgree.do"
							class="join">회원가입</a> <a
							href="${pageContext.request.contextPath}/main/main.do"
							class="ldSearch">메인 페이지</a>
					</div>
					<ul>
						<li>쌍용 아파트에 오신 것을 환영합니다.</li>
						<li>비회원이신 분은 회원가입을 통하여 다양한 서비스를 경험하시기 바랍니다.</li>
					</ul>
				</div>
				<!-- 하단 끝 -->
				
			</div> <!-- end of sbLogin -->
			
		</div> <!-- end of content-main -->
		
	</div> <!-- end of page-main -->
	<!-- 내용 끝 -->


	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer 끝 -->
	
</body>
</html>
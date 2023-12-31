<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/inquiry.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
	$(function(){
		//이벤트 연결
		$('#write_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요!');
				$('#title').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#content').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="write-page-main">
	
	<!-- 내용 시작 -->
	<div class="inner">
		<div id="container" class="inner">
			<div class="main-page">
				<h1>1:1문의 작성</h1>
				<div class="write-page">	
				<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
					<ul>
						<li>
						</li>
						<li>
						<div class="write-title">
							<c:if test="${user_auth == 1 || user_auth == 9 }">
								<input type="text" id="title" name="title" maxlength="30"  placeholder="제목을 입력해주세요.">	
							</c:if>
						</div>
						</li>
						<li>
							<textarea rows="5" cols="30" id="content" name="content" maxlength="650"  placeholder="내용을 입력해주세요."></textarea>
						</li>
						<li>
							<input type="file" id="filename" name="filename" accept="image/png, image/jpeg, image/gif" >
						</li>
						<li>
						<div class="write-btn-div">
							<input type="submit" value="등록" class="write-btn">
							<input type="button" value="취소" onclick="location.href='list.do'" class="write-btn">
						</div>
						</li>
					</ul>
				</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>



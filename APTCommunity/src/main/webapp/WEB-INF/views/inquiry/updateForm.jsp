<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의 수정</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/inquiry.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
	$(function(){
		//이벤트 연결
		$('#write_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요');
				$('#title').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요');
				$('#content').val('').focus();
				return false;
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
			<div class="main-page">
				<h1>1:1문의 수정</h1>
				<div class="write-page">	
				<form id="update_form" action="update.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="in_num" value="${inquiry.in_num}">
					<ul>
						<li>
						</li>
						<li>
						<div class="write-title">
							<c:if test="${user_auth==1 || user_auth== 9}">
								<input type="text" id="title" name="title" maxlength="40" placeholder="제목을 입력해주세요." value="${inquiry.title}">	
							</c:if>
						</div>
						</li>
						<li>
							<textarea rows="5" cols="30" id="content" name="content" maxlength="650"  placeholder="내용을 입력해주세요.">${inquiry.content}</textarea>
						</li>
						<li>
							<input type="file" id="filename" name="filename" accept="image/png, image/jpeg, image/gif" >
							<c:if test="${!empty inquiry.filename}">
							<div id="file_detail"> &nbsp;(${inquiry.filename}) 파일이 등록되어 있습니다.&nbsp;
								<input type="button" value="파일삭제" id="file_del">
							</div>
							<script type="text/javascript">
								$(function(){
									$('#file_del').click(function(){
										let choice = confirm('삭제하시겠습니까?');
										if(choice){
											$.ajax({
												url:'deleteFile.do',
												type:'post',
												data:{in_num:${inquiry.in_num}},
												dataType:'json',
												success:function(param){
													if(param.result == 'logout'){
														alert('로그인 후 사용하세요');
													}else if(param.result == 'success'){
														$('#file_detail').hide();
													}else if(param.result == 'wrongAccess'){
														alert('잘못된 접속입니다.');
													}else{
														alert('파일 삭제 오류 발생');
													}
												},
												error:function(){
													alert('네트워크 오류 발생');
												}
											});// end of ajax
										}
									});
								});
							</script>
							</c:if>
						</li>
						<li>
						<div class="write-btn-div">
							<input type="submit" value="수정" class="write-btn">
							<input type="button" value="취소" onclick="location.href='detail.do?in_num=${inquiry.in_num}'" class="write-btn">
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

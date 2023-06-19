<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/noticeWrite.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
			}
			if($('#check').is(':checked')==true){
				$('#status').val(1);
			}
		});
	});
</script>
</head>
<body>
<div id="wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
<div class="main-page">
	<h1>공지사항 글쓰기</h1>
	<div class="write-page">	
	<form id="write_form" action="writeNotice.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="category_status" value="1">
	<input type="hidden" name="status" id="status" value="0">
		<ul>
			<li>
				<select name="keyfield_dept" class="keyfield">
						<option value="1" <c:if test="${param.keyfield_dept==1}">selected</c:if>>관리사무소 회의 결과</option>
						<option value="2" <c:if test="${param.keyfield_dept==2}">selected</c:if>>주민자치회 회의 결과</option>
						<option value="3" <c:if test="${param.keyfield_dept==3}">selected</c:if>>선관위 회의 결과</option>
				</select>
				<%-- <select name="keyfield_cate">
						<option value="1" <c:if test="${param.keyfield_cate==1}">selected</c:if>>공지사항</option>
						<option value="2" <c:if test="${param.keyfield_cate==2}">selected</c:if>>자유게시판</option>
						<option value="3" <c:if test="${param.keyfield_cate==3}">selected</c:if>>중고거래</option>
						<option value="3" <c:if test="${param.keyfield_cate==3}">selected</c:if>>하자보수</option>
						<option value="3" <c:if test="${param.keyfield_cate==3}">selected</c:if>>예약(시설)</option>
				</select> --%>
			</li>
			<li>
			<div class="wirte-title">
				<input type="text" id="title" name="title" placeholder="제목을 입력해주세요.">
					<label for="checkbox">상단고정</label>			
					<input type="checkbox" id="check" name="check" value="1">
			</div>
			</li>
			<li>
				<textarea rows="5" cols="30" id="content" name="content" placeholder="내용을 입력해주세요."></textarea>
			</li>
			<li>
				<input type="file" id="filename" name="filename" accept="image/png, image/jpeg, image/gif" >
			</li>
			<li>
			<div class="write-btn-div">
				<input type="submit" value="등록" class="write-btn">
				<input type="button" value="취소" onclick="location.href='noticeList.do'" class="write-btn">
			</div>
			</li>
		</ul>
	</form>
	</div>
</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
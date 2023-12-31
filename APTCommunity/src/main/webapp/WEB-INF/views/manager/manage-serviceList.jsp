<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/manage_calender.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/manage.js"></script>

<!-- 1.회원관리 -->
<div id="manage_member">
	<!--  목록 검색창 -->
	<h1>회원목록조회</h1>
	<form action="manage-serviceList.do" method="get" id="mem_search_form">
		<ul>
			<li>
				<div class="manage-search">
					<select name="mem_select" class="manage-member">
						<option value="1"
							<c:if test="${param.mem_select==1}">selected</c:if>>세대주</option>
						<option value="2"
							<c:if test="${param.mem_select==2}">selected</c:if>>동</option>
						<option value="3"
							<c:if test="${param.mem_select==3}">selected</c:if>>호수</option>
					</select> <input type="search" placeholder="회원 목록 조회" class="search-member"
						name="keyword" id="keyword" value="${ param.keyword }">
				</div>
			</li>
			<li>
				<div class="mem-search-btn">
					<input type="submit" value="검색">
				</div>
			</li>
		</ul>
	</form>
	<!--  목록 검색참 끝 -->
	<!-- 회원 목록 -->
	<div class="mem-list">
		<table id="mem_info">
			<tr>
				<th>동-호수</th>
				<th>세대주</th>
				<th>전화번호</th>
				<th>가입일</th>
			</tr >
		</table>
		<div id="change-memlist">
			<table id="mem_output">
				<c:forEach var="mem" items="${ list }" varStatus="status">
				<tr>
					<td id="mem_detail_btn" class="mem-detail-btn manage-detail-btn">
						<input type="hidden" name="mem_num" id="mem_num" value="${ mem.mem_num }">
						${ mem.dongho }
					</td>
					<td id="2">${ mem.name }</td>
					<td id="3">${ mem.phone }</td>
					<td id="4">${ mem.reg_date }</td>
				</tr>
				</c:forEach>
			</table>
		<c:if test="${ count > 0 }">
			<div class="mem-page">${ page }</div>
		</c:if>
		</div>
	</div>
</div>
<!-- 1.회원관리 끝-->
<!--  2.공지사항 글 작성 폼 -->
<div id="manage_notice">
	<div class="write-title-text">
		<h1>공지사항 글쓰기</h1>
	</div>
	<div class="manage-write-manage-page">
		<form id="write_manage_form"
			action="${ pageContext.request.contextPath }/notice/writeNotice.do"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="category_status" value="1"> <input
				type="hidden" name="status" id="status" value="0">
			<ul>
				<li><select name="keyfield_dept" class="keyfield">
						<option value="1"
							<c:if test="${param.keyfield_dept==1}">selected</c:if>>관리사무소
							공지사항</option>
						<option value="2"
							<c:if test="${param.keyfield_dept==2}">selected</c:if>>입대의
							공지사항</option>
						<option value="3"
							<c:if test="${param.keyfield_dept==3}">selected</c:if>>건의사항</option>
				</select></li>
				<li>
					<div class="wirte-title">
						<input type="text" id="title" name="title"
							placeholder="제목을 입력해주세요." maxlength="20"> <label
							for="checkbox">상단고정</label> <input type="checkbox" id="check"
							name="check" value="1">
					</div>
				</li>
				<li><textarea rows="5" cols="30" id="content" name="content"
						placeholder="내용을 입력해주세요."></textarea>
					<div id="re_first">
						<span class="letter-count">700/700</span>
					</div></li>
				<li><input type="file" id="filename" name="filename"
					accept="image/png, image/jpeg, image/gif"></li>
				<li>
					<div class="write-btn-div">
						<input type="submit" value="등록" class="write-btn"> <input
							type="button" value="취소" class="write-btn"
							onclick="history.go(-1)">
					</div>
				</li>
			</ul>
		</form>
	</div>
</div>
<!--  2.공지사항 글 작성 폼 -->
<!--  3. 머리 공지글 작성 폼 -->	
<div class="main-main" id="manage_category">
	<div class="write-title-text">
		<h1>머리글 공지사항 글쓰기</h1>
	</div>
	<div class="write-manage-page">	
	<form id="write_manage_form" action="${ pageContext.request.contextPath }/notice/writeNotice.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="keyfield_dept" value="4">
	<input type="hidden" name="status" id="status" value="0">
		<ul>
			<li>
				<select name="category_status" class="keyfield">
						<option value="2" <c:if test="${param.keyfield_cate==2}">selected</c:if>>자유게시판</option>
						<option value="3" <c:if test="${param.keyfield_cate==3}">selected</c:if>>중고거래</option>
						<option value="4" <c:if test="${param.keyfield_cate==4}">selected</c:if>>하자보수</option>
						<option value="5" <c:if test="${param.keyfield_cate==5}">selected</c:if>>예약(시설)</option>
						<option value="6" <c:if test="${param.keyfield_cate==6}">selected</c:if>>1:1문의</option>
				</select>
			</li>
			<li>
			<div class="wirte-title">
				<input type="text" id="title" name="title" placeholder="제목을 입력해주세요." maxlength="20">
					<label for="checkbox">상단고정</label>			
					<input type="checkbox" id="check" name="check" value="1">
			</div>
			</li>
			<li>
				<textarea rows="5" cols="30" id="content" name="content" placeholder="내용을 입력해주세요."></textarea>
				<div id="re_first">
						<span class="letter-count">700/700</span>
				</div>
			</li>
			<li>
				<input type="file" id="filename" name="filename" accept="image/png, image/jpeg, image/gif" >
			</li>
			<li>
			<div class="write-btn-div">
				<input type="submit" value="등록" class="write-btn">
				<input type="button" value="취소" class="write-btn" onclick="history.go(-1)">
			</div>
			</li>
		</ul>
	</form>
	</div>
</div>	
<!--  3. 머리 공지글 작성 끝  -->
<!-- 4. 1:1문의 관리 -->
<div id="manage_inquiry">
	<!--  목록 검색창 -->
	<h1>1:1문의 관리</h1>	
			<div class="manage-search">
				<select name="inquiry_select" class="manage-member" id="inquiry_select">
					<option value="2">--선택--</option>
					<option value="1" <c:if test="${inquiry_select==1}">selected</c:if>>답변완료</option>
					<option value="0" <c:if test="${inquiry_select==0}">selected</c:if>>미답변</option>
				</select>
			</div>
	<!-- 목록 검색참 끝 -->
	<!-- 1:1문의 목록 -->
<div class="mem-list">
		<table id="inquiry_info" class="manage_info">
			<tr>
				<th>글 번호</th>
				<th>제목</th>
				<th>동-호수</th>
				<th>작성일</th>
				<th>답변여부</th>
			</tr>
		</table>
		<div id="change-inquirylist">
			<table id="inquiry_output" class="manage_contentList">
				<c:forEach var="inquiry" items="${ inquiry_list }">
					<tr>
						<td id="1">${ inquiry.in_num }</td>
						<td id="2" class="manage-detail-btn" 
						onclick="location.href='${ pageContext.request.contextPath}/inquiry/detail.do?in_num=${ inquiry.in_num }'">
							${ inquiry.title }
						</td>
						<td id="3">${ inquiry.dongho }</td>
						<td id="4">${ inquiry.reg_date }</td>
						<td>
							<c:if test="${ inquiry.check > 0 }">답변완료</c:if>
							<c:if test="${ inquiry.check == 0 }">미답변</c:if>
						</td> 
					</tr>
				</c:forEach>
			</table>
			<c:if test="${ in_count > 0 }">
				<div class="mem-page">${ in_page }</div>
			</c:if>
		</div>
	</div>
</div>
<!-- 4. 1:1문의 목록-->
<!-- 5. 하자보수글 관리 -->
<div id="manage_fix">
	<!--  목록 검색창 -->
	<h1>하자보수글 조회</h1>
			<div class="manage-search">
				<select name="fix_select" class="manage-member" id="fix_select">
					<option value="2">--선택--</option>
					<option value="1" <c:if test="${fix_select==1}">selected</c:if>>답변완료</option>
					<option value="0" <c:if test="${fix_select==0}">selected</c:if>>미답변</option>
				</select>
			</div>
	<!--  목록 검색참 끝 -->
	<!-- 글 목록 -->
	<div class="mem-list">
		<table id="fix_info" class="manage_info">
			<tr>
				<th>글 번호</th>
				<th>제목</th>
				<th>동-호수</th>
				<th>작성일</th>
				<th>답변여부</th>
			</tr >
		</table>
		<div id="change-memlist">
			<table id="fix_output" class="manage_contentList">
				<c:forEach var="fix" items="${ fix_list }">
				<tr>
					<td id="1">${ fix.fix_num }</td>
					<td id="2" class="manage-detail-btn" 
					onclick="location.href='${ pageContext.request.contextPath}/fix/fixDetail.do?fix_num=${ fix.fix_num }'" >
					${ fix.title }
					</td>
					<td id="3">${ fix.dongHo }</td>
					<td id="4">${ fix.reg_date }</td>
					<td>
						<c:if test="${ fix.check > 0 }">답변완료</c:if>
						<c:if test="${ fix.check == 0 }">미답변</c:if>
					</td> 
				</tr>
				</c:forEach>
			</table>
		<c:if test="${ fix_count > 0 }">
			<div class="mem-page">${ page }</div>
		</c:if>
		</div>
	</div>
</div>
<!-- 5. 하자보수글 관리 끝 -->
<!-- 6. 예약 관리 -->
<div id="manage_book">
	<!--  예약 선택 시작 -->
	<h1>예약 관리</h1>
	<form action="manage-serviceList.do" method="get" id="mem_search_form">
		<ul>
			<li>
				<div class="room-search">
					<select name="room_select" class="manage-member" id="room_select">
						<option value="선택" 
							<c:if test="${param.room_select=='선택'}">selected</c:if>>--시설 선택--</option>
						<option value="도서실"
							<c:if test="${param.room_select=='도서실'}">selected</c:if>>도서실</option>
						<option value="회의실"
							<c:if test="${param.room_select=='회의실'}">selected</c:if>>회의실</option>
						<option value="게스트하우스"
							<c:if test="${param.room_select=='게스트하우스'}">selected</c:if>>게스트하우스</option>
					</select>
				</div>
			</li>
			<li id="room_type" style="display: none;">
				<div class="room-search">
					<select name="room_select2" class="manage-member" id="room_select2">
					
					</select>
				</div>
			</li>
		</ul>
	</form>
	<!-- 예약 선택 끝 -->
	<!-- 달력 -->
	<div class="book-cal" style="display: none; ">
	<table id="calendar" >
		<tr>
			<td><label class="go-prev" onclick="prevCalendar()"> ◀ </label></td>
			<td id="calendarTitle" colspan="5" align="center" ><label>invalid</label></td>
			<td><label class="go-next" onclick="nextCalendar()"> ▶ </label></td>
		</tr>
		<tr class="weeks">
			<td class="holiday">일</td>
			<td>월</td>
			<td>화</td>
			<td>수</td>
			<td>목</td>
			<td>금</td>
			<td class="saturday">토</td>
		</tr>
	</table>
	</div>
	<div class="book-list" style="display: none;">
		<h2 id="book_title">날짜</h2>
		<input type="button" value="비활성화" id="noBook_btn">
		<input type="button" value="활성화" id="yesBook_btn">
		<table id="book_info">
			<tr>
				<th>동-호수</th>
				<th>시설</th>
				<th>방</th>
				<th>예약 인원</th>
				<th>예약시간</th>
				<th>취소</th>
			</tr >
		</table>
		<div id="change-booklist">
			<table id="book_output">
			<!-- 선택한 시설/날짜의 예약 현황 -->
			</table>
		</div>
	</div>
</div>
<!-- 5. 예약 관리 끝 -->

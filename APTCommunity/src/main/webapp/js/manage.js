$(function(){
//상세 페이지 전환
	//1.회원관리-상세페이지/*
		$('#change-memlist').on('click','.mem-detail-btn',function(){
			mem_num = $(this).find('#mem_num').val();
			$.ajax({
				 type:'get',
				 url:'manage-detail.do?mem_num='+mem_num,
				 dataType:'text',
				 success:function(data){
					 let plus = $('#manage_content').html(data).find('#mem_detail');
					 $('#ma	nage_content').html(plus);
				 },
				 error:function(){
					 alert('1.통신 에러 발생');
				 }
			 })
		})

//회원 목록	
	//회원 관리 검색참
	$('#mem_search_form').submit(function(event){
		//submit 이벤트 제거
		event.preventDefault();
		//폼 데이터 전부 읽기
		let form_data = $(this).serialize();
		//ajax 통신
		$.ajax({
			url:'manage-serviceList.do?manage_select=1',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				$('#change-memlist').empty();
				
				let output = '';
				if(param.list == ""){
					$('.mem-page').empty();
					
					output += '<div class="result-display">존재하지 않는 회원입니다.</div>';
					output += '<hr color="#edeff0" noshade="noshade">';
					$("#change-memlist").append(output);
					
				}else{
					output += '<table id="mem_output">';
					$(param.list).each(function(index,item){
						output += '<tr>';
						output += '<td id="mem_detail_btn" class="mem-detail-btn manage-detail-btn">';
						output += '<input type="hidden" name="mem_num" id="mem_num" value="'+item.mem_num+'">';
						output += item.dongho+'</td>'
						output += '<td>'+item.name+'</td>';
						output += '<td>'+item.phone+'</td>';
						output += '<td>'+item.reg_date+'</td>';
						output += '</tr>';
					})	
					output += '</table>'
					output += '<div class="mem-page">'+param.page+'</div>';
					$("#change-memlist").append(output); // index가 끝날때까지 
				}
			},
			error:function(){
				alert('오류발생');
			}
		})
		//빈 글자 검색 막기
		if($('#keyword').val().trim() == ''){
			alert('검색할 내용을 입력하세요');
			$('#key').val('').focus();
			return false;
		}
	})
//회원목록 검색 끝		
//예약 목록 선택		
	$('#room_select').change(function(){
		let room_num = $('select[name=room_select] > option:selected').val();
		$('#book_output').empty();
		$('.book-cal').hide();
		$('.book-list').hide();
		$('#room_type').show();
		$('select[name=room_select2] > option').remove();
			$.ajax({
				url:'manage-serviceList.do?manage_select=6',
				data:{room_name:room_num, room_type:'0'},
				type:'post',
				dataType:'json',
				success:function(param){
					let output = '<option>--방 선택--</option>'
					$(param.bookinfo_list).each(function(index,item){
						//alert(item.room_num);
						output += '<option value="'+item.room_num+'">'+item.room_type+'</option>';
					})
					$('#room_select2').append(output);
				},
				error:function(){
					alert('예약 네트워크 오류');
				}
			})
		$('.room-search').on('change','#room_select2',function(){
			//캘린더 호출
			$('.book-cal').show();
			buildCalendar();
			//
		})
	})
//1:1문의 검색
$('#inquiry_select').change(function(){
	$('#manage_content').load(location.href+' #manage_content');
	let A_select = $(this).val();
	$.ajax({
			type:'get',
			 url:'manage-serviceList.do?manage_select=4',
			 data:{A_select:A_select},
			 success:function(param){
				//alert('성공');
				//$('#manage_content').load('manage-serviceList.do #manage_inquiry', {"manage_select" : "4"})--오류
				
				 let plus = $('#manage_content').html(param).find('#manage_inquiry');
				 $('#manage_content').html(plus);--실행됨
				
				 //$('#manage_inquiry').replaceWith(param);
			 },
			 error:function(){
				 alert('1:1문의 통신 에러 발생');
			 }
	})
})	
//하자보수 검색
$('#fix_select').change(function(){
	$('#manage_content').load(location.href+' #manage_content');
	let A_select = $(this).val();
	$.ajax({
			type:'get',
			 url:'manage-serviceList.do?manage_select=5',
			 data:{A_select:A_select},
			 success:function(param){
				 let plus = $('#manage_content').html(param).find('#manage_fix');
				 $('#manage_content').html(plus);//실행됨
			 },
			 error:function(){
				 alert('하자보수 통신 에러 발생');
			 }
	})
})	
//---------------------------------- 조건 체크 --------------------------------------------//		
	$('#write_manage_form').submit(function(){
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
		$(document).on('keyup','textarea',function(){
			let inputLength = $(this).val().length;
			if(inputLength > 700){//300자를 넘어선 경우
				$(this).val($(this).val().substring(0,700));//300자 다음 글자는 자름
				alert('최대 700자까지 입력가능합니다.');
			}else{//300자 이하인 경우
				let remain = 700 - inputLength;
				remain += '/700';
				$('#re_first .letter-count').text(remain);
			}
		})













})
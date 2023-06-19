package kr.booking.vo;

import java.sql.Date;

public class BookingVO {
	private int bk_num;			//예약번호 시퀀스
	private int room_num;		//시설정보번호 시퀀스
	private int mem_num;		//회원번호 시퀀스
	private int book_mem;		//예약 인원
	private Date bk_date;		//예약한 날짜
	private String start_time;	//시작 시간
	private String end_time;	//끝 시간
	
	private Room_infoVO room_info; // 시설정보모델

	public int getBk_num() {
		return bk_num;
	}

	public void setBk_num(int bk_num) {
		this.bk_num = bk_num;
	}

	public int getRoom_num() {
		return room_num;
	}

	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getBook_mem() {
		return book_mem;
	}

	public void setBook_mem(int book_mem) {
		this.book_mem = book_mem;
	}

	public Date getBk_date() {
		return bk_date;
	}

	public void setBk_date(Date bk_date) {
		this.bk_date = bk_date;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public Room_infoVO getRoom_info() {
		return room_info;
	}

	public void setRoom_info(Room_infoVO room_info) {
		this.room_info = room_info;
	}
}
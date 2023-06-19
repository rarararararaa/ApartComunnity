package kr.booking.vo;

public class Room_infoVO {
	private int room_num;		//시설정보 번호
	private String room_type;	//방 타입(ex:독서실, 회의실)
	private String room_name;	//방 이름(ex:A101)
	private int bk_status;		//예약상태
	private int total_mem;		//최대 예약 가능 인원
	
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public int getBk_status() {
		return bk_status;
	}
	public void setBk_status(int bk_status) {
		this.bk_status = bk_status;
	}
	public int getTotal_mem() {
		return total_mem;
	}
	public void setTotal_mem(int total_mem) {
		this.total_mem = total_mem;
	}
}
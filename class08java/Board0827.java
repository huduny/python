package CHAPTER6;

public class Board0827 {
	String title;
	String content;
	String writer;
	String date;
	int hitcount;
	
	public Board0827() {
		
	}

	public Board0827(String title, String content){
		this(title, content, null, null, 0);
		this.writer = "로그인한 회원아이디";
		this.date	= "현재 컴퓨터 날짜";
		this.hitcount = 0;
	}
	public Board0827(String title, String content, String writer){
		this(title, content, writer, null, 0);
		this.date	= "현재 컴퓨터 날짜";
		this.hitcount = 0;
	}
	public Board0827(String title, String content, String writer, String date){
		this(title, content, writer, date, 0);
		this.hitcount = 0;
	}
	public Board0827(String title, String content, String writer, String date, int hitcount){
		this.title=title; 
		this.content=content; 
		this.writer=writer; 
		this.date=date; 
		this.hitcount=hitcount;
	}
		
	
}

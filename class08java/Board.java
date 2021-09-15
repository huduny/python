package CHAPTER11.chapter11_0915;

public class Board {
	String subject;
	String content;
	String writer;
	
	public Board(String subject, String content, String writer) {
//		데이터의 하나의 row를 저장할수 잇는 것이 board이다.
//		BoardVO => VO(Value Object) wed에서 가장 많이 사용
//		BoardDTO => DTO(Data Transfer Object)
//		BoardBean => Bean(객체)
//		BoardModel => Model(데이터)
//		BoardItem => Item(데이터 항목)
		this.subject = subject;
		this.content = content;
		this.writer = writer;
		
	}
}

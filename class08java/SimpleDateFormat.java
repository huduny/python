package CHAPTER11.chapter11_02;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class SimpleDateFormat {
	public static void main(String[] args) {
		
//		Date date = new Date();
//		System.out.println(date);
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 mm월 dd일 e요일 hh시 mm분 ss초");
//		simpleDateFormat.a
//		
//		LocalDate now = LocalDate.now();
//		System.out.println(new);
		LocalDate now = LocalDate.now(); //static메소드로 만들어서 표현
		System.out.println(now.format(DateTimeFormatter.ofPattern("yyyy년 MM월 a dd일 E요일")));
		System.out.println(now.getYear()+'년');
	}
}

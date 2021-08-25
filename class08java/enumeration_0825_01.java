package CHAPTER5;

import java.time.DayOfWeek;
import java.util.Calendar;

public class enumeration_0825_01 {

		public static void main(String[] args) {
//		Calendar는 사용하지 말자.
//		Calendar랑 Date(DateTime, time) 객체를 사용하지 말자.
//		DayOfWeeks
//		이펙티브자바
//		LocalDate 또는 LocalTime(LocalDateTime)
//		토비의스피링
			
		int week =	Calendar.getInstance().get(Calendar.DAY_OF_WEEK); //오늘 날짜에 요일
		Week_0825 today = null;
		
		switch (week) {
		case 1:
			today = Week_0825.SUNDAY;
			break;
		case 2:
			today = Week_0825.MONDAY;
			break;
		case 3:
			today = Week_0825.THURSDAY;
			break;
		case 4:
			today = Week_0825.WENDESDAY;
			break;
		case 5:
			today = Week_0825.THURSDAY;
			break;
			
		}
		System.out.println(today);
		}
}

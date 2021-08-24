package CHAPTER5;

public class RefrenceType_0824_01 {

	public static void main(String[] args) {
//		2021/08/24-01
//		어딘가에 데이터 저장(메모리), 자료형
//		데이터 타입-정수 실수 논리(기본형)/참조형
//		데이터의 사용목적에 따라서 힙 메소드 스택 영역에 저장, 스택(메인) 힙(모든객체) 메소드(정보)
//		String s1 = "산용권";하면 s1이라는 변수가 string으로 선언이 되고 s1은 스택에 신용권은 힙에 만들어진다.
//		문자열은 문자열만 관리하는 풀이 존재한다(힙 안에), s1은 값을 가지고 있는게 아니라 메모리의 주소값을 참조하고 있다.
//		변수는 스택에 데이터는 힙에 생성된다, null(어떠한 메모리의 주소도 참조하지 않는다)
//		로컬블록(메소드)-스택에 쌓이고-블록이 끝나면 사라진다, 메인메소드에서 변수는 끝나면 사라지지만 힙의 주소 값들은 남아있다.
//		그래서 생성하고 소멸되는 값들이 쌓여 메모리가 소모되게 된다. 자바는 직접할 필요 없이 수집해서 나중에 없앤다 garbageCollector
//		[]를 써서 배열을 사용한다. 반드시 저장되는 데이터의 타입이 같아야 한다.
//		처음에 배열이 한정되면 바꿀수 없다.
		
//		배열의 선언
//		배열은 처음에 반드시 몇개의 데이터를 저장할지 수를 지정해야한다.
		int[] intArrays;
		String[] strArrays; // 타입 뒤에 대괄호를 쓰면 된다.
		
//		배열의 생성 => 객체 => 참조타입 => Heap에 만들어짐
//		new 명령어를 사용하면 Heap 공간에 생성됨
		intArrays = new int[25];//배열이라는 공간을 힙에 만든것이다, 주소값을 생성, 데이터가 저장되는 것이 아님
		strArrays = new String[25];
//		리터럴 형식으로 생성, 리터럴(어떤 변수에 값을 할당을 할때 저장되는 값 자체)
		int[] scores = {83, 90, 69, 87, 94,};
		String[] names = {"신용권", "홍길동", "감자바"};
//		선언과 초기화가 분리되어 실행하면 안된다. 즉 선언과 동시에 써야 된다.
		int[] values;
		values = new int[] {40,50,60,80};
		
//		배열의 사용
//		scores[인덱스]
//		scores[0]//0번째 인덱스
		scores[2] = 74;
//		System.out.println(scores[0]);
//		System.out.println(scores[2]);
//		배열은 거의 대부분 반복문과 함께 쓴다
		for (int i = 0; i < values.length; i++)//현재 반복문에 근접한 배열이 나온다.length는 길이다.01234된다 
		{
			System.out.println(scores[i]);
		}
		
		

	}

}

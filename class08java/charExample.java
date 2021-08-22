package Chapter02;

public class charExample {

	public static void main(String[] args) {
		//char의 저장 범위: 0~65535
		//자바에서는 문자를 처리하기 위해 char 자료형을 제공
		//작은 따옴표로 감싸준다.
		//요즘 언어는 따옴표와 작은 따옴표를 구분하지 않고
		//문자열로 사용하나 자바에서는 큰 따옴표는 문자열,
		//작은따옴표는 문자를 나타날때 사용한다.
		//내부적을노는 숫자로 관리되며 사람에게 보여주고 입력받을때
		//문자로 보여주거나 입력받을 수 있다.
		// \t tab \s space \n enter \u incoding
		char c1 = 'a';
		char c2 = 65;
		char c3 = '\u0041';
		char c4 = '가';
		char c5 = 44032;
		char c6 = '\uac00';
		char c7 = '\ud7a3';
		
	}

}

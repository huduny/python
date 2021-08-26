package CHAPTER6;

public class teacherClass_21082601{
//		클래스와 파일명은 같아야 된다.
// 		TODO Auto-generated method stub
//		기능별로 묶어보자, 틀을 만들자(객체)
	
//		객체를 구성하는 요소 2가지
//		1. 데이터 저장하는 변수 =>필드
//		2. 중간에 객체를 사용하는 실행 블록인 생성자가 있다.
//		3. 동작을 나타내는 실행블록 =>메소드
		
//		클래스의 구성 요소로 선언 1. field 괄호가 없다
		String studentNo; //학번
		String name; 
		String hp;
		
//		2. 생성자 메모리에 생성할 때 실행되는 블록
		teacherClass_21082601(){
			
		}
		
		
//		3. method 실행 블록
 		void setName(String n) {
			System.out.println("이름: " + n);
		}


}
	public static void main(String[] args) {
		teacherClass_21082601 student1	=new teacherClass_21082601();
//		student1을 클래스 변수 or 인스턴스 변수
		teacherClass_21082601 student2	=new teacherClass_21082601();
//		new student()가 인스턴스(객체)이다
		System.out.println(student1==student2);
//studnet1은 stack에 new는 heap에 만들어짐
		student1.name="dgdf";
		System.out.println(student1.name);
		
		student1.setName("자바");
//		결국 불러오거나 값을 저장하거나 할수 있다.
		
}	
		
		
		
		
		
		
		
		
	



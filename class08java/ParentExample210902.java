package CHAPTER7;

public class ParentExample210902 {

	public static void main(String[] args) {
		ParentChild110902 child01 = new ParentChild110902();
		child01.print();
//		child01.p = 10;
		child01.breath();
		ParentChild110902 child02 = new ParentChild110902();
		child02.print();
	}
	
//	메서드 이름을 다르게 하면 각각호출할수 있따.
//	printParent or printChild 등으로
//	같은 메소드 동작이라면 이름을 같이해서 메소드오버라이딩이라고 한다.
//	동물들은 소리를 내는데 소리를 정의할 수 없다. 부모는 공통적인 것을 정의해주고 자식들은 나만의 소리를 정의
//	고양이는 야옹 강아지는 멍멍
//	외부에서는 부모에 직접적으로 접근하지 못하고 접근할려면 객체를 생성해야된다. 
//	오버로딩 더 만드는 것(파라미터나 타입이 다른 것으로) 오버라이딩은 덮어씌우는 것(기존의 부모 매서드를 나만의 매소드로 재 정의)
	
	
	
}

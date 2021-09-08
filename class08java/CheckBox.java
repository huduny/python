package CHAPTER9.chapter9_2;

public class CheckBox {
	
	
	
	
	static interface OnSelectListener{
		void onSelect();
	}
	
	OnSelectListener listener;
//	null은 참조할수 없다. OnSelectListener listener; 선언은 했지만 만들어져야 한다. 
//	객체를 주입한다(injection) 1. 체크박스 객체가 만들어질때 생성자에다가 외부에 그 객체를 넣어달라고 요청하는것이다.
//						  2. 메소드를 통해 주입(injection) setter를 이용해서
	void select() {
		listener.onSelect();
	}
//	1.생성자
	public CheckBox(OnSelectListener listener) {
	this.listener = listener; }
//	2.메소드를 통해 주입
	public void setOnSelectListener(OnSelectListener listener) {
	this.listener = listener;
	}
//	현업에서는 생성자를 이용한 방법을 가장 많이 사용한다.
	
	
	
}

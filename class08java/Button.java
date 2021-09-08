package CHAPTER9.chapter9_1;

public class Button {
	
	OnClickListener listener;
	
	void setOnclickListener(OnClickListener listener) {
		this.listener = listener;
	}
	
	void touch() {
		listener.onClick();
	}
//	함수형 프로그래밍 람다 표현식을 이용해서
	static interface OnClickListener{
		void onClick();
	}
}

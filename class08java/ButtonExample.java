package CHAPTER9.chapter9_1;

public class ButtonExample {
	public static void main(String[] args) {
		Button btn = new Button();
		btn.setOnclickListener(new CallListener());
		btn.touch();
		
		btn.setOnclickListener(new MessageListener());
		btn.touch();
		
	}
}

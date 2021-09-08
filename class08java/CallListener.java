package CHAPTER9.chapter9_1;

import javax.swing.ButtonModel;

public class CallListener implements Button.OnClickListener {

	@Override
	public void onClick() {
		System.out.println("전화를 겁니다.");
		
	}

}

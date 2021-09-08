package CHAPTER9.chapter9_2;

public class CheckBoxExample {
	public static void main(String[] args) {
		CheckBox checkBox = new CheckBox(new CheckBox.OnSelectListener() {
			
			@Override
			public void onSelect() {
				System.out.println("배경을 변경합니다");
				
			}
		});
		checkBox.setOnSelectListener(new CheckBox.OnSelectListener() {
			@Override
			public void onSelect() {
				System.out.println("전경을 변경ㅎㅂ니다.");
				
			}
		});
		checkBox.select();
//		new할때 바로 재정의해서 사용할 수 있다.
	}
	
	
	
	
}

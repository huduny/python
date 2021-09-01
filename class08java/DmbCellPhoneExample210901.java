package CHAPTER7;

public class DmbCellPhoneExample210901 {

	public static void main(String[] args) {
		DmbCellPhone210901 dmbCellPhone = new DmbCellPhone210901("wk", "sad", 10);
		System.out.println("모델: "+dmbCellPhone.channel);
		System.out.println(dmbCellPhone.color);
		System.out.println(dmbCellPhone.model);
		System.out.println(dmbCellPhone.apps("abc"));
	}

}

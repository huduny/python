package CHAPTER11.chaper11_01;

public class StringExample {
	public void mian(String[] args) {
		byte[] bytes = "abc".getBytes();
		
		// bytes=> 암호화
		
		String string = new String(bytes);
		System.out.println(string);
	}
}

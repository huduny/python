package CHAPTER11.chaper11_01;

public class StringCharExample {
	public static void main(String[] args) {
		String ssn = "010624-1230123";
		char sex = ssn.charAt(7);
		switch(sex) {
		case '1':
		case '3':
			System.out.println("man");
			break;
		case '2':
		case '4':
			System.out.println("woman");
			break;
		}
	}
}

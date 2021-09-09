package CHAPTER10.chapter10_1;

public class TryCatchFinallyExample {
	public static void main(String[] args) {
	String[] strArray = {"10", "2a", "30"};
	int value = 0;
	
	for(int i = 0; i<=2; i++) {
		try {
			value = Integer.parseInt(strArray[i]);
		}
		catch(ArrayIndexOutOfBoundsException e) {
			System.out.println("excess");
		}
		catch(NumberFormatException e) {
			System.out.println("cant convert");
		}
		finally {
			System.out.println(value);
		}
	}
  }
}



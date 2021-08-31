package CHAPTER6;

public class SingletonExample21083102 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Singleton21083102 instance1 = Singleton21083102.getInstance();
		Singleton21083102 instance2 = Singleton21083102.getInstance();
		System.out.println(instance1 == instance2);
	}

}

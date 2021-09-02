package CHAPTER7;

public  class ParentChild110902 extends Parent210902 {

		int p;
		void print() {
			super.printC();
			System.out.println("child1");
		}
		void breath() {
			System.out.println("숨을쉰다");
		}
		String sound() {
			return "야옹";
		}
	}


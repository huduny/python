package CHAPTER6;

import java.util.Scanner;

public class ShopServiceExample21083105 {

	public static void main(String[] args) {
		ShopService21083105 obj1 = ShopService21083105.getInstance(); //
		
		ShopService21083105 obj11 = ShopService21083105.getInstance();
		
		Scanner sca = new Scanner(System.in); //객체생성
		int obj3 = sca.nextInt(); //메모리에 상주할 필요가 없어서 scanner 같은 경우에는 그때그때 입출력
//		ctrl을 누르면 그부분으로 이동 ctrl+o를 누르면 전체를 볼수 있다.
		
		ShopService21083105 obj2 = ShopService21083105.getInstance();
		
		
		if(obj1 == obj2) {
			System.out.println("same");
		}else {
			System.out.println("different");
		}// else end

		
		
		
		
	}//main end

}//class end

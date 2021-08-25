package homeworks_08M;

import java.util.Random;

public class ReferenceTypes_0825_02 {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		로또번호를 생성하는 프로그램을 작성하시오.
//		(로또 번호는 1 ~ 45번까지 있으며 이 중에서 중복되지 않는 6개의 숫자를 추출하여 결과를 출력한다.)
		
		
		
		int[] ranNum = new int [6];
		Random random = new Random();
		
		for (int i = 0; i < ranNum.length; i++) 
		{ ranNum[i] = random.nextInt(45)+1;
		
			for (int j = 0; j < i; j++) 
			{
				if (ranNum[i]==ranNum[j])
				{
					i--;
				}
			}
			
		}
		for (int i = 0; i < ranNum.length; i++) 
		{
			System.out.println(ranNum[i]);
		}
		
	}
}

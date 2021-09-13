package CHAPTER11.chaper11_01;

public class StringReplaceExample {
	public static void main(String[] args) {
		String oldStr = "자바는 객체 지향 언어입니다. 자바는 풍부한 api를 지원합니다.";
		String newStr = oldStr.replace("자바", "java");
		System.out.println(oldStr);
		System.out.println(newStr);
		
		String str1= "JAVA PROGRAMMING";
		String str2= "java programming";
		
		System.out.println(str1.equals(str2));
		
		String lowerstr1 = str1.toLowerCase();
		String lowerstr2 = str2.toLowerCase();
		
		System.out.println(lowerstr1.equals(lowerstr2));
		
		System.out.println(str1.equalsIgnoreCase(str2));
		
		String tel1 = "    02";
		String tel2 = "       02";
		String tel3 = " 02   ";
		String tel4 = "   02 ";
		String tel = tel1.trim()+tel2.trim()+tel3.trim()+tel4.trim();
		System.out.println(tel);
		
		
		String s1 = String.valueOf(10);
		String s2 = "10";
		int i1 = 10;
		System.out.println(i1==s1);
	}
	
}

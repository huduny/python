package CHAPTER7;

public class DmbCellPhone210901 
//{
extends CellPhone210901 {

//	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int channel;
		
		DmbCellPhone210901(String model, String color, int channel){
			super();//부모클래스를 생성하는 생성자를 호출, 없으면 default
//			따라서 부모를 만들고 자식을 만든다. 먼저 cellphone이라는 부모 객체를 만들고
//			주소값을 다시 dmbcellphone이라는 자식개체가 만들어질때 참조
//			따라서 필드나 메소드에 접근 가능
			this.model = model; //부모 클래스가 가지고 있어서 접근이 가능하다
			this.color = color;
			this.channel = channel;
		}
		@Override
		public String apps(String s) {
			System.out.println("asdasdassda");
			return s+s;
		}
		
		
		
		
	} // main end

 //class end

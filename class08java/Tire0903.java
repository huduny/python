package CHAPTER7;

public class Tire0903 {
	public int maxRotation;
	public int accumulateRotation;
	public String location;
	
	public Tire0903(int maxRotation, String location) {
		this.maxRotation = maxRotation;
		this.location = location;
	}

	public boolean rooll() {
		accumulateRotation++;
		if(accumulateRotation<maxRotation) {
			System.out.println(location+" "+getClass().getSimpleName()+" 수명: " + (maxRotation-accumulateRotation)+"회");
			return true;
		}else{
		System.out.println("***"+location+" "+getClass().getSimpleName()+"펑크***");
		return false;}
	}
//	getClass().getSimpleName() 클래스의 이름을 가져온다
}

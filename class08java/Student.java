package CHAPTER8.chapter8_2;

public class Student implements Comparable<Student>{//<t>제네릭 이라는 것인데 비교를 무엇이랑 할지 타입을 정해줘야 된다.
	private String name;
	private int javascore;
	private int dbScore;
	//생정자, getter-setter, toString(), equals() - hashCode()
//	이 4개는 기본으로 만든다. 자바의 기본 스팩이다.
	
	public Student(String name, int javascore, int dbScore) {
		super();
		this.name = name;
		this.javascore = javascore;
		this.dbScore = dbScore;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getJavascore() {
		return javascore;
	}
	public void setJavascore(int javascore) {
		this.javascore = javascore;
	}
	public int getDbScore() {
		return dbScore;
	}
	public void setDbScore(int dbScore) {
		this.dbScore = dbScore;
	}
	@Override
	public int compareTo(Student o) {
//		if (name.compareTo(o.getName()) > 0) {
//			return -1;
//		} else if (name.compareTo(o.getName()) < 0 ) {
//			return 1;
//		} else {
//			return 0;
//		}
//		if (javascore > o.getJavascore()) {
//			return -1;
//		} else if (javascore < o.getJavascore()) {
//			return 1;
//		} else {
//			return 0;
//		}
//		return name.compareTo(o.getName()); //이름을 비교해서 사전식으로 분류해준다.
		
		return name.compareTo(o.getName())*(-1);
	}
	@Override
	public String toString() {
		return "이름:" + name + ", 자바:" + javascore + ", 디비:" + dbScore ;
	}

	
	
}

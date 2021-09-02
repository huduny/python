package CHAPTER7;

public class SupersonicAirplaneExample210902 {
	public static void main(String[] args) {
		SupersonicAirplane210902 sa = new SupersonicAirplane210902();
		sa.takeOff();
		sa.fly();
		sa.flyMode = SupersonicAirplane210902.SUPERSONIC;
		sa.fly();
		sa.flyMode = SupersonicAirplane210902.NORMAL;
		sa.fly();
		sa.land();
	}
}

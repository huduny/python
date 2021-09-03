package CHAPTER7;

public class Car0903 {
	Tire0903 frontLeftTire = new Tire0903(6, "앞왼쪽");
	Tire0903 frontRightTire = new Tire0903(2, "앞왼쪽");
	Tire0903 backLetfTire = new Tire0903(3, "앞왼쪽");
	Tire0903 backRightTire = new Tire0903(4, "앞왼쪽");

	int run() {
		System.out.println("[자동차가 달립니다.]");
		if (frontLeftTire.rooll() == false) {
			stop();
			return 1;
		}
		if (frontRightTire.rooll() == false) {
			stop();
			return 2;
		}
		if (backLetfTire.rooll() == false) {
			stop();
			return 3;
		}
		if (backRightTire.rooll() == false) {
			stop();
			return 4;
		}
		return 0;
	}

	private void stop() {
		System.out.println("[자동치가 멈춥니다.]");
	}

}

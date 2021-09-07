package homeworks09_07_02;

public class Novel extends Book {

	public Novel(String title, String author) {
		super(title, author);
		// TODO Auto-generated constructor stub
	}

	@Override
	public int getLateFee(int lateDays) {
		return 300*lateDays;
	}


	
}

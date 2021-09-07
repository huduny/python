package homeworks09_07_02;

public class ScienceFiction  extends Book {

	public ScienceFiction(String title, String author) {
		super(title, author);
		// TODO Auto-generated constructor stub
	}

	@Override
	public int getLateFee(int lateDays) {
		return 600*lateDays;
		}
		
	

}

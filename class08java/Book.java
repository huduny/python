package homeworks09_07_02;

import java.util.Objects;

public abstract class  Book {
	int number;
	String title;
	String author;
	static int  countOfBooks = 0;
	
	public Book(String title, String author) {
		this.title = title;
		this.author = author;
		this.number = countOfBooks++;
	
		
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	public abstract int getLateFee(int lateDays);
	
	@Override
	public int hashCode() {
		return Objects.hash(author, title);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Book))
			return false;
		Book other = (Book) obj;
		return Objects.equals(author, other.author) && Objects.equals(title, other.title);
	}

	@Override
	public String toString() {
		return String.format("Book [title=" +"%s"  + ", author=" +"%s"  + "]"+"일주일 연체료: "+"%d",title,author, getLateFee(7) );
	}

	
	
	
}

package CHAPTER11.chapter11_0915;

import java.util.List;

public class ListExample {

	public static void main(String[] args) {
		BoardDao dao = new BoardDao();
		List<Board1> list = dao.getBoard1List();
		for (Board1 board : list) {
			System.out.println(board.getTitle()+"-"+board.getContent());
		}

		
		for
	}

}

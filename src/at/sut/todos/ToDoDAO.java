package at.sut.todos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ToDoDAO {
	private static List<ToDo> todoList = new ArrayList<ToDo>();
	private static Connection connection = null;

	public List<ToDo> getAllToDos() throws SQLException {
		if (this.connection == null) {
			setConnection();
		}

		todoList.clear();

		Statement stmt = this.connection.createStatement();

		ResultSet resultSet = stmt.executeQuery("select * from ToDoTable");
		resultSet.first();

		while (!(resultSet.isAfterLast())) {
			ToDo t = new ToDo(resultSet.getString(2), resultSet.getInt(1));
			todoList.add(t);
			resultSet.next();
		}
		return todoList;

	}

	public void insertToDo(ToDo t) {

		try {
			Statement stmt = this.connection.createStatement();
			String description = t.getDescription();

			String sql = "Insert into ToDoTable (description) values ('"
					+ description + "')";

			stmt.executeUpdate(sql);

			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void updateToDo(int id, String update) {
		try {
			Statement stmt = this.connection.createStatement();

			String sql = ("UPDATE ToDoTable SET description="+update+" + where id=" + id);
					
		

			stmt.executeUpdate(sql);
			stmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteToDo(int id) {
		try {
			Statement stmt = this.connection.createStatement();

			String sql = ("DELETE FROM ToDoTable where id=" + id);

			stmt.executeUpdate(sql);
			stmt.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setConnection() throws SQLException {
		try {
			// this will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			this.connection = DriverManager
					.getConnection("jdbc:mysql://192.168.5.134/TodoDB?user=TodoUser&password=password");

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}

}

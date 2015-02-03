package at.sut.todos;

public class ToDo {

	String description;
	int id;

	public ToDo(String description, int ID) {
		this.description = description;
		this.id = ID;
	}

	public ToDo(String description) {
		this.description = description;

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}

<%@page import="at.sut.todos.ToDo"%>
<%@page import="at.sut.todos.ToDoDAO"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ToDo Website</title>
<script src="./res/js/jquery-1.11.1.min.js"></script>
<script src="./res/js/jquery-ui.min.js"></script>
<link href="./res/css/bootstrap.min.css" rel="stylesheet">
<link href="./res/css/jquery-ui.min.css" rel="stylesheet">
<script>
	$(function() {
		var isOpen = false;
		$("#toggleButton").click(function() {
			if (isOpen == false) {
				$("#input").slideToggle();
				isOpen = true;
				$("#toggleButton").html("Schließen");
			} else {
				$("#input").slideToggle();
				isOpen = false;
				$("#toggleButton").html("Add ToDo");
			}

		});
		$("[data-type='send']").click(
				function() {
					window.location = "index.jsp?type=delete&id="
							+ $(this).attr("data-id");
				});

		$("[data-type='update']").click(
				function() {
					window.location = "index.jsp?type=update&id="
							+ $(this).attr("data-id");
				});

	});
</script>
<style type="text/css">
span {
	cursor: pointer;
}

#input {
	display: none;
}

body {
	background-image: url(./res/img/background-grey.jpg);
	height: 100%;
}

#input {
	margin-top: 10px;
	margin-bottom: 10px;
}

.container {
	background-color: white;
	margin-top: 40px;
	margin-bottom: 40px;
}

h1 {
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<div id="heading">
			<h1>ToDo Website</h1>
		</div>
		<div>
			<button id="toggleButton" class="btn btn-default">Add ToDo</button>
			<%
				ToDoDAO d = new ToDoDAO();

				String description = request.getParameter("description");
				String type = request.getParameter("type");
				String update = "spielen";

				if (type != null && type.equals("delete")) {
					String id = request.getParameter("id");
					d.deleteToDo(Integer.parseInt(id));
				}

				if (type != null && type.equals("update")) {
					String id = request.getParameter("id");
					d.updateToDo(Integer.parseInt(id), "tudas");
				}

				if (description != null) {
					ToDo t = new ToDo(description);
					d.insertToDo(t);
				}

				List<ToDo> todoList = d.getAllToDos();
			%>

			<div id="input">
				<form role="form" method="post" action="index.jsp">
					<div class="form-group">
						    <label for="usr">Description:</label><input type="text"
							class="form-control" id="description" name="description">
						 
					</div>

					<input type="submit" class="btn btn-success"></input>

				</form>
			</div>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th>ID</th>
					<th>Description</th>
					<th>Delete</th>
					<th>Edit</th>
				</tr>
			</thead>
			<tbody>

				<%
					for (ToDo t : todoList) {
						if (t.getDescription() != null) {
				%>

				<tr>
					<td><%=t.getId()%></td>
					<td contenteditable="true"><%=t.getDescription()%></td>
					<td><span data-id="<%=t.getId()%>" data-type="send"
						class="glyphicon glyphicon-remove"></span></td>
					<td><span data-id="<%=t.getId()%>" data-type="update"
						class="glyphicon glyphicon-pencil"></span></td>
				</tr>

				<%
					}
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
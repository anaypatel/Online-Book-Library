<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/results.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Results</title>
</head>
<body>
	<div id="top">
		<h1><a href="index.html">LibraMate</a></h1>
		<form name="myform" method="GET" action="Results.jsp" >
			<input type="text" name="search" id="search">
			<div id="search-icon-container">
				<img id="search-icon" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-ios7-search-strong-128.png" />
			</div>
				
				<div id="group1">
					<input id="intitle" type="radio" name="radio" value="intitle" class="radio">
					<label for="title">Title</label>
					<input id="isbn" type="radio" name="radio" value="isbn" class="radio">
					<label for="isbn">ISBN</label>
				</div>
				<div id="group2">
					<input id="inauthor" type="radio" name="radio" value="inauthor" class="radio">
					<label for="author">Author</label>
					<input id="subject" type="radio" name="radio" value="subject" class="radio">
					<label for="subject">Genre</label>
				</div>
				
				<input type="hidden" id="searchtype" name="searchtype" value="books">
				
		</form>
		
		<div id="group0">
			<button id="togglebutton" value="books" onclick="searchToggle()"><i class="material-icons" style="font-size:32px">library_books</i></button>
		</div>
		
	</div>
	<table id="table">
	</table>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>

<script>

	var urlParams = new URLSearchParams(window.location.search);

	if(urlParams.get("searchtype") === "books"){	
	
		var query = urlParams.get("search");
		var radioField = urlParams.get("radio");
		// sets the value of search and radiobutton to previous entry
	 	document.getElementById("search").value = query; 
		document.getElementById(radioField).setAttribute("checked", "checked"); 
		
	 	xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if(this.readyState == 4 && this.status == 200) {
				var jsonResponse = JSON.parse(xhttp.responseText.trim());
				// begin populating table with books
				var table = document.getElementById("table");
				var row = document.createElement("tr"); 
				table.appendChild(row);
				
				for(var i = 0; i < jsonResponse.items.length; i++) {
					var td = document.createElement("td");
					
					//Getting the image
					var img = document.createElement("img");
					//If imageLinks exists.
					if( jsonResponse.items[i].volumeInfo.hasOwnProperty('imageLinks')) {
						if(jsonResponse.items[i].volumeInfo.imageLinks.extraLarge) {
							img.src = jsonResponse.items[i].volumeInfo.imageLinks.extraLarge;
						} else if(jsonResponse.items[i].volumeInfo.imageLinks.large) {
							img.src = jsonResponse.items[i].volumeInfo.imageLinks.large;
						} else if(jsonResponse.items[i].volumeInfo.imageLinks.medium) {
							img.src = jsonResponse.items[i].volumeInfo.imageLinks.medium;
						} else if(jsonResponse.items[i].volumeInfo.imageLinks.small) {
							img.src = jsonResponse.items[i].volumeInfo.imageLinks.small;
						} else if(jsonResponse.items[i].volumeInfo.imageLinks.thumbnail) {
							img.src = jsonResponse.items[i].volumeInfo.imageLinks.smallThumbnail;
						} else {
							img.src = "";
						}
					} 
					
					//Getting the Title
					var h1 = document.createElement("h2");
					var t = document.createTextNode(jsonResponse.items[i].volumeInfo.title);
					
					//Getting the link to go to the Book.jsp
					var anchor = document.createElement("A");
					anchor.href = "Details.jsp?id=" + jsonResponse.items[i].id;
					
					//Getting the author (sometimes there are no authors)
					
					var author = document.createElement("h3");
					var authorNode;
					console.log(jsonResponse.items[i].volumeInfo.hasOwnProperty("authors"))
					if(jsonResponse.items[i].volumeInfo.hasOwnProperty("authors")) {
						var authorText = "by ";
						for (var index = 0; index < jsonResponse.items[i].volumeInfo.authors.length; index++) {
							authorText += jsonResponse.items[i].volumeInfo.authors[index];
							console.log(jsonResponse.items[i].volumeInfo.authors[index]);
							if(index != jsonResponse.items[i].volumeInfo.authors.length - 1) {
								authorText += ", ";
							}
						}
						authorNode = document.createTextNode(authorText);
						author.appendChild(authorNode);
					}
					
					
					//Putting it all together
					h1.appendChild(t);
					anchor.appendChild(h1);
					author.appendChild(authorNode);
					anchor.appendChild(author);
					
					//Adding to the cell
					td.appendChild(img);
					td.appendChild(anchor);
		
					//Adding to the row			
					if(i % 4 === 0 && i != 0) {
						row = document.createElement("tr"); //Creating a new row.
						row.appendChild(td);
						table.appendChild(row);
					} else {
						row.appendChild(td);
					}
				}
			}
		};
		
	
		var url = "https://www.googleapis.com/books/v1/volumes?q=";
		var query = document.getElementById("search").value;
		query = query.replace(" ", "+"); 
		var finalUrl = url + radioField + ":" + query + "&maxResults=12";	
		
		xhttp.open("GET", finalUrl, false); 
		xhttp.send();
	
	} else{
		
		var query = urlParams.get("search");	
		var file = 'registration.json';
		$.ajax({
			url: file,
			dataType: 'json',
			success: function(data){
				console.log(data);
				var table = document.getElementById("table");
				var row = document.createElement("tr"); 
				table.appendChild(row);			
				for(i=0;i<data.users.length;i++){
					
					if(data.users[i].username.includes(query)){
						var td = document.createElement("td");
						var img = document.createElement("img");
						img.src = data.users[i].imageURL;
						
						var h1 = document.createElement("h2");
						var u = document.createTextNode(data.users[i].username);
						
						var anchor = document.createElement("A");
						anchor.href = "User.jsp?username=" + data.users[i].username;
						
						h1.appendChild(u);
						anchor.appendChild(h1);						
						td.appendChild(img);
						td.appendChild(anchor);						
						
						//Adding to the row			
						if(i % 4 === 0 && i != 0) {
							row = document.createElement("tr"); //Creating a new row.
							row.appendChild(td);
							table.appendChild(row);
						} else {
							row.appendChild(td);
						}
						
						console.log(data.users[i]);
					}
				}
				
				
			}
			
			
		});
		
		
		
	}
	
</script>

<script>

function searchToggle(){
	
	if(document.getElementById("togglebutton").value === "books"){
		document.getElementById("togglebutton").innerHTML = '<i class="fa fa-user" style="font-size:32px"></i>';
		document.getElementById("togglebutton").value = "users";
		document.getElementById("searchtype").value = "users";
		console.log(document.getElementById("searchtype").value);
	}else{
		document.getElementById("togglebutton").innerHTML = '<i class="material-icons" style="font-size:32px">library_books</i>';
		document.getElementById("togglebutton").value = "books";
		document.getElementById("searchtype").value = "books";
		console.log(document.getElementById("searchtype").value);
	}
	
}

</script>

</html>
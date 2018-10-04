<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/user.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>User</title>
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
	<button onclick="toggleFollow()" id="followbutton">Follow</button>
	
	<div id="pic"></div>
	<div id="follow">
    <h2 id="username"></h2>    
    </div>
		
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>

<script>

	var urlParams = new URLSearchParams(window.location.search);

	var username = urlParams.get("username");
	
	document.getElementById("username").innerHTML = "@" + username;
	
	var file = 'registration.json';
	$.ajax({
		url: file,
		dataType: 'json',
		success: function(data){			
			var pic = document.getElementById("pic");	 
			
			for(i=0;i<data.users.length;i++){
				if(data.users[i].username === username){
					var img = document.createElement("img");
					img.src = data.users[i].imageURL;
					pic.appendChild(img);
					break;
				}
			}
			
			
		}
	});
		
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

function toggleFollow(){
	if(document.getElementById("followbutton").innerHTML === "Follow"){
		document.getElementById("followbutton").innerHTML = "Unfollow";
	}else{
		document.getElementById("followbutton").innerHTML = "Follow";
	}
}

</script>

<script>



</script>

</html>
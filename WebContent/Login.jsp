<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/login.css">
<title>Login</title>
</head>
<body>

	
	<%
		String loginError = (String) request.getAttribute("loginError");
		if (loginError == null){
			loginError = "";
		}
		
	%>
	
	<div id="top">
		<h1><a href="index.html">LibraMate</a></h1>
	</div>
	
	<div id="bottom">
	
	<h1>Login</h1>
		
		<form name="myform" method="POST" action="Login">
		
			<div id="group1">			
			
			<style>
			#group1 {
				font-family: 'Roboto', sans-serif;
				font-size: 18px;
			}
			
			input[type=text] {
				position: relative;
				height: 20px;
				font-size: 18px;
				width: 200px;
				margin-bottom: 10px;
			}
			
			input[type=password] {
				position: relative;
				height: 20px;
				font-size: 18px;
				width: 200px;
				margin-bottom: 10px;
			}
	
			span{
				font-size: 1.5em;
				font-family: 'Roboto', sans-serif;
				color: white;
				background-color: black;
			}	
			
			input[type=submit] {
    				width: 5em;
    				height: 2em;
    				background-color: black;
    				color: white;
    				font-size: 1.5em;
				font-family: 'Roboto', sans-serif;
			}	
			
			</style>
			
				<h2>Username</h2>
				<input type="text" name="username">
				<h2>Password</h2>
				<input type="password" name="password">
				<br>
				<font color="red" name="error"><strong><%= loginError %></strong></font>	
				<br><br>
				<input type="submit" name="submit" value="Submit">
			</div>
		
		</form>
	
	</div>
	

</body>
</html>
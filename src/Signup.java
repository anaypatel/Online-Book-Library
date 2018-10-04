

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
/**
 * Servlet implementation class Search
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String imgurl = request.getParameter("imgurl");

		String next = "/index.jsp";
		
		if (username == "") {
    			request.setAttribute("usernameError", " Please enter a username.");
    			next = "/Signup.jsp";
    		}
		
		if (password == "") {
			request.setAttribute("passwordError", " Please enter a password.");
			next = "/Signup.jsp";
		}
		
		if (imgurl == "") {
			request.setAttribute("imgurlError", " Please enter an image URL.");
			next = "/Signup.jsp";
		}
		
//		String fname = "/Users/anaypatel/Desktop/Assignment 2 Solution/WebContent/registration.json";
		String fname = getServletContext().getRealPath("/registration.json"); 

		List<User> users;
		
		
		BufferedReader br = new BufferedReader(new FileReader(fname));
		Gson gson = new Gson();
						
		UserDatabase data = gson.fromJson(br, UserDatabase.class);
		users = data.getUsers();
		
		for(int i=0;i<users.size();i++) {
			if(users.get(i).getUsername().equals(username)) {
				System.out.println("true");
				request.setAttribute("usernameError", " That username has already been taken.");
	    			next = "/Signup.jsp";
	    			break;
			}
		}
		
		if(next.equals("/index.jsp")) {
			Writer wr = new FileWriter(fname);
			
			User u = new User(username, password, imgurl);
			users.add(u);
			
			UserDatabase newData = new UserDatabase(users);
			
			Gson gs = new GsonBuilder().create();
			String js = gs.toJson(newData);
			
			wr.write(js);
			wr.close();
		}
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		
    		try {
    			dispatch.forward(request,response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

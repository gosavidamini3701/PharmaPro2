package com.pharmapro.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.pharmapro.model.User;
import com.pharmapro.dao.*;

/**
 * Servlet implementation class UserLoginServlet
 */

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO(); // Instance of UserDAO  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        
        // Check if the user credentials are valid
        User user = userDAO.loginUser(email, password ,role);
        
        // Check login result
        if (user != null) {
            System.out.println("User Email: " + user.getEmail());
            System.out.println("User Role: " + user.getRole()); // Add other necessary fields
            request.getSession().setAttribute("user", user); 
            HttpSession session = request.getSession();
            user = new User(user.getUserId(),user.getUserName(), user.getEmail()); // Assume user details are retrieved
            session.setAttribute("currentUser", user);
            response.sendRedirect("dashboard.html"); 
        } else {
            request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("login.html").forward(request, response); 
        }
        
    }
		
	

}

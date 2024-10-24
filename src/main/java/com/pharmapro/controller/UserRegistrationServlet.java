package com.pharmapro.controller;

import com.pharmapro.dao.UserDAO;
import com.pharmapro.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO(); // Instance of UserDAO

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve user details from the request
        String userName = request.getParameter("user_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String phone = request.getParameter("phone");
        String Role = request.getParameter("role");
        System.out.println(userName);
        System.out.println(email);
        System.out.println(password);
        System.out.println(confirmPassword);
        System.out.println(phone);
        
        System.out.println(Role);

        // Create a User object
        User user = new User();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword(password); // Ensure to hash this before storing in production
        user.setConfirmPassword(confirmPassword);
        user.setPhone(phone);
        user.setRole(Role);
        // Register the user using UserDAO
        int result = userDAO.registerUser(user);
        
        // Check registration result
        if (result > 0) {
            // Registration successful, redirect to login page
        	
            response.sendRedirect("login.html");
        } else {
            // Registration failed, set an error message
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

package com.pharmapro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.pharmapro.connectDB.ConnectDB;
import com.pharmapro.model.Cart;
import com.pharmapro.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")

public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch the medicine ID from the request
    	
        String medicineIdStr = request.getParameter("medicine_id");
        String userEmail =null ;
        Cart cart=new Cart();
        
     
        cart.setMedicine_id(medicineIdStr);
        
        System.out.println(userEmail);
        System.out.println(medicineIdStr);
        
        
        // Retrieve user details from the session
        HttpSession session = request.getSession(false); // 'false' prevents creating a new session if one doesn't exist
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                userEmail = user.getEmail();
                System.out.println("User Email: " + userEmail);
                String  userId=""+user.getUserId();
                cart.setUser_id(userId);
                
            } else {
                response.sendRedirect("login.html"); // Redirect if user is not in session
                return;
            }
        } else {
            response.sendRedirect("login.html"); // Redirect if session doesn't exist
            return;
        }

        // Validate input parameters
        if (medicineIdStr == null || medicineIdStr.isEmpty() || userEmail == null || userEmail.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Medicine ID or User Email is missing.");
            return;
        }

        int medicineId;
        try {
            medicineId = Integer.parseInt(medicineIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Medicine ID format.");
            return;
        }

        // Database connection and operation
        try (Connection con = ConnectDB.dbCon();
             PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM cart WHERE user_email = ? AND medicine_id = ?")) {
            
            // Check if the item already exists in the cart
            checkStmt.setString(1, userEmail);
            checkStmt.setInt(2, medicineId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // If item is already in the cart, increase the quantity
                    try (PreparedStatement updateStmt = con.prepareStatement("UPDATE cart SET quantity = quantity + 1 WHERE user_email = ? AND medicine_id = ?")) {
                        updateStmt.setString(1, userEmail);
                        updateStmt.setInt(2, medicineId);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // If item is not in the cart, add it with a default quantity of 1
                    try (PreparedStatement insertStmt = con.prepareStatement("INSERT INTO cart (user_email, medicine_id, quantity) VALUES (?, ?, 1)")) {
                        insertStmt.setString(1, userEmail);
                        insertStmt.setInt(2, medicineId);
                        insertStmt.executeUpdate();
                    }
                }
                
                
            }
            
           PreparedStatement cartStmt = con.prepareStatement("SELECT quantity FROM cart WHERE user_email = ? AND medicine_id = ?");
           cartStmt.setString(1, userEmail);
           cartStmt.setInt(2, medicineId);
           ResultSet rs = cartStmt.executeQuery();
           if(rs.next())
           {
        	   int cartQty = rs.getInt("quantity");
        	   System.out.println(cartQty);
        	   cart.setQuantity(cartQty);
           }
           else {
        	   
        	   System.out.println("quantity is not retrived !!");
           }
           
           
         // Redirect to medicine catalog page with success alert
          response.sendRedirect("medicine_catalog.jsp?cartSuccess=true");


            // Redirect to the catalog page or cart page after adding the item
           // response.sendRedirect("medicine_catalog.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding to cart.");
        }
    }
}

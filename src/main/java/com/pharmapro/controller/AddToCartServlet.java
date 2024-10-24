package com.pharmapro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.pharmapro.connectDB.ConnectDB;
import com.pharmapro.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       User user=new User();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch parameters and add validation checks
        String medicineIdStr = request.getParameter("medicine_id");
        String userIdStr = request.getParameter("user_email");
        System.out.println("the user id is "+userIdStr);
        
        System.out.print("the medicne id is"+medicineIdStr);

        if (medicineIdStr == null || userIdStr == null || medicineIdStr.isEmpty() || userIdStr.isEmpty()) {
            // If parameters are missing, redirect to an error page or send an error response
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Medicine ID or User ID is missing.");
            return;
        }

        int medicineId = 0;
        int userId = 0;

        try {
            medicineId = Integer.parseInt(medicineIdStr);
            userId = Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            // If parsing fails, send an error response
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Medicine ID or User ID.");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Get a database connection
            con = ConnectDB.dbCon();

            // Check if the item is already in the user's cart
            String checkQuery = "SELECT * FROM cart WHERE user_email = ? AND medicine_id = ?";
            ps = con.prepareStatement(checkQuery);
            ps.setInt(1, userId);
            ps.setInt(2, medicineId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // If item already in the cart, update the quantity
                String updateQuery = "UPDATE cart SET quantity = quantity + 1 WHERE user_email = ? AND medicine_id = ?";
                ps = con.prepareStatement(updateQuery);
                ps.setInt(1, userId);
                ps.setInt(2, medicineId);
                ps.executeUpdate();
            } else {
                // If item is not in the cart, insert it with a default quantity of 1
                String insertQuery = "INSERT INTO cart (user_email, medicine_id, quantity) VALUES (?, ?, ?)";
                ps = con.prepareStatement(insertQuery);
                ps.setInt(1, userId);
                ps.setInt(2, medicineId);
                ps.setInt(3, 1);
                ps.executeUpdate();
            }

            // Redirect to view cart page
            response.sendRedirect("viewCart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding to cart.");
        } 
    }
}

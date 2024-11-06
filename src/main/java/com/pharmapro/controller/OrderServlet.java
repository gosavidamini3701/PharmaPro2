package com.pharmapro.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.ResultSet;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.pharmapro.connectDB.ConnectDB;
import com.pharmapro.model.Cart;
import com.pharmapro.model.User;

/**
 * Servlet implementation class OrderServlet
 */

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quantity = 1;
        int userId = 0;
        String userEmail = "";
        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("currentUser");
            if (user != null) {
                userId = user.getUserId();
                userEmail = user.getEmail();
                System.out.println("The userId is " + userId);
            }
        }

        String medicineId = request.getParameter("medicine_id");
         System.out.println("the  in the order servelet medicine id is :"+medicineId);
        // Get the quantity from the database
        java.sql.Connection connection = null;
        java.sql.PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        connection = ConnectDB.dbCon();

        try {
            String sql = "SELECT quantity FROM cart WHERE user_email = ? and medicine_id=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userEmail);
            preparedStatement.setString(2, medicineId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                quantity = resultSet.getInt("quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("the user id is " + userId);
        if (medicineId != null && !medicineId.isEmpty()) {
            java.sql.Connection con = null;
            java.sql.PreparedStatement ps = null;
            try {
                con = ConnectDB.dbCon();
                String query = "INSERT INTO orders (user_id, medicine_id, order_quantity, order_date) VALUES (?, ?, ?, NOW())";
                ps = con.prepareStatement(query);
                ps.setInt(1, userId);
                ps.setInt(2, Integer.parseInt(medicineId));
                ps.setInt(3, quantity);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
            
                      
                	request.setAttribute("medicineId", medicineId);
                    request.setAttribute("quantity", quantity);
                    
                    
                    request.getRequestDispatcher("order_details_form.jsp").forward(request, response);
                   
                } else {
                    response.sendRedirect("medicine_catalog.jsp?orderError=true");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("medicine_catalog.jsp?orderError=true");
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("medicine_catalog.jsp?orderError=true");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

 package com.pharmapro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.pharmapro.model.User;

import jakarta.servlet.http.HttpSession;

import com.pharmapro.connectDB.ConnectDB; // Assuming you have a ConnectDB class for connection handling

public class UserDAO {

    // SQL queries
    private static final String INSERT_USER_SQL = "INSERT INTO users (username, password, role, email, phone_number) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_EMAIL_AND_PASSWORD_AND_ROLE = "SELECT * FROM users WHERE email = ? AND password = ? AND role=?";

    private static final String INSERT_USER_CUSTOMER_SQL = "INSERT INTO customers (user_id, full_name,phone_number, customerEmail) VALUES (?, ?, ?, ?)";
    private static final String INSERT_USER_SUPPLIER_SQL = "INSERT INTO suppliers (user_id,supplier_name,phone_number, email) VALUES ( ?, ?, ?,?)";
    private static final String INSERT_USER_PHARMACIST_SQL = "INSERT INTO pharmacists (user_id, full_name, phone_number, pharmacist_email) VALUES (?, ?, ?, ?)";

    // Database connection method using ConnectDB
    protected static Connection getConnection() throws SQLException {
        return ConnectDB.dbCon();
    }

    public int registerUser(User user) {
        int result = 0;
        int userId = 0;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL, Statement.RETURN_GENERATED_KEYS)) {

            // Insert into users table
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getRole());
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.setString(5, user.getPhone());

            result = preparedStatement.executeUpdate();
            
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
            }

            // Role-based insertions
            String userRole = user.getRole();
            if (userRole.equalsIgnoreCase("CUSTOMER")) {
                try (PreparedStatement customerStmt = connection.prepareStatement(INSERT_USER_CUSTOMER_SQL)) {
                    customerStmt.setInt(1, userId);
                    customerStmt.setString(2, user.getUserName());
                    customerStmt.setString(3, user.getPhone());
                    customerStmt.setString(4, user.getEmail());
                    result = customerStmt.executeUpdate();
                }
            } else if (userRole.equalsIgnoreCase("SUPPLIER")) {
                try (PreparedStatement supplierStmt = connection.prepareStatement(INSERT_USER_SUPPLIER_SQL)) {
                    supplierStmt.setInt(1, userId);
                    supplierStmt.setString(2, user.getUserName());
                    supplierStmt.setString(3, user.getPhone());
                    supplierStmt.setString(4, user.getEmail());
                    result = supplierStmt.executeUpdate();
                }
            } else if (userRole.equalsIgnoreCase("PHARMACIST")) {
                try (PreparedStatement pharmacistStmt = connection.prepareStatement(INSERT_USER_PHARMACIST_SQL)) {
                    pharmacistStmt.setInt(1, userId);
                    pharmacistStmt.setString(2, user.getUserName());
                    pharmacistStmt.setString(3, user.getPhone());
                    pharmacistStmt.setString(4, user.getEmail());
                    result = pharmacistStmt.executeUpdate();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // User login method
    public  User loginUser(String email, String password,String role) {
        User user = null;

        // Using try-with-resources to automatically close resources
        try (
        	 Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_EMAIL_AND_PASSWORD_AND_ROLE)) {

            // Set parameters for the SQL query
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, role);

            // Execute the query and get the result
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    // Map the result set to the User object
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUserName(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone_number"));
                    user.setRole(role);
                    
                   
                }
            }
            
           
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
       
        return user;
    }
}

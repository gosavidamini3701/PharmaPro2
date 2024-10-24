package com.pharmapro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.pharmapro.model.User;
import com.pharmapro.connectDB.ConnectDB; // Assuming you have a ConnectDB class for connection handling

public class UserDAO {

    // SQL queries
    private static final String INSERT_USER_SQL = "INSERT INTO users (username, password, role, email, phone_number) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_EMAIL_AND_PASSWORD = "SELECT * FROM users WHERE email = ? AND password = ?";

    private static final String INSERT_USER_CUSTOMER_SQL = "INSERT INTO customers (user_id, full_name, phone_number, customerEmail) VALUES (?, ?, ?, ?)";
    private static final String INSERT_USER_SUPPLIER_SQL = "INSERT INTO suppliers (user_id, supplier_name, supplier_phone, supplier_email) VALUES (?, ?, ?, ?)";
    private static final String INSERT_USER_PHARMACIST_SQL = "INSERT INTO pharmacists (user_id, full_name, phone_number, pharmacist_email) VALUES (?, ?, ?, ?)";

    // Database connection method using ConnectDB
    protected static Connection getConnection() throws SQLException {
        return ConnectDB.dbCon();
    }

    // Register a new user
    public int registerUser(User user) {
        int result = 0;
        int userId = 0;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters for the SQL query to insert into the users table
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getRole());
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.setString(5, user.getPhone());

            // Execute the query to insert the user
            result = preparedStatement.executeUpdate();

            // Retrieve the generated user ID
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1); // Retrieve the generated user ID
            }

            // Insert into the respective role table based on the user's role
            String userRole = user.getRole();
            if (userRole.equalsIgnoreCase("CUSTOMER")) {
                try (PreparedStatement customerStmt = connection.prepareStatement(INSERT_USER_CUSTOMER_SQL)) {
                    customerStmt.setInt(1, userId); // Use the generated user ID
                    customerStmt.setString(2, user.getUserName());
                    customerStmt.setString(3, user.getPhone());
                    customerStmt.setString(4, user.getEmail());
                    result = customerStmt.executeUpdate();
                }
            } else if (userRole.equalsIgnoreCase("SUPPLIER")) {
                try (PreparedStatement supplierStmt = connection.prepareStatement(INSERT_USER_SUPPLIER_SQL)) {
                    supplierStmt.setInt(1, userId); // Use the generated user ID
                    supplierStmt.setString(2, user.getUserName());
                    supplierStmt.setString(3, user.getPhone());
                    supplierStmt.setString(4, user.getEmail());
                    result = supplierStmt.executeUpdate();
                }
            } else if (userRole.equalsIgnoreCase("PHARMACIST")) {
                try (PreparedStatement pharmacistStmt = connection.prepareStatement(INSERT_USER_PHARMACIST_SQL)) {
                    pharmacistStmt.setInt(1, userId); // Use the generated user ID
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
    public static User loginUser(String email, String password) {
        User user = null;

        // Using try-with-resources to automatically close resources
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_EMAIL_AND_PASSWORD)) {

            // Set parameters for the SQL query
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            // Execute the query and get the result
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    // Map the result set to the User object
                    user = new User();
                    user.setUserId(rs.getInt("userId"));
                    user.setUserName(rs.getString("userName"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}

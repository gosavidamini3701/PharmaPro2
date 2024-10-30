package com.pharmapro.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.pharmapro.connectDB.ConnectDB;

@WebServlet("/uploadPrescription")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
                 maxFileSize = 1024 * 1024 * 10,   // 10 MB
                 maxRequestSize = 1024 * 1024 * 50) // 50 MB
public class PrescriptionUploadServlet extends HttpServlet {

    private static final String SAVE_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String patientName = request.getParameter("patientName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");

        System.out.println("In the prescription upload");

        // Get uploaded file
        Part filePart = request.getPart("prescription_file");
        String fileName = getFileName(filePart);
        String fileType = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

        // Validate file type
        if (!fileType.equals("png") && !fileType.equals("jpg") && !fileType.equals("pdf")) {
            request.setAttribute("message", "Invalid file type. Only PNG, JPG, or PDF files are allowed.");
            request.getRequestDispatcher("prescription-upload.jsp").forward(request, response);
            return;
        }

        // Save file
        String savePath = getSavePath(request);
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        String filePath = savePath + File.separator + fileName;
        filePart.write(filePath);

        // Save to database
        try (Connection conn = ConnectDB.dbCon()) {
            String sql = "INSERT INTO prescriptions (patient_name, email, phone_number, file_path, file_type) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, patientName);
                stmt.setString(2, email);
                stmt.setString(3, phoneNumber);
                stmt.setString(4, filePath);
                stmt.setString(5, fileType);
                stmt.executeUpdate();
            }
            request.setAttribute("message", "Prescription uploaded successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while uploading the prescription.");
        }

        request.getRequestDispatcher("prescription_upload.jsp").forward(request, response);
    }

    // Helper method to extract the file name from the part header
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    // Helper method to get the save path for the uploaded file
    private String getSavePath(HttpServletRequest request) {
        String appPath = request.getServletContext().getRealPath("");
        return appPath + File.separator + SAVE_DIR;
    }
} 
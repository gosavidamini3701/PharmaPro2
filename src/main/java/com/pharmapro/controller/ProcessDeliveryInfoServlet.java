package com.pharmapro.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class ProcessDeliveryInfoServlet
 */

@WebServlet("/ProcessDeliveryInfoServlet")
public class ProcessDeliveryInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessDeliveryInfoServlet() {
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
		String deliveryAddress = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        String medicineId = request.getParameter("medicineId");
        String quantity = request.getParameter("quantity");

        // Handle delivery address and payment processing here
        // For example, save the information to the database or call a payment API
        
        // After processing, redirect to a confirmation page
        response.sendRedirect("order_confirmation.jsp");
	}

}

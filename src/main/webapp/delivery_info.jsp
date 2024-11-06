<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delivery Information</title>
</head>
<body>
    <h1>Delivery Information</h1>
    <form action="ProcessDeliveryInfoServlet" method="post">
        <label for="address">Delivery Address:</label><br>
        <input type="text" id="address" name="address" required><br><br>

        <label for="paymentMethod">Payment Method:</label><br>
        <select id="paymentMethod" name="paymentMethod" required>
            <option value="credit_card">Credit Card</option>
            <option value="debit_card">Debit Card</option>
            <option value="paypal">PayPal</option>
        </select><br><br>

        <input type="hidden" name="medicineId" value="${param.medicineId}">
        <input type="hidden" name="quantity" value="${param.quantity}">

        <input type="submit" value="Submit">
    </form>
</body>
</html>

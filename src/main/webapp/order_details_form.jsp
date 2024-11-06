<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enter Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #11598d;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            color: #11598d;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #11598d;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .submit-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Order Details</h1>
        <form action="order_confirmation.jsp" method="post">
            <!-- Pass existing parameters if they exist -->
            <input type="hidden" name="medicineId" value="<%= request.getAttribute("medicineId")%>">
            <input type="hidden" name="quantity" value="<%= request.getAttribute("quantity") %>">
            
            <div class="form-group">
                <label for="address">Delivery Address:</label>
                <input type="text" id="address" name="address" required placeholder="Enter your delivery address">
            </div>

            <div class="form-group">
                <label for="paymentMethod">Payment Method:</label>
                <select id="paymentMethod" name="paymentMethod" required>
                    <option value="">Select a payment method</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="Net Banking">Net Banking</option>
                    <option value="Cash on Delivery">Cash on Delivery</option>
                </select>
            </div>

            <button type="submit" class="submit-button">Proceed to Confirmation</button>
        </form>
    </div>
</body>
</html>

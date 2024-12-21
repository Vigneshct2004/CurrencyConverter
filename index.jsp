<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Currency Converter</title>
    <style>
        /* Make sure the html and body take the full height of the screen */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('https://static.vecteezy.com/system/resources/previews/037/752/297/non_2x/digital-currency-indian-rupee-symbol-on-golden-coin-vector.jpg') no-repeat center center;
            background-size: cover;  /* Ensures the image fills the screen */
            background-position: center center;  /* Centers the image */
            background-repeat: no-repeat;  /* Prevents image repetition */
            height: 100%; /* Ensure it takes full height */
            position: relative;  /* Needed for absolute positioning of message */
        }

        .message {
            text-align: center;
            color: green;
            font-weight: bold;
            margin-bottom: 20px;
            position: absolute;
            top: 20px;  /* Position message at the top of the screen */
            width: 100%;
        }

        form {
            background: rgba(255, 255, 255, 0.6); /* Adjust opacity to make the form transparent */
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            z-index: 1;  /* Ensure the form is always above the background */
        }

        form label {
            font-weight: bold;
            color: #333333;
            display: block;
            margin-bottom: 10px;
        }

        form select,
        form input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #d1d9e6;
            border-radius: 5px;
            font-size: 14px;
        }

        form .button-container {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        form input[type="submit"],
        form input[type="reset"],
        form input[type="button"] {
            width: 48%;  /* Adjust the width of buttons */
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        form input[type="submit"] {
            background-color: #007bff;
            color: white;
        }

        form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        form input[type="reset"] {
            background-color: #f0ad4e;
            color: white;
        }

        form input[type="reset"]:hover {
            background-color: #ec971f;
        }

        form input[type="button"] {
            background-color: #28a745;
            color: white;
        }

        form input[type="button"]:hover {
            background-color: #218838;
        }

        h2 {
            text-align: center;
            color: #333333;
            margin-bottom: 20px;
        }

        .error {
            color: red;
            font-size: 14px;
            display: none;
        }
    </style>
    <script>
        function swapCurrencies() {
            // Swap the selected values of 'from' and 'to' dropdowns
            var fromCurrency = document.getElementById("from");
            var toCurrency = document.getElementById("to");

            var temp = fromCurrency.value;
            fromCurrency.value = toCurrency.value;
            toCurrency.value = temp;
        }

        function validateForm() {
            var value = document.getElementById("val").value;
            var errorMessage = document.getElementById("error-message");

            // Check if value is a number
            if (isNaN(value) || value === "") {
                errorMessage.style.display = "block"; // Show error message
                return false; // Prevent form submission
            } else {
                errorMessage.style.display = "none"; // Hide error message
                return true; // Allow form submission
            }
        }

        function resetForm(event) {
            // Prevent the default reset behavior
            event.preventDefault();

            // Reset dropdowns to their first option
            document.getElementById("from").selectedIndex = 0;
            document.getElementById("to").selectedIndex = 0;

            // Clear input fields
            document.getElementById("val").value = "";
            document.getElementById("answer").value = "";

            // Hide the error message
            document.getElementById("error-message").style.display = "none";
        }

        document.addEventListener("DOMContentLoaded", function () {
            const form = document.querySelector("form");

            // Override reset button behavior
            form.addEventListener("reset", resetForm);
        });
    </script>
</head>
<body>
<%-- Check if a message attribute is set and display it at the top --%>
<% String message = (String) request.getAttribute("message"); %>
<% if (message != null) { %>
    <div class="message">
        <%= message %>
    </div>
<% } %>

<form action="ans" method="post" onsubmit="return validateForm()">
    <h2>Currency Converter</h2>

    <!-- Choose From Currency -->
    <label for="from">Choose From Currency:</label>
    <select name="from" id="from">
        <option value="INR" <%= "INR".equals(request.getAttribute("from")) ? "selected" : "" %>> &#x20B9; Indian Rupee (INR)</option>
        <option value="USD" <%= "USD".equals(request.getAttribute("from")) ? "selected" : "" %>> &#36; USD</option>
        <option value="EUR" <%= "EUR".equals(request.getAttribute("from")) ? "selected" : "" %>> &#8364; Euro (EUR)</option>
        <option value="JPY" <%= "JPY".equals(request.getAttribute("from")) ? "selected" : "" %>>&#165; Yen (JPY)</option>
    </select>

    <!-- Enter the Value -->
    <label for="val">Enter the Value:</label>
    <input type="text" name="val" id="val" value="<%= request.getAttribute("val") != null ? request.getAttribute("val") : "" %>" placeholder="Enter value">

    <!-- Error Message -->
    <div id="error-message" class="error">Please enter a valid number.</div>

    <!-- Choose To Currency -->
    <label for="to">Choose To Currency:</label>
    <select name="to" id="to">
        <option value="INR" <%= "INR".equals(request.getAttribute("to")) ? "selected" : "" %>>&#x20B9; Indian Rupee (INR)</option>
        <option value="USD" <%= "USD".equals(request.getAttribute("to")) ? "selected" : "" %>> &#36; USD</option>
        <option value="EUR" <%= "EUR".equals(request.getAttribute("to")) ? "selected" : "" %>> &#8364; Euro (EUR)</option>
        <option value="JPY" <%= "JPY".equals(request.getAttribute("to")) ? "selected" : "" %>>&#165; Yen (JPY)</option>
    </select>

    <!-- Converted value -->
    <label for="answer">Converted value is:</label>
    <input type="text" name="answer" id="answer" value="<%= request.getAttribute("answer") != null ? request.getAttribute("answer") : "" %>" readonly>

    <div class="button-container">
        <input type="submit" value="Convert">
        <input type="reset" value="Reset">
    </div>
    <br>
    <div class="button-container">
        <input type="button" value="Swap" onclick="swapCurrencies()">
    </div>
</form>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        form {
            background: #fff;
            border-radius: 8px;
            padding: 20px 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        form h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        form label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        form input[type="text"],
        form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        form input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        form input[type="submit"]:hover {
            background-color: #0056b3;
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
        .error-message {
            color: #d9534f;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }
    </style>
    <script>
        function validateEmail() {
            var email = document.getElementById("email").value;
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

            // Test if email matches the pattern
            if (!email.match(emailPattern)) {
                // Show error message
                document.getElementById("email-error").style.display = "block";
                return false; // Prevent form submission
            }
            document.getElementById("email-error").style.display = "none";
            return true; // Allow form submission
        }

        function validateForm(event) {
            // Validate the email on form submission
            if (!validateEmail()) {
                event.preventDefault(); // Prevent form submission if invalid email
            }
        }

        // Attach the validateForm function to the form's submit event
        document.addEventListener("DOMContentLoaded", function() {
            document.querySelector("form").addEventListener("submit", validateForm);
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
<form action="validate" method="post">
    <h2>Login</h2>

    <!-- Error message for invalid email -->
    <div class="error-message" id="email-error" style="display:none;">
        * Please enter a valid email address.
    </div>

    <!-- Email input -->
    <label for="email">Enter Email:</label>
    <input type="text" name="email" id="email" placeholder="Email" required>

    <!-- Username input -->
    <label for="uname">Enter Username:</label>
    <input type="text" name="uname" id="uname" placeholder="Username" required>

    <!-- Password input -->
    <label for="password">Enter Password:</label>
    <input type="password" name="pwd" id="password" placeholder="Password" required>

    <!-- Submit button -->
    <input type="submit" value="Login">
</form>
</body>
</html>

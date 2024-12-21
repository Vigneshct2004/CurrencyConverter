<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Error</title>
    <script type="text/javascript">
        // Display an alert with the error message and redirect to login page
        window.onload = function() {
            alert("<%= request.getAttribute("error") %>");
            window.location.href = "Login.jsp"; // Redirect to Login page
        }
    </script>
</head>
<body>
</body>
</html>

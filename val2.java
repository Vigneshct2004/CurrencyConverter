import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class val2 extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res){
        String email = req.getParameter("email");
        String uname = req.getParameter("username");
        String pwd = req.getParameter("password");

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/user", "root", "vicky10@");

            // Check if the email or username already exists
            PreparedStatement ps = conn.prepareStatement("Select * from login where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            PreparedStatement ps1 = conn.prepareStatement("Select * from login where username=?");
            ps1.setString(1, uname);
            ResultSet rs1 = ps1.executeQuery();

            // If email or username exists, forward to login page with a message
            if (rs.next() || rs1.next()) {
                req.setAttribute("message", "This email is already taken. Please try again.");
                RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
                rd.forward(req, res);
            } else {
                // Insert new user into the database
                PreparedStatement add = conn.prepareStatement("insert into login values(?,?,?)");
                add.setString(1, email);
                add.setString(2, uname);
                add.setString(3, pwd);
                add.executeUpdate();

                // Set success message for new account creation
                req.setAttribute("message", "Account successfully created!");

                // Forward to the index.jsp page
                RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
                rd.forward(req, res);
            }

            // Close the connection
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

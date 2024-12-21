import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class valServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) {
        String url = "jdbc:mysql://localhost:3308/user";
        String username = "root";
        String password = "vicky10@";

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // Check for matching credentials
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM login WHERE email=? AND username=? AND password=?"
            );
            ps.setString(1, req.getParameter("email"));
            ps.setString(2, req.getParameter("uname"));
            ps.setString(3, req.getParameter("pwd"));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Set a success message
                req.setAttribute("message", "Login successful");
                // Redirect to index.jsp
                RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
                rd.forward(req, res);
            } else {
                // Check if the email exists
                PreparedStatement ps1 = conn.prepareStatement(
                        "SELECT * FROM login WHERE email=?"
                );
                ps1.setString(1, req.getParameter("email"));
                ResultSet rs1 = ps1.executeQuery();

                if (rs1.next()) {
                    // Email exists but credentials are incorrect
                    req.setAttribute("error", "Wrong credentials. Please enter correct login details.");
                    RequestDispatcher rd = req.getRequestDispatcher("error.jsp");
                    rd.forward(req, res);
                } else {
                    // Email does not exist: Redirect to sign-in with a query parameter
                    res.sendRedirect("signIn.html?newUser=true");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import okhttp3.*;
import org.json.JSONObject;
import java.io.*;

public class Answer extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        // Get the parameters from the request
        String convertFrom = request.getParameter("from");
        String convertTo = request.getParameter("to");
        String valStr = request.getParameter("val");
        double val = 0;

        // Check if the value is a valid number
        try {
            val = Double.parseDouble(valStr);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try {
                response.getWriter().println("Invalid value for amount. Please enter a numeric value.");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
            return;
        }

        // Check if the currencies are valid (simple validation)
        if (convertFrom == null || convertTo == null || convertFrom.length() != 3 || convertTo.length() != 3) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try {
                response.getWriter().println("Invalid 'from' or 'to' currency code. Example: from=USD, to=EUR.");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        // Convert currency codes to uppercase
        convertFrom = convertFrom.toUpperCase();
        convertTo = convertTo.toUpperCase();

        // Prepare the API request URL
        String urlString = "https://api.exchangerate.host/convert?from=" + convertFrom + "&to=" + convertTo + "&amount=" + val + "&access_key=7c459a2e90ccc4122be40f65f9b9e05a";

        OkHttpClient client = new OkHttpClient();
        Request req = new Request.Builder()
                .url(urlString)
                .get()
                .build();

        try {
            // Make the request
            Response res = client.newCall(req).execute();
            String stringResponse = res.body().string();
            System.out.println("Response: " + stringResponse);

            // Check if the response contains the expected data
            JSONObject jsonObject = new JSONObject(stringResponse);
            if (!jsonObject.getBoolean("success")) {
                // Handle API error
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().println("Error: " + jsonObject.getJSONObject("error").getString("info"));
                return;
            }

            // Get the conversion result from the response
            double result = jsonObject.getDouble("result");
            System.out.println("Converted value: " + result);

            // Set the converted result as a request attribute for answer
            request.setAttribute("answer", String.format("%f", result));
            // Set the form data as request attributes to preserve it in the form
            request.setAttribute("from", convertFrom);
            request.setAttribute("to", convertTo);
            request.setAttribute("val", valStr);

            // Forward to the same form page (index.jsp)
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                response.getWriter().println("Internal server error: " + e.getMessage());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}

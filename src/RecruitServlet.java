import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/RecruitServlet") // 映射到特定的URL
public class RecruitServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 从请求中获取表单数据
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String introduction = request.getParameter("introduction");
        String position = request.getParameter("position");
        System.out.println("Name: " + name + " Phone: " + phone + " Email: " + email + " Introduction: " + introduction + " Position: " + position);

        // 数据库连接信息
        String jdbcURL = "jdbc:mysql://localhost:3306/disney?useUnicode=true&characterEncoding=UTF-8";
        String username = "root";
        String password = "root";

        // SQL插入语句
        String query = "INSERT INTO recruit (name, phone, email, introduction, position) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(jdbcURL, username, password);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, introduction);
            ps.setString(5, position);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("Recruit.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
         out.close();
    }
}
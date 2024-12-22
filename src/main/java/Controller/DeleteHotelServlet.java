package Controller;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 删除酒店的 Servlet
@WebServlet("/deletehotel")
public class DeleteHotelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 初始化 HotelService 服务层
    private HotelService hotelService;

    @Override
    public void init() throws ServletException {
        // 实例化服务层
        hotelService = new HotelService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取请求参数
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // 获取酒店ID
            String hotelId = request.getParameter("id");

            if (hotelId != null && !hotelId.isEmpty()) {
                try {
                    // 调用服务层删除酒店
                    boolean isDeleted = hotelService.deleteHotel(Integer.parseInt(hotelId));

                    if (isDeleted) {
                        // 删除成功后，重定向回酒店管理页面
                        response.sendRedirect("hotelManagement");
                    } else {
                        // 如果删除失败，显示错误页面或返回到管理页面
                        request.setAttribute("errorMessage", "删除酒店失败！");
                        request.setAttribute("errorDetail", "无法找到指定的酒店或删除时发生数据库错误。");
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    // 处理转换错误
                    request.setAttribute("errorMessage", "无效的酒店ID！");
                    request.setAttribute("errorDetail", "酒店ID必须是数字。");
                    request.getRequestDispatcher("/error.jsp").forward(request, response);
                }
            } else {
                // 没有提供ID，返回错误
                request.setAttribute("errorMessage", "酒店ID不能为空！");
                request.setAttribute("errorDetail", "您必须提供一个有效的酒店ID。");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }

    // HotelService 服务层类
    public class HotelService {
        // 负责所有与酒店相关的业务逻辑
        private HotelDao hotelDao;

        public HotelService() {
            hotelDao = new HotelDao();
        }

        // 删除酒店
        public boolean deleteHotel(int hotelId) {
            return hotelDao.deleteHotel(hotelId);
        }
    }

    // HotelDao 数据访问层类
    public class HotelDao {
        // 获取数据库连接
        public Connection getConnection() throws SQLException {
            String url = "jdbc:mysql://localhost:3306/sczl";
            String username = "root";
            String password = "123456";
            return DriverManager.getConnection(url, username, password);
        }

        // 删除酒店
        public boolean deleteHotel(int hotelId) {
            String sql = "DELETE FROM hotels WHERE id = ?";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, hotelId);
                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;  // 如果删除成功，返回 true
            } catch (SQLException e) {
                e.printStackTrace();
                return false;  // 出现错误时，返回 false
            }
        }
    }
}

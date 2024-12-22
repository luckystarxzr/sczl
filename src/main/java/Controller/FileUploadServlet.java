package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)

@WebServlet("/newupload")
public class FileUploadServlet extends HttpServlet {

    private static final String UPLOAD_DIR = ""; // 相对路径

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取表单数据
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");
        // 获取上传的文件
        Part filePart = request.getPart("fileName");
        String fileName = extractFileName(filePart);

        // 确保上传目录存在
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 创建目录
        }

        try {
            // 保存文件到指定目录
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // 数据库中保存相对路径
            String relativePath = UPLOAD_DIR + "/" + fileName;

            // 保存资讯到数据库
            saveNewsToDatabase(title, author, content, relativePath);
            // 返回上传成功信息
            response.getWriter().write("{\"message\": \"资讯上传成功！\"}");
            response.sendRedirect("adminnew.jsp"); // 跳转到资讯列表页面
        } catch (Exception e) {
            e.printStackTrace(); // 打印到控制台
            response.getWriter().write("{\"message\": \"上传失败: " + e.getMessage() + "\"}");
        }
    }

    // 从 Part 中提取文件名
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }

    // 将资讯信息保存到数据库
    private void saveNewsToDatabase(String title, String author, String content, String filePath) throws Exception {
        String dbURL = "jdbc:mysql://localhost:3306/sczl"; // 修改为你的数据库地址
        String dbUser = "root";                           // 数据库用户名
        String dbPassword = "123456";                     // 数据库密码

        String sql = "INSERT INTO news (title, author, content, file_path) VALUES (?, ?, ?, ?)";

        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, content);
            stmt.setString(4, filePath);

            stmt.executeUpdate();
        }
    }
}

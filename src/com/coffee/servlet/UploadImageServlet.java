package com.coffee.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@MultipartConfig // 处理文件上传
public class UploadImageServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "C:\\Users\\Administrator\\Downloads\\apache-tomcat-9.0.96-windows-x64\\apache-tomcat-9.0.96\\webapps\\unnamed\\img";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 获取上传的文件部分
            Part filePart = request.getPart("file");
            if (filePart == null) {
                throw new IOException("文件部分为空");
            }

            // 获取文件名
            String fileName = getFileName(filePart);
            if (fileName == null || fileName.isEmpty()) {
                throw new IOException("无法获取文件名");
            }

            // 构造保存文件的路径
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 如果目录不存在，则创建
            }
            String filePath = UPLOAD_DIR + File.separator + fileName;

            // 保存文件
            filePart.write(filePath);

            // 返回上传成功的 JSON 响应
            response.getWriter().write("{\"code\": 0, \"message\": \"文件上传成功\", \"data\": {\"src\": \"" + fileName + "\"}}");
        } catch (Exception e) {
            e.printStackTrace();
            // 返回上传失败的 JSON 响应
            response.getWriter().write("{\"code\": 1, \"message\": \"文件上传失败: " + e.getMessage() + "\"}");
        }
    }

    // 获取文件名的辅助方法
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}


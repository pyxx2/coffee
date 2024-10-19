package com.coffee.servlet;

import com.coffee.dao.ManagerDao;
import com.coffee.dao.UserDao;
import com.coffee.daoImpl.ManagerDaoImpl;
import com.coffee.daoImpl.UserDaoImpl;
import com.coffee.vo.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ManagerLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        HttpSession session = req.getSession();
        ManagerDao md = new ManagerDaoImpl();
        try {
            boolean flag = md.login(name,password);
            if (flag) {
                // 转发到 homepage.jsp 页面
                req.getRequestDispatcher("manage.jsp").forward(req, resp);
            }else{
                //重定向
                resp.sendRedirect("error.jsp");
            }
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

package com.coffee.servlet;

import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;
import com.coffee.vo.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //int id = Integer.parseInt(req.getParameter("user_id"));

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        HttpSession session = req.getSession();
        UserDao ud = new UserDaoImpl();
        try {
            boolean flag = ud.login(name,password);
            if (flag) {
                User u = ud.selectUser(name);
                //req.setAttribute("userid", id);
                //转发
//                req.getRequestDispatcher("index1.jsp").forward(req, resp);
                //
                // 将用户名作为请求属性传递给 JSP 页面
                req.setAttribute("userName", name);
                // 转发到 homepage.jsp 页面
                req.getRequestDispatcher("index.jsp").forward(req, resp);
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

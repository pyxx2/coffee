package com.coffee.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;
import com.coffee.vo.User;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = 1;
        UserDao ud = new UserDaoImpl();
        String name = req.getParameter("username");
        boolean check=ud.checkUserName(name); //找到了一样的用户名，则为true
        if(check){//找到了，在注册界面register.jsp，弹窗“该用户名已被使用”
            // 用户名已存在，提示用户
            req.setAttribute("error", "注册失败，用户名已存在。");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return; // 直接返回，避免继续执行下面的代码
        }
        String tel = req.getParameter("tel");
        String p1 = req.getParameter("pwd1");
        String p2 = req.getParameter("pwd2");
        String cartable = "car";
        boolean passwordsMatch = p1 != null && p2.equals(p1);
        String[] flag = {null,null};
        if (passwordsMatch) {
            User u = new User(id, name, tel, p1, cartable);

            flag = ud.AddUser(u);
            if (flag[1].equals("true")) {
                id = Integer.parseInt(flag[0]);
                cartable = cartable + flag[0];
                boolean fla = ud.AddTable(cartable);
                u.setId(id);
                u.setName(req.getParameter("username"));
                u.setCartable(cartable);
                boolean fl = ud.UpdateUser(u);
                if (fl && fla) {
                    req.setAttribute("userinfo", u);
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                } else {
                    req.getRequestDispatcher("register.jsp").forward(req, resp);
                }
            } else {
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        }
    }
}

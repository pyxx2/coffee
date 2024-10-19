package com.coffee.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int g = Integer.parseInt(req.getParameter("goodsid"));
        String userName = req.getParameter("userName");
        if(userName==null){
            userName=(String) req.getAttribute("userName");
        }
//        UserDao ud = new UserDaoImpl();
//        GoodsCar gc = ud.UpdateToGoodsCar(g,u);
//        req.setAttribute("goodscar", gc);
        req.setAttribute("goodsid", g);
        req.setAttribute("userName", userName);
        req.getRequestDispatcher("booking.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

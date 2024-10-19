package com.coffee.servlet;

import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("goodscarid"));
        String ct = req.getParameter("cartable");
        String userName = req.getParameter("userName");
        UserDao ud = new UserDaoImpl();
        boolean delete = ud.delete(ct,id);

        if (delete) {
            req.setAttribute("cartable", ct);
            req.setAttribute("userName", userName);
            req.getRequestDispatcher("GoodsCarServlet").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

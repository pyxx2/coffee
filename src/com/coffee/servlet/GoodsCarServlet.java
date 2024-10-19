package com.coffee.servlet;

import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;
import com.coffee.vo.GoodsCar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class GoodsCarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ct = req.getParameter("cartable");
        String userName=req.getParameter("userName");
        if(userName==null){
            userName=(String)req.getAttribute("userName");
        }
        UserDao ud = new UserDaoImpl();
        ArrayList<GoodsCar> gcs = ud.selectCartOfAll(ct);
        req.setAttribute("gcs", gcs);
        req.setAttribute("cartable", ct);
        req.setAttribute("userName", userName);
        req.getRequestDispatcher("goodsCar.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}

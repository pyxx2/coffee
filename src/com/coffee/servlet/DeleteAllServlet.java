package com.coffee.servlet;

import com.coffee.dao.ManagerDao;
import com.coffee.daoImpl.ManagerDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteAllServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("goodsId"));
        ManagerDao md=new ManagerDaoImpl();
        boolean flag=md.deleteGoods(id);
        if(flag){
            req.setAttribute("deleteMessage", "商品已成功删除");
            req.getRequestDispatcher("manageStore.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

package com.coffee.servlet;

import com.coffee.dao.ManagerDao;
import com.coffee.daoImpl.ManagerDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ChangeNumServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 接收参数
        String numStr = req.getParameter("num");
        String goodsIdStr = req.getParameter("goodsId");

        // 转换参数为合适的数据类型
        int num = Integer.parseInt(numStr);
        int goodsId = Integer.parseInt(goodsIdStr);

        ManagerDao md=new ManagerDaoImpl();
        md.changeNum(num,goodsId);
    }
}

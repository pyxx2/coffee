package com.coffee.servlet;

import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;
import com.coffee.vo.GoodsCar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SuccessServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取表单中的参数
        int g = Integer.parseInt(req.getParameter("goodsid"));
        String userName = req.getParameter("userName");
        System.out.println(userName);
//        int u = Integer.parseInt(req.getParameter("userid"));
        int selfnum = Integer.parseInt(req.getParameter("selfnum"));
        UserDao ud = new UserDaoImpl();
        GoodsCar gc = ud.UpdateToGoodsCar(g,userName);
        gc.setSelfnum(ud.selectGoodsCarSelfNum(gc));
        boolean flag = false;
        if (gc.getSelfnum()>0){
            flag = ud.UpdateGoodsCar(gc, selfnum);
        }else{

            gc.setSelfnum(selfnum);
            flag = ud.AddGoodsCar(gc);
        }
        if (flag) {
            req.setAttribute("userName",userName);
            req.setAttribute("goodsid",g);
            req.getRequestDispatcher("buycarsuccess.jsp").forward(req, resp);
        }else{
            req.getRequestDispatcher("fail.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

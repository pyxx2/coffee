package com.coffee.servlet;

import com.coffee.dao.ManagerDao;
import com.coffee.daoImpl.ManagerDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@MultipartConfig
public class AddGoodsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");


        // 获取参数
        String goodsName = request.getParameter("goodsname");
        String priceStr = request.getParameter("price"); // 获取价格的字符串
        String numStr = request.getParameter("num");
        String image = request.getParameter("image");
        String message = request.getParameter("message");

        System.out.println("goodsName: " + goodsName);
        System.out.println("priceStr: " + priceStr);
        System.out.println("numStr: " + numStr);
        System.out.println("image: " + image);
        System.out.println("message: " + message);


        // 检查参数是否为空或无效
        if (goodsName == null || priceStr == null || numStr == null || image == null || message == null) {
            response.getWriter().write("请求参数无效！");
            return;
        }

        try {
            // 转换参数
            float price = Float.parseFloat(priceStr); // 转换为浮点数
            int num = Integer.parseInt(numStr); // 转换为整数

            // 这里进行数据库的插入操作，例如调用 OrderDaoImpl 来保存商品信息
            ManagerDao md=new ManagerDaoImpl();
            boolean flag=md.addGoods(goodsName,price,num,image,message);
            if (flag){
                request.setAttribute("deleteMessage", "商品已成功添加");
                request.getRequestDispatcher("manageStore.jsp").forward(request, response);
                // 返回成功响应
                response.getWriter().write("商品添加成功！");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            // 捕获转换失败的异常，返回错误信息
            response.getWriter().write("数值转换失败，请检查输入的价格或数量！");
        }
    }
}

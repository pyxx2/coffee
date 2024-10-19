package com.coffee.servlet;

import com.coffee.dao.OrderDao;
import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;
import com.coffee.daoImpl.OrderDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class orderServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应编码，避免中文乱码
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // 获取传递的参数
        String goodsidStr = request.getParameter("goodsid");
        String userName = request.getParameter("userName");
        String selfnumStr = request.getParameter("selfnum");
        String totalPriceStr = request.getParameter("totalPrice");

        // 转换 selfnum 和 totalPrice
        int selfnum = Integer.parseInt(selfnumStr);
        double totalPrice = Double.parseDouble(totalPriceStr);


        // 处理 goodsid（String 转换为 int）
        int goodsid = 0;
        if (goodsidStr != null) {
            try {
                goodsid = Integer.parseInt(goodsidStr);
            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid Goods ID format!");
                return; // 停止执行，避免后续操作
            }
        }

        System.out.println("goodsid: " + goodsid);
        System.out.println("userName: " + userName);
        System.out.println("selfnum: " + selfnum);
        System.out.println("totalPrice: " + totalPrice);
        // 获取当前的日期和时间
        LocalDateTime currentDateTime = LocalDateTime.now();

        OrderDao od = new OrderDaoImpl();

        int orderId = 0;
        orderId=od.insertOrder(userName,goodsid,selfnum,currentDateTime,"处理中",totalPrice);
        System.out.println("orderId:"+orderId);
        if (orderId!=0){
            // 将 orderId 和 userName 存入请求属性
            request.setAttribute("orderId", orderId);
            request.setAttribute("userName", userName);
            request.getRequestDispatcher("SuccessOrder.jsp").forward(request, response);
        }else {

        }

    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // 获取用户名
        String userName = request.getParameter("userName");

        // 获取多个商品的参数
        String[] goodsidStrs = request.getParameterValues("goodsid[]");
        String[] selfnumStrs = request.getParameterValues("selfnum[]");
        String[] totalPriceStrs = request.getParameterValues("totalPrice[]");

        //获取goodscarid和catable
        String[] goodscaridStrs = request.getParameterValues("goodscarid[]");
        String catable=request.getParameter("cartable");
        System.out.println(catable);

        if (goodscaridStrs != null &&goodscaridStrs.length>0) {
            UserDao ud = new UserDaoImpl();
            for (int i = 0; i < goodscaridStrs.length; i++) {
                int goodscarid = Integer.parseInt(goodscaridStrs[i]);
                boolean delete = ud.delete(catable,goodscarid);
            }
        }

        // 创建一个列表来存储所有订单编号
        List<Integer> orderIds = new ArrayList<>();

        if (goodsidStrs != null && goodsidStrs.length > 0) {
            OrderDao od = new OrderDaoImpl();
            LocalDateTime currentDateTime = LocalDateTime.now();

            // 遍历每个商品的信息并插入订单表
            for (int i = 0; i < goodsidStrs.length; i++) {
                int goodsid = Integer.parseInt(goodsidStrs[i]);
                int selfnum = Integer.parseInt(selfnumStrs[i]);
                double totalPrice = Double.parseDouble(totalPriceStrs[i]);

                // 插入订单并获取订单编号
                int orderId = od.insertOrder(userName, goodsid, selfnum, currentDateTime, "处理中", totalPrice);

                // 将订单编号添加到列表中
                orderIds.add(orderId);
            }

            // 将订单编号列表和用户名传递到 JSP
            request.setAttribute("orderIds", orderIds);
            request.setAttribute("userName", userName);

            // 跳转到成功页面
            request.getRequestDispatcher("SuccessOrder.jsp").forward(request, response);
        } else {
            response.getWriter().println("没有选中的商品");
        }
    }
}

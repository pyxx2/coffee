package com.coffee.servlet;

import com.coffee.dao.ManagerDao;
import com.coffee.daoImpl.ManagerDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("orderId");
        System.out.println("Received orderId: " + orderId);

        if (orderId != null) {
            try {
                int order_id = Integer.parseInt(orderId);
                ManagerDao md = new ManagerDaoImpl();
                md.updateStatus(order_id);
                req.getRequestDispatcher("manageOrder.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                System.out.println("Invalid orderId format: " + orderId);
            }
        } else {
            System.out.println("orderId is null or invalid");
        }
    }


}

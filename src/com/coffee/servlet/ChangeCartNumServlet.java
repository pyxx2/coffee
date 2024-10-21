package com.coffee.servlet;

import com.coffee.dao.UserDao;
import com.coffee.daoImpl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ChangeCartNumServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String numStr = req.getParameter("num");
            String goodsIdStr = req.getParameter("goodsId");
            String cartable = req.getParameter("ct");

            System.out.println("numStr: " + numStr);
            System.out.println("goodsIdStr: " + goodsIdStr);
            System.out.println("cartable: " + cartable);

            if (numStr == null || goodsIdStr == null || cartable == null) {
                throw new IllegalArgumentException("缺少必要的参数");
            }

            // 转换参数
            int num = Integer.parseInt(numStr);
            int goodsId = Integer.parseInt(goodsIdStr);


            // 更新数据库
            UserDao ud = new UserDaoImpl();
            ud.changeNum(goodsId, num, cartable);

            // 返回成功响应
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("数量更新成功");

        } catch (NumberFormatException e) {
            // 捕获参数转换异常
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("无效的数字格式");
            e.printStackTrace(); // 输出日志帮助调试
        } catch (Exception e) {
            // 捕获其他所有异常
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("服务器内部错误");
            e.printStackTrace(); // 输出日志帮助调试
        }
    }
}

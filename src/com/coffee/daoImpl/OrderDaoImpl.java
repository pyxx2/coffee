package com.coffee.daoImpl;

import com.coffee.dao.OrderDao;
import com.coffee.db.DBConnection;
import com.coffee.vo.Order;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class OrderDaoImpl implements OrderDao {
    //连接
    public Connection con;
    public PreparedStatement ps;
    public ResultSet rs;

    @Override
    public int insertOrder(String userName, int goods_id, int num, LocalDateTime order_time, String status, double price) {
        DBConnection db = new DBConnection();
        con = db.getCon();

        // 使用 RETURN_GENERATED_KEYS 来获取生成的主键
        String sql = "INSERT INTO `order` (username, goods_id, num, order_time, status, price) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, userName);
            ps.setInt(2, goods_id);
            ps.setInt(3, num);
            ps.setTimestamp(4, Timestamp.valueOf(order_time));
            ps.setString(5, status);
            ps.setDouble(6, price);

            // 执行插入操作
            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // 获取生成的主键
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // 返回新插入记录的 ID
                    } else {
                        throw new SQLException("Inserting order failed, no ID obtained.");
                    }
                }
            } else {
                throw new SQLException("Inserting order failed, no rows affected.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public ArrayList<Order> selectOrder(String userName) {
        DBConnection db = new DBConnection();
        con = db.getCon();

        String sql = "SELECT * FROM `order` WHERE `username` = ?";
        ArrayList<Order> orders = new ArrayList<>(); // 创建一个存储订单的列表
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, userName);
            rs = ps.executeQuery();

            while (rs.next()) {
                // 从结果集中获取订单信息
                int orderId = rs.getInt("order_id");
                int goodsId = rs.getInt("goods_id");
                int num = rs.getInt("num");
                LocalDateTime orderTime = rs.getTimestamp("order_time").toLocalDateTime(); // 使用 Timestamp 转换为 LocalDateTime
                String status = rs.getString("status");
                double price = rs.getDouble("price");

                // 创建一个 Order 对象并设置属性
                Order order = new Order(userName, orderId, goodsId, num, orderTime, status, price);

                // 将订单对象添加到列表
                orders.add(order);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return orders; // 返回包含订单的列表
    }

}

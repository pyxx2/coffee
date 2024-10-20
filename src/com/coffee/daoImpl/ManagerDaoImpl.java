package com.coffee.daoImpl;

import com.coffee.dao.ManagerDao;
import com.coffee.db.DBConnection;
import com.coffee.vo.Goods;
import com.coffee.vo.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class ManagerDaoImpl implements ManagerDao {

    //连接
    public Connection con;
    public PreparedStatement ps;
    public ResultSet rs;

    @Override
    public boolean login(String name, String password) {
        boolean flag = false;
        //连接数据库
        DBConnection db = new DBConnection();
        con= db.getCon();
        //查询语句
        String sql="select * from manager where name=? and password=?";

        //预处理
        try{
            ps=con.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,password);
            rs=ps.executeQuery();
            if(rs.next()){
                flag=true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return flag;
    }

    @Override
    public ArrayList<Goods> selectAllGoods() {
        ArrayList<Goods> list = new ArrayList<>();

        DBConnection db = new DBConnection();
        con=db.getCon();

        String sql="select * from goods";
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                Goods g = new Goods();
                g.setId(rs.getInt("id"));
                g.setName(rs.getString("name"));
                g.setPrice(rs.getFloat("price"));
                g.setNum(rs.getInt("num"));
                g.setImage(rs.getString("image"));
                g.setMessage(rs.getString("message"));
                list.add(g);
            }
        }catch(SQLException e) {
            System.out.println("Database error: " + e.getMessage()); // 调试输出
            e.printStackTrace(); // 或者将错误日志打印到控制台
        }
        return list;
    }

    @Override
    public void changeNum(int num,int goodId) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql="update goods set num=? where id=?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1,num);
            ps.setInt(2,goodId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public ArrayList<Order> selectAllOrder() {
        DBConnection db = new DBConnection();
        con = db.getCon();

        String sql = "SELECT * FROM `order`";
        ArrayList<Order> orders = new ArrayList<>(); // 创建一个存储订单的列表
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                // 从结果集中获取订单信息
                int orderId = rs.getInt("order_id");
                int goodsId = rs.getInt("goods_id");
                int num = rs.getInt("num");
                LocalDateTime orderTime = rs.getTimestamp("order_time").toLocalDateTime(); // 使用 Timestamp 转换为 LocalDateTime
                String status = rs.getString("status");
                double price = rs.getDouble("price");
                String userName=rs.getString("username");

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

    @Override
    public void updateStatus(int orderId) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String status="已完成";
        String sql = "update `order` set status=? where order_id = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1,status);
            ps.setInt(2,orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean addGoods(String name, Float price, int num, String img, String msg) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql="insert into goods values(id,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1,name);
            ps.setFloat(2,price);
            ps.setInt(3,num);
            ps.setString(4,img);
            ps.setString(5,msg);
            int flag2 = ps.executeUpdate();
            if(flag2 > 0) {
                return true ;
            }else{
                return false;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}

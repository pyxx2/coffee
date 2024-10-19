package com.coffee.daoImpl;

import com.coffee.dao.ManagerDao;
import com.coffee.db.DBConnection;
import com.coffee.vo.Goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}

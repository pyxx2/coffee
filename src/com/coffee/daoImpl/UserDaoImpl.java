package com.coffee.daoImpl;

import com.coffee.dao.UserDao;
import com.coffee.db.DBConnection;
import com.coffee.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao {

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
        String sql="select * from user where name=? and password=?";

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
    public String[] AddUser(User u) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String[] A = {null,null};
        String sql="insert into user values(id,?,?,?,?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1,u.getName());
            ps.setString(2,u.getTel());
            ps.setString(3,u.getPassword());
            ps.setString(4,u.getCartable());
            int flag = ps.executeUpdate();
            if(flag > 0) {
                sql="select * from user";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                rs.last();
                A[0] = String.valueOf(rs.getInt("id"));
                A[1] = "true";
                return A ;
            }else{

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return A;
    }

    @Override
    public boolean AddTable(String cartable) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql="create table "+cartable+"(id int not null unique," +
                "name varchar(255)," +
                "price decimal," +
                "num int," +
                "image varchar(255)," +
                "selfnum int)";
        try {
            ps = con.prepareStatement(sql);
            int flag = ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

    @Override
    public boolean UpdateUser(User u) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql = "update user set name = ?,tel = ?,password = ?,cartable =? where id = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1,u.getName());
            ps.setString(2,u.getTel());
            ps.setString(3,u.getPassword());
            ps.setString(4,u.getCartable());
            ps.setInt(5,u.getId());
            int flag = ps.executeUpdate();
            if(flag > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}

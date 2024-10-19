package com.coffee.daoImpl;

import com.coffee.dao.UserDao;
import com.coffee.db.DBConnection;
import com.coffee.vo.Goods;
import com.coffee.vo.GoodsCar;
import com.coffee.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

    @Override
    public boolean UpdateGoodsCar(GoodsCar gc, int selfnum) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql = "update "+gc.getCartable()+" set selfnum=? where id = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1,gc.getSelfnum()+selfnum);
            ps.setInt(2,gc.getId());
            int flag = ps.executeUpdate();
            if(flag > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public User selectUser(String name) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        User u = new User();
        String sql="select * from user where name = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if(rs.next()) {
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setPassword(rs.getString("password"));
                u.setTel(rs.getString("tel"));
                u.setCartable(rs.getString("cartable"));
            }
        }catch(SQLException e) {
            throw new RuntimeException(e);
        }
        return u;
    }

    @Override
    public int selectGoodsCarSelfNum(GoodsCar gc) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql="select * from "+gc.getCartable()+" where id = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, gc.getId());
            rs = ps.executeQuery();
            if(rs.next()) {
                return rs.getInt("selfnum");
            }
        }catch(SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public ArrayList<Goods> selectAll()  {
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
                list.add(g);
            }
        }catch(SQLException e) {
            System.out.println("Database error: " + e.getMessage()); // 调试输出
            e.printStackTrace(); // 或者将错误日志打印到控制台
        }
        return list;
    }

    @Override
    public Goods selectGoods(int id) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        Goods g = new Goods();
        String sql="select * from goods where id = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if(rs.next()) {
                g.setId(rs.getInt("id"));
                g.setName(rs.getString("name"));
                g.setPrice(rs.getFloat("price"));
                g.setNum(rs.getInt("num"));
                g.setImage(rs.getString("image"));
                g.setMessage(rs.getString("message"));

            }
        }catch(SQLException e) {
            throw new RuntimeException(e);
        }
        return g;
    }

    @Override
    public GoodsCar UpdateToGoodsCar(int goodsid,String userName) {
        User u = selectUser(userName);
        Goods g = selectGoods(goodsid);
        GoodsCar gc = new GoodsCar(g.getId(), g.getName(), g.getPrice(), g.getNum(), g.getImage(), 1,u.getCartable());
        return gc;
    }

    @Override
    public boolean AddGoodsCar(GoodsCar gc) {
        DBConnection db = new DBConnection();
        con=db.getCon();

        String sql="insert into "+gc.getCartable()+" values(?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1,gc.getId());
            ps.setString(2,gc.getName());
            ps.setFloat(3,gc.getPrice());
            ps.setInt(4,gc.getNum());
            ps.setString(5,gc.getImage());
            ps.setInt(6,gc.getSelfnum());
            int flag = ps.executeUpdate();
            if(flag > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public ArrayList<GoodsCar> selectCartOfAll(String ct) {
        ArrayList<GoodsCar> list = new ArrayList<>();

        DBConnection db = new DBConnection();
        con=db.getCon();

        String sql="select * from "+ct;
        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                GoodsCar gc = new GoodsCar();
                gc.setId(rs.getInt("id"));
                gc.setName(rs.getString("name"));
                gc.setPrice(rs.getFloat("price"));
                gc.setNum(rs.getInt("num"));
                gc.setImage(rs.getString("image"));
                gc.setSelfnum(rs.getInt("selfnum"));
                gc.setCartable(ct);
                list.add(gc);
            }
        }catch(SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public int selectIdByUserName(String userName) {
        DBConnection db = new DBConnection();
        con = db.getCon();
        int userId = -1; // 默认值
        String sql = "SELECT id FROM user WHERE name = ?"; // 确保表名和字段名正确
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, userName); // 设置参数
            rs = ps.executeQuery(); // 执行查询
            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 打印堆栈跟踪以帮助调试
        } finally {
            // 关闭资源，防止内存泄漏
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return userId;
    }

    @Override
    public String selectNameById(int id) {
        DBConnection db = new DBConnection();
        con = db.getCon();

        String userName=null; // 默认值
        String sql = "SELECT name FROM user WHERE id = ?"; // 确保表名和字段名正确
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, id); // 设置参数
            rs = ps.executeQuery(); // 执行查询
            if (rs.next()) {
                userName = rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 打印堆栈跟踪以帮助调试
        } finally {
            // 关闭资源，防止内存泄漏
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return userName;
    }

    @Override
    public boolean delete(String ct, int id) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String sql="delete from "+ct+" where id = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1,id);
            int flag = ps.executeUpdate();
            if(flag > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public String selectCartIdByName(String userName) {
        DBConnection db = new DBConnection();
        con=db.getCon();
        String cartId=null;
        String sql="select * from user where name = ?";
        try {
            ps=con.prepareStatement(sql);
            ps.setString(1,userName);
            rs=ps.executeQuery();
            if(rs.next()) {
                cartId = rs.getString("cartable");
                return cartId;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cartId;
    }

}

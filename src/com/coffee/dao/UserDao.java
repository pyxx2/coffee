package com.coffee.dao;

import com.coffee.vo.Goods;
import com.coffee.vo.GoodsCar;
import com.coffee.vo.User;

import java.util.ArrayList;

public interface UserDao {
    //登录检查
    public boolean login(String name,String password);

    //增加用户
    public String[] AddUser(User u);

    //增加表单
    public boolean AddTable(String cartable);

    //修改cartable
    public boolean UpdateUser(User u);
    public boolean UpdateGoodsCar(GoodsCar gc, int selfnum);

    //个例查询
    public User selectUser(String name);
    public int selectGoodsCarSelfNum(GoodsCar gc);

    //全查询
    public ArrayList<Goods> selectAll();

    //查询商品
    public Goods selectGoods(int id);
    //检查商品是否还出售
    public boolean selectFromStore(int id);

    //转换类对象
    public GoodsCar UpdateToGoodsCar(int g,String userName);

    //增加购物车
    public boolean AddGoodsCar(GoodsCar gc);

    //找每个人对应购物车
    ArrayList<GoodsCar> selectCartOfAll(String ct);

    //找对应的id
    public int selectIdByUserName(String userName);
    //找对应的username
    public String selectNameById(int id);

    //删除购物车
    public boolean delete(String ct,int id);

    //通过username查找购物车
    public String selectCartIdByName(String userName);

    //修改数量
    public void changeNum(int goodsId, int num,String ct);
}

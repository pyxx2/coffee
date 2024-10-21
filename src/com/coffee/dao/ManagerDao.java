package com.coffee.dao;

import com.coffee.vo.Goods;
import com.coffee.vo.Order;

import java.util.ArrayList;

public interface ManagerDao {

    //登录检查
    public boolean login(String name, String password);

    //查询全部商品
    public ArrayList<Goods> selectAllGoods();

    //修改数量
    public void changeNum(int num,int goodId);

    //查询全部订单
    public ArrayList<Order> selectAllOrder();

    //更新订单状态
    public  void updateStatus(int orderId);

    //增加商品
    public boolean addGoods(String name, Float price, int num,String img,String msg);

    //删除商品
    public boolean deleteGoods(int goodId);
}

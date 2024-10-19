package com.coffee.dao;

import com.coffee.vo.Goods;

import java.util.ArrayList;

public interface ManagerDao {

    //登录检查
    public boolean login(String name, String password);

    //查询全部商品
    public ArrayList<Goods> selectAllGoods();

    //修改数量
    public void changeNum(int num,int goodId);
}

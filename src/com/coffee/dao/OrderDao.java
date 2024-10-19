package com.coffee.dao;

import com.coffee.vo.Order;

import java.time.LocalDateTime;
import java.util.ArrayList;

public interface OrderDao {
    //插入记录
    public int insertOrder(String userName, int goods_id, int num, LocalDateTime order_time, String status, double price);

    //根据用户名查询记录
    public ArrayList<Order> selectOrder(String userName);
    //修改记录
}

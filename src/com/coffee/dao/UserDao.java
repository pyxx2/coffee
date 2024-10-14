package com.coffee.dao;

import com.coffee.vo.User;

public interface UserDao {
    //登录检查
    public boolean login(String name,String password);

    //增加用户
    public String[] AddUser(User u);

    //增加表单
    public boolean AddTable(String cartable);

    //修改cartable
    public boolean UpdateUser(User u);
}

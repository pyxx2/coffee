package com.coffee.vo;

public class User {
    private int id;
    private String name;
    private String tel;
    private String password;
    private String cartable;
    public User(int id, String name, String tel, String password, String cartable) {
        this.id = id;
        this.name = name;
        this.tel = tel;
        this.password = password;
        this.cartable = cartable;
    }
    public User(){
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCartable() {
        return cartable;
    }

    public void setCartable(String cartable) {
        this.cartable = cartable;
    }
}

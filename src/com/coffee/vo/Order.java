package com.coffee.vo;

import java.time.LocalDateTime;

public class Order {

    private String userName;
    private int orderId;
    private int goodsId;
    private int num;
    private LocalDateTime orderTime;
    private String status;
    private double price;
    public Order(String userName, int orderId, int goodsId, int num, LocalDateTime orderTime, String status,double price) {
        this.userName = userName;
        this.orderId = orderId;
        this.goodsId = goodsId;
        this.num = num;
        this.orderTime = orderTime;
        this.status = status;
        this.price = price;
    }

    public Order() {

    }
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public LocalDateTime getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(LocalDateTime orderTime) {
        this.orderTime = orderTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}

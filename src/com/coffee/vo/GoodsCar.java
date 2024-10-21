package com.coffee.vo;

public class GoodsCar {
    private int id;
    private String name;
    private float price;
    private int num;
    private String image;
    private String cartable;

    public GoodsCar(int id, String name, float price, int num, String image, String cartable) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.num = num;
        this.image = image;
        this.cartable = cartable;
    }
    public GoodsCar(){
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }


    public String getCartable() {
        return cartable;
    }

    public void setCartable(String cartable) {
        this.cartable = cartable;
    }

}
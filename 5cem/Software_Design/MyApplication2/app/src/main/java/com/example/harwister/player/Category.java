package com.example.harwister.player;

import com.activeandroid.Model;
import com.activeandroid.annotation.Column;
import com.activeandroid.annotation.Table;

@Table(name = "category")
public class Category extends Model {

    @Column public String name = "";

    public Category() {}

    public Category(String name) {
        this.name = name;
    }
}

package com.example.harwister.player;

import com.activeandroid.Model;
import com.activeandroid.annotation.Column;
import com.activeandroid.annotation.Table;

@Table(name = "category")
public class Category extends Model {

    @Column(name = "name")
    public String name = "";

    public Category() {
        super();
    }

    public Category(String name) {
        super();
        this.name = name;
    }
}

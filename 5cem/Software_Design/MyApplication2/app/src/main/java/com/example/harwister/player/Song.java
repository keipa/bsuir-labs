package com.example.harwister.player;

import com.activeandroid.Model;
import com.activeandroid.annotation.Column;
import com.activeandroid.annotation.Table;

import java.sql.Date;

@Table(name = "songs")
public class Song extends Model {
    @Column public String name = "";
    @Column public String artist = "";
    @Column public String filepath = "";
    @Column public String imagepath = "";
    @Column public Integer duration = 0;
    @Column public Category category = new Category();
    @Column public Date date = new Date(0);

    public Song() {}

    public Song(String name, String artist, String filepath,
                String imagepath, Integer duration, Category category) {
        this.name = name;
        this.artist = artist;
        this.filepath = filepath;
        this.imagepath = imagepath;
        this.duration = duration;
        this.category = category;
    }
}

package com.example.harwister.player;

import com.activeandroid.Model;
import com.activeandroid.annotation.Column;
import com.activeandroid.annotation.Table;

import java.sql.Date;

@Table(name = "songs")
public class Song extends Model {
    @Column(name="name") public String name = "";
    @Column(name="artist") public String artist = "";
    @Column(name="filepath") public String filepath = "";
    @Column(name="imagepath") public String imagepath = "";
    @Column(name="duration") public Integer duration = 0;
    @Column(name="category") public Category category = new Category();
    @Column(name="date") public Date date = new Date(0);

    public Song() {super();}

    public Song(String name, String artist, String filepath,
                String imagepath, Integer duration, Category category) {
        super();
        this.name = name;
        this.artist = artist;
        this.filepath = filepath;
        this.imagepath = imagepath;
        this.duration = duration;
        this.category = category;
    }
}

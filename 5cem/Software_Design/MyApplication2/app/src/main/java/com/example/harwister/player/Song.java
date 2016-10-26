package com.example.harwister.player;

import android.os.Parcel;
import android.os.Parcelable;

import com.activeandroid.Model;
import com.activeandroid.annotation.Column;
import com.activeandroid.annotation.Table;

import java.sql.Date;

@Table(name = "songs")
public class Song extends Model implements Parcelable {
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

    protected Song(Parcel in) {
        name = in.readString();
        artist = in.readString();
        filepath = in.readString();
        imagepath = in.readString();
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(artist);
        dest.writeString(filepath);
        dest.writeString(imagepath);
    }

    public static final Creator<Song> CREATOR = new Creator<Song>() {
        @Override
        public Song createFromParcel(Parcel in) {
            return new Song(in);
        }

        @Override
        public Song[] newArray(int size) {
            return new Song[size];
        }
    };

    public int describeContents() {
        return 0;
    }


}

package com.example.harwister.player;

import android.os.Parcel;
import android.os.Parcelable;

import com.activeandroid.Model;
import com.activeandroid.annotation.Column;
import com.activeandroid.annotation.Table;


@Table(name = "songs")
public class Song extends Model implements Parcelable {
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
    @Column(name = "name")
    public String name = "";
    @Column(name = "artist")
    public String artist = "";
    @Column(name = "filepath")
    public String filepath = "";
    @Column(name = "imagepath")
    public int imagepath = 0;
    @Column(name = "duration")
    public long duration = 0;
    @Column(name = "category")
    public Category category = new Category();
    @Column(name = "date")

    public java.util.Date date;
    @Column(name = "picpath")
    public String picpath = "";

    public Song() {
        super();
    }

    public Song(String name, String artist, String filepath,
                Integer imagepath, Integer duration, Category category) {
        super();
        this.name = name;
        this.artist = artist;
        this.filepath = filepath;
        this.imagepath = imagepath;
        this.duration = duration;
        this.category = category;
        this.date = new java.util.Date();
    }

    protected Song(Parcel in) {
        name = in.readString();
        artist = in.readString();
        filepath = in.readString();
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeString(name);
        dest.writeString(artist);
        dest.writeString(filepath);
    }

    public int describeContents() {
        return 0;
    }


}

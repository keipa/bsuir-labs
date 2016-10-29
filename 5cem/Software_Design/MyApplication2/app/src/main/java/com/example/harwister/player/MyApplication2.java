package com.example.harwister.player;

import com.activeandroid.ActiveAndroid;
import com.activeandroid.Configuration;


public class MyApplication2 extends com.activeandroid.app.Application {
    @Override
    public void onCreate() {
        super.onCreate();
        Configuration.Builder config = new Configuration.Builder(this);
        config.addModelClasses(Category.class, Song.class);
        ActiveAndroid.initialize(config.create());
    }
}
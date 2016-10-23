package com.example.harwister.player.adapters;


import android.app.Activity;
import android.media.Image;
import android.support.v7.widget.RecyclerView;
import android.text.Layout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.activeandroid.query.Select;
import com.example.harwister.player.Category;
import com.example.harwister.player.R;
import com.example.harwister.player.Song;

import java.util.List;

public class CategoryAdapter extends RecyclerView.Adapter<CategoryAdapter.ViewHolder> {

    private List<Category> list;
    private List<Song> songs;
    private Activity activity;

    public CategoryAdapter(List<Category> categoriesList, List<Song> recentSongs, Activity activity) {
        this.activity = activity;
        this.list = categoriesList;
        this.songs = recentSongs;
    }



    public class ViewHolder extends RecyclerView.ViewHolder {
        public ViewHolder(View view){
            super(view);
        }
    }
    public class CategoryViewHolder extends ViewHolder {
        TextView name;
        TextView count;

        public CategoryViewHolder(View v) {
            super(v);
            name = (TextView)v.findViewById(R.id.CategoryNameText);
            count = (TextView)v.findViewById(R.id.CountOfCompositionsText);
        }
    }
    public class RecentSongViewHolder extends ViewHolder {
        TextView name;
        ImageView image;

        public RecentSongViewHolder(View v) {
            super(v);
            name = (TextView)v.findViewById(R.id.textView4);
            image = (ImageView)v.findViewById(R.id.imageView5);
        }
    }
    public class SeparatorViewHolder extends ViewHolder {
        public SeparatorViewHolder(View v) {
            super(v);
        }
    }



    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
//        return new ViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.category_cardview, parent, false));
        View v;
        if (viewType == 0) {
            v = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.category_cardview, parent, false);

            return new CategoryViewHolder(v);
        } else if (viewType == 1) {
            v = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.categories_and_song_separator, parent, false);
            return new SeparatorViewHolder(v);
        } else {
            v = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.song_cardview, parent, false);
            return new RecentSongViewHolder(v);
        }

    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        if (holder.getItemViewType() == 0) {
            CategoryViewHolder cholder = (CategoryViewHolder) holder;
            cholder.count.setText(Integer.toString(new Select().from(Song.class).
                    where("category = ?", list.get(position).getId()).count()));
            cholder.name.setText(list.get(position).name);
        }
        else if (holder.getItemViewType() == 1) {
            SeparatorViewHolder cholder = (SeparatorViewHolder) holder;
        }
        else {
            RecentSongViewHolder cholder = (RecentSongViewHolder) holder;
            cholder.name.setText(songs.get(position).name);
        }
    }

    @Override
    public int getItemCount() {
        return list.size() + songs.size() + 1;
    }

    @Override
    public int getItemViewType(int pos) {
        if (pos < list.size()) {
            return 0;
        } else if (pos == list.size() + 1) {
            return 1;
        }
        return 2;
    }
}
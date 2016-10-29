package com.example.harwister.player.adapters;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.activeandroid.query.Select;
import com.example.harwister.player.Category;
import com.example.harwister.player.MusicActivity;
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
        public ViewHolder(View view) {
            super(view);
        }
    }

    public class CategoryViewHolder extends ViewHolder {
        TextView name;
        TextView count;

        public CategoryViewHolder(View v) {
            super(v);
            name = (TextView) v.findViewById(R.id.CategoryNameText);
            count = (TextView) v.findViewById(R.id.CountOfCompositionsText);

            v.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(activity, MusicActivity.class);
                    //too bad
                    long id = 0;
                    for (Category c : list)
                        if (c.name == name.getText().toString()) {
                            id = c.getId();
                            continue;
                        }
                    intent.putExtra("category_id", id);
                    activity.startActivity(intent);
                }
            });
        }
    }

    public class RecentSongViewHolder extends ViewHolder {
        TextView name;
        ImageView image;

        public RecentSongViewHolder(View v) {
            super(v);
            name = (TextView) v.findViewById(R.id.textView4);
            image = (ImageView) v.findViewById(R.id.imageView5);
        }
    }

    public class SeparatorViewHolder extends ViewHolder {
        public SeparatorViewHolder(View v) {
            super(v);
        }
    }


    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        switch (viewType) {
            case 0:
                return new CategoryViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.category_cardview, parent, false));             //category
            case 1:
                return new SeparatorViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.categories_and_song_separator, parent, false));//separator
            default:
                return new RecentSongViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.song_cardview, parent, false));               //song
        }

    }


    public void addCategory(Category category) {
        list.add(0, category);
        notifyItemInserted(0);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        switch (holder.getItemViewType()) {
            case 0: {                //category
                CategoryViewHolder cholder = (CategoryViewHolder) holder;
                cholder.count.setText(Integer.toString(new Select().from(Song.class).
                        where("category = ?", list.get(position).getId()).count()) + " songs");
                cholder.name.setText(list.get(position).name);
                break;
            }
            case 1: {                 //separator
                SeparatorViewHolder cholder = (SeparatorViewHolder) holder;
                break;
            }
            default: {               //case 2 - song
                if (songs.size() != 0) {
                    RecentSongViewHolder cholder = (RecentSongViewHolder) holder;
                    cholder.name.setText(songs.get(position).name);
                    break;
                }
            }

        }

    }

    @Override
    public int getItemCount() {
        return list.size() + songs.size() + 1;
    }


    @Override
    public int getItemViewType(int pos) {
        if (pos < list.size()) {
            return 0;       // category
        } else if (pos == list.size()) {
            return 1;       // separator
        }
        return 2;           // songs
    }
}
package com.example.harwister.player.adapters;

import android.app.Activity;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.harwister.player.CategoryActivity;
import com.example.harwister.player.MusicActivity;
import com.example.harwister.player.R;
import com.example.harwister.player.Song;
import java.util.List;

import static com.example.harwister.player.R.id.category_edit_text;

public class MusicAdapter extends RecyclerView.Adapter<MusicAdapter.ViewHolder> {

    private List<Song> songs;
    private Activity activity;

    public MusicAdapter(List<Song> songs, Activity activity){
        this.activity = activity;
        this.songs = songs;
    }
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new SongViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.song_cardview, parent, false));
    }

    @Override
    public void onBindViewHolder(MusicAdapter.ViewHolder holder, int position) {
        SongViewHolder cholder = (SongViewHolder) holder;
        cholder.name.setText(songs.get(position).name);

    }

    public class SongViewHolder extends ViewHolder {
        TextView name;
        ImageView image;

        public SongViewHolder(View v) {
            super(v);
            name = (TextView)v.findViewById(R.id.textView4);
            image = (ImageView)v.findViewById(R.id.imageView5);
            v.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    //play song
                    Toast.makeText(activity, "playing", Toast.LENGTH_SHORT).show();

                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return songs.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public ViewHolder(View itemView) {
            super(itemView);
        }
    }


}

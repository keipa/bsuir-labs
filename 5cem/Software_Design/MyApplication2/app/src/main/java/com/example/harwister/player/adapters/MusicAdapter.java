package com.example.harwister.player.adapters;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.activeandroid.query.Select;
import com.example.harwister.player.AudioService;
import com.example.harwister.player.CategoryActivity;
import com.example.harwister.player.MusicActivity;
import com.example.harwister.player.R;
import com.example.harwister.player.Song;
import java.util.List;

import static com.example.harwister.player.R.id.category_edit_text;

public class MusicAdapter extends RecyclerView.Adapter<MusicAdapter.ViewHolder> {

    private List<Song> songs;
    private Activity activity;
    Intent intent;
    ServiceConnection serviceConnection;
    AudioService service;
    boolean bound = false;


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
                    intent = new Intent(activity, AudioService.class);
                    intent.putExtra("track", (Song) new Select().from(Song.class).where("name = ?", name).execute().get(0));
                    serviceConnection = new ServiceConnection() {
                        @Override
                        public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
                            service = ((AudioService.AudioPlayBinder)iBinder).getService();
                            bound = true;
                        }

                        @Override
                        public void onServiceDisconnected(ComponentName componentName) {
                            bound = false;
                        }
                    };

                }
            });
            v.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View view) {
                    Toast.makeText(activity, "deleting", Toast.LENGTH_SHORT).show();
                    return true;
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

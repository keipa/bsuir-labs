
package com.example.harwister.player.adapters;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.media.MediaPlayer;
import android.net.Uri;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.activeandroid.query.Select;
import com.example.harwister.player.R;
import com.example.harwister.player.Song;

import java.util.Date;
import java.util.List;


public class MusicAdapter extends RecyclerView.Adapter<MusicAdapter.ViewHolder> {
    private MediaPlayer mediaPlayer;
    private List<Song> songs;
    private Activity activity;


    public MusicAdapter(List<Song> songs, Activity activity) {
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

    public Dialog onCreateDialog(final String song_name) {
        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        LayoutInflater inflater = activity.getLayoutInflater();
        final View kek = inflater.inflate(R.layout.dialog_delete_song, null);
        builder.setView(kek)
                .setPositiveButton("DELETE", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        Toast.makeText(activity, "deleting", Toast.LENGTH_SHORT).show();
                        Song file_to_delete = (Song) new Select().from(Song.class).where("name = ?", song_name.toString()).execute().get(0);
                        int index = songs.indexOf(file_to_delete);
                        songs.remove(file_to_delete);
                        notifyItemRemoved(index);
                        file_to_delete.delete();
                    }
                }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
            }
        });
        builder.setTitle("Delete song?");
        return builder.create();
    }

    @Override
    public int getItemCount() {
        return songs.size();
    }

    public class SongViewHolder extends ViewHolder {
        TextView name;
        ImageView image;

        public SongViewHolder(View v) {
            super(v);
            name = (TextView) v.findViewById(R.id.textView4);
            image = (ImageView) v.findViewById(R.id.imageView5);
            v.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Toast.makeText(activity, "playing", Toast.LENGTH_SHORT).show();
                    Song song_to_play = (Song) new Select().from(Song.class).where("name = ?", name.getText().toString()).execute().get(0);
                    mediaPlayer = MediaPlayer.create(activity, Uri.parse(song_to_play.filepath));
                    mediaPlayer.start();
//                    Calendar c = Calendar.getInstance();
//                    Log.d("hi", "LOG");
//                    Log.w("TAG", String.valueOf(song_to_play.date));
                    //todo add here playing date insertion
                    Date date = new Date();
                    song_to_play.date = date;
                    song_to_play.save();

//                    fragment.setArguments(songs);

                }
            });
            v.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View view) {
                    Dialog dialog = onCreateDialog(name.getText().toString());
                    dialog.show();
                    return true;
                }
            });
        }
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public ViewHolder(View itemView) {
            super(itemView);
        }
    }


}

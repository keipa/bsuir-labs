
package com.example.harwister.player.adapters;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaPlayer;
import android.net.Uri;
import android.support.v7.app.NotificationCompat;
import android.support.v7.widget.CardView;
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

    private int playingSongPosition = -1;


    public MusicAdapter(List<Song> songs, Activity activity) {
        this.activity = activity;
        this.songs = songs;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new SongViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.song_cardview, parent, false));
    }

    @Override
    public void onBindViewHolder(final MusicAdapter.ViewHolder holder, final int position) {
        final SongViewHolder cholder = (SongViewHolder) holder;
        cholder.name.setText(songs.get(position).name);

        // image setup
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;
        Bitmap bitmap = BitmapFactory.decodeFile(songs.get(position).picpath, options);
        cholder.image.setImageBitmap(bitmap);
        // image setup

        cholder.root.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(activity, "playing", Toast.LENGTH_SHORT).show();
                Song song_to_play = (Song) new Select().from(Song.class).where("name = ?", cholder.name.getText().toString()).execute().get(0);
                if (mediaPlayer != null) mediaPlayer.stop();
                mediaPlayer = MediaPlayer.create(activity, Uri.parse(song_to_play.filepath));
                mediaPlayer.start();
                Date date = new Date();
                song_to_play.date = date;
                song_to_play.save();
                playingSongPosition = position;

            }
        });

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
        CardView root;

        public SongViewHolder(View v) {
            super(v);
            name = (TextView) v.findViewById(R.id.textView4);
            image = (ImageView) v.findViewById(R.id.imageView5);
            root = (CardView) v.findViewById(R.id.song_card);

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

    public void playNextSong(ImageView imageView) {
        playingSongPosition = ++playingSongPosition % songs.size();
        Toast.makeText(activity, "playing song number " + playingSongPosition, Toast.LENGTH_SHORT).show();
        Song song_to_play = songs.get(playingSongPosition);
        if (mediaPlayer != null) mediaPlayer.stop();
        mediaPlayer = MediaPlayer.create(activity, Uri.parse(song_to_play.filepath));

        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;
        Bitmap bitmap = BitmapFactory.decodeFile(song_to_play.picpath, options);
//        selected_photo.setImageBitmap(bitmap);
        imageView.setImageBitmap(bitmap);
        mediaPlayer.start();
        Date date = new Date();
        song_to_play.date = date;
        song_to_play.save();

    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public ViewHolder(View itemView) {
            super(itemView);
        }
    }


}

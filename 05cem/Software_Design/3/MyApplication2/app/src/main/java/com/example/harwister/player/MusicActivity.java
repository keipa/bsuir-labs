package com.example.harwister.player;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.ContentResolver;
import android.content.DialogInterface;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.annotation.NonNull;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import com.activeandroid.query.Select;
import com.example.harwister.player.adapters.MusicAdapter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Random;

public class MusicActivity extends AppCompatActivity implements PlayFragment.OnFragmentInteractionListener{
    MusicAdapter musicAdapter;
    List<Song> songs;
    Long categoryId;
    int[] images = {R.drawable.ima1,
            R.drawable.ima2,
            R.drawable.ima3,
            R.drawable.ima4};
    Random ran = new Random();

    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music);
        categoryId = getIntent().getExtras().getLong("category_id");
        songs = new Select().from(Song.class).where("category = ?", categoryId).execute();
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab_music);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Dialog dialog = onCreateDialog(savedInstanceState);
                dialog.show();
            }
        });
        RecyclerView rec = (RecyclerView) findViewById(R.id.MusicList);
        rec.setLayoutManager(new LinearLayoutManager(this));
        musicAdapter = new MusicAdapter(songs, this);
        rec.setAdapter(musicAdapter);


    }

    public void playNextSong(ImageView imageView){
        musicAdapter.playNextSong(imageView);
    }


    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(MusicActivity.this);
        LayoutInflater inflater = MusicActivity.this.getLayoutInflater();
        final View view_dialog = inflater.inflate(R.layout.dialog_add_song, null);
        final List<Integer> mSelectedItems = new ArrayList<>();
        final ArrayList<Song> songs_on_the_device = findTracks();
        CharSequence[] charSongs = ConvertToCharSequence(songs_on_the_device);
        boolean[] zeroArraySelectedSongs = new boolean[songs_on_the_device.size()];
        builder.setView(view_dialog).setMultiChoiceItems(charSongs, zeroArraySelectedSongs,
                new DialogInterface.OnMultiChoiceClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which, boolean isChecked) {
                        if (isChecked) mSelectedItems.add(which);
                        else if (mSelectedItems.contains(which))
                            mSelectedItems.remove(Integer.valueOf(which));
                    }
                }).setPositiveButton("Add", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int id) {
                Toast.makeText(MusicActivity.this, "Song added", Toast.LENGTH_SHORT).show();
                for (int chosenSong : mSelectedItems) {
                    Song new_song = new Song();
                    new_song.name = songs_on_the_device.get(chosenSong).name;
                    new_song.artist = songs_on_the_device.get(chosenSong).artist;
                    new_song.filepath = songs_on_the_device.get(chosenSong).filepath;
                    new_song.category = (Category) new Select().from(Category.class).where("Id = ?", categoryId).execute().get(0);
                    new_song.imagepath = images[ran.nextInt(images.length - 1)];
                    new_song.save();
                    songs.add(new_song);
                    musicAdapter.notifyItemInserted(songs.size());
                }
            }
        }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int id) {
            }
        });
        builder.setTitle("New Category");
        return builder.create();
    }

    private CharSequence[] ConvertToCharSequence(ArrayList<Song> songs) {
        CharSequence[] charSongs = new CharSequence[songs.size()];
        for (int i = 0; i < songs.size(); i++) charSongs[i] = songs.get(i).name;
        return charSongs;
    }


    public ArrayList<Song> findTracks() {
        ArrayList<Song> tracks = new ArrayList<>();
        String[] projection = {
                MediaStore.Audio.Media._ID,
                MediaStore.Audio.Media.ARTIST,
                MediaStore.Audio.Media.TITLE,
                MediaStore.Audio.Media.DATA
        };
        Uri uriInternal = MediaStore.Audio.Media.INTERNAL_CONTENT_URI;
        ContentResolver contentResolver = getContentResolver();
        Cursor cursorInt = contentResolver.query(uriInternal, projection, null, null, null);

        if (cursorInt != null) {
            for (int i = 0; i < cursorInt.getCount(); i++) {
                cursorInt.moveToPosition(i);
                int id = cursorInt.getInt(cursorInt.getColumnIndex(MediaStore.Audio.Media._ID));
                String title = cursorInt.getString(cursorInt.getColumnIndex(MediaStore.Audio.Media.TITLE));
                String artist = cursorInt.getString(cursorInt.getColumnIndex(MediaStore.Audio.Media.ARTIST));
                String data = cursorInt.getString(cursorInt.getColumnIndex(MediaStore.Audio.Media.DATA));
                Song track = new Song(title, artist, data, 0, 100, null);
                if (!track.artist.equals("<unknown>")) tracks.add(track);
            }
            cursorInt.close();
        }

        return tracks;
    }


    @Override
    public void onFragmentInteraction(Uri uri) {

    }
}


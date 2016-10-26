package com.example.harwister.player;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.ContentResolver;
import android.content.DialogInterface;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.provider.MediaStore;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Toast;

import com.activeandroid.query.Select;
import com.example.harwister.player.adapters.MusicAdapter;

import java.util.ArrayList;
import java.util.List;

public class MusicActivity extends AppCompatActivity {
    MusicAdapter musicAdapter;
    List<Song> songs;


    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music);

        final Long id = getIntent().getExtras().getLong("category_id");
        songs = new Select().from(Song.class).where("category = ?", id).execute();
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab_music);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Dialog dialog = onCreateDialog(savedInstanceState);

                ArrayList<Song> songs = findTracks();

                dialog.show();
            }
        });


        RecyclerView rec = (RecyclerView) findViewById(R.id.MusicList);
        rec.setLayoutManager(new LinearLayoutManager(this));


        musicAdapter = new MusicAdapter(songs, this);
        rec.setAdapter(musicAdapter);
    }


    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(MusicActivity.this);
        LayoutInflater inflater = MusicActivity.this.getLayoutInflater();
        final View view_dialog = inflater.inflate(R.layout.dialog_add_song, null); // set to list of SONGS
        final List<Integer> mSelectedItems = new ArrayList<>();
        ArrayList<Song> songs = findTracks();
        CharSequence[] charSongs = ConvertToCharSequence(songs);
        boolean[] zeroArraySelectedSongs = new boolean[songs.size()];
        builder.setView(view_dialog).setMultiChoiceItems(charSongs,zeroArraySelectedSongs,
                new DialogInterface.OnMultiChoiceClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which, boolean isChecked) {
                        if (isChecked) mSelectedItems.add(which);
                        else if (mSelectedItems.contains(which)) mSelectedItems.remove(Integer.valueOf(which));
                    }
                }).setPositiveButton("Add",new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int id) {
                Toast.makeText(MusicActivity.this, "Song added", Toast.LENGTH_SHORT).show();
                for (int chosenSong:mSelectedItems) {
                    Song new_song = new Song(); //todo end right there
                }
            }
        }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int id) {}
        });
        builder.setTitle("New Category");
        return builder.create();
    }

    private CharSequence[] ConvertToCharSequence(ArrayList<Song> songs) {
        CharSequence[] charSongs =  new CharSequence[songs.size()];
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
                Song track = new Song(title, artist, data, data, 100, null);
                if (!track.artist.equals("<unknown>"))
                    tracks.add(track);
            }
            cursorInt.close();
        }

        return tracks;
    }


}


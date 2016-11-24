package com.example.harwister.player;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.ContentResolver;
import android.content.DialogInterface;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.provider.MediaStore;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.view.GestureDetectorCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.GestureDetector;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import com.activeandroid.query.Select;
import com.example.harwister.player.adapters.FileSafeTask;
import com.example.harwister.player.adapters.MusicAdapter;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MusicActivity extends AppCompatActivity implements PlayFragment.OnFragmentInteractionListener {
    public MusicAdapter musicAdapter;
    List<Song> songs;
    Long categoryId;
    int[] images = {R.drawable.ima1,
            R.drawable.ima2,
            R.drawable.ima3,
            R.drawable.ima4};
    Random ran = new Random();

    private GestureDetectorCompat mDetector;

    private float mScaleFactor = 1.f;
    private long ndkDurationSum = 0;
    private long durationOfNDKSum = 0;
    private long javaDurationSum = 0;
    private long durationOfJavaSum = 0;

    static {
        System.loadLibrary("native_sum");
    }


    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

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

        mDetector = new GestureDetectorCompat(this, new MyGestureListener());


        rec.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                mDetector.onTouchEvent(event);
                return false;
            }
        });

//        PlayFragment fragment = new PlayFragment();
//        fragment.songs = songs;
//        fragment.current_song = songs.get(0);
//        fragment.activity = this;
    }

    public void playNextSong(ImageView imageView) {
        musicAdapter.playNextSong(imageView);
    }



    public native long findDurationSumWithNDK(long[] arr);

    protected long findDurationSumWithJava(long[] arr) {
        long sum = 0;
        for (int i = 0; i < arr.length; i++) {
            sum += arr[i];
        }
        return sum;
    }

    protected void findDurationSums() throws InterruptedException {
        long[] arr = new long[songs.size()];
        for (int i = 0; i < songs.size(); i++) {
            arr[i] = songs.get(i).duration;
        }

        this.durationOfNDKSum = System.currentTimeMillis();
        ndkDurationSum = findDurationSumWithNDK(arr);
        this.durationOfNDKSum = System.currentTimeMillis() - this.durationOfNDKSum;

        this.durationOfJavaSum = System.currentTimeMillis();
        Thread.sleep(1,1);
        javaDurationSum = findDurationSumWithJava(arr);
        this.durationOfJavaSum = System.currentTimeMillis() - this.durationOfJavaSum;
    }

    @Override
    protected void onStart() {
        super.onStart();
        try {
            findDurationSums();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Toast.makeText(this, "NDK SUM: " + this.ndkDurationSum
                + " " + durationOfNDKSum + " Miliseconds", Toast.LENGTH_LONG).show();
        Toast.makeText(this, "JAVA SUM: " + this.javaDurationSum
                + " " + durationOfJavaSum + " Miliseconds", Toast.LENGTH_LONG).show();
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
                MediaMetadataRetriever mmr = new MediaMetadataRetriever();
                for (int chosenSong : mSelectedItems) {
                    Song new_song = new Song();
                    new_song.name = songs_on_the_device.get(chosenSong).name;
                    new_song.artist = songs_on_the_device.get(chosenSong).artist;
                    new_song.filepath = songs_on_the_device.get(chosenSong).filepath;

                    mmr.setDataSource(new_song.filepath);
                    String duration = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION);
                    new_song.duration = Long.parseLong(duration);

                new_song.category = (Category) new Select().
                        from(Category.class).where("Id = ?", categoryId).execute().get(0);

                songs.add(new_song);
                FileSafeTask task = new FileSafeTask(new_song, MusicActivity.this);
                  new_song.save();
                task.execute();
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

    public void onSwipeLeft(){
        playNextSong((ImageView) findViewById(R.id.song_imageview));
    }

    class MyGestureListener extends GestureDetector.SimpleOnGestureListener {
        private static final int SWIPE_MIN_DISTANCE = 120;
        private static final int SWIPE_MAX_OFF_PATH = 250;
        private static final int SWIPE_THRESHOLD_VELOCITY = 200;

        @Override
        public boolean onDown(MotionEvent event) {
            return true;
        }

        @Override
        public boolean onFling(MotionEvent event1, MotionEvent event2,
                               float velocityX, float velocityY) {

            float diffY = event2.getY() - event1.getY();
            if (diffY > SWIPE_MAX_OFF_PATH)
                return false;

            float diffX = event2.getX() - event1.getX();
            if (Math.abs(diffX) > SWIPE_MIN_DISTANCE &&
                    Math.abs(velocityX) > SWIPE_THRESHOLD_VELOCITY) {
                if (diffX > 0) {
                    //right swipe
                } else {
                    onSwipeLeft();
                }

                return true;
            }
            return false;
        }
    }
}


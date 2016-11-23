package com.example.harwister.player;

import android.app.Activity;
import android.content.Context;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;

import java.util.List;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link PlayFragment.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * create an instance of this fragment.
 */
public class PlayFragment extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER


    // TODO: Rename and change types of parameters

    public List<Song> songs;
    public Song current_song;
    private OnFragmentInteractionListener mListener;
    public MediaPlayer mediaPlayer;
    public Activity activity;

    private ScaleGestureDetector mDetector;

    private Button playNextSong;

    float mScaleFactor = 1.f;

    public PlayFragment() {
    }

    // TODO: Rename and change types and number of parameters
   /* public static PlayFragment newInstance(List<Song> kek) {
        PlayFragment fragment = new PlayFragment();
        fragment.songs = kek;
        return fragment;
    }*/

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment

        View v = inflater.inflate(R.layout.fragment_play, container, false);
        final ImageView song_imageview = (ImageView) v.findViewById(R.id.song_imageview);

        mDetector = new ScaleGestureDetector(getActivity(), new ScaleListener());

        playNextSong = (Button) v.findViewById(R.id.next_song_button);


        playNextSong.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return mDetector.onTouchEvent(event);
            }
        });

/*        playNextSong.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View ve) {
//                song_imageview.setImageResource(R.drawable.ima1);
                ((MusicActivity) getActivity()).playNextSong(song_imageview);

            }
        });*/



//        v.findViewById(R.id.song_imageview)
        // set image
        return v;
    }

//    private void play() {
//        mediaPlayer = MediaPlayer.create(activity, Uri.parse(current_song.filepath));
//        mediaPlayer.start();
//    }
//
//    private void playNextSong() {
//      /*  int index = songs.indexOf(current_song);
//        if (songs.size() == index - 1) current_song = songs.get(1);
//        else current_song = songs.get(index + 1);*/
//
//    }


    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    class ScaleListener extends ScaleGestureDetector.SimpleOnScaleGestureListener {
        @Override
        public boolean onScale(ScaleGestureDetector detector) {

            mScaleFactor *= detector.getScaleFactor();

            // Don't let the object get too small or too large.
            mScaleFactor = Math.max(0.9f, Math.min(mScaleFactor, 1.1f));


            playNextSong.setTextSize(TypedValue.COMPLEX_UNIT_PX,
                    playNextSong.getTextSize() * mScaleFactor);

            playNextSong.invalidate();
            return true;
        }
    }
}

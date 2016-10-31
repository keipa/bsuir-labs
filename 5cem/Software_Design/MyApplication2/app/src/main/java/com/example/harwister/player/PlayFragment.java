package com.example.harwister.player;

import android.app.Activity;
import android.content.Context;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link PlayFragment.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link PlayFragment#newInstance} factory method to
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

    public PlayFragment() {
    }

    // TODO: Rename and change types and number of parameters
    public static PlayFragment newInstance(List<Song> kek) {
        PlayFragment fragment = new PlayFragment();
        fragment.songs = kek;
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v =inflater.inflate(R.layout.fragment_play, container, false);
        v.findViewById(R.id.next_song_button).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setNextSong();
                play();
            }
        });
//        v.findViewById(R.id.song_imageview)
        // set image
        return v;
    }

    private void play() {
        mediaPlayer = MediaPlayer.create(activity, Uri.parse(current_song.filepath));
        mediaPlayer.start();
    }

    private void setNextSong() {
        int index = songs.indexOf(current_song);
        if (songs.size() == index - 1) current_song = songs.get(1);
        else current_song = songs.get(index + 1);

    }


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
}

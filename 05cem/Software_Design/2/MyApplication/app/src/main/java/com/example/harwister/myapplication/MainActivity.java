package com.example.harwister.myapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.content.res.Configuration;

import android.widget.RelativeLayout;
import android.widget.Toast;


import java.util.*;


public class MainActivity extends AppCompatActivity {

    int marginTop = 0;
    int marginLeft = 0;
    List<String> namesCheckboxes = new ArrayList<String>();
    List<Boolean> checkedCheckboxes = new ArrayList<Boolean>();
    List<CheckBox> checkboxes = new ArrayList<CheckBox>();


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        menu.add(0,0,0,"Clear all");
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        final RelativeLayout layout = (RelativeLayout) findViewById(R.id.relativelayout);

        deleteallCheckboxes(layout);
        Toast.makeText(this, "CLEARED", Toast.LENGTH_SHORT).show();
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button button = (Button) findViewById(R.id.button);
        final EditText edit = (EditText) findViewById(R.id.editText);
        final EditText email = (EditText)  findViewById(R.id.editText2);
        Button button2 = (Button) findViewById(R.id.button2);
        final RelativeLayout layout = (RelativeLayout) findViewById(R.id.relativelayout);
        final int wrapContent = RelativeLayout.LayoutParams.WRAP_CONTENT;

        if (button != null) {
            button.setOnClickListener(new View.OnClickListener() {
                                          @Override
                                          public void onClick(View v) {
                                              addCheckboxes(wrapContent,edit, layout);
                                          }
                                      }
            );
        }
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteCheckboxes(layout);

            }
        });



    }
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        marginLeft = 0;
        marginTop = 0;
        final int wrapContent = RelativeLayout.LayoutParams.WRAP_CONTENT;
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(wrapContent, wrapContent);
        final RelativeLayout layout = (RelativeLayout) findViewById(R.id.relativelayout);
        int size = checkboxes.size();
        for (int i = 0; i<size-1; i++) {
            if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT) {
                marginTop += 80;
            } else {
                marginLeft += 160;
            }
            params.setMargins(marginLeft,marginTop,0,0);
            CheckBox newItem = new CheckBox(this);
            newItem.setText(checkboxes.get(i).getText());
            newItem.setChecked(checkboxes.get(i).isChecked());
            newItem.setLayoutParams(params);
            layout.addView(newItem, params);
        }

    }


    private void deleteCheckboxes(RelativeLayout layout) {
        for (int counter = 0; counter < layout.getChildCount(); counter++) {
            CheckBox checkBox = (CheckBox) layout.getChildAt(counter);
            if (checkBox.isChecked()) {
                layout.removeViewAt(counter);
                checkboxes.remove(counter);
                counter--;
            }
        }

    }


    private void deleteallCheckboxes(RelativeLayout layout) {
        for (int counter = 0; counter < layout.getChildCount(); counter++) {
            CheckBox checkBox = (CheckBox) layout.getChildAt(counter);
                layout.removeViewAt(counter);
                checkboxes.remove(counter);


        }

    }

    private void addCheckboxes(int wrapContent, EditText edit, RelativeLayout layout) {
        int orientation = getResources().getConfiguration().orientation;

        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(wrapContent, wrapContent);
        CheckBox newItem = new CheckBox(this);
        newItem.setText(edit.getText());

        if (orientation == Configuration.ORIENTATION_PORTRAIT) {
            marginTop += 80;
        } else {
            marginLeft += 160;
        }
        params.setMargins(marginLeft,marginTop,0,0);

        newItem.setLayoutParams(params);
        checkboxes.add(newItem);
        layout.addView(newItem, params);

    }


}

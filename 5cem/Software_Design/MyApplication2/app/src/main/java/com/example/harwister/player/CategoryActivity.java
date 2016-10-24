package com.example.harwister.player;

    import android.app.AlertDialog;
    import android.app.Dialog;
    import android.content.DialogInterface;
    import android.os.Bundle;
    import android.support.design.widget.FloatingActionButton;
    import android.support.v7.app.AppCompatActivity;
    import android.support.v7.widget.LinearLayoutManager;
    import android.support.v7.widget.RecyclerView;
    import android.support.v7.widget.Toolbar;
    import android.view.LayoutInflater;
    import android.view.View;
    import android.view.Menu;
    import android.view.MenuItem;
    import android.widget.EditText;
    import android.widget.Toast;

    import com.activeandroid.ActiveAndroid;
    import com.activeandroid.query.Select;
    import com.example.harwister.player.adapters.CategoryAdapter;
    import java.util.List;


public class CategoryActivity extends AppCompatActivity {
    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_category);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Dialog dialog = onCreateDialog(savedInstanceState);
                dialog.show();
            }
        });
        RecyclerView rec = (RecyclerView) findViewById(R.id.CategoriesList);
        rec.setLayoutManager(new LinearLayoutManager(this));

        List<Category> listcategory = new Select().from(Category.class).execute();
        List<Song> listsong = new Select().from(Song.class).execute();
        rec.setAdapter(new CategoryAdapter(listcategory, listsong,this));

    }

    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(CategoryActivity.this);

        LayoutInflater inflater = CategoryActivity.this.getLayoutInflater();

        builder.setView(inflater.inflate(R.layout.dialog_create_category, null))
                .setPositiveButton("Create", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        EditText category_edit_text =(EditText) findViewById(R.id.category_edit_text);
                        Toast.makeText(CategoryActivity.this, "Category "+category_edit_text.getText().toString()+" added", Toast.LENGTH_SHORT).show();
                        Toast.makeText(CategoryActivity.this, "Text saved", Toast.LENGTH_SHORT).show();
                    }
                })
                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                    }
                });
        builder.setTitle("New Category");
        return builder.create();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_category, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}

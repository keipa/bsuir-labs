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
    import com.activeandroid.query.Select;
    import com.example.harwister.player.adapters.CategoryAdapter;
    import java.util.List;


public class CategoryActivity extends AppCompatActivity {
    CategoryAdapter categoryadapter;

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
        SendDataToAdapter(rec);

    }

    public Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(CategoryActivity.this);
        LayoutInflater inflater = CategoryActivity.this.getLayoutInflater();
        final View kek = inflater.inflate(R.layout.dialog_create_category, null);
        builder.setView(kek)
                .setPositiveButton("Create", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int id) {
                        EditText category_edit_text =(EditText)kek.findViewById(R.id.category_edit_text);
                        AddCategoryDialog(category_edit_text);
                        Toast.makeText(CategoryActivity.this, "Category "+category_edit_text.getText().toString()+" added", Toast.LENGTH_SHORT).show();
                    }
                }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {public void onClick(DialogInterface dialog, int id) {}});
        builder.setTitle("New Category");
        return builder.create();
    }

    private void SendDataToAdapter(RecyclerView rec) {
        List<Category> list_category = new Select().from(Category.class).execute();
        List<Song> list_song = new Select().from(Song.class).execute();
        categoryadapter = new CategoryAdapter(list_category, list_song,this);
        rec.setAdapter(categoryadapter);
    }


    private void AddCategoryDialog(EditText category_edit_text) {
        Category new_category = new Category();
        new_category.name = category_edit_text.getText().toString();
        new_category.save();
        categoryadapter.addCategory(new_category);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_category, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (item.getItemId() == R.id.action_settings) return true;
        return super.onOptionsItemSelected(item);
    }
}

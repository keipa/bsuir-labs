package com.example.harwister.player;

    import android.app.AlertDialog;
    import android.app.Dialog;
    import android.content.DialogInterface;
    import android.os.Bundle;
    import android.support.annotation.NonNull;
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

    import java.util.Collection;
    import java.util.Iterator;
    import java.util.List;
    import java.util.ListIterator;


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


    @Override
    protected void onStart() {
        super.onStart();
        Toast.makeText(CategoryActivity.this, "OnStart", Toast.LENGTH_SHORT).show();

    }

    @Override
    protected void onResume() {
        super.onResume();
        Toast.makeText(CategoryActivity.this, "onResume", Toast.LENGTH_SHORT).show();
//        categoryadapter.notify();

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
                        AddCategoryInDialog(category_edit_text);





                        Toast.makeText(CategoryActivity.this, "Category "+category_edit_text.getText().toString()+" added", Toast.LENGTH_SHORT).show();
                    }
                }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {public void onClick(DialogInterface dialog, int id) {}});
        builder.setTitle("New Category");
        return builder.create();
    }


    private void SendDataToAdapter(RecyclerView rec) {
        List<Category> list_category = new Select().from(Category.class).execute();
//        List<Song> list_song = new Select().from(Song.class).where("song = ?", 0).execute();     //TODO fix when songs playing would done
        List<Song> list_song = new List<Song>() {
            @Override
            public void add(int i, Song song) {

            }

            @Override
            public boolean add(Song song) {
                return false;
            }

            @Override
            public boolean addAll(int i, Collection<? extends Song> collection) {
                return false;
            }

            @Override
            public boolean addAll(Collection<? extends Song> collection) {
                return false;
            }

            @Override
            public void clear() {

            }

            @Override
            public boolean contains(Object o) {
                return false;
            }

            @Override
            public boolean containsAll(Collection<?> collection) {
                return false;
            }

            @Override
            public Song get(int i) {
                return null;
            }

            @Override
            public int indexOf(Object o) {
                return 0;
            }

            @Override
            public boolean isEmpty() {
                return false;
            }

            @NonNull
            @Override
            public Iterator<Song> iterator() {
                return null;
            }

            @Override
            public int lastIndexOf(Object o) {
                return 0;
            }

            @Override
            public ListIterator<Song> listIterator() {
                return null;
            }

            @NonNull
            @Override
            public ListIterator<Song> listIterator(int i) {
                return null;
            }

            @Override
            public Song remove(int i) {
                return null;
            }

            @Override
            public boolean remove(Object o) {
                return false;
            }

            @Override
            public boolean removeAll(Collection<?> collection) {
                return false;
            }

            @Override
            public boolean retainAll(Collection<?> collection) {
                return false;
            }

            @Override
            public Song set(int i, Song song) {
                return null;
            }

            @Override
            public int size() {
                return 0;
            }

            @NonNull
            @Override
            public List<Song> subList(int i, int i1) {
                return null;
            }

            @NonNull
            @Override
            public Object[] toArray() {
                return new Object[0];
            }

            @NonNull
            @Override
            public <T> T[] toArray(T[] ts) {
                return null;
            }
        };
        categoryadapter = new CategoryAdapter(list_category, list_song,this);
        rec.setAdapter(categoryadapter);

    }


    private void AddCategoryInDialog(EditText category_edit_text) {
        Category new_category = new Category();
        new_category.name = category_edit_text.getText().toString();
        new_category.save();
        categoryadapter.addCategory(new_category);


        //delete this
        Song new_song = new Song();
        new_song.name = "sample song";
        new_song.category = new_category;
        new_song.save();
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

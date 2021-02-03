package com.outsystems.plugins.fileviewer;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;

public class OSOpenFileChooser {

    public void openFileChooser(Activity activity) throws ActivityNotFoundException {

        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.setType("*/*");
        intent.addCategory(Intent.CATEGORY_OPENABLE);

        activity.startActivityForResult(
                Intent.createChooser(intent, "Select a file to open"),
                0);
    }

    //Singleton
    private static OSOpenFileChooser instance;

    static OSOpenFileChooser getInstance() {
        return instance == null ? (instance = new OSOpenFileChooser()) : instance;
    }

}

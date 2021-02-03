package com.outsystems.plugins.fileviewer;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.webkit.MimeTypeMap;

import androidx.core.content.FileProvider;

import java.io.File;

public class OSOpenDocument {

    public void openDocumentFromLocalPath(Activity activity, String filePath, String mimeType) throws ActivityNotFoundException{
        if(mimeType.equals("")){
            mimeType = getMimeType(filePath);
        }

        File file = new File(filePath.replace("file:///", ""));
        Uri contentUri = FileProvider.getUriForFile(activity.getApplicationContext(), activity.getPackageName() + ".opener.provider", file);

        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(contentUri, mimeType);
        intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

        activity.startActivity(intent);
    }

    public void openDocumentFromURL(Activity activity, String url) throws ActivityNotFoundException{
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
        activity.startActivity(intent);
    }

    public static String getMimeType(String url) {
        String type = null;
        String extension = MimeTypeMap.getFileExtensionFromUrl(url);
        if (extension != null) {
            type = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension);
        }
        return type;
    }

    /**
     * boolean method to check if a given file path or url is valid
     * @param path - the file path or url to check
     * @return true if path is valid, false otherwise
     */
    public boolean isPathValid(String path){
        return (path != null && path.length() > 0);
    }


    //Singleton
    private static OSOpenDocument instance;

    static OSOpenDocument getInstance() {
        return instance == null ? (instance = new OSOpenDocument()) : instance;
    }

}

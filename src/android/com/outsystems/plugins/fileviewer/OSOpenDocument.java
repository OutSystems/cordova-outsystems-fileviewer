package com.outsystems.plugins.fileviewer;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.webkit.MimeTypeMap;

import androidx.core.content.FileProvider;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.MalformedURLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class OSOpenDocument {

    public void openDocumentFromLocalPath(Activity activity, String filePath) throws ActivityNotFoundException, FileNotFoundException {
        String mimeType = getMimeType(filePath);
        File file = new File(filePath.replace("file:///", ""));

        if(file.exists()){
            Uri contentUri = FileProvider.getUriForFile(activity.getApplicationContext(), activity.getPackageName() + ".opener.provider", file);

            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(contentUri, mimeType);
            intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
            intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

            activity.startActivity(intent);
        }
        else{
            throw new FileNotFoundException();
        }
    }

    public void openDocumentFromResources(Activity activity, String filePath) throws ActivityNotFoundException, FileNotFoundException {
        AssetManager assetManager = activity.getAssets();
        String mimeType = getMimeType(filePath);
        File file = new File(filePath);

        if(file.exists()){
            Uri contentUri = Uri.parse(filePath);
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(contentUri, mimeType);
            intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
            intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

            activity.startActivity(intent);
        }
        else{
            throw new FileNotFoundException();
        }
    }

    public void openDocumentFromURL(Activity activity, String url) throws ActivityNotFoundException, MalformedURLException{
        if(isURLValid(url)){
            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
            activity.startActivity(intent);
        }
        else{
            throw new MalformedURLException();
        }
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

    public boolean isURLValid(String url){
        Pattern p = Pattern.compile("http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?");
        Matcher m = p.matcher(url);

        if(m.find()){
            return true;
        }
        return false;
    }

    //Singleton
    private static OSOpenDocument instance;

    static OSOpenDocument getInstance() {
        return instance == null ? (instance = new OSOpenDocument()) : instance;
    }

}

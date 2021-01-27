package com.outsystems.plugins.fileviewer;

import android.Manifest;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;

import androidx.core.content.FileProvider;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.apache.cordova.LOG;
import org.apache.cordova.PermissionHelper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;

public class OSFileViewer extends CordovaPlugin {

    private final static String KEY_ACTION_PREVIEW_DOCUMENT_FROM_FILE_PATH = "previewDocumentFromLocalPath";
    private final static String KEY_ACTION_PREVIEW_DOCUMENT_FROM_URL = "previewDocumentFromUrl";
    private final static String KEY_ACTION_OPEN_DOCUMENT_FROM_FILE_PATH = "openDocumentFromLocalPath";
    private final static String KEY_ACTION_OPEN_DOCUMENT_FROM_URL = "openDocumentFromUrl";
    private final static String KEY_ACTION_PREVIEW_MEDIA_CONTENT = "previewMediaContent";

    //permission codes
    public static final int WRITE = 3;
    public static final int READ = 4;

    private static final String LOG_TAG = "FileViewer";

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals(KEY_ACTION_PREVIEW_DOCUMENT_FROM_FILE_PATH)) {
            this.previewDocumentFromLocalPath(args, callbackContext);
            return true;
        }
        else if (action.equals(KEY_ACTION_PREVIEW_DOCUMENT_FROM_URL)) {
            this.previewDocumentFromUrl(args, callbackContext);
            return true;
        }
        else if (action.equals(KEY_ACTION_OPEN_DOCUMENT_FROM_FILE_PATH)) {
            this.openDocumentFromLocalPath(args, callbackContext);
            return true;
        }
        else if (action.equals(KEY_ACTION_OPEN_DOCUMENT_FROM_URL)) {
            this.openDocumentFromUrl(args, callbackContext);
            return true;
        }
        else if (action.equals(KEY_ACTION_PREVIEW_MEDIA_CONTENT)) {
            this.previewMediaContent(args, callbackContext);
            return true;
        }
        return false;
    }

    private void previewDocumentFromLocalPath(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }

    private void previewDocumentFromUrl(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }

    private void openDocumentFromLocalPath(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String filePath = null;
        String mimeType = null;
        try {
            filePath = args.getString(0);
            mimeType = args.getString(1);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        if(needPermission(filePath, READ)){
            getReadPermission();
        }

        //using the FileProvider and the getUriForFile, as it explains in the Android documentation for FileProvider

        File file = new File(filePath.replace("file:///", ""));
        Uri contentUri = FileProvider.getUriForFile(this.cordova.getActivity().getApplicationContext(), this.cordova.getActivity().getPackageName() + ".opener.provider", file);

        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(contentUri, mimeType);
        intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

        try{
            this.cordova.getActivity().startActivity(intent);
            callbackContext.success();
        } catch (ActivityNotFoundException e) {
            callbackContext.error("There is no app to open this document.");
        }

    }

    private void openDocumentFromUrl(JSONArray args, CallbackContext callbackContext) {
        String url = null;
        try {
            url = args.getString(0);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
        try{
            this.cordova.getActivity().startActivity(intent);
            callbackContext.success();
        } catch (ActivityNotFoundException e) {
            callbackContext.error("There is no app to open this document.");
        }
    }

    private void previewMediaContent(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }

    private boolean needPermission(String nativeURL, int permissionType) throws JSONException {
        JSONObject j = requestAllPaths();
        ArrayList<String> allowedStorageDirectories = new ArrayList<String>();
        allowedStorageDirectories.add(j.getString("applicationDirectory"));
        allowedStorageDirectories.add(j.getString("applicationStorageDirectory"));
        if(j.has("externalApplicationStorageDirectory")) {
            allowedStorageDirectories.add(j.getString("externalApplicationStorageDirectory"));
        }

        if(permissionType == READ && hasReadPermission()) {
            return false;
        }
        else if(permissionType == WRITE && hasWritePermission()) {
            return false;
        }

        // Permission required if the native url lies outside the allowed storage directories
        for(String directory : allowedStorageDirectories) {
            if(nativeURL.startsWith(directory)) {
                return false;
            }
        }
        return true;
    }

    private JSONObject requestAllPaths() throws JSONException {
        Context context = cordova.getActivity();
        JSONObject ret = new JSONObject();
        ret.put("applicationDirectory", "file:///android_asset/");
        ret.put("applicationStorageDirectory", toDirUrl(context.getFilesDir().getParentFile()));
        ret.put("dataDirectory", toDirUrl(context.getFilesDir()));
        ret.put("cacheDirectory", toDirUrl(context.getCacheDir()));
        if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
            try {
                ret.put("externalApplicationStorageDirectory", toDirUrl(context.getExternalFilesDir(null).getParentFile()));
                ret.put("externalDataDirectory", toDirUrl(context.getExternalFilesDir(null)));
                ret.put("externalCacheDirectory", toDirUrl(context.getExternalCacheDir()));
                ret.put("externalRootDirectory", toDirUrl(Environment.getExternalStorageDirectory()));
            }
            catch(NullPointerException e) {
                /* If external storage is unavailable, context.getExternal* returns null */
                LOG.d(LOG_TAG, "Unable to access these paths, most liklely due to USB storage");
            }
        }
        return ret;
    }

    private static String toDirUrl(File f) {
        return Uri.fromFile(f).toString() + '/';
    }

    private boolean hasReadPermission() {
        return PermissionHelper.hasPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE);
    }

    private boolean hasWritePermission() {
        return PermissionHelper.hasPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE);
    }

    private void getReadPermission() {
        PermissionHelper.requestPermission(this, 1, Manifest.permission.READ_EXTERNAL_STORAGE);
    }

}
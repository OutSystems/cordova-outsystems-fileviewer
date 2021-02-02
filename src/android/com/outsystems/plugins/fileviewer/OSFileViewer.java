package com.outsystems.plugins.fileviewer;

import android.Manifest;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.util.Log;
import android.webkit.MimeTypeMap;

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
    private final static String KEY_ACTION_OPEN_FILE_CHOOSER = "openFileChooser";

    //permission codes
    public static final int WRITE = 3;
    public static final int READ = 4;

    private static final String LOG_TAG = "FileViewer";

    //Request code for selecting a PDF document
    private static final int PICK_PDF_FILE = 2;

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
            this.openDocumentFromLocalPath(args, callbackContext);
            return true;
        }
        else if (action.equals(KEY_ACTION_OPEN_FILE_CHOOSER)) {
            this.openFileChooser(args, callbackContext);
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

    /**
     * Method to open files from local paths (from inside the app sandbox)
     * @param args
     * @param callbackContext
     * @throws JSONException
     */
    private void openDocumentFromLocalPath(JSONArray args, CallbackContext callbackContext) throws JSONException {
        String filePath = null;
        String mimeType = null;
        try {
            filePath = args.getString(0);
            mimeType = args.getString(1);
        } catch (JSONException e) {
            callbackContext.error(buildErrorResponse(1, "Invalid arguments"));
            return;
        }

        if (isPathValid(filePath)) {

            if(mimeType.equals("")){
                mimeType = getMimeType(filePath);
            }

            File file = new File(filePath.replace("file:///", ""));
            Uri contentUri = FileProvider.getUriForFile(this.cordova.getActivity().getApplicationContext(), this.cordova.getActivity().getPackageName() + ".opener.provider", file);

            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(contentUri, mimeType);
            intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
            intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

            try {
                this.cordova.getActivity().startActivity(intent);
                callbackContext.success();
            } catch (ActivityNotFoundException e) {
                callbackContext.error(buildErrorResponse(5, "There is no app to open this document"));
            }
            return;
        }

        callbackContext.error(buildErrorResponse(2, "Path of the file to open is invalid"));
    }

    /**
     * Method to open a document from an URL
     * @param args
     * @param callbackContext
     */
    private void openDocumentFromUrl(JSONArray args, CallbackContext callbackContext) {
        String url = null;
        try {
            url = args.getString(0);
        } catch (JSONException e) {
            callbackContext.error(buildErrorResponse(1, "Invalid arguments"));
            return;
        }

        if (isPathValid(url)) {

            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
            try {
                this.cordova.getActivity().startActivity(intent);
                callbackContext.success();
            } catch (ActivityNotFoundException e) {
                callbackContext.error(buildErrorResponse(5, "There is no app to open this document"));
            }
            return;
        }

        callbackContext.error(buildErrorResponse(2, "URL to open is invalid"));
    }

    private void previewMediaContent(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }

    /**
     * Method to open the file chooser, when the user wants to open files from outside the app sandbox
     * @param args
     * @param callbackContext
     */
    private void openFileChooser(JSONArray args, CallbackContext callbackContext) {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.setType("*/*");
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        try {
            this.cordova.getActivity().startActivityForResult(
                    Intent.createChooser(intent, "Select a file to open"),
                    0);
        } catch (ActivityNotFoundException ex) {
            callbackContext.error(buildErrorResponse(6, "There is no app to browse files with"));
        }
    }

    /**
     * boolean method to check if a given file path or url is valid
     * @param path - the file path or url to check
     * @return true if path is valid, false otherwise
     */
    private boolean isPathValid(String path){
        return (path != null && path.length() > 0);
    }

    private JSONObject buildErrorResponse(int errorCode, String errorMessage) {
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("error_code", errorCode);
            jsonObject.put("error_message", errorMessage);
        } catch (JSONException e) {
            Log.e("FileViewer", e.toString());
        }
        return jsonObject;
    }

    public static String getMimeType(String url) {
        String type = null;
        String extension = MimeTypeMap.getFileExtensionFromUrl(url);
        if (extension != null) {
            type = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension);
        }
        return type;
    }

}
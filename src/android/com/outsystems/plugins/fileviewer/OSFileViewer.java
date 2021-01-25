package com.outsystems.plugins.fileviewer;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class OSFileViewer extends CordovaPlugin {

    private final static String KEY_ACTION_PREVIEW_DOCUMENT_FROM_FILE_PATH = "previewDocumentFromLocalPath";
    private final static String KEY_ACTION_PREVIEW_DOCUMENT_FROM_URL = "previewDocumentFromUrl";
    private final static String KEY_ACTION_OPEN_DOCUMENT_FROM_FILE_PATH = "openDocumentFromLocalPath";
    private final static String KEY_ACTION_OPEN_DOCUMENT_FROM_URL = "openDocumentFromUrl";
    private final static String KEY_ACTION_PREVIEW_MEDIA_CONTENT = "previewMediaContent";

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

    private void openDocumentFromLocalPath(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }

    private void openDocumentFromUrl(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }

    private void previewMediaContent(JSONArray args, CallbackContext callbackContext) {
        //TODO
    }


}
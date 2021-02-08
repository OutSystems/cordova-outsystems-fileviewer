package com.outsystems.plugins.fileviewer;

import android.webkit.MimeTypeMap;

public class OSGetMimeType {

    public static String determineMimeType(String url){
        String type = null;
        String extension = MimeTypeMap.getFileExtensionFromUrl(url);
        if (extension != null) {
            type = MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension);
        }
        return type;
    }

}

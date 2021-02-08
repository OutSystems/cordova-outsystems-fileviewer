package com.outsystems.plugins.fileviewer;

public class GetMimeTypeMock extends OSGetMimeType {

    public static String determineMimeType(String url){
        String mimeType = "";
        if(url.contains("pdf")){
            mimeType = "application/pdf";
        }
        return mimeType;
    }

}

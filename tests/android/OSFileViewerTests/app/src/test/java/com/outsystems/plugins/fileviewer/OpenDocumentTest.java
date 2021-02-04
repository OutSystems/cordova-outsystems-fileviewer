package com.outsystems.plugins.fileviewer;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class OpenDocumentTest {

    @Test
    public void isPathValid_FilePathSuccess(){

        assertTrue(OSOpenDocument.getInstance().isPathValid("file:///storage/emulated/0/android/media/com.outsystems.rd.FileViewerTest/nomePDF.pdf"));

    }

    @Test
    public void isPathValid_FilePathError(){

        assertFalse(OSOpenDocument.getInstance().isPathValid(""));

    }

    //add test with invalid filePath, i.e., a path that does not exist (e.g. "aaaaaa")

}
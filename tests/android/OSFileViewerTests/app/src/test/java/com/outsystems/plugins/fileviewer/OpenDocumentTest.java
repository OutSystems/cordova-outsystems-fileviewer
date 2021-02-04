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
    public void given_ValidFilePath_When_CheckingIsPathValid_Then_FilePathIsValid(){

        assertTrue(OSOpenDocument.getInstance().isPathValid("file:///storage/emulated/0/android/media/com.outsystems.rd.FileViewerTest/nomePDF.pdf"));

    }

    @Test
    public void given_ValidURL_When_CheckingIsPathValid_Then_URLIsValid(){

        assertTrue(OSOpenDocument.getInstance().isPathValid("https://www.tutorialspoint.com/swift/swift_tutorial.pdf"));

    }

    @Test
    public void given_EmptyPath_When_CheckingIsPathValid_Then_PathIsNotValid(){

        assertFalse(OSOpenDocument.getInstance().isPathValid(""));

    }

    //add test with invalid filePath, i.e., a path that does not exist (e.g. "aaaaaa")

}